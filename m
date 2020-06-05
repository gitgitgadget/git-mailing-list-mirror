Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD77C433E0
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 05:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9ECD207ED
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 05:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coUGVpHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgFEFee (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 01:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgFEFee (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 01:34:34 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FE2C08C5C2
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 22:34:33 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 18so1725836ooy.3
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 22:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=BYA6FvHxOg8He37QQUHJHz03tX6JzhQgNt8GcuR0J9k=;
        b=coUGVpHKH/KWP7IEYiO3Pdmy6B+dcBW28mQj44k/PiYSJGziEr3BVbl+kr5BPiQNuV
         /OCy4ApRnDPg1ir0yVN7ZU0ZtPP3oOpxTF8y5jPORytSXrZCgSVC5haQ/MzQk64kQCii
         Yzt2YuDChu3uFtpprnSt2oUQ6xoOtQ/mER+Fzz0hJnXlNVVhqQsSvKw5GBo18COCu3Jy
         4UW9Mx4zimZ7lpd73tSQhO0K3T3YWDvcTjZeFhEg6WuHefKcSAq/c0z6DQntx3BDS6XJ
         OAk4jDmHIFImFwf/iXJ2iAmRzb6vceKCEF3LEMMVhYpMlCGdwyZI6sI1Z0k6IllDpuya
         Js5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BYA6FvHxOg8He37QQUHJHz03tX6JzhQgNt8GcuR0J9k=;
        b=mmpL9q92+UxijQiq+JO6rUBXLwwvQhZ34I/ATn1QtiorJDMe7NezoDXiD7/wSn5SYn
         AgytG9PnQS2D1YsKtX99ZRQqdyaUr72Ktx0MQmbpIrJAgZGBh49fL2kZZzDBuxfqWtBw
         YNx9NjkjdnLLUxFDIS5fMSoR2W6raCIQ+4/t5ORVO+qepWwFk9hfQAyyvDFnGEgcCioU
         5tcG0BrkTtEWceRre/YS2YqLx5aywYxc5W5qeUSVPhNqSWF91Le0JIs8c7nyejPFVj/8
         BXew7ZgjCBvkM47wwdEYSh986zRWX4fOFkyUye+9DrDJUhk2b6ATCdB+xuhiMdIoaF6d
         fDFA==
X-Gm-Message-State: AOAM530RR1GzHdpno1RtuIyIIw5lfK8Nh71P/zxWohJLLEBupMcc0xxa
        KI3cQLGIbrkNETx67g+0NjSlVUsSCBlD6KIiElnZ5qJh1bQ=
X-Google-Smtp-Source: ABdhPJwvRiG6XBJgTcZtPMLrk1SyxMoqFaF4qgASUbFHLKUFCSUmj428I0HE8l9VjQHh/ofJ1L//7l8+ksYKvVJpFks=
X-Received: by 2002:a4a:94d1:: with SMTP id l17mr6423630ooi.88.1591335272264;
 Thu, 04 Jun 2020 22:34:32 -0700 (PDT)
MIME-Version: 1.0
From:   Varun Varada <varuncvarada@gmail.com>
Date:   Fri, 5 Jun 2020 00:34:21 -0500
Message-ID: <CAD2i4DCyovfV78rXwH+B+tNOeDM7rJCHWSCPFOiCv7mVR+56ew@mail.gmail.com>
Subject: Standardizing on Oxford English
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I noticed the Documentation/SubmittingPatches file reads:

> We prefer to gradually reconcile the inconsistencies in favor of US English

May I ask why? US English is highly idiosyncratic, illogical, and used
by a minority of the English-speaking population of the world (see
https://en.wikipedia.org/wiki/American_and_British_English_spelling_differences).
Since British English has its own idiosyncrasies, why not use Oxford
English, the most international English that is used by millions of
the world? It is used by practically every international organization
(such as the UN, ISO, IEC, BIPM, NATO, etc.), taught in practically
every school in non-native-English-speaking countries (and even
native-English-speaking ones), and used by myriad publications (e.g.,
Nature) and people around the world. Given the inherently
international nature of the Git project, it makes complete sense to
follow suit.

Regards,
Varun
