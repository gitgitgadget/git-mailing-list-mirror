Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF11C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 19:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0AB6206D3
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 19:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7uk3fEW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbgA3TWw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:22:52 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:35520 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbgA3TWw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 14:22:52 -0500
Received: by mail-yb1-f193.google.com with SMTP id q190so1948302ybq.2
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 11:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NZh1j/9DWXS0Up60DonuvtYRfn8R3HqvT3y5YSdO8fg=;
        b=H7uk3fEWqsCGvhKAHnzsrHb18fAqoFp4H7RWVrjAC6jPMkRF7EiZJYs8/NsuCN9BDu
         6Z2BRfVMhufhUGbrFGz4e+F5JT969DJKOl9DbsaNAekR/e44hAlD7quq16VRoPoLBuvn
         aZbQ4cjYQsa8jwxkuJ/tS8rcZJamMjzSGxvvJDWM3KpsIVtRJll7vZF7AInnP6L6KXne
         Z1KiQQjjsqt6YSh2GRTDq3ytRqZj+ONDru5xhnBgrVZbm5cYxvEPTS9/Hxg5P9nTD1+X
         bs3ciz+k5XHN27drz7lI3cqLZ4mUL1ZTo3QBV7iGd2yciDaAbKb5CKxBO6HOUsC66vBi
         X1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NZh1j/9DWXS0Up60DonuvtYRfn8R3HqvT3y5YSdO8fg=;
        b=AGN0CNX3gBzbPFWVJ3R/Lml9zA1+yAiouD9Db8ivvLuwItIS5Tzf6VZGZQlDOOpTCw
         yT3TZtXaWA2wVxIPvl7+GbKmG0nSR4RQH6WJgIrnxMzpg1STi9Wn9IZYpJTpn1kQbLn2
         nVXRytRUnoxlLSjfaOJTg8A8nWOK20Q2BaqSUx4abADa0j9IGj9qmXRzxmpESMrrJ6he
         nbKQmNVO/cam4DLyjR3DDgXZv7ANHqooR1XVeoIR/aW4ihrS+0aSM1KHrZXlphPnvkkq
         LvCMRGzmdY6Z/7RPyk4woCPZPD8qXU04hj4TCDF0zNLOXR/ocpD+pHJ3qLeM4MM52Q3d
         uufw==
X-Gm-Message-State: APjAAAUnp7aksBZqOujsMeh5De9wRDHBAW1YKDxhRUGokRuTBfyDeqKe
        AqUtB2s1Uuryp2a7JrJBPx1aSHKakUg=
X-Google-Smtp-Source: APXvYqzSlGzeHTHZ+UTBWb722WAQ+rCpXquPr+MsIPczyeTL89lYhs3vG5SoIyCgxp0r4gNJwi+gMw==
X-Received: by 2002:a25:bf91:: with SMTP id l17mr5498977ybk.417.1580412171234;
        Thu, 30 Jan 2020 11:22:51 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id k135sm2959893ywe.2.2020.01.30.11.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 11:22:50 -0800 (PST)
Subject: Re: Sparse checkout inconsistency with non-folder paths between cone
 mode and full matching (2.5.0)
From:   Derrick Stolee <stolee@gmail.com>
To:     finnbryant@gmail.com, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
References: <CADSBhNbbO=aq-Oo2MpzDMN2VAX4m6f9Jb-eCtVVX1NfWKE9zJw@mail.gmail.com>
 <ef39f8c5-ce0b-a48b-940d-821df563b292@gmail.com>
Message-ID: <967f96e0-d26b-1ec0-f39f-617d95615d6f@gmail.com>
Date:   Thu, 30 Jan 2020 14:22:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <ef39f8c5-ce0b-a48b-940d-821df563b292@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/30/2020 1:52 PM, Derrick Stolee wrote:
> On 1/30/2020 10:25 AM, Finn Bryant wrote:
>> $ git sparse-checkout init --cone
>> $ git read-tree -mu HEAD
>> $ ls -1
>> a_file_or_folder
>> some_file
>> $ git sparse-checkout set a_file_or_folder
>> $ git read-tree -mu HEAD
>> $ ls -1
>> some_file
>> $ cat .git/info/sparse-checkout
>> /*
>> !/*/
>> /a_file_or_folder/
> 
> This is an interesting test, because I would expect the /a_file_or_folder/
> pattern to not cause the _file_ to not match. It does match the first two
> patterns, and just because it doesn't match the third pattern shouldn't
> remove it.
> 
> This is actually a bug in the hashset-based pattern-matching algorithm,
> since setting core.sparseCheckoutCone=false does not have this behavior.
> I'll make a patch to fix this.

And here is a patch. I'll add this on top of my "Harden the sparse-checkout
builtin" series in its v4.

-->8--

From bf2115670e8ef79844ec7e87f3ba99d1f776a44d Mon Sep 17 00:00:00 2001
From: Derrick Stolee <dstolee@microsoft.com>
Date: Thu, 30 Jan 2020 19:11:26 +0000
Subject: [PATCH] sparse-checkout: fix cone mode behavior mismatch

The intention of the special "cone mode" in the sparse-checkout feature
is to always match the same patterns that are matched by the same
sparse-checkout file as when cone mode is disabled.

When a file path is given to "git sparse-checkout set" in cone mode,
then the cone mode improperly matches the file as a recursive path.
When setting the skip-worktree bits, files were not expecting the
MATCHED_RECURSIVE response, and hence these were left out of the
matched cone.

Fix this bug by checking for MATCHED_RECURSIVE in addition to MATCHED
and add a test that prevents regression.

Reported-by: Finn Bryant <finnbryant@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1091-sparse-checkout-builtin.sh | 12 ++++++++++++
 unpack-trees.c                     |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 37e9304ef3..7d982096fb 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -305,6 +305,18 @@ test_expect_success 'different sparse-checkouts with worktrees' '
 	check_files worktree a deep
 '
 
+test_expect_success 'set using filename keeps file on-disk' '
+	git -C repo sparse-checkout set a deep &&
+	cat >expect <<-\EOF &&
+	/*
+	!/*/
+	/a/
+	/deep/
+	EOF
+	test_cmp expect repo/.git/info/sparse-checkout &&
+	check_files repo a deep
+'
+
 check_read_tree_errors () {
 	REPO=$1
 	FILES=$2
diff --git a/unpack-trees.c b/unpack-trees.c
index 3789a22cf0..78425ce74b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1416,7 +1416,7 @@ static int clear_ce_flags_1(struct index_state *istate,
 						name, &dtype, pl, istate);
 		if (ret == UNDECIDED)
 			ret = default_match;
-		if (ret == MATCHED)
+		if (ret == MATCHED || ret == MATCHED_RECURSIVE)
 			ce->ce_flags &= ~clear_mask;
 		cache++;
 		progress_nr++;
-- 
2.25.0.vfs.1.1



