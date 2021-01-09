Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6238C433E0
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 16:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7602D23A3C
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 16:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbhAIQZX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 11:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbhAIQZX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 11:25:23 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721B3C061786
        for <git@vger.kernel.org>; Sat,  9 Jan 2021 08:24:42 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a12so11899378wrv.8
        for <git@vger.kernel.org>; Sat, 09 Jan 2021 08:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=6k5cbUFXiXWNB1KWk7Gul9Yhd8QF2lxF1EJAWHtGS1I=;
        b=gc3Jd20ZZaDgueO5cujMHeOAAnSxA3dNdepuUIVZioKI0UsidvDEldtqh9RnkEgoRC
         Nfe4cWwbwz1BVMOdN7BwuZ2Qw23HjU3DTXIzBuq0QZaDiuSjm3AE7wYPHAuLbJwQ1iL4
         vgVabEzoD6mcZ6ym1ACQUsmBJZKtDHStqrexH6J9AAGWk5D64eowXQXZTEzdv+13TZf4
         dBEqpwxgHqcuB5VHwhb64ZkZr32jUj3zlVzS823eTPJLXBkLtc6DVmmb216f6mi5GhRa
         yQYy5bjqtufNejwlpzZgjOAuGEOCkN2k8hfFtVz1eZyQLgmXPykEx4LrXjaDYhdLTS0F
         hTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=6k5cbUFXiXWNB1KWk7Gul9Yhd8QF2lxF1EJAWHtGS1I=;
        b=HRkvmkaNGBcnW3f7THrljDD0RgIbSnmIaHfN/FXImJ/e4ZDS55mPkxWxN4c8Yt7A9U
         XSfbYTlRX54+7mRxXe0sxkNVlapsj3WeCRZrIrn7dRVyL9O5eJKh29W/nDxt/Hk7A2US
         HAWQ0P8GET0tw+bJYWkatdAeE1d35h04WX7NgrBEPu5ZI6K6Qte0ziYbYhR7ZpEffWMz
         2twXovt5MjJZuEys1u8i7R+4NwUE6wg2b9SDR2/TPq2B2wvasTpsy28pYfoMKnepkpwb
         tgCxj0NQVTDet9Gqyeg2m6BNXWCqOL1TcAIZad+QO9aJDRn6qDk+zd3sT1fDW0ahDOyy
         LDZw==
X-Gm-Message-State: AOAM532++T/0JB39ishQgdJAR8x48RBmd/+d2Dz48wW9z7KxMMY8bd8t
        EPodhr765ApxNkLTVjapxbRc5KC/BjyA
X-Google-Smtp-Source: ABdhPJxeRuFmkziXgPnyQTt/6IQR1aI5ktutS1p+lS4w5+kW2dHS1Ff42TDpCm/iO/lCL65s//EA7Q==
X-Received: by 2002:adf:e705:: with SMTP id c5mr8494665wrm.303.1610209481200;
        Sat, 09 Jan 2021 08:24:41 -0800 (PST)
Received: from sync (90.ip-167-114-239.eu. [167.114.239.90])
        by smtp.gmail.com with ESMTPSA id l7sm15870285wme.4.2021.01.09.08.24.40
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Jan 2021 08:24:40 -0800 (PST)
Date:   Sat, 9 Jan 2021 16:24:40 +0000
From:   Arnaud Morin <arnaud.morin@gmail.com>
To:     git@vger.kernel.org
Subject: rev-list with multiple commits sharing same patch-id
Message-ID: <20210109162440.GM31701@sync>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey all,

I am struggling with a rev-list command, hope someone can give me a
clue on what is going on.

I have 2 branches:
$ git branch
  B
* master

Currently on master, there is not diff against B:
$ git diff
(empty)

The commits in B are cherry-picked from master.
Here is the graph:
$ git log --graph --oneline --all
* ae2e3c4 (origin/B, B) remove line2 and add line4 (bis)
* a7a0339 remove line4
* caa4aad restore line2
* d7dc596 remove line2 add line4
* 44bcfd4 add line3
* e372641 b
| * dbf86d8 (HEAD -> master, origin/master) remove line2 and add line4 (bis)
| * 4017282 remove line4
| * 0f2a449 restore line2
| * 8969d3f remove line2 add line4
| * e73b420 add line3
| * fe5a75a b
|/  
* 6192505 a
* b4089e1 init


However, when using git rev-list to perform a symmetric difference, git
is giving me a commit ID:
$ git rev-list --left-right --cherry-pick B...master
>dbf86d8aafc897a25a3093139b4237a62395041e

Note that this commit is not empty
$ git show dbf86d8aafc897a25a3093139b4237a62395041e --stat
commit dbf86d8aafc897a25a3093139b4237a62395041e (origin/master, master)
Author: Arnaud Morin <hidden@mail>
Date:   Sat Jan 9 10:30:10 2021 +0100

    remove line2 and add line4 (bis)

 a | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)



So, from git rev-list perspective, there is a diff.

After digging a little bit, the thing is that this commit is having the
following patch-id:
$ git show dbf86d8aafc897a25a3093139b4237a62395041e | git patch-id
20f4ace68e80a751b07d78a27c94e83d6c5314bc dbf86d8aafc897a25a3093139b4237a62395041e

Which is also already existing in an other commit:
$ for c in $(git rev-list HEAD) ; do git show $c |git patch-id |grep 20f4ace68e80a751b07d78a27c94e83d6c5314bc; done
20f4ace68e80a751b07d78a27c94e83d6c5314bc dbf86d8aafc897a25a3093139b4237a62395041e
20f4ace68e80a751b07d78a27c94e83d6c5314bc 8969d3fa9159730fd3b23199873bfb26e3d20027

So, is it normal that rev-list is not able to figure out that a commit
is existing in both branch when 2 commits share the same patch-id?

Is there any way to prevent rev-list from showing this commit?

Thanks for your help.


PS. I have uploaded my test repo here:
https://gitlab.com/arnaudmorin/git-rev-list


-- 
Arnaud Morin

