Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E03C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 01:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbiLTBmc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 20:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbiLTBmK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 20:42:10 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD421DDC5
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 17:29:32 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so14941697pjr.3
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 17:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMrBRsbkdpyxLmWaKp5Gi6sTJ2IIo3jjQP1yzNqTsuw=;
        b=Nbq0ny7A0rqYSpLT3vL04AS6801Uuw4QWdZ+JRE1s9qte/cr5QuylaD36zumWt0C8b
         6DwR7IjYwRisivbJ7FuPHacS9g+sRN50hRSJ7IHwP1gLhpLvKIFZybSz4iqTrXyb8bfi
         H6MkB+6qT/wbdyZd5gvQUBYbfo1PRwCN9LTPHmvYNKsIyAC/3AhXQ7r07weffHdScZDX
         ejrCixOSYe4AoogfAOQT+vbdTy8sWcdJE7I/r26R9IXgVhRQVVaVD0TOLR+c3+u3Q2my
         6k5xLh4wKIdmwVy+vR6lbHAbr88vPq5VSKBzHQfl0tmsRupbDGZ0+y04OuReFL+DocGc
         BVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wMrBRsbkdpyxLmWaKp5Gi6sTJ2IIo3jjQP1yzNqTsuw=;
        b=G53D97xPRkdC7kBpRfEP3s2zRY3ATj7GKZn/7VuULPSn7zpSPRW325n1M3sRnzfD63
         /eMXnznBubkykhluZ1c3mSvcgbCMiXyRYVqgEyd8gxbCzYfb+qqw8CyiWSyMfZWpe35J
         o+Va37Y2Os3KgFcgl7c8K4yYt6tdRv4bCW67WTmvybuVK01AT8iC6PH/uqGtlmRlXESy
         1iPvRr+wwt7Z45/q5JMy07vYAHxheNlBgvzLtKz3gSgYlbLFMCrRhv1NXLtSfzhdfh90
         fWhY7snXY07EL0ophRJqTxUvhRA4bOEAWFCIa4Xx4i2W0GFJ+owDVfOLgXiLFG2tOEvC
         M2sA==
X-Gm-Message-State: ANoB5pm6kOYIuuFqVgkVkGKMZ86VGBA309i6chKddo28RwGJQv6T1aWO
        nHZLAYXKQHIP5NKbT60VhuE=
X-Google-Smtp-Source: AA0mqf6pXdZShyY8GZJ8tXf/k2CzW3AZuvi4R6Xtcej0I6/MbEa03uX/155UoCJzlVO+fS+pK42f+w==
X-Received: by 2002:a17:902:ccc1:b0:189:3580:48dd with SMTP id z1-20020a170902ccc100b00189358048ddmr51662394ple.37.1671499753292;
        Mon, 19 Dec 2022 17:29:13 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id jf14-20020a170903268e00b00189a50d2a3esm7787968plb.241.2022.12.19.17.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 17:29:12 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] am: don't pass strvec to apply_parse_options()
References: <baf93e4a-7f05-857c-e551-09675496c03c@web.de>
        <221213.86mt7r4ru2.gmgdl@evledraar.gmail.com>
        <2d0d77a4-f6ac-1fa7-bddb-9083579d8dd7@web.de>
        <Y53DAoJ4eK01rEji@coredump.intra.peff.net>
        <91c5120d-bbd4-8aa5-a205-d1f5387a7f19@web.de>
Date:   Tue, 20 Dec 2022 10:29:12 +0900
In-Reply-To: <91c5120d-bbd4-8aa5-a205-d1f5387a7f19@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 17 Dec 2022 17:07:12 +0100")
Message-ID: <xmqqa63izwuv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Depends on the specifics.  Perhaps .bar is redundant and could be
> inferred from .foo.  Or they could be replaced by an enum.
> ...
> Or normalize the struct to avoid dependencies between fields.

I think the example Peff brought up was mostly from the revisions
API, where there are two vastly different traversal behaviour
(i.e. limited and !limited).  With .limited bit set, we first
fully enumerate the potential commits, before showing a single
entry in the output, and without, we can stream the output.
In general, we prefer !limited traversal because that would give us
better interactive latency, but some options only can work with
the limited bit set (e.g. --ancestry-path, --cherry).

We _could_ probably have do without the .limited bit and instead
wrote each and every check we currently make to the revs->limited
bit as something like 

#define is_limited(revs) (revs->cherry_mark || \
			  revs->ancestry_path || \
			  ...)

so that the "struct members" API users do not have to know that they
have to set the .limit bit when they set .cherry_mark bit.  There
are many others even in the revisions API alone.

IOW, yes, this depends on the specifics, and "normalize" is easier
said than done, unfortunately.
