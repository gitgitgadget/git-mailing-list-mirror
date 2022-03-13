Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B15C433F5
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 02:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbiCMCWO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Mar 2022 21:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbiCMCWN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Mar 2022 21:22:13 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16011181B01
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 18:21:06 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D9F0A196CD7;
        Sat, 12 Mar 2022 21:21:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7q37iI9hyVwR
        pSP6Oy9BGfH5KDuGb4xhqBOPhgw2AEo=; b=TOKvGilpkBog7pLfUfZhE8o/1THy
        94CfRUvwpLNWZpZpnFa3AIizGYh/SUa1MK3uIuYXIgVdwaRjTUKQ/Q5fkXpizyx2
        8+FxOP1ohbj7JbOD3fhok8ClML9ORA8phgw34fyLd5gCCYsqUJstca0Q68rgtANJ
        CLxXDuegoLwdBPc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D2DA8196CD6;
        Sat, 12 Mar 2022 21:21:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.195.168.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 20815196CD3;
        Sat, 12 Mar 2022 21:21:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Git List <git@vger.kernel.org>,
        Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH] test-lib.sh: use awk instead of expr for a POSIX non
 integer check
References: <20220304133702.26706-1-gitter.spiros@gmail.com>
        <20220308113305.39395-1-carenas@gmail.com>
        <CAPig+cSNgQ7SEYk9M=L7z0G=hteTdupKS6sHJL8T7zEp=zkLEA@mail.gmail.com>
        <CAPig+cT3TNFBMesYvYoncawfBdLqKL971SoP_J7F9FgnL10Eqw@mail.gmail.com>
        <CAPig+cSUTaPRvALJyJ8AxNB4wMFLyaWBOa8f+_8K6quPbxTT5A@mail.gmail.com>
        <xmqqv8wnm30q.fsf@gitster.g>
        <220309.86pmmulw77.gmgdl@evledraar.gmail.com>
        <CAPig+cQNeTAvWHm2GUGc2i=FKF2V6Gqkmmsw4kDOTzrSYEbgxA@mail.gmail.com>
        <220312.86o82bfo7x.gmgdl@evledraar.gmail.com>
Date:   Sat, 12 Mar 2022 18:20:59 -0800
In-Reply-To: <220312.86o82bfo7x.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 12 Mar 2022 11:38:33 +0100")
Message-ID: <xmqqtuc2lhis.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3A6815C0-A274-11EC-BDBF-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> But probably better is to just amend that to call it as "test-tool libc
> is-glibc-2.34-or-newer" or whatever. Then just do:
>
> 	if (__GLIBC__ > 2 || (__GLIBC__ =3D=3D 2 && 34 >=3D __GLIBC_MINOR__))
> 		return 0;
> 	return 1;

Yuck.  Then we'd have yet another libc-is-glibc-2.36-or-newer
option, too, in the future?


