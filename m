Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C19931F667
	for <e@80x24.org>; Thu, 17 Aug 2017 02:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751556AbdHQCtt (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 22:49:49 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34851 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751490AbdHQCts (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 22:49:48 -0400
Received: by mail-pg0-f65.google.com with SMTP id t80so1307952pgb.2
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 19:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VuY92svo8U52eqbvNomKX44/xddbeCs+pi5by1YMIj8=;
        b=Isp6zAlGCexu2ebAW7AcnsqmNI214BUqOj+lmfh7uxxo1GrrFPZhdg37YBYLMzh8Oy
         RDgWFjkRBAMDmwpveWY7/jCj9y3+Ytx1vyAsin4T/u96EK8UJkeiQhzE46kOyRjL2+iV
         vKdgRWRF6CZKxtOJUCajhqkhJ9lTD6Q6Yy0xN6oZ1f2jfHiVDTuKdI5vCHhmxnSD45Ii
         7T8n3TgKsCbCaAgaj1F3MEb6Css/IkYydquQpePXq6SYDO4w1sYcDqmtYSoYAp0WbsYI
         ZfBaPFrZxri3zXjvc51axwa0pS8gGOqwsAZpg4TZGB34t7dla5/xkMdZVFM6N3tyOj67
         RARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VuY92svo8U52eqbvNomKX44/xddbeCs+pi5by1YMIj8=;
        b=GGlAKyx/Cz623QfsCKQhQPO/kCR7jo0DzrxWi+0lUh2z0UDxpfgXfMWcrVJp0hhlr2
         wsW1VfMaJ1oUo01NlyCU45tXFeChHITbT0K8d4qwguMbMubKLORtiM9wl9eQnuKXQr0t
         suyinoPj9iPAqtjsj06OrGvaBE2pxUsRyYsJtY87rXtI/u0i38hZMB/5+rVc7aRTnwLR
         sYW4uhOBcfRhNbFhpa1S8OolbriBCCeOhZjbj3O5ZWw8JsS1XKltteWWffhsdDaknVn4
         OblUg8/4CUJmBfKj+ij6RQdT6+TuSu8gjPLxjDiZFCKRQj2l9YJH4vrVgWVfyDulC7NF
         8pCA==
X-Gm-Message-State: AHYfb5gOEACifm0Aj/Fy4AMopQ0JdudHyIFDh0Zl/q67+HvGHilHapqX
        46zAjYoz5kLMvA==
X-Received: by 10.84.130.108 with SMTP id 99mr3972546plc.76.1502938188161;
        Wed, 16 Aug 2017 19:49:48 -0700 (PDT)
Received: from localhost.localdomain ([157.50.14.209])
        by smtp.gmail.com with ESMTPSA id a87sm3824741pfg.18.2017.08.16.19.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Aug 2017 19:49:47 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: [PATCH v2/RFC] hook: use correct logical variable
Date:   Thu, 17 Aug 2017 08:20:24 +0530
Message-Id: <20170817025024.6517-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.0.rc1.434.g6eded367a
In-Reply-To: <1502938058.1710.14.camel@gmail.com>
References: <1502938058.1710.14.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In general, a 'Sign-off' added should be that of the *committer* and not
that of the *commit's author*. As the 3rd part of the 'prepare-commit-msg'
hook appended the sign-off of the *commit's author* it worked weirdly in
some cases. For example 'git commit --amend -s' when coupled with that part
of the script woked weirdly as illustrated by the following scenario in which
the last commit's log message has the following trailer,

    ...

    Signed-off-by: Random Developer <developer@example.com>

and the commit's author is "Random Developer <developer@example.com>". Assume
that the commit is trying to be amended by another developer who's identity is
"Another Developer <another-dev@example.com>". When he tries to do

    $ git commit --amend -s

with the 3rd part of the hook enabled then the trailer he would see in his editor
would be,

    ...

    Signed-off-by: Random Developer <developer@example.com>
    Signed-off-by: Another Developer <another-dev@example.com>
    Signed-off-by: Random Developer <developer@example.com>

This is because,

  * the hook is invoked only after the sign-off is appended by the '-s' option

  * the script tries to add the sign-off of the *commit's author* using interpret-trailers
    and 'interpret-trailers' in it's default configuration tries to adds the trailer
    when the *neighbouring* trailer isn't the same as the one trying to be added.

This is just an example and this kind of issue could repeat if similar conditions are
satisified for other cases.

Moreover the rest of Git adds the sign-off of the *committer* using sequencer.c::append_signoff().
So, use the correct logical variable that identifies the committer to append the sign-off
in the sample hook script.

Bottom line: Being consistent prevents all sorts of weird issues.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 Changes in v2:

    - updated the commit message
 
 Suggestions regarding ways to improve the message are most welcome.

 templates/hooks--prepare-commit-msg.sample | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
index a84c3e5a8..12dd8fd88 100755
--- a/templates/hooks--prepare-commit-msg.sample
+++ b/templates/hooks--prepare-commit-msg.sample
@@ -34,7 +34,7 @@ SHA1=$3
 #  *) ;;
 # esac
 
-# SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
+# SOB=$(git var GIT_COMMITTER_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
 # git interpret-trailers --in-place --trailer "$SOB" "$COMMIT_MSG_FILE"
 # if test -z "$COMMIT_SOURCE"
 # then
-- 
2.14.0.rc1.434.g6eded367a

