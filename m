Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7357C46467
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 22:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjANWO7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 17:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjANWO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 17:14:56 -0500
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498969ECC
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 14:14:55 -0800 (PST)
Received: from [IPV6:2a01:e0a:4b3:a730:2ef0:5dff:fecf:e60a] (unknown [IPv6:2a01:e0a:4b3:a730:2ef0:5dff:fecf:e60a])
        by smtp3-g21.free.fr (Postfix) with ESMTP id 7A03D13F86A
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 23:14:51 +0100 (CET)
Message-ID: <d0f9520d-9ccc-a899-609e-fbbb4529e005@free.fr>
Date:   Sat, 14 Jan 2023 23:14:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   =?UTF-8?B?RnLDqWTDqXJpYyBGb3J0?= <fortfrederic@free.fr>
Subject: Segmentation fault within git read-tree
To:     git@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I am doing some tests trying to do a sparse checkout of a partial clone 
within a subtree.
However, I get a segfault when trying to run git read-tree as is done by 
git subtree internally.

Maybe what I am doing isn't supposed to work at all, but I suppose it 
shouldn't at least cause git read-tree to segfault.

Here should be a MWE to reproduce my error:

# Run this to create the repo that will become your subtree
git init subtree.git
cd subtree.git
touch x y
git add .
git commit -m "first commit"

# Run this to create the repo that has a sparse checkout of a partial 
clone within a subtree
git init repo
cd repo
git commit --allow-empty "first commit"
git sparse-checkout set "subtree/x"
git remote add origin-subtree git@my.server:/with/the/subtree.git
git fetch --filter=blob:none origin-subtree
git rev-parse --verify "FETCH_HEAD^{commit}"
git read-tree --debug-unpack --prefix="subtree" FETCH_HEAD

Yours sincerely,
Frédéric Fort

