Return-Path: <SRS0=kadj=4S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D88CC3F2CD
	for <git@archiver.kernel.org>; Sun,  1 Mar 2020 15:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D4E21775
	for <git@archiver.kernel.org>; Sun,  1 Mar 2020 15:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzKSv/Si"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgCAP75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Mar 2020 10:59:57 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38631 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgCAP75 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Mar 2020 10:59:57 -0500
Received: by mail-lj1-f194.google.com with SMTP id w1so9003265ljh.5
        for <git@vger.kernel.org>; Sun, 01 Mar 2020 07:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iJfpVOupDhyb35481B0dEx01N6tSCZ1SMhaQJs9/DEk=;
        b=SzKSv/SiTQ3bBFmjmc60Kqf+zYGaBTxHfmdkW74GcLXKsVfMm2Osin32AxWO1sQRov
         eTUcbkfGxMnvoEvXs5YjTxsvSkuiPlJvoD0O3V1hhdBXhq3l0Rso/giN72tSz9a5najw
         yvjGYBjyroIFcmpcxb8/NFAf3k2YwTJS6Fj3AARu7zpfdCGO9jML5fw9z5TnRFbMtcAf
         Exez8t3BSX4iLKVTVgE8uLblWT2c4RozyF5wklOkDn7sT2N6Qcv297AgExm/1izHl5hg
         BbXPYhtlSaA8lKB2DhGj12V8ZZtacfYyuPrMG+KrKihaOJVDrviJWIyZPPwUQm/fYkQk
         mALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iJfpVOupDhyb35481B0dEx01N6tSCZ1SMhaQJs9/DEk=;
        b=Vyzf4hoOMoKf3A75GifchqyoQzY2RjGP2iypNC0EhFulUVGUDV282tTAP290y/FpNH
         qY6ap7ZuhKTdR8lp6ggsvKI8gPfSC5UOw9wb/0u15279CFbVSUEezedrQnu4kAAOUauF
         hO/263jQtKftqIQQ0FSwcAjQ4cNMcbwZajBZwI+CHSEix30jVx+Eq6pOOz0kLa8ENZfa
         NFkche0Z7mWbn1iNJcxFNHV6ogM+DqO/YZp/ltBS7eolVI9ZjqI/aexokBCHcWWWIADR
         TDEuOe8bu4gAmBtyn/wXiJsnkKUM3+wYIdxpNlPagILDlZd1VUzgUbV57TPLCja8rjFW
         8G0A==
X-Gm-Message-State: ANhLgQ2ywAF0H553YOFcJy9P/ShU2fTGimmhnEKHt4spuhsttJcytsPf
        eRDz2bVi/MalPts4KSjKSG00EnqA
X-Google-Smtp-Source: ADFU+vuQVEYAGhr/LfrNrl8wmGTINSME5aGccDiGA4IGTLcgk7Xj2v/D167JqYi0KrVVUcoHHdaikA==
X-Received: by 2002:a05:651c:391:: with SMTP id e17mr2744961ljp.242.1583078395268;
        Sun, 01 Mar 2020 07:59:55 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id o4sm3321738lfl.62.2020.03.01.07.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 07:59:54 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [PATCH] show_one_mergetag: print non-parent in hex form.
Date:   Sun,  1 Mar 2020 16:59:37 +0100
Message-Id: <20200301155937.7168-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <pull.568.git.1582981677312.gitgitgadget@gmail.com>
References: <pull.568.git.1582981677312.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Harald,

On Sat, 29 Feb 2020 at 14:11, Harald van Dijk via GitGitGadget <gitgitgadget@gmail.com> wrote:
> When a mergetag names a non-parent, which can occur after a shallow
> clone, its hash was previously printed as raw data. Print it in hex form
> instead.

Minor nit: "..., its hash is printed as raw data. ...". (It *is* indeed
being printed as raw data as you set out to write this patch.)

>         else if ((nth = which_parent(&tag->tagged->oid, commit)) < 0)
>                 strbuf_addf(&verify_message, "tag %s names a non-parent %s\n",
> -                                   tag->tag, tag->tagged->oid.hash);
> +                                   tag->tag, oid_to_hex(&tag->tagged->oid));

Looks obviously correct.

> +test_expect_success GPG 'log --graph --show-signature for merged tag in shallow clone' '
> +       test_when_finished "git reset --hard && git checkout master" &&
> +       git checkout -b plain-shallow master &&
> +       echo aaa >bar &&
> +       git add bar &&
> +       git commit -m bar_commit &&

These last three lines could be "test_commit bar".

> +       git checkout --detach master &&
> +       echo bbb >baz &&
> +       git add baz &&
> +       git commit -m baz_commit &&

Similarly here.

> +       git tag -s -m signed_tag_msg signed_tag_shallow &&
> +       hash=$(git rev-parse HEAD) &&
> +       git checkout plain-shallow &&
> +       git merge --no-ff -m msg signed_tag_shallow &&
> +       git clone --depth 1 --no-local . shallow &&
> +       test_when_finished "rm -rf shallow" &&
> +       git -C shallow log --graph --show-signature -n1 plain-shallow >actual &&
> +       grep "tag signed_tag_shallow names a non-parent $hash" actual
> +'

But I also wonder if we even need the "bar" commit. Similarly,
"--detach"-ing when checking out master seems unnecessary, unless we're
afraid of "messing up" master, by modifying the expectations of later
tests? Was that something you were concerned about?

I realize the test you add is similar to the ones surrounding it. But it
does look tempting to squash in the diff below. The test still fails
before and passes after. What do you think about this? Does this
correctly capture your scenario?

(I suppose even the "test_commit baz" could be dropped, but then this
test needs to assume that "master" already contains a commit.)

Martin

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 20cb436c43..7441485e73 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1636,17 +1636,11 @@ test_expect_success GPG 'log --graph --show-signature for merged tag' '
 
 test_expect_success GPG 'log --graph --show-signature for merged tag in shallow clone' '
 	test_when_finished "git reset --hard && git checkout master" &&
-	git checkout -b plain-shallow master &&
-	echo aaa >bar &&
-	git add bar &&
-	git commit -m bar_commit &&
-	git checkout --detach master &&
-	echo bbb >baz &&
-	git add baz &&
-	git commit -m baz_commit &&
+	git checkout master &&
+	test_commit baz &&
 	git tag -s -m signed_tag_msg signed_tag_shallow &&
 	hash=$(git rev-parse HEAD) &&
-	git checkout plain-shallow &&
+	git checkout -b plain-shallow HEAD~ &&
 	git merge --no-ff -m msg signed_tag_shallow &&
 	git clone --depth 1 --no-local . shallow &&
 	test_when_finished "rm -rf shallow" &&
-- 
2.25.1

