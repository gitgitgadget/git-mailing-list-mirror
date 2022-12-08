Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDEDC4708D
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 00:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiLHA2K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 19:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiLHA16 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 19:27:58 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0B0260D
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 16:27:56 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id b2so181164eja.7
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 16:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AEfhQVWQu1PLpgdyELfxlkAO24/qJyq8v92cTysGaeE=;
        b=ZvCQ2EZUcUsyu85fLDarrmSoiSsN1RW8Ar1FQG1ZO73+tIP3wB/k5d+aMSG+YyXC93
         g0SyLzwukl02Ao68kgJkFP8cVFf6ki73PVPNkSCgCtowuiwRl7m7cDNG4MW+NSeflAsf
         r0YYxyLGQ0W/4OOd506yIlewrizT/teVl3/G9Cdlqe7KYwb31VJ4PCG/XP6qnS+WE/z7
         Uw1lU8Z2oGjG9cwfdJaF0DFIj2UFKoNSWRBuW9QOuMLN7Iu2mCdAriU2k56enwIOUINQ
         daKX3pF73fGp9B6b+E9Wq19fi6iVnMfTis1JyebbeVYA/qN2Xmo8yMR/Cuxps4e0Uf3d
         gMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AEfhQVWQu1PLpgdyELfxlkAO24/qJyq8v92cTysGaeE=;
        b=FkVFu/z6XtTawXrkoY3yBqqW+Padb6WIQ/tYF3KdretIPnKxVjvFCXH/FePrmmvAfh
         dH32MxV32O1GSgV3ww7SmnXDVH3od0ED7meUjuVkH9fD7JvXhmowh+zeUNruo7/RBlIN
         mFaYP8fjUc62wXjI0dyfwNLllKWTo+PaAs0m7ss6DO+dEIpzQ8T+wWh/GnXbt4zgQuXY
         bgXv/2A1UoqB/7O5XZG1eQIrmDpqrYk/OTFgvtnXDNgEeO7OhJNdHlAKw1PQKi8u27w3
         uRgd4pDP1YVN9j2yudJmoiQ44HhgPVnF8XYE3+X714RLySAHqX7cFYLuvj8n7Hrok0JB
         6XvQ==
X-Gm-Message-State: ANoB5pmSD8WEJjOwnIxRUGkWf16a3auftBNI/Apl49+Z31lBo2bP3FMA
        wOkBZr+v64QE4p4/3efdBNIPJy1qApc7lQ==
X-Google-Smtp-Source: AA0mqf5RkoSS0dBJd9ZfRDcSC5N49AI+I+rYoRgKNscA/sHU0Y8oax7i90gCh27nd2A7XzbfXqjOrA==
X-Received: by 2002:a17:906:7209:b0:7ad:8057:4f06 with SMTP id m9-20020a170906720900b007ad80574f06mr895587ejk.59.1670459274702;
        Wed, 07 Dec 2022 16:27:54 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id c17-20020a17090618b100b007a8de84ce36sm9027611ejf.206.2022.12.07.16.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 16:27:54 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p34lV-004jFC-2N;
        Thu, 08 Dec 2022 01:27:53 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] CI: migrate away from deprecated "set-output" syntax
Date:   Thu, 08 Dec 2022 01:27:28 +0100
References: <patch-1.1-deb65805345-20221206T195811Z-avarab@gmail.com>
 <patch-v2-1.1-4e7db0db3be-20221207T014848Z-avarab@gmail.com>
 <xmqq359q6a30.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqq359q6a30.fsf@gitster.g>
Message-ID: <221208.861qpa91ti.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 08 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>>     +-          echo "::set-output name=3Dbase::$base"
>>     +-          echo "::set-output name=3Dhead::$head"
>>     ++          cat >>$GITHUB_OUTPUT <<-EOF
>>     ++          base=3D$base
>>     ++          head=3D$head
>>     ++          EOF
>
> Hmph, I do not trust this part.
>
> The redirection operator "<<-" causes the leading tabs in the
> here-doc-text stripped, but the .yml file does not indent with tab
> to begin with.
>
> I suspect the leading spaces will all be stripped and not seen by
> the shell, so the distinction may not matter, which means the use of
> "<<-" is very much misleading.
>
> Let's stick to the dumb and proven
>
> 	echo "base=3D$base" >>$GITHUB_OUTPUT
> 	echo "head=3D$head" >>$GITHUB_OUTPUT
>
> instead, which is used throughout the rewrite in this patch.

Sure, I'll re-roll with that.
