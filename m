Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42004C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 11:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8E5206E6
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 11:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcVNhwlG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgC0LpB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 07:45:01 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:36132 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgC0LpA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 07:45:00 -0400
Received: by mail-wr1-f41.google.com with SMTP id 31so11038698wrs.3
        for <git@vger.kernel.org>; Fri, 27 Mar 2020 04:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=bdhcN8cGjljRgav470q8cgYs4iwGZuoWdepeMcq5EfI=;
        b=bcVNhwlGShSyacbp7XDUtHh1WPC3u+1b/csKNFLpuQfKEt6UBgQr88Z+6fCfX+4W2u
         MGJTQGCDYp1KuqHtgGSG0fBxOCKDyLbEdKK4Wa4zK/1ooUTZ7gTRIj3+c8qeG/29mNWK
         vBkpFsNS5MydPBVbfWyRMxEtuf7t3rawHyQZoSpmZYBgK27lbhNk66QYA5Dv2LJPn6FC
         jjjiSnNkDM4qH4Om0jGtr3NK5lSD2GLntkeZ2TUKCczStpSq3AvhsbluTdyu/Ok6/Otf
         ZW1VZe7YFxPxLjLqNdN6eaoHEkMR1gsDCUuwjYNP6CG87n4Cay5CLVhSJKK7tmxZC7Iz
         9MIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=bdhcN8cGjljRgav470q8cgYs4iwGZuoWdepeMcq5EfI=;
        b=Tzz9ft8dmGZ5OM61J6s0oohfMOqYYAXTQcO3Tj1St/NTTdXR5xtWmj+jz8Lh6MWdZ3
         +eo3ViLJ9ssiDbuvT6BDSVLKzM0TzPoNDqw7xNS1QgTt1/2SlWX6aEnpLceOAT+v5UjT
         DMyJCwTsXzR/+yLRDg47nL/yb1FjQVy+yJQcCQlU0e1YTO7a4LQGJD23vQQMl1cq0X8K
         baD/66WIzAlIx1ZrISba3+RoLlOHjK/39PiG3dfmj7+bNs7uKy9AYH5yJjxI6CK9Y8pb
         9F1Ex4jK1htXxp4vldTaGytHUGTrfE7awIYjU1p4blLKJLu725guU5sBt5VmV2OxxMEG
         2tnA==
X-Gm-Message-State: ANhLgQ3paz8MzNw1sDDZoKNHzNf5wXrXEeVcP5YE06FyNuLjnUE5t04W
        fPgYu4p7IWQvgKXuusOtd6Jt7kRETNY=
X-Google-Smtp-Source: ADFU+vu1KMP0Qa04db8d10rgGhaBtPj1fbLUqemuemWyGe3q7dSACP8l4u1fGOh38+nZCr3jW25+5w==
X-Received: by 2002:a5d:550c:: with SMTP id b12mr3708226wrv.304.1585309498633;
        Fri, 27 Mar 2020 04:44:58 -0700 (PDT)
Received: from ocellus (p200300EAE7168C007DE5706AB5458F3F.dip0.t-ipconnect.de. [2003:ea:e716:8c00:7de5:706a:b545:8f3f])
        by smtp.gmail.com with ESMTPSA id s2sm7680661wru.68.2020.03.27.04.44.57
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 04:44:58 -0700 (PDT)
Message-ID: <9b4bc756764d87c9f34c11e6ec2fc6482f531805.camel@gmail.com>
Subject: git rebase fast-forward fails with abbreviateCommands
From:   "Jan Alexander Steffens (heftig)" <jan.steffens@gmail.com>
To:     git@vger.kernel.org
Date:   Fri, 27 Mar 2020 12:44:57 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Since 2.26.0 a simple "git rebase" fails to fast-forward a
branch, reporting "error: nothing to do."

It started to work again after removing my gitconfig. I've
reduced it to the following:

    git init foo; cd foo
    git commit --allow-empty -m foo
    git commit --allow-empty -m bar
    git checkout -tb foo
    git reset HEAD~
    git -c rebase.abbreviateCommands=true rebase

