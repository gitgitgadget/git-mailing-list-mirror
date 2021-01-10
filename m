Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677FCC433E0
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 14:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 234B62082D
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 14:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbhAJOpH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 09:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbhAJOpH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 09:45:07 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0FFC061786
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 06:44:26 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d26so13705795wrb.12
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 06:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FOPuPp4vjmkzKmlY670Q9FDbgvln4gKbKxegpWcExys=;
        b=RmqlNZS/xug4Fu+bg/3QhmWqEXFbL9AOltJ/XB08RFlUUSTSK6aOCDDZ3Ih9tplAvE
         COWLtZsblP0jxB+HD7rdB+YkrsRNuqAjXvReQzV/T12Cw3k/oIX7ZdAV8I5tHYUYg1PS
         tUKfjfxefY9diK8x4DwNCgT/13Jp4rITBmki6eWThl7XDvux+Hs0dVuLjlpDG/zmICnF
         fyP4fXmLM+AXANAmXrLGrLwIqKHBiHBRYDjIUvG/xW0CkPtEqKiNXlrXBNq771JhRYRb
         RvVKrCs7nqgftoEjG1bTcBKHDojF6tipsItgcMzOqHmJa/ZZNgQX6DF5nN+jV8Ii0ede
         LDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FOPuPp4vjmkzKmlY670Q9FDbgvln4gKbKxegpWcExys=;
        b=fGGbJdBhJNimefiU8xqcQY+t8uP3UWfjU3as4Xj6zVE+mgraqsNJ//pOgEZQFZg6kx
         XBa/InlZZKqXdmElFDD+cpx3IBs7BamkyA5E3B69Jp3nILAtbZ0qKxmUkAh5j7RTTrBa
         ObVkY89ACR9bBxhGCf9Am+y+Q2fW6mcPzPh0DnJhJsq/iStRFxeAiDFx0Z4ly2t7suVi
         8gbJ5DYfPWium3HG5zBVqpzQ9tlNU8BvNfFwiODXHkJEJkJe5CmdbmosH5YlkiZPxlV1
         IcL56j+WjMd9PhJF9cJmJy+8VlvJinIDArrBYNzkLYDq8B58TH9SRRcQazUJ8wn+PG55
         kExQ==
X-Gm-Message-State: AOAM533EG0nRJqHOM5XyX02Vp0IIRSJU8rWj9uiVbpxCYNx5Pez0n8mA
        nozu81CVaKkreuC1o3C79as=
X-Google-Smtp-Source: ABdhPJzRGLjrbgl/Av8OTGTdEp+hGoAcyDd6v0U10mC3rB8fsjqFnhMz9c3SoOzLrDqMNgYJnMtKqg==
X-Received: by 2002:a05:6000:14b:: with SMTP id r11mr12693618wrx.53.1610289865342;
        Sun, 10 Jan 2021 06:44:25 -0800 (PST)
Received: from szeder.dev (84-236-109-1.pool.digikabel.hu. [84.236.109.1])
        by smtp.gmail.com with ESMTPSA id i18sm21374775wrp.74.2021.01.10.06.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jan 2021 06:44:24 -0800 (PST)
Date:   Sun, 10 Jan 2021 15:44:23 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: Re: [PATCH v3 0/2] refs: allow @{n} to work with n-sized reflog
Message-ID: <20210110144423.GU8396@szeder.dev>
References: <cover.1609923643.git.liu.denton@gmail.com>
 <cover.1610015769.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610015769.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio,

On Thu, Jan 07, 2021 at 02:36:57AM -0800, Denton Liu wrote:
> When there is only one reflog entry (perhaps caused by expiring the
> reflog and then making a single commit) @{1} errors out even though
> there is technically enough information to do the lookup. Look at the
> old side of the reflog instead of the new side so that this does not
> fail. This is explained in more detail in the commit of the last patch.

> Denton Liu (2):
>   refs: factor out set_read_ref_cutoffs()
>   refs: allow @{n} to work with n-sized reflog

Topic 'dl/reflog-with-single-entry', i.e. these two patches queued
directly on top of v2.29.2, break the test case "61 - valid ref of the
form "n", n < N" in 't3903-stash.sh'.  Queueing them on top of
something already containing commit 4f44c5659b (stash: simplify reflog
emptiness check, 2020-10-24) fixes this issue.

