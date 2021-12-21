Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D66C433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 01:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhLUBpA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 20:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhLUBo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 20:44:59 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B17C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 17:44:59 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id j6so24893578edw.12
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 17:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=r0gN/J8L6QR+mH6QkUfiHhamCIs0jIZs9sLBgImbFtY=;
        b=le4N1jtSoCWtdXa6lBgzrmD6xaYHuVUyGH/qQunhEr3Q3NpZHBDB+3tHUNzOS8Q/p9
         dQ950JVL08En5lD/G1MiU5lxNHMFCO5u3D8a0mZHvYV3/2KI5tll0k2OIQqaH/HwlmKv
         P9FqXUpTUXGmjYOFUOJS4dmpkPXV0O/L2rMoegfzVBbmSb4n2wi4blr3sqqIaabdgBkP
         gffTpssitY+9GzBnmNtl5HqWUVwxPSzO5p/LLn+vZMa5Tm8Pit0QjcbDWuRJpbE5PZHL
         7DR0UWRYFd+QY5X5b2eQFD+Cq2DavTwedccwVReAYrfLQkXPUPvbgqtERBJk0Twcjb3b
         4fiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=r0gN/J8L6QR+mH6QkUfiHhamCIs0jIZs9sLBgImbFtY=;
        b=O3B28GBGU1ppAM4DOzVAqPRE0oOHbwWh2CdXNn5+Q4yGvVGZt3FMFMaQ3bqq4KS7AJ
         95V9grbeeCBzZfAVthRbP50cmwqsPIarUFINXQ7MCQvaKZNcMtmoFTrBDNmaZrV1+dSD
         jZXE4gMm5zJEB7gG4TakJ7ZyZS4tXVDBtVrBS89JvY8vnrmyeIQK1LuWryY2H7oTVrPn
         c8lJSNcLVMdVUIymq1sHDOT8xNBiu6+/T4lf9vmWM/5nCTIYvAc1h9IYPY5QTY/Jr1f7
         gh9nf72sNsb7MjC4cvrUzMwfhb8xJpIr+HqPDpBxzccaD/cJ14RAeS89v28or+BOIDu5
         RW2g==
X-Gm-Message-State: AOAM531hZNGiXFFClhlou78UAkSW7j7z1ZVyLpBQCYEjRbF1P1LTsqg2
        2vXSXkeMzU2Zo7cpzdQtx2oXISqpEupC0A==
X-Google-Smtp-Source: ABdhPJx4KjZGyNPCUDxx84eP/HayTzfKgwtPE2krF5Kw9CEzvaK1CRw353CzPzlt6l8T2GXBvnvBBQ==
X-Received: by 2002:a17:907:2d10:: with SMTP id gs16mr695810ejc.489.1640051097931;
        Mon, 20 Dec 2021 17:44:57 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d18sm7368490edj.23.2021.12.20.17.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 17:44:57 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzUD2-000ax8-Te;
        Tue, 21 Dec 2021 02:44:56 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Han Xin <chiyutianyi@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC PATCH] object-file API: add a format_loose_header() function
Date:   Tue, 21 Dec 2021 02:42:44 +0100
References: <20211217112629.12334-3-chiyutianyi@gmail.com>
 <RFC-patch-1.1-bda62567f6b-20211220T120740Z-avarab@gmail.com>
 <xmqqilviud6e.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqilviud6e.fsf@gitster.g>
Message-ID: <211221.86wnjyspd3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 20 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Add a convenience function to wrap the xsnprintf() command that
>> generates loose object headers. This code was copy/pasted in various
>> parts of the codebase, let's define it in one place and re-use it from
>> there.
>> ...
>> +/**
>> + * format_loose_header() is a thin wrapper around s xsnprintf() that
>
> The name should have "object" somewhere in it.  Not all readers can
> be expected to know that you meant "loose" to be an acceptable short
> hand for "loose object".

*nod*

> That nit aside, I think it is a good idea to give people a common
> helper function to call.  I am undecided if it is a good idea to
> make it take enum or "const char *"; most everybody should be able
> to say
>
> 	format_object_header(type_name(OBJ_COMMIT), ...)
>
> just fine, so two variants might be overkill, just to allow=20
>
> 	format_object_header(OBJ_COMMIT, ...)
>
> and to forbid
>
> 	format_object_header("connit", ...)
>
> I dunno.

Ultimately only a single API caller in hash-object.c really cares about
something else than the enum.

I've got some patches locally to convert e.g. write_object_file() to use
the enum, and it removes the need for some callers to convert enum to
char *, only to have other things convert it back.

So I think for any new APIs it makes sense to work towards sidelining
the hash-object.c --literally caller.
