Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCC6620357
	for <e@80x24.org>; Mon, 10 Jul 2017 14:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932395AbdGJOSB (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 10:18:01 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34620 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932298AbdGJOR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 10:17:59 -0400
Received: by mail-pf0-f194.google.com with SMTP id c24so14723144pfe.1
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 07:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/GiIJsEuadA6wMI/gfh4j1+912+21d/YHVMbo6HQCVU=;
        b=Ya07WhxkeMMtkrTptcc4KsZriRFUzB9nthw2vsBDwFZgBLjJo+Vt/EHI6dEmYqIYyY
         FZvhX2IMDZoVt/sjyISAZEdPx2TNinQIHOdtFM48GuSQeaiWZ/DfPWmRQ6+KZmtzA+bc
         wCYan4WWx2aZZu8eGTrysuxlkwNwpqCjVXUoEXHdYjqZDUwD+Ts5najXvE/LxJlBHpzY
         07YdqhXZIm6Mmq3xiPU2gQEHkQVxvxNvU4KEz4YqRjFgqSRwBFDK2C4mJKkKgDladnPe
         6ObusEGhlZrw2Bni1rPvPDZygyZuCF8Bwe2OfsrI93N1F1172lIjaZg/4eFUR+1avrYK
         OPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/GiIJsEuadA6wMI/gfh4j1+912+21d/YHVMbo6HQCVU=;
        b=sMbALRoVzn0b7bzXnntWxkE05dQ4BHH1r+zFXZFOXTVr/yOfYzn7muh5Qwo/3QDMXB
         xmnXu4M+zqh+tLcz2DEB5ivsAeDYKzzXQWXkT9Det54OfIhTahHRYmoG8v8NrTey3K4V
         siSZ5KQF9iKJNo3zYNefoG18HMwrxR4dgwhLT3cIiLU1StVd7Yb1/TcdA017+kOzmJCE
         Hdr6u0GV9NJL7fQWB71S5VL39vTbLJi4n6+wi2oWeQ50juTM/WhS7iyq6o3WABQrGMTJ
         Vq9cpOfxg7tyiF15t/05rIjVjPtTW9KzqKwgc59VC3F+CmUYZ3c60oUN2xE5in06JP79
         lRng==
X-Gm-Message-State: AIVw112D57n7gavqP6eoFJYR2ucaRySFoQHjtpubiHTQIZCMGAGiuxz4
        k2AgLMB4PiNLXQ==
X-Received: by 10.84.194.37 with SMTP id g34mr18781252pld.111.1499696278396;
        Mon, 10 Jul 2017 07:17:58 -0700 (PDT)
Received: from localhost.localdomain ([117.209.158.50])
        by smtp.gmail.com with ESMTPSA id t78sm25469923pfa.48.2017.07.10.07.17.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jul 2017 07:17:58 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH 3/4] hook: add signature using "interpret-trailers"
Date:   Mon, 10 Jul 2017 19:47:43 +0530
Message-Id: <20170710141744.8541-3-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.13.2.957.g457671ade
In-Reply-To: <20170710141744.8541-1-kaarticsivaraam91196@gmail.com>
References: <xmqqinj4ayqb.fsf@gitster.mtv.corp.google.com>
 <20170710141744.8541-1-kaarticsivaraam91196@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sample hook to prepare the commit message before
a commit allows users to opt-in to add the signature
to the commit message. The signature is added at a place
that isn't consistent with the "-s" option of "git commit".
Further, it could go out of view in certain cases.

Add the signature in a way similar to "-s" option of
"git commit" using git's interpret-trailers command.

It works well in all cases except when the user invokes
"git commit" without any arguments. In that case manually
add a new line after the first line to ensure it's consistent
with the output of "-s" option.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 templates/hooks--prepare-commit-msg.sample | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
index 708f0e92c..a15d6d634 100755
--- a/templates/hooks--prepare-commit-msg.sample
+++ b/templates/hooks--prepare-commit-msg.sample
@@ -32,4 +32,8 @@ SHA1=$3
 # esac
 
 # SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
-# grep -qs "^$SOB" "$COMMIT_MSG_FILE" || echo "$SOB" >> "$COMMIT_MSG_FILE"
+# git interpret-trailers --in-place --trailer "$SOB" "$COMMIT_MSG_FILE"
+# if test -z "$COMMIT_SOURCE"
+# then
+#   @PERL_PATH@ -i.bak -pe 'print "\n" if($first_line++ == 0)' "$COMMIT_MSG_FILE"
+# fi
-- 
2.13.2.957.g457671ade

