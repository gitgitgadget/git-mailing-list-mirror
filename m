Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A6CC43603
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 02:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC57120CC7
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 02:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RijIJHle"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfLUCTb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 21:19:31 -0500
Received: from mail-yb1-f169.google.com ([209.85.219.169]:36603 "EHLO
        mail-yb1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfLUCTa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 21:19:30 -0500
Received: by mail-yb1-f169.google.com with SMTP id w126so2709993yba.3
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 18:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:date:subject:from:to:message-id;
        bh=Z9sZT+GZOq6NQ9zQGSjY3D4fUh3KVLuM3tjyxkGmQ+A=;
        b=RijIJHle/O20jJWPfNRuTytsQ+pVTPRXRa6vr8UmgqWucWZR5uXtOpOIHApsI+KnsN
         /cCjRO/0Ld9HldvU1i0+7Y59XbRJCBzLDak9FPJT3zSRtxTVGHAEGlyP9Wew2f31cYNA
         5bsWBFCpGGTfPEXeS/GsysulJyTgrN2uiLKdI8i5UOATfH3SW2vCDQmPFc0YBFLwg4z5
         +KN7HuCdCTR3bfZ5URT098E+SUjqp+oPtDPo/rTa7cmyCHEgTaqOl/2G/V2pDFYgM+TA
         +mh+mnw68+SptiSY5wPbINiQvfxJ9tB+ZiFYxrEXsZmqVaPimORCfG2beNUEGK7E8rFl
         SWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:date:subject:from:to
         :message-id;
        bh=Z9sZT+GZOq6NQ9zQGSjY3D4fUh3KVLuM3tjyxkGmQ+A=;
        b=HRksOrL6Qf7l+s/5wGQ+SiURdNptxMs44IhWNIFT4Gxkbo68jnqHhPb+IBwR6QdcPc
         TjKF0OO41gG/NPd1xey/gbZWX+VICdPvfDoJzovY7REAQh38tc5/dDOQZ94Jx6bzllGw
         SwDhKqJN7EDfCBAczqVwYJgJj0GBSi2omTOsQx3jA17HK6FWf2BnOxeAXWsIdvYbc+cH
         zFy6lFvwSXmTqdwFN8KJ/LhpcxAXk830l7LLIXUY7lTWSjBHJuXF4dDRRIJTgEZXz4eX
         R//OZEtVkEFFH4kcxMZQu/BjItZIDsORfu9gaKMpXF+smeHBvuwHORR+Jb8MKokRAa8/
         pQeQ==
X-Gm-Message-State: APjAAAV7pxmrP8q8fRlp0R95aVxIT2ZhAtUbnX+tfW+zo4l6xg0KI6+1
        3zImNsBOA60PpkGUwGkZkT8j2hX2DFY=
X-Google-Smtp-Source: APXvYqyeVUwkPhJBlH1aW0ErecfuIKna2yKM0gjHYiXFKMK/lFDDBhBGVe1CZJh9tYqZOMmD/oU9vQ==
X-Received: by 2002:a5b:84b:: with SMTP id v11mr12503143ybq.367.1576894769438;
        Fri, 20 Dec 2019 18:19:29 -0800 (PST)
Received: from localhost ([108.209.60.34])
        by smtp.gmail.com with ESMTPSA id g65sm4523542ywd.109.2019.12.20.18.19.26
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 18:19:28 -0800 (PST)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 20 Dec 2019 20:17:57 -0600
Subject: Propose promoting 'contrib/rerere-train.sh' to command
From:   "Tom Miller" <jackerran@gmail.com>
To:     <git@vger.kernel.org>
Message-Id: <BZAQIE4YND2I.Z7BFCW7BLH3K@penguin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I would like to propose promoting 'contrib/rerere-train.sh' to one of the
following:

    1. A builtin c command 'builtin/rerere-train.c'
    2. To the top level directory as a built in script 'git-rerere-train.sh=
'

I have recently found myself writing scripts using 'contrib/rerere-train.sh=
'
and I wish it was built into the command. This would make it easier to use
rather than having to find it on different platforms. I think it could also
benefit from some documentation.

I am trying to gauge the interest in this change before spending some time =
on
working on it. I would also appreciate feedback or alternative approaches t=
o
what I have suggested. Thank you for your time.

Thanks,
Tom Miller
