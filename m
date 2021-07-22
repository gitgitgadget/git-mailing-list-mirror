Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88157C63793
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 10:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E1C161285
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 10:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhGVJo4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 05:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbhGVJoj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 05:44:39 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16675C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 03:25:04 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id f93-20020a9d03e60000b02904b1f1d7c5f4so1253248otf.9
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 03:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=C6l4i6TDg/05FKc+GCZpkYkAC0nvx2tMWdidL/aJVU0=;
        b=C9NqCTDOpPYGl8TbAmwy4fiX472nVwMOQgdhDrmzrgQZseyxe5uOaiHHvEKZ2PKsN8
         cH/Q7RnTAPW+3OZCC5aHTlzTH3Yfv2pGeEDILf5b2TVsmThkwT5nOYBR3Er6qwdTcfAH
         TVg3enToLHT1yUQnUjhc6ryX2gL4keXVtABt+p1WKGamARviN8YrxzJpILfRsZtc2qDg
         v3TysUXz/ZJiFHSTCi+93iXicOPZDisK0/28vsvC1pktRH1BSpAICuOCchlw/X9DldUQ
         ZIZQqdYNOKrS+hgG+L5Xc02Ee0tL7O2iLFzhTfowyFRxHzCWICvZtvIYwdIcMYnJrTX2
         WmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=C6l4i6TDg/05FKc+GCZpkYkAC0nvx2tMWdidL/aJVU0=;
        b=WQ7qeEX/J4JGMJaV/fsLn8fdSYwl5rrkiAEzarLKWY4hvCwGpvt53L3eq7g6CQrxiI
         01xALeNAYXhfqbYtkin2fKdTOSpBtDGLiV7Qzp3vMuTzRRUJ9g7uyKFsz55jOvsEP62c
         Y9wF1rYRocvCI+e/Pq6vQaKNmyNvDqaEL2tsCsCXBFlKcOGEScwBPtVnGrtxOFyzzsa9
         mVStdpLhv9+ijarD+3ep/K1moo0DEcKX3mdR8X3+R9W/CwOSmyF1Wc0ifONm3ggm3Yob
         A9XeBGa9gnb2W6hFMmKlVICIJ/Dx3epmrFdvq7z6172b8HW5ebIUqASSXq/Yjfht7YNw
         syFA==
X-Gm-Message-State: AOAM533uZuM8tIDTfZPKaFUT98FHJ45FD2tkQGClbCqv3lS03KbDHr92
        1mP26U1GaGvAFSi7OUZ7xyqIqY3rauKy7Q==
X-Google-Smtp-Source: ABdhPJwCBGI7A7i4awyf8caNKzERcq8TuZ9MgQ5tw8FQ4OAVWOYgZE9V0vXop7BdeqFjPP3TvgfNTw==
X-Received: by 2002:a05:6830:2a0b:: with SMTP id y11mr16555204otu.275.1626949503450;
        Thu, 22 Jul 2021 03:25:03 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id z14sm3961953otm.66.2021.07.22.03.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 03:25:02 -0700 (PDT)
Date:   Thu, 22 Jul 2021 05:25:01 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     BENTZ Sylvain <sylvain.bentz@md6.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <60f9477d9cd3a_3fba2082@natae.notmuch>
In-Reply-To: <bdb6c03f290c49bb96e6c0a3d9742a52@md6.fr>
References: <bdb6c03f290c49bb96e6c0a3d9742a52@md6.fr>
Subject: RE: Bug: Commit a merge resolution with non-closed conflict markers
 leads to errs, segfault
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

BENTZ Sylvain wrote:
> I've stumbled on a segmentation fault while resolving merge conflicts.
> Basically, I missed to remove some conflict markers, tried to commit the
> (faulty) merge resolution, and Git mishandles that.
> 
> The original issue happened applying a patch using 3-way merge.  The minimal
> working example below creates a conflict with a simple `git merge` command.

A quick workaround:

  git config --global rerere.enabled false

But yeah, there seems to be a bug in `git rerere`.

-- 
Felipe Contreras
