Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52451C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 16:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjARQ0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 11:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjARQZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 11:25:29 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AC15B86
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:23:49 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id y1so37401415plb.2
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snnt8fZXQG/AOs2mHyeXHG9D1+C6xDfx4ruXd8l1NCY=;
        b=OtcFI2v89+IUnhDPbbwAl5GrINikfewZ1IvOMmbg8fnT3x/0RCxlmKtu0YvjQDR1S1
         2wa5rqWwl/lcTQHwODQyz9t/E/Sf/hBI67DjeuHZSnGjdJtcy4PaEHa5tBaQr5V41Ttm
         xy9Ci8xi8vNl+g456+nwfgsZ9hq2QPUtdChBH1JyXbvWqCx8PeUO2fjNBEkH+6HdE7rk
         83Otemmh63VQZQVBL8sUIrmjlFNtKS/0mm6qUUe5uD99b8rgUh9ISV924UaW5Ykz0y1M
         TAZCXqgOQHy09z4QhAsgFrBfA3XhkzvvTFqFlVaPhiNwwBQ5YVpD+BnP53jT2zgztZmz
         8GEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=snnt8fZXQG/AOs2mHyeXHG9D1+C6xDfx4ruXd8l1NCY=;
        b=H/mY3YRxyrRUnpE7fqyVwjc5lX3yMOmZxr6MkKnAaszv4JHkwcqhzEHxFv5jsYHiqS
         O+3EpXNhU3iS/C4qvLr2K0wrOUOhYwYvGK7AccRiOuvbvPihO7SSZwaUkj9cmVYBBHwX
         VNyA0TdtN8znlZtWPiQyu02cGyhOLlUFXJj5wEn4sdxGP5SX5CHxrPgLdjlnvWtPL3tK
         1EYxMsUYorgZ0Uc5bhxRoLrWWLP778ExQF8T35LQEtXRxfNzFSmWRLEf9tmFYxo90T6R
         TKL2GwnYW7Y/mqnKgn0A6Z84wS2rL9cPCe9bc8LGhfLQIfj8TxfGMCrSnw47Bm89VuBe
         y25A==
X-Gm-Message-State: AFqh2kpHJmLy5+j1izjMM7sj+mQ35kGdjUPpvCrQ0KdGgm29xNL2kOSZ
        AthhkU6ho9FAt9tXowP/v5U=
X-Google-Smtp-Source: AMrXdXsvExIg6YehuwX57tUZyIKgfDFOfzq4cqhg8W5Vmg9r0T5IwDTS5Ju5oJUaFqYr/MHanWArAw==
X-Received: by 2002:a05:6a21:918a:b0:b8:7bfc:7a32 with SMTP id tp10-20020a056a21918a00b000b87bfc7a32mr7195997pzb.2.1674059028778;
        Wed, 18 Jan 2023 08:23:48 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id t1-20020a63d241000000b004c974bb9a4esm6841546pgi.83.2023.01.18.08.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:23:48 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: Re: [PATCH] git-cat-file.txt: fix list continuations rendering
 literally
References: <20230118082749.1252459-1-martin.agren@gmail.com>
Date:   Wed, 18 Jan 2023 08:23:48 -0800
In-Reply-To: <20230118082749.1252459-1-martin.agren@gmail.com> ("Martin
        =?utf-8?Q?=C3=85gren=22's?= message of "Wed, 18 Jan 2023 09:27:49 +0100")
Message-ID: <xmqqzgaf4xrf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> With Asciidoctor, all of the '+' introduced in a797c0ea04 ("cat-file:
> add mailmap support to --batch-check option", 2022-12-20) render
> literally rather than functioning as list continuations. With asciidoc,
> this renders just fine.

Good to have somebody who is careful to notice these differences ;-)

> For consistency, let's wrap all three of these inner lists from
> a797c0ea04 in open blocks. This also future-proofs us a little -- if we
> ever gain more contents after any of those first two lists, as we did
> already in a797c0ea04 for the third list, we're prepared and should
> render fine with both asciidoc and Asciidoctor from the start.

Nice.

Are you comparing both roff output and html output, by the way?

Thanks.
