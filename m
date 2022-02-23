Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304BAC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 21:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241300AbiBWVvk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 16:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235875AbiBWVvk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 16:51:40 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C369347069
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 13:51:11 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 120DF11F80F;
        Wed, 23 Feb 2022 16:51:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9NlcLFIa0FlL
        l/XgeBMnvMgjoq3kESC0aGmHlpzrMHs=; b=kS/vogQrzDXNuD8Vcnxe+bbc+1tm
        mBfgBrUwwlblTnpMciCVjUi3m7f/Wf0LJ6Dl3Uy1uNLNzh23kjG5q3drJeGS5NmT
        CunFD5TyraI3l2Zen/bY22ORL3LDRrIY3xelpHEE0yZRbEByyVzFe5yej4hZnaCf
        8OjPytN6gGGe08g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A0BE11F80E;
        Wed, 23 Feb 2022 16:51:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6FCE011F80D;
        Wed, 23 Feb 2022 16:51:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 2/9] help.c: use puts() instead of printf{,_ln}() for
 consistency
References: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com>
        <cover-v2-0.9-00000000000-20220221T193708Z-avarab@gmail.com>
        <patch-v2-2.9-124643c4b35-20220221T193708Z-avarab@gmail.com>
Date:   Wed, 23 Feb 2022 13:51:08 -0800
In-Reply-To: <patch-v2-2.9-124643c4b35-20220221T193708Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 21 Feb
 2022 20:38:45
        +0100")
Message-ID: <xmqqfso9s14j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B6660194-94F2-11EC-81B5-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> -		printf("\n%s\n", _(desc));
> +		putchar('\n');
> +		puts(_(desc));

This is sort of "Meh".  Even the justification that says "we'll do
the same thing in future patches" is not really a justification, as
it is entirely fine to add more of the "line-break plus %\n" printf()
in the later steps in the same series.

>  		print_command_list(cmds, mask, longest);
>  	}
>  	free(cmds);
> @@ -317,7 +318,7 @@ void list_commands(struct cmdnames *main_cmds, stru=
ct cmdnames *other_cmds)
>  	}
> =20
>  	if (other_cmds->cnt) {
> -		printf_ln(_("git commands available from elsewhere on your $PATH"));
> +		puts(_("git commands available from elsewhere on your $PATH"));

This *IS* an improvement, as the first parameter to printf_ln() is
supposed to be a format string, and should have been

	printf_ln("%s", _("git commands ..."));

> -	printf_ln(_("See 'git help <command>' to read about a specific subcom=
mand"));
> +	puts(_("See 'git help <command>' to read about a specific subcommand"=
));

Ditto.
