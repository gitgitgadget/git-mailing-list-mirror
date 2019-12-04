Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F02CC43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 17:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF04A2077B
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 17:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fUGYBiQW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfLDR0W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 12:26:22 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52028 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfLDR0W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 12:26:22 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B0B138D6EA;
        Wed,  4 Dec 2019 12:26:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=84TYqxlSBWbZ
        3auGzCs0kkAQC+U=; b=fUGYBiQWw2Oslhfdmo6I+TorCSKJeTFL1n8WCGmri8Ej
        tMMK9ykZadMJgN6/lk76tqXa0cC8HcyPiOq0FovM65DM0EuXZeRb3NTgMepg2EtU
        toG9V4j29Mgtwpm7x2Hbu2K/TtzK0Vnevfv5a3filDb6eXwlYQZsKtm6+ZBe9lU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=CXDoLo
        Z/2Z2CNkTYlyMWXEciamiiazt+9F9ZQRr1pNeUvGy4ChvW0Bzq1Nop2wC6171Z/w
        YmcVoCeRLkbzXjzJGYeVh0Vy7FZLP9rxLnsctylhfYGs4vN4P1mb/WhkYs0QOETL
        WLbT39SBnlnC7WiEz0qkCSuX8t//cabvcsvGY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A90E98D6E9;
        Wed,  4 Dec 2019 12:26:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C79E68D6E7;
        Wed,  4 Dec 2019 12:26:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Biesinger <cbiesinger@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 4/5] format-patch: teach --no-base
References: <cover.1574878089.git.liu.denton@gmail.com>
        <cover.1575445582.git.liu.denton@gmail.com>
        <6cba51ca247423c76bda498152c162900aba1b59.1575445583.git.liu.denton@gmail.com>
        <3d355c0c-805a-a55d-eb4e-e4918585e30c@web.de>
Date:   Wed, 04 Dec 2019 09:26:15 -0800
In-Reply-To: <3d355c0c-805a-a55d-eb4e-e4918585e30c@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Wed, 4 Dec 2019 11:36:25 +0100")
Message-ID: <xmqq5ziw57ew.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2E382DAE-16BB-11EA-852E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Clearing the global variable base_auto feels unclean to me, as does the
> introduction of a callback for that purpose.  Why not set base_commit
> after reading the config and before parsing command line options to
> reflect base_auto?  That would achieve the intended precedence in a
> simpler way, something like this:

Nice.


>
> diff --git a/builtin/log.c b/builtin/log.c
> index a26f223ab4..af1b0d0209 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1714,6 +1714,8 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
>  		rev.mime_boundary =3D default_attach;
>  		rev.no_inline =3D 1;
>  	}
> +	if (base_auto)
> +		base_commit =3D "auto";
>
>  	/*
>  	 * Parse the arguments before setup_revisions(), or something
> @@ -1973,7 +1975,7 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
>  	}
>
>  	memset(&bases, 0, sizeof(bases));
> -	if (base_commit || base_auto) {
> +	if (base_commit) {
>  		struct commit *base =3D get_base_commit(base_commit, list, nr);
>  		reset_revision_walk();
>  		clear_object_flags(UNINTERESTING);
