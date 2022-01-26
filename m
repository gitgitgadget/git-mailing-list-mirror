Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E33C2BA4C
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 16:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243254AbiAZQn0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 11:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236669AbiAZQnY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 11:43:24 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A436C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 08:43:23 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id k25so40073418ejp.5
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 08:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:to:content-language:from:subject
         :content-transfer-encoding;
        bh=z1YIZLB1n/7L1NzRVtrWek/H7BoCvPP+5MIRI2XW5GI=;
        b=dUFBqh5CZeM7Qf0EYJdDCH65LUZEdZhNqjeVh4s6L7Uea/j4PM1u3WuyQg40CURcT0
         hXoUai0/ovxAlGYSf60lNxaCv1yWZMtEnmURB3Ii47hyAO2NDeJev7OK+mzw4cewePWR
         ePmaIKzlAj+Ig4KaZdxJcspwuAox9S/l+88rcn2I9409zsRGwclrI1m5rEEbGWDOsbKP
         OPOwZ+SXTWfiMbKeoixmQIePqCC8+F1/bL/rblkFwv5sYbAXKlKAsuAitI/8hJktVWRC
         j3Hr45B/emhDNr7NE5D+7KEyLQj8FUQzE8qr9+/ey1L7HlZXqiJEYwpRvvZ0jGm+fCt+
         K2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:to:content-language
         :from:subject:content-transfer-encoding;
        bh=z1YIZLB1n/7L1NzRVtrWek/H7BoCvPP+5MIRI2XW5GI=;
        b=CXlDULXUKdZ0IzyJz1Zr5L6Q82F3vWYrCDXzEzulbI7ijAPqDHRimp6+U/zO0qVKzE
         fxU7URRJ31vqIVxvNOUL5BaAsUOFk6IwdYvAI5wBuoKAzMyOPlKB9GogutZbU22BCOOO
         VnYHR18v0CSYf5lZEcKkVBuzgyNMZ/c/QAfi/hx5D3KOvfN1mfKLjs+2y1LgrKDB303W
         n9pT4KBa6v+QoVBRqAHlL6+VznArvxNlbBI/0Te0VOD7anKqPHB6eCt9iLJVjL/TXSdJ
         p41J5twSxnVm83qox7GO8Egu06gE7ea4RAK1ZyHP/Z1IuVCGZvY0UFKG3B4q0jayOiCI
         s1+A==
X-Gm-Message-State: AOAM532y4aYl2eDgfl4d9EU8be2P2n2Mis7g2VfQHSSWdc/OCmVdzAgK
        xaDnucvme4wQ3QSDE4tQUSlfyzsBlK8=
X-Google-Smtp-Source: ABdhPJx91OJ8e/fl+5tQsSVoJcWadOrmnTKu94m41tf3xT3QPY0093PE+pQVG/kXImnrbbe7zAcGWA==
X-Received: by 2002:a17:906:d9a:: with SMTP id m26mr20812370eji.762.1643215401897;
        Wed, 26 Jan 2022 08:43:21 -0800 (PST)
Received: from [192.168.178.26] (ip5b40c18c.dynamic.kabel-deutschland.de. [91.64.193.140])
        by smtp.gmail.com with ESMTPSA id oz3sm7654665ejb.206.2022.01.26.08.43.21
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 08:43:21 -0800 (PST)
Message-ID: <2a50d67e-364b-5927-801b-00f38179e904@gmail.com>
Date:   Wed, 26 Jan 2022 17:37:52 +0100
MIME-Version: 1.0
To:     git@vger.kernel.org
Content-Language: en-US
From:   Federico Kircheis <federico.kircheis@gmail.com>
Subject: git worktree, submodule and force checkout/switch
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello to everyone,

I would like to report what I believe is a bug, or at least an 
inconsistent behavior when using submodules and worktrees.


Consider following test-case

----
# create 2 repositories with one commit
mkdir repo1 && (cd repo1 && git init && git commit --allow-empty -m "repo1")
mkdir repo2 && (cd repo2 && git init && git commit --allow-empty -m "repo2")

# add submodule, a couple of branches, and a worktree
cd repo1
git submodule add ../repo2 && git commit -m "add submodule"
git switch -c branch1
git switch -c branch2
git worktree add ../repo1.w --detach


# test switch in the worktree
cd ../repo1.w
# git switch works
git switch --recurse-submodule branch1
git switch --recurse-submodule master
#git submodule update # (1)
cat .git
cat .gitmodules
cat repo2/.git # (2)
git switch --force branch1 # (3)error if no submodule update
----


Notice that if one forgets to git submodule update (1) before git switch 
--force branch1, even when using --recurse-submodule, there is no 
submodule, as repo1.w/repo2/ is empty (2).

It is confusing/unexpected that git switch --force fails and creates a 
repo1.w/repo2/.git file pointing to the wrong location.


As comparison, when cloning a repository and forgetting to do "git 
submodule update", then "git switch --force branch1" works as expected:



----
# create 2 repositories with one commit
mkdir repo1 && (cd repo1 && git init && git commit --allow-empty -m "repo1")
mkdir repo2 && (cd repo2 && git init && git commit --allow-empty -m "repo2")

cd repo1
git submodule add ../repo2 && git commit -m "add submodule"
git switch -c branch1
git switch -c branch2

cd ..
git clone repo1 repo1.c
cd repo1.c
git switch branch2
git switch --force branch1 # works, event without git submodule update
----




Notice:
In both cases "git switch" and "git checkout" behave the same.
Also the parameter "--recurse-submodule" does not change anything.


Best

Federico


PS: I'm not subscribed to the mailing list (yet), so please keep me in CC.
