Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F94C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 11:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbiFOLYa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 07:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344205AbiFOLYT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 07:24:19 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA33135A8A
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 04:24:17 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id y19so22569080ejq.6
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 04:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F4UrA/9bkYMBqPebWF1tF6gPEQitL3B209MC9lUQ3i0=;
        b=gaRcnMuJcvX/KUQeQSUl5dd8GTNE2QCemZ0Pc3vReGp5Q91N8Ib0UNMxeTvkfxPJkJ
         QenCmqJedkCn91EYKBrG7NBMCb+xrMdfPbE8NKkb+HuMkW1Qis5jW/AgdqJaTV662t5c
         kbAaTYmN9coxj6Yi01oLNmpvIzFh4ESWWhVZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F4UrA/9bkYMBqPebWF1tF6gPEQitL3B209MC9lUQ3i0=;
        b=x+xxMzeuacxbxxMF/cJI41is2F7FXA7vYSL2urFqQJU7eeNUJh5YZdm6zbK5Wzuzwy
         wUAQT+d2xhTyJs1wAm1BNAonFMU9a/SBFY5hFB0yjIt1ociDy6X8WeGPQBWuRiPUuWnc
         3D++U6YByoCxRu7MzntXEMtILJyr4nxYVIxhJT6VfPzrv/QiwZOetyZEAhAw3ZIFQHdB
         HrnB6Pk0jwC3VSZh2AYLkmTa4Gj9pJfb9CX+LKpu65QZUTIugRtRv/DDBCd9uFiZvSqs
         q9Dsc2ryiPWK6zBj36HX3esbVhGZm80/Fyx8ksFvyKnFvAHXN3pVw8U7fiLvsceOFXTB
         RunA==
X-Gm-Message-State: AJIora9GN62wGw6Vz+hAJdelQPdzTAEmss8lSquwIYsJ5Ch3VSvlU8bw
        C8nOs9uIfsSQOVBWIs4VtJy1wBgrAK8YKoY7iuRaIXgl3OxFlK/W4xY=
X-Google-Smtp-Source: ABdhPJyvd1fBj5yILgGI3muNDyQd68x0938DW70ufnUorA83qHeQu8aZhGMVYlLe8qzRZr6Eem8a0roy1suwfX83Qc0=
X-Received: by 2002:a17:906:2b5a:b0:707:ce7b:94eb with SMTP id
 b26-20020a1709062b5a00b00707ce7b94ebmr8228411ejg.335.1655292256369; Wed, 15
 Jun 2022 04:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1257.git.1654967038802.gitgitgadget@gmail.com>
 <xmqqleu3au2n.fsf@gitster.g> <xmqqedzt8nfq.fsf@gitster.g> <CAPMMpogcm36pd7fjvG64G7Vg29arukF-wzOKYbNYG9NOpVCXvQ@mail.gmail.com>
In-Reply-To: <CAPMMpogcm36pd7fjvG64G7Vg29arukF-wzOKYbNYG9NOpVCXvQ@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Wed, 15 Jun 2022 13:24:05 +0200
Message-ID: <CAPMMpohZbcK1a8T+eoTdG2wjaOvLun1E0QZEEVv6QTxhHb8r5w@mail.gmail.com>
Subject: Re: [PATCH] apply: support case-only renames in case-insensitive filesystems
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 14, 2022 at 8:22 AM Tao Klerks <tao@klerks.biz> wrote:
>
>
> New patch coming.
>

Quick update on this - while exploring test scenarios I found an
edge-case where these changes *seem* to introduce a regression. The
probably-problematic behavior is that if there is a
differing-in-case-only (case-insensitive duplicate) file (with
different content) in the index, but obviously not on the filesystem
as the case-insensitive filesystem can't allow both files to exist,
the "git apply --index" of a case-only rename from the original
filename to the "duplicate" filename will replace that duplicate file
in the index, replacing its original content. With these changes, the
rename of a file can, under very specific circumstances, cause a
"rename" patch to replace/delete unrelated data in a staged-only (and
maybe also committed) file.

I need to do more testing to understand the relationship between this
behavior and similar scenarios in, for example, git checkout.

The current patch can be found at
https://github.com/gitgitgadget/git/pull/1257, but I'm not sure when
I'll have time to investigate further, settle whether this is a
(meaningful) regression or not, think about how to address it if so,
and submit a v2 :(
