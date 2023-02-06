Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB14C05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 23:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjBFXmh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 18:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBFXmd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 18:42:33 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC4D2E0DF
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 15:42:32 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id bx22so10310409pjb.3
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 15:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJTj3uFJCXfS52nJooAO/pX16I8GXSwvV5kI2Giw/8o=;
        b=hAuqdfV1PKCiY++RuOhT9BCNhfcw8LwdGmGP9Wo+ia7uOUFKj9ObIPmIR+5K9HTVBy
         /hp4SX1ka+CGqTktNhzQhKvEGwf/wU64ts4dyFsX+CbXl7Y7/qEU1vTJgHUOoTRisOk2
         DNHAvC9rpartzkgaGhffZt8ax8er7z44E7+AnDst8d0qgJKKWxshwYHOX1bgv4MJ5mWg
         CZVE0qUt4yoJFLdr+4plMZlzZo0fY7QUTWXSIL+c9dLyRcPKROHP/NdjDORCFXv9Regb
         tDLStB3rEB/sc8Q0PxAF2ZylAqBNfur/MwCkqTp2GJgxnQm56CAMVy0M1aGglxmC2CQX
         ISjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJTj3uFJCXfS52nJooAO/pX16I8GXSwvV5kI2Giw/8o=;
        b=Wl1DhNctyhySK51rol9Ky3xDw/CCy63vaBRGznncS/PuLlaI+5K2/o46yWqprkg+DV
         dtkAA0uUqmONn2TVJN70RqsiuFdxZIPPkryB/+j4eSM0q2YL6tWugKgxj9zCGVjNAUXv
         Fc3rf8Ez6rtFmDSFsBUoND01UPCNhUWfo3v5QYzvElODiQpNQiVuZqCgRU19/pW0MWyy
         xRHqYfpXFHsmTGpAyPdRNYW0YQYhXLNp1YahdBsuebjnb8lr0OnYeYZeoC3h6n6fQfSB
         gENIyOwZ//939mNNKguV/L3OzQ9gz6+6WQrK6qH05vig4px1cav1J7mad4438AbJKIve
         RPfA==
X-Gm-Message-State: AO0yUKX1rsioW8YFgIdDi7XJj3Gu576Q5DdHqKlcud64SZwdg4s+OBDX
        selJA3nA4ZXg482Wxsrao7c=
X-Google-Smtp-Source: AK7set8IzTv22fkoRDBnzgLDfeVhoTcAVoJ/UJQdeNiVDIyNBJ/yPy/eisboJWYSDIF6sDIXskxeKg==
X-Received: by 2002:a17:903:244f:b0:199:a0c:1221 with SMTP id l15-20020a170903244f00b001990a0c1221mr843929pls.14.1675726952218;
        Mon, 06 Feb 2023 15:42:32 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id t6-20020a170902b20600b0018544ad1e8esm5273630plr.238.2023.02.06.15.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 15:42:30 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v6 18/19] push: refactor refspec_append_mapped() for
 subsequent leak-fix
References: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
        <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
        <patch-v6-18.19-aa33f7e05c8-20230202T094704Z-avarab@gmail.com>
        <xmqqk00zsoqh.fsf@gitster.g>
        <230206.86sffi67ce.gmgdl@evledraar.gmail.com>
Date:   Mon, 06 Feb 2023 15:42:30 -0800
In-Reply-To: <230206.86sffi67ce.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 06 Feb 2023 18:16:21 +0100")
Message-ID: <xmqq357i2wex.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I think you're mistaken, or I'm misunderstanding you. For e.g. the 29th
> test in t4301-merge-tree-write-tree.sh where we do:
>
> 	git push read-only side1 side2 side3
>
> We'll only invoke "get_local_heads()" once, not once for each of the
> refs.

Ahh.  get_local_heads() appears inside this conditional in the
original.

	} else if (!strchr(ref, ':')) {
		if (!remote) {
			remote = remote_get(repo);
			local_refs = get_local_heads();
		}
	        refspec_append_mapped(...);
	} else
		...

So the original was using !remote as the switch to make both remote
and local_refs assigned onnly once.  The rewritten code makes them
separately "find first non-null".

OK.
