Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BE5C433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 13:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7675A23A6C
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 13:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbhANNza (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 08:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbhANNz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 08:55:28 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363D5C061574
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 05:54:48 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id f26so7836364qka.0
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 05:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=UKKZjRTHYHqnCf7QKdllxyP/6nLm/skxEV4/9md5rOE=;
        b=ssqjvFU77jt2zYPLwpdspzgkXVR5PYEMgFkfvSgiRX6xz9Y06rHn3aV9JiVy35fxlD
         hG8GXVl6lv7hSXxR8N/grY/4XfL6t1Us4NpzG0hv4RGUWxPi6p3T6CCNtLQ8ZJCjz/kG
         dM00jJL94YPnntSoXcuAmLQ0wTVd+KpZ2HNQE+lPwsRgzN/PPGZXiGNL7NkTu8sfTVTM
         /+MswGPqB+CpnJUBoMR9PF2jLgfc2o3OBHHzLK7FN1o82vkOFuObWsI87fFFRMmYqNb0
         tjvydTm8nYddxThqbyh3h5vU5MrD2G1tJxbzhubLc/V+KAcVJ7JSZ1mIINhBlcMQyVHz
         Py8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UKKZjRTHYHqnCf7QKdllxyP/6nLm/skxEV4/9md5rOE=;
        b=LihSvShqz1s5HL0DyytfliuAO+nFe8XlyQtN63Lm9Pqs9P2ZgbzoOB+CV7j/mY3KHr
         GP5GEPxz1lfJlEMVi6aCBSFsbvlyZD8CKy+Xn6lxNUuiQZ8qLlfCm8wMQHSWFlQEEgYY
         HJoG8IB/pVg/UqDEhNIxYQ3uSQR1t2LaVqai5teXe8kIhKgB1s1Ym3WY8/0d77WjsyBN
         sm4XW0S6rmebIgZbK7DG75A8SUfDW55MvLdHLbS0Lp3F/Qrh0yjaAvmZ4yzQXLH3DplU
         s2Y1xQe1A0YWwaCeOgFRCCvKWRpC7B36skrAU29o0rO6959ws++9Huf7Ijfu5YMqoq22
         2CXQ==
X-Gm-Message-State: AOAM530WxN4zn3/GlTRbUw8Ix6YiI4sdaHGMV8K4h77BG59rqvV269q3
        ZZ/5fsJDIu43FyBsXZdd7/lIDyEMCic=
X-Google-Smtp-Source: ABdhPJxO7eRlB0rZmRvzkdtxpfOrVg6u2Y/EBNxOrLQ9ZsllwjC8DFacw9LievIUs6v256iEvck84A==
X-Received: by 2002:a37:4f12:: with SMTP id d18mr7101642qkb.42.1610632487018;
        Thu, 14 Jan 2021 05:54:47 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id r8sm2960341qkm.106.2021.01.14.05.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 05:54:46 -0800 (PST)
Subject: Re: bug: checkout --recurse-submodules discard uncommited changes in
 submodule
To:     Kevin Bernard <kevin.bernard@fiveco.ch>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <570e77a07f0b4d4ea09307e5fa819d6f@fiveco.ch>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <05afbdeb-6c72-f14c-cdf0-e14894de05a3@gmail.com>
Date:   Thu, 14 Jan 2021 08:54:45 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <570e77a07f0b4d4ea09307e5fa819d6f@fiveco.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kevin,

Le 2021-01-14 à 03:35, Kevin Bernard a écrit :
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> Make a git repository with a submodule in it.
> Make two different commits in the main repository with two different versions of
> the submodule, one of them is the head of the branch.
> Checkout the head of the branch in the main repository, and make a submodule update.
> Make a modification, do not commit it, in a submodule file that will not result
> in a "error: Your local changes to the following files would be overwritten by
> checkout" when the other version of the library will be checked out.

I assume that you confirmed that by running 'git checkout <other version>'
in the submodule, right ?

> Go back to the main repository and make a checkout of the other commit with the
> switch --recurse-submodules.
> 
> What did you expect to happen? (Expected behavior)
> The checkout with the switch --recurse-submodules should fail when there are
> uncommitted changes in the submodule.
> 
> What happened instead? (Actual behavior)
> Uncommitted changes in the submodule are discarded without any notifications.
> 
> What's different between what you expected and what actually happened?
> Loss of the uncommitted changes in the submodule.
> 
> Anything else you want to add:
> I stay at your disposal if you need more information.


Thanks for the report. This is a known problem that was reported in [1] and [2].
I'm currently working on fixing that bug. I'm not quite finished yet as I want
to polish the end-user experience a bit, but if you want to compile from source,
the heart of the fix is this change:

diff --git a/unpack-trees.c b/unpack-trees.c
index 323280dd48..a3e3d98de1 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1872,7 +1872,7 @@ static int verify_uptodate_1(const struct cache_entry *ce,
  
  		if (submodule_from_ce(ce)) {
  			int r = check_submodule_move_head(ce,
-				"HEAD", oid_to_hex(&ce->oid), o);
+				"HEAD", empty_tree_oid_hex(), o);
  			if (r)
  				return add_rejected_path(o, error_type, ce->name);
  			return 0;


This should disallow switching branches with '--recurse-submodules' if *any* file
in the submodule is modified.

However, I'm actually thinking that maybe it would
be better to let the checkout succeed in the exact case you mention, i.e. when
the modified files in the submodules are at the same version in both submodule
commits (i.e. git checkout <other version> in the submodule succeeds and the
modified files stay modified), and also carry over the modified files in the
submodule. This would mimic the 'git checkout' experience
without submodules, i.e. modified files that do not conflict are carried over
to the branch you are checking out.

If you can write a complete reproducer (complete steps starting with 'git init',
etc.) I will make sure that your scenario is adequately tested in my patch series.


Cheers,

Philippe.


[1] https://lore.kernel.org/git/CAHsG2VT4YB_nf8PrEmrHwK-iY-AQo0VDcvXGVsf8cEYXws4nig@mail.gmail.com/
[2] https://lore.kernel.org/git/20200525094019.22padbzuk7ukr5uv@overdrive.tratt.net/
