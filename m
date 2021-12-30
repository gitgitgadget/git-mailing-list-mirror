Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7B0C433EF
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 23:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbhL3Xqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 18:46:45 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58464 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237257AbhL3Xqo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 18:46:44 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3282F10F6BA;
        Thu, 30 Dec 2021 18:46:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=3qGcM5bHpWEXgIXM0dIKPIHh2
        +z7kxPT9olFPKGoKnc=; b=ViT2/LxnV69vvLgb9tYfUHQ5JbN/ag61tB6a4WXLv
        FbiyGXwUGDPgmtH1YSEY3YKycp6iXxcprNjJ2dz7cCwI/He6xPenzL7hxHHH8ABR
        YK6eQCwfRx5Cnne451hCuO0Lo13uH/eDSunh1Ak8EVfi3dHtcH89AzMiYrQPFqcT
        m0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A9AB10F6B9;
        Thu, 30 Dec 2021 18:46:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7A20210F6B8;
        Thu, 30 Dec 2021 18:46:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v6 3/6] object-name: make ambiguous object output
 translatable
References: <cover-v5-0.6-00000000000-20211125T215529Z-avarab@gmail.com>
        <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
        <patch-v6-3.6-daebc95542c-20211228T143223Z-avarab@gmail.com>
Date:   Thu, 30 Dec 2021 15:46:42 -0800
Message-ID: <xmqqpmpdmza5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BE17D104-69CA-11EC-8EB0-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +		/*
> +		 * TRANSLATORS: This is a line of
> +		 * ambiguous tag object output. E.g.:
> +		 *
> +		 *    "deadbeef tag Some Tag Message"
> +		 *
> +		 * The second argument is the "tag" string from
> +		 * object.c, it should (hopefully) already be
> +		 * translated.
> +		 */
> +		strbuf_addf(&desc, _("%s tag %s"), hash, tag_tag);

It is better to lose ", it should (hopefully) already be translated"
near the end of the comment.

> +	} else if (type =3D=3D OBJ_TREE) {
> +		/*
> +		 * TRANSLATORS: This is a line of ambiguous <type>
> +		 * object output. E.g. "deadbeef tree".
> +		 */
> +		strbuf_addf(&desc, _("%s tree"), hash);
> +	} else if (type =3D=3D OBJ_BLOB) {
> +		/*
> +		 * TRANSLATORS: This is a line of ambiguous <type>
> +		 * object output. E.g. "deadbeef blob".
> +		 */
> +		strbuf_addf(&desc, _("%s blob"), hash);
>  	}
> =20
> +
>  out:
> -	advise("  %s %s",
> -	       repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV),
> -	       desc.buf);
> +	/*
> +	 * TRANSLATORS: This is line item of ambiguous object output
> +	 * from describe_ambiguous_object() above.
> +	 */
> +	advise(_("  %s"), desc.buf);

What do we expect the translators to do here?  Swap order of the
leading space and the string around?

All the other sentence legos we see in the earlier part of this
patch (omitted) looked quite sensibly done.  Especially the part
that shows a commit object, which lets the translators to take the
object name, the date string, and the message and combine them into
a single string in an order of their choice is nice.
