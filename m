Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35958C4321E
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 23:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiK3XnW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 18:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiK3XnE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 18:43:04 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A1F57B47
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 15:42:58 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so316048pjb.0
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 15:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zx5FtR+4FRHQhJAoKgP3aUHBpR0JGCaEME41VoXQ57U=;
        b=opeDMx6Fqafc3GkTniVxM1iHIR84zOl9wc6boa9cITLBjCrVI8LdfjleBRqYVZskE9
         fsfpAqYfp/7M0kLmlUsKz06k95A/+v8AtQcjkUGfJ/1HycJuF1xBC1224WoAWyyY0i+b
         7mH7Qct4/F3shfxDILs5YvZwf57LBgJZyofyRC/QD7XQNaquC0HwWADWg01am2tnWuqH
         m2M6yjgyxd/12u9jJF74+5uYkNb0v2UEU4tJar67Sx7tSc5Y88JTaGv663NwcqiFZ7op
         W9nA53p0E5/vk6JvO14hS07eqe/OHv1rS6gltTpdEI6QlVbG0bjw83pkVhfOhpXe+0xY
         KiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zx5FtR+4FRHQhJAoKgP3aUHBpR0JGCaEME41VoXQ57U=;
        b=nI78maGix68qUdGoTWboOyJ2PONmU2+BeOaRhflLh8eilsmgjSkwYEqpavcCCSpxE4
         mTLnFAEOMhFX7GvJXtgPioM+JkE+MmqfiUmVdlumBzftMbqTuXyorOhSQ+ooQDypjfrp
         frZLveHyZF94jC5+Bzt7u9NzVNvcCwjGDySNcK1G/eEGZZJvHBhYEX/okmh5VlutHnWa
         kuCyr7bac982+s3NWDdsI1gxG9fNtSJ1byunPkzxI/m2qCSNWRJqH3qyzGk2nS2//77k
         EoPOSXZBWAzHrxm+MivUz3fw0601H0uV33JUjtOnq5l+gxbZlPZSBx1LsBk1TlQ2s5Yc
         xdbA==
X-Gm-Message-State: ANoB5pmLkcaTHeOSCfmqVCjQiEakfycikmlCuagDUNj2KzNsQV+p8qlq
        shAOdmuXDXRPwOuDZoaZSmkV4g14tdZl/g==
X-Google-Smtp-Source: AA0mqf45gcDRN/sDW/cdlzJa1Dgv8cVNkDXEjkUNxdKlQXOqewZXqjpSDS4XeHBCKbm/3N0XImzQsA==
X-Received: by 2002:a17:902:f70c:b0:189:bee:65ee with SMTP id h12-20020a170902f70c00b001890bee65eemr46002463plo.107.1669851778189;
        Wed, 30 Nov 2022 15:42:58 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902c40100b001869ba04c83sm2039044plk.245.2022.11.30.15.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 15:42:57 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/4] object-file: refactor corrupt object diagnosis
References: <cover.1669839849.git.jonathantanmy@google.com>
        <a8c5fcd9f860a0434f974779bae6edf6a8ceeaca.1669839849.git.jonathantanmy@google.com>
        <Y4fBdW4IMhVXazm4@coredump.intra.peff.net>
Date:   Thu, 01 Dec 2022 08:42:57 +0900
In-Reply-To: <Y4fBdW4IMhVXazm4@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 30 Nov 2022 15:47:49 -0500")
Message-ID: <xmqqa648uhz2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So maybe:
>
>   if (!oideq(real_oid, oid))
>
> instead? It's a little slower, but the point of this is to diagnose and
> die, so it's not exactly a hot path. :)

Very true, including the part that the original is fine because it
is localized and fairly obvious.  For a public function, we cannot
assume any additional constraints between oid and real_oid (other
than they are of the same "struct object_id *" type) like the two
pointers prepared locally in the original had, and use of oideq()
would be more appropriate here.

Thanks.


