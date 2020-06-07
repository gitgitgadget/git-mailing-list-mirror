Return-Path: <SRS0=8Spe=7U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E12C433E0
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 06:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46E1620659
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 06:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLFMDkoY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgFGGI6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 02:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbgFGGI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jun 2020 02:08:57 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA75C08C5C2
        for <git@vger.kernel.org>; Sat,  6 Jun 2020 23:08:56 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 185so7187866pgb.10
        for <git@vger.kernel.org>; Sat, 06 Jun 2020 23:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=IdoW5zKfem1TV4utMr8FFDwZXpagDxXQpdt2tg/rnzo=;
        b=bLFMDkoYdU0Q7RGHEVrbYUxu6vgKdVqZijkm1rchn0Pu/N+EzR9IBxAh+TY3FvfJnp
         v3RPX4q0IA68nWm5QEcw0alkd3J4NwyDHjOyP6ZV+ArUy03ZvabxbCOt5R3aarpsJYhV
         8mkOjx/2bBX28ySpKcOtht2TBF54VtmDcsuj0VEDz6eWj7Y2LAGft1o6Un2UBa3BIDAq
         Ay5Fq4TlX1OJ+AgkaJfKdj8vNsu2FzxM9COfRhatH+Gi25tqosb0Jf5vBcl0PrjfIy4G
         stHkVsJ97OfpSx8opSVnOJm53n6bCiuVisWlDK7qtW9Pxs6Qdc0nvBZVAUnIEumnQrY4
         f9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=IdoW5zKfem1TV4utMr8FFDwZXpagDxXQpdt2tg/rnzo=;
        b=OmEy97p4dUilj4wf/F3mWGfMtwGSA/I5wnqKzSM9iYqhxL6BhcrDfOmKuYoEE1fzuw
         82GrBqW4V8m5wua0JcJLPwhcVYfMBke+Oh3ra240ZWizYx2kTnNmICAcbb2zz7m2nrLW
         5EnhKWjw3NPWMEy6nRcOipUvAb6iDJt4bcnH01XPlz35KWcojlG6H4RjAoPvF9j9ZI7a
         SmlF18BP4VH03h1eEDKzhJhl49o0Jq0Zjyri4G3vuVzTkETFfMNRw/eEeomwH3MtB2y7
         njnABo0h6qzAqU7GbgSd/+G63E7tPG4yUsZ2LfKbDW11JiS5W9ihSJ855Jj79mx8F8sc
         T8pw==
X-Gm-Message-State: AOAM533OPPMZ/8pHFXCAadZPx8jAlBPVJLmVgsGHN6I+pjtmTm/7vbE0
        BLWsjtpnIAGxvFQk9nHWTj/RcoJtX3o=
X-Google-Smtp-Source: ABdhPJw8HhbJYOmNB/SpP8ewQGcNuYkXPdwmYlxNM1N7sdCSlPpZtcw8M89gJ77gZ7B1Ot0x7wWOsQ==
X-Received: by 2002:a65:6902:: with SMTP id s2mr14134825pgq.199.1591510135147;
        Sat, 06 Jun 2020 23:08:55 -0700 (PDT)
Received: from konoha ([103.37.201.176])
        by smtp.gmail.com with ESMTPSA id o20sm11410508pjw.19.2020.06.06.23.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2020 23:08:54 -0700 (PDT)
Date:   Sun, 7 Jun 2020 11:38:49 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, kaartic.sivaraam@gmail.com
Subject: [GSoC] Week 4 Blog
Message-ID: <20200607060849.GA8615@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all!

This is the blog covering the 4th week of my GSoC:
https://shouryashukla.blogspot.com/2020/06/gsoc-week-4.html
I have covered what all I have done till now as well as the things I
have learnt (related to GSoC, Git and other things) in the blog too!

All feedback is welcome :)

Regards,
Shourya Shukla
