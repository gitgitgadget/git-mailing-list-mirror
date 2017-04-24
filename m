Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01BFE1FE90
	for <e@80x24.org>; Mon, 24 Apr 2017 08:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166433AbdDXIGy (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 04:06:54 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:35698 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1166414AbdDXIGw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 04:06:52 -0400
Received: by mail-vk0-f41.google.com with SMTP id 198so13359376vkk.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 01:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=/lfar9OpTFSH4c9wBLx9vodxZSxS9XqLdnD5SsmWljs=;
        b=tdL2KfN0t/JQbYnrRZ1G7+6PC5qwcmB4QLZhFmQPLtoGjZpMgJ3Kn/twqL09FsUqVm
         mkAE5qv0MYbrfDIYLs0kLPYS7RojdmfA+kZUcWNDbi7sSC+4xaZ1B1MLLG3ceJt5xGB2
         KqlOpilapDTASlTsuVfQOu7+r8AWkIoCxoa/Lq1kLGme2YzScrvReCLZrhiFOVzM/8HR
         K0QPKmAIEeFmT2NTgZuHOrDuRCtWM6ol2cyhm2fVks6lflPn7Rf14am76fROZBpTXg8L
         DBW65lEEE8R/i7aE3c6yNTkQz5m4xft7R1/CS8RylBy52osvE9ORWQvUus31FzaXsLub
         GmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/lfar9OpTFSH4c9wBLx9vodxZSxS9XqLdnD5SsmWljs=;
        b=luH1I8dk4M9ucC7w7+FuIl8WbO70LSvFO175QO0pNISf+ktpwaelFLPH5MIPqb+I0Q
         lOau5H8XeHuUiihK3jlgB1jURqEnZuKIT00sT1P1YERuKVwxywcmUCJGnM0LLi/ZqnPK
         GmFbCkflrf0//VRo0gDotp1BbjcCCse3SC71CcMtBi1qOYL8hyyM/cZRcfk3z23T1WCm
         R1FPpMJVUqHOUS5XF0h9yluodqPYPTC4L919HU+cBda+e1mh/WP9hRPt2uReyKdXGOmz
         AoId8QNc6re1hWlPdI64kDSG6XS9axdQnnaH3YE2ziYigC/tTRdsXFpPLIKelwb8f8n9
         +9Rw==
X-Gm-Message-State: AN3rC/4olnNl7wPiEJltaOmz0+OpEBeWDFVEyTHBij9ANxsPbi484Yej
        pDqXhB4Bpl3qqKI1GnvNnH60Q3USSDLQ0jA=
X-Received: by 10.31.147.136 with SMTP id v130mr1769849vkd.164.1493021211346;
 Mon, 24 Apr 2017 01:06:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.183.8 with HTTP; Mon, 24 Apr 2017 01:06:50 -0700 (PDT)
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Mon, 24 Apr 2017 11:06:50 +0300
Message-ID: <CAGHpTBJCjNa8gQRkMah30ehESdsVVKNy+6CuLSf9hfDedR+tPA@mail.gmail.com>
Subject: Submodule/contents conflict
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've noticed a strange behavior with submodule/content conflict. My
current Git version is 2.12.2, but the problem exists since I
remember.

Branch A has a submodule.
In branch B which diverged from A, I replaced the submodule with its contents.

Now, every time I merge A into B, and A had changed the submodule
reference, all the files inside the ex-submodule directory in B are
being "re-added".

Moreover, aborting the merge prints an error, but seems to work
nevertheless, and if I run git reset --hard all the files in that
directory are actually written to the disk, even though they haven't
changed at all.

When the submodule is small, it might be ok. But in my project we have
a huge submodule with ~16K files, and on each merge all the files are
listed, and even mixed reset takes several minutes.

The following script demonstrates this:
#!/bin/sh

rm -rf super sub
mkdir sub
cd sub
git init
touch foo
git add foo
git commit -m 'Initial commit'
mkdir ../super; cd ../super
git init
git submodule add ../sub
touch foo; git add foo sub
git commit -m 'Initial commit'
git checkout -b update-sub
git update-index --cacheinfo 160000,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,sub
git commit -m 'Update submodule'
git checkout -b remove-sub HEAD^
git rm sub
mkdir sub
touch sub/foo sub/bar
git add sub
git commit -m 'Replaced submodule with contents'
git checkout -b remove-2 HEAD^
git merge --no-ff remove-sub
git merge update-sub
# Adding sub/foo
# Adding sub/bar
# CONFLICT (modify/delete): sub deleted in HEAD and modified in
update-sub. Version update-sub of sub left in tree at sub~update-sub.
# Automatic merge failed; fix conflicts and then commit the result.
git merge --abort
# error: 'sub' appears as both a file and as a directory
# error: sub: cannot drop to stage #0

- Orgad
