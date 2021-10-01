Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6C9C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 20:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70EC361A8F
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 20:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhJAU2R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 16:28:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54278 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355315AbhJAU2M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 16:28:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A5BE153229;
        Fri,  1 Oct 2021 16:26:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=Qm09KWlpcddaH8jsVlEdMeG2H
        ckChW2A2fnhMPKyBjk=; b=yEB6TliJMYivjG6uef10x8kGJJMWNOp824DKfDBO7
        PL/ogSyuBm3mSvHd/4ZlxrVZD6/KJS4B4T/wdyElXPIawUHgKbTBT8s2S7+gnNgd
        JH3FY2uHO4gtJ4OioCgyZqVmX9LwTBlQDP0MtpRk58s1wcR0GTtiPYNs3s0UCzQ1
        yU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 83746153228;
        Fri,  1 Oct 2021 16:26:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 24470153225;
        Fri,  1 Oct 2021 16:26:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/9] test-mergesort: add sort subcommand
References: <943b1e01-465e-5def-a766-0adf667690de@web.de>
        <f0a8c3c5-4c51-5128-42a3-3dadb8600a6f@web.de>
Date:   Fri, 01 Oct 2021 13:26:24 -0700
Message-ID: <xmqqzgrs5w5r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D96ABAFA-22F5-11EC-95F1-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Give the code for sorting a text file its own sub-command.  This allows
> extending the helper, which we'll do in the following patches.
> ...
> -int cmd__mergesort(int argc, const char **argv)
> +static int sort_stdin(void)
>  {
>  	struct line *line, *p =3D NULL, *lines =3D NULL;
>  	struct strbuf sb =3D STRBUF_INIT;
> @@ -49,3 +49,10 @@ int cmd__mergesort(int argc, const char **argv)
>  	}
>  	return 0;
>  }
> +
> +int cmd__mergesort(int argc, const char **argv)
> +{
> +	if (argc =3D=3D 2 && !strcmp(argv[1], "sort"))
> +		return sort_stdin();
> +	usage("test-tool mergesort sort");
> +}

This smelled funny, as it would certainly have broken any existing
script in t/ that were using "test-tool mergesort <input".

But "git grep mergesort master -- t/" reveals that nobody uses it,
so we are safe ;-)

