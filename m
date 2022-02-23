Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D17C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 22:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244013AbiBWWbm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 17:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243976AbiBWWbi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 17:31:38 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7577140A16
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 14:31:10 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CABFD103A6E;
        Wed, 23 Feb 2022 17:31:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qi2eHP/Nt7Nz
        mMOc6EXkelg1bi35w53FioHxq9rLraE=; b=vEDZdjy0LQzlKG877KGtE+sKVXh3
        krA7fn7fcSiDR275qHc86biv10GqehT8osl1EWUuAYPLDCaxxWPwJGdGdN9RQwmV
        vui9BmJMIJlJdm2TBRsNMGD/BnwRB4cYoyUwT3St6Ts56BgYklV/E5fysBMKzwlI
        Gias4Ngdqoxzdfg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B736D103A6C;
        Wed, 23 Feb 2022 17:31:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DFE59103A68;
        Wed, 23 Feb 2022 17:31:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 9/9] help: don't print "\n" before single-section output
References: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com>
        <cover-v2-0.9-00000000000-20220221T193708Z-avarab@gmail.com>
        <patch-v2-9.9-08dc693dc3e-20220221T193708Z-avarab@gmail.com>
Date:   Wed, 23 Feb 2022 14:31:06 -0800
In-Reply-To: <patch-v2-9.9-08dc693dc3e-20220221T193708Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 21 Feb
 2022 20:38:52
        +0100")
Message-ID: <xmqqh78pqkph.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4B662314-94F8-11EC-9A4E-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> @@ -124,7 +124,8 @@ static void print_cmd_by_category(const struct cate=
gory_description *catdesc,
>  		uint32_t mask =3D catdesc[i].category;
>  		const char *desc =3D catdesc[i].desc;
> =20
> -		putchar('\n');
> +		if (i)
> +			putchar('\n');
>  		puts(_(desc));
>  		print_command_list(cmds, mask, longest);
>  	}
> @@ -328,6 +329,7 @@ void list_commands(struct cmdnames *main_cmds, stru=
ct cmdnames *other_cmds)
>  void list_common_cmds_help(void)
>  {
>  	puts(_("These are common Git commands used in various situations:"));
> +	putchar('\n');
>  	print_cmd_by_category(common_categories, NULL);
>  }
> =20
> @@ -481,6 +483,7 @@ void list_all_cmds_help(int show_external_commands,=
 int show_aliases)
>  	int longest;
> =20
>  	puts(_("See 'git help <command>' to read about a specific subcommand"=
));
> +	putchar('\n');
>  	print_cmd_by_category(main_categories, &longest);
> =20
>  	if (show_external_commands)


This patch is a good example to demonstrate that some changes cannot
be reviewed without showing in the whole file what didn't get
changed.  Among three callers of print_cmd_by_category(), two of
them we see here are *not* the first to speak, and do add a blank
line before the call.  The other caller that does not appear in the
patch is what is being fixed, list_guides_help(), which has nobody
to speak before it.

The correct pattern we want to follow in these messages is that
before you say something, you add a blank line if somebody else has
spoken before you.  It might make sense to tell these print_cmd_by*
helpers if they are the first to speak by passing the pointer to a
"state" variable to indicate what has been emitted so far, instead
of making the callers responsible to physically add blank lines, as
the callers would stop knowing if nobody else has spoken before them
if we further refactor them and introduce new direct callers.

In any case, the posted patch itself looks OK.  After following
these 9 steps, I still do not see enough justification for the
earlier "use puts()" step, except for correcting the misused
printf_ln().

Thanks, will queue the whole thing.


> diff --git a/t/t0012-help.sh b/t/t0012-help.sh
> index 64321480c68..6c3e1f7159d 100755
> --- a/t/t0012-help.sh
> +++ b/t/t0012-help.sh
> @@ -226,7 +226,6 @@ test_expect_success "'git help -a' section spacing"=
 '
> =20
>  test_expect_success "'git help -g' section spacing" '
>  	test_section_spacing_trailer git help -g <<-\EOF &&
> -
>  	The Git concept guides are:
> =20
>  	EOF
