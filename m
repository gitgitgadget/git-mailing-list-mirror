Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D88220323
	for <e@80x24.org>; Sun, 19 Mar 2017 20:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbdCSUYN (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 16:24:13 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35882 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752284AbdCSUYG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2017 16:24:06 -0400
Received: by mail-wr0-f195.google.com with SMTP id l37so15653741wrc.3
        for <git@vger.kernel.org>; Sun, 19 Mar 2017 13:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fTOtl++s2HpGYDbNHkR/eF8JEQ238dZ6l7twtRJAcCQ=;
        b=Zcb0L7hzUCNCdZK9wT17GFi3RhDShDKJNQRVH8ThLlbDezNEIiZ56ahhvvqGSeMYo3
         FQIEP574b96BN+2Gdgs3rHjHJNcAzZvUTvLwAAMFQngHzzSO1NOOpXKHoz+xSGZ7sS+Y
         yzlADKtu1TnKumxYxd2ulXg4oP/zwuTixj+BxH6lPo2SR56u3Dp2g0/dLGNR7qCpuBsI
         oHmRcK2os9HxPwhjB/VMVFnxWsMv2t2c5r1g6jhW0f6wknOdlqSWeGcJ83PIWYzlVn80
         wpPoFBsnDHd3RObw8peiCYmtWVS8MWVGQBGDt+scxXav6oXSc65W5U6HEUzfmB5BbNXi
         7HFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fTOtl++s2HpGYDbNHkR/eF8JEQ238dZ6l7twtRJAcCQ=;
        b=fIL31z1xXHM9JYXii4ZvIdFNUidHpFJ4S+FI8RWhoKh9jTFuKCgpy98n7J6SUhreMJ
         dA2rbhVwBb7FfH+cgrv4LnTLOb5ZFnPs6YRGkKh5Zbe1917GXwouiAQ04BA8LMOx3ruE
         0jkluViwS8M34T0gTcd0pz06RBQqPc0m0+LYPSjd04vVHXRUyVAcxMsr4ewmbApqZsM1
         d/OZZEfQtIkg8jKw0hbCdDjgKFTW7hNFt6umJL/CL1GTnpNuWjg5Ek6m8PArMsHqow39
         fieimKdL4i/5KqxqMUzeOWCaOrX8D+VARHnjTuIZR4R5ymvpMQ4PtZoZ7Hb927h6EzDF
         wo4g==
X-Gm-Message-State: AFeK/H3mH3WX31dO98CVqbzv9HAkdQSHuKsMicNl7p3O20RIdZOsPsuwMBb/mn7qfXYu/g==
X-Received: by 10.223.169.161 with SMTP id b30mr23075734wrd.196.1489955022175;
        Sun, 19 Mar 2017 13:23:42 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id u7sm18167353wru.56.2017.03.19.13.23.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Mar 2017 13:23:41 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC 3/3] stash: pass the pathspec argument to git reset
Date:   Sun, 19 Mar 2017 20:23:51 +0000
Message-Id: <20170319202351.8825-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.12.0.483.gad4152297
In-Reply-To: <20170319202351.8825-1-t.gummerer@gmail.com>
References: <20170318183658.GC27158@hank>
 <20170319202351.8825-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For "git stash -p --no-keep-index", the pathspec argument is currently
not passed to "git reset".  This means that changed that are staged but
that are excluded from the pathspec still get unstaged by git stash -p.

Make sure that doesn't happen by passing the pathspec argument to the
git reset in question, bringing the behaviour in line with "git stash --
<pathspec>".

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
So this make things a bit inconsistent in for example the following
situation:

    $ git status -s
     M git-stash.sh
    M  read-cache.c

where using git stash -p --no-keep-index, when only changes in
git-stash.sh are added to the stash would reset read-cache.c, but with
git stash -p --no-keep-index -- git-stash.sh, read-cache.c would not
be reset.  

However it does bring things more in line with git stash --
<pathspec>, so I think this is an improvement.

 git-stash.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index c58f98f1d6..2d5c9a609c 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -322,7 +322,7 @@ push_stash () {
 
 		if test "$keep_index" != "t"
 		then
-			git reset ${GIT_QUIET:+-q}
+			git reset ${GIT_QUIET:+-q} -- "$@"
 		fi
 	fi
 }
-- 
2.12.0.483.gad4152297

