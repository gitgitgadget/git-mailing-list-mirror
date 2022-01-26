Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26474C433F5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 22:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiAZWfD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 17:35:03 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52977 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiAZWfA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 17:35:00 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1A604178E6C;
        Wed, 26 Jan 2022 17:34:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BeJ5jkSuUQWy
        Fk9HwIGpG2a+J/2ePxcYh0RSIXk0LBk=; b=cJMBAw2T5lBwKdVuLj/IGoMMKX1V
        eCgh3iyX3v/KaB4t7w6IVCs3ebXFfQrzjMkxJ19w4ADXWu6MPSVShGvoTIY0Nf1D
        mvjgC3bjPxS+WcH8TCbI5SLKbtsItfMUL0cCxe+UnOwizfWY1wgQR3fvjAU3bZzl
        j7i+rUGb/GVeKLo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 125EC178E6B;
        Wed, 26 Jan 2022 17:34:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 841EA178E6A;
        Wed, 26 Jan 2022 17:34:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Hongyi Zhao <hongyi.zhao@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        =?utf-8?Q?Jo=C3=A3o?= Victor Bonfim 
        <JoaoVictorBonfim+Git-Mail-List@protonmail.com>
Subject: Re: [PATCH] completion: add a GIT_COMPLETION_SHOW_ALL_COMMANDS
References: <CAGP6POJ9gwp+t-eP3TPkivBLLbNb2+qj=61Mehcj=1BgrVOSLA@mail.gmail.com>
        <patch-1.1-5f18305ca08-20220125T124757Z-avarab@gmail.com>
Date:   Wed, 26 Jan 2022 14:34:55 -0800
In-Reply-To: <patch-1.1-5f18305ca08-20220125T124757Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 25 Jan
 2022 13:49:04 +0100")
Message-ID: <xmqqk0emp1m8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3018E81E-7EF8-11EC-A910-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add a GIT_COMPLETION_SHOW_ALL_COMMANDS=3D1 configuration setting to go
> with the existing GIT_COMPLETION_SHOW_ALL=3D1 added in
> c099f579b98 (completion: add GIT_COMPLETION_SHOW_ALL env var,
> 2020-08-19).
>
> This will include plumbing commands such as "cat-file" in "git <TAB>"
> and "git c<TAB>" completion. Without/with this I have 134 and 243
> completion with git <TAB>, respectively.

OK.  This makes sense in the sense that more choice is better.

> It was already possible to do this by tweaking
> GIT_COMPLETION_SHOW_ALL_COMMANDS from the outside, that testing
> variable was added in 84a97131065 (completion: let git provide the
> completable command list, 2018-05-20). Doing this before loading
> git-completion.bash worked:

Perhaps there is a typo that ruined whole the paragraph.  We are
adding that variable with this patch, so by definition, it did not
exist before, which means we cannot "tweak" it because it did not
exist.

> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -49,6 +49,11 @@
>  #     and git-switch completion (e.g., completing "foo" when "origin/f=
oo"
>  #     exists).
>  #
> +#   GIT_COMPLETION_SHOW_ALL_COMMANDS
> +#
> +#     When set to "1" suggest all commands, including plumbing command=
s
> +#     which are hidden by default (e.g. "cat-file" on "git ca<TAB>").
> +#

Usually we frown upon inserting a new thing to the middle of a list
of things that has no inherent order.  In this case, I think this is
OK, as the existing "all" (below) is about completing options, while
the new one is about completing subcommands, and the latter is at a
higher conceptual level than the former.

>  #   GIT_COMPLETION_SHOW_ALL
>  #
>  #     When set to "1" suggest all options, including options which are
> @@ -3455,7 +3460,13 @@ __git_main ()
>  			then
>  				__gitcomp "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
>  			else
> -				__gitcomp "$(__git --list-cmds=3Dlist-mainporcelain,others,nohelpe=
rs,alias,list-complete,config)"
> +				local list_cmds=3Dlist-mainporcelain,others,nohelpers,alias,list-c=
omplete,config
> +
> +				if test "${GIT_COMPLETION_SHOW_ALL_COMMANDS-}" =3D "1"
> +				then
> +					list_cmds=3Dbuiltins,$list_cmds

It is sad that there is no "plumbing" class (assuming the goal is
"we by default exclude plumbing, so add that to the list"), or just
"everything under the sun" class.  If there were a plumbing command
that is not implemented as a built-in, adding buitlins to list_cmds
will not show the command, will it?  Also, because nohelpers is not
removed from list_cmds, whatever command that were removed from
exclude_helpers_from_list() will be hidden.

It looks as though help.c needs a new list_all_cmds() that can be
called from git.c::list_cmds() when "all" is asked for, and dumps
everything from command_list[] plus whatever load_command_list()
loads.

> +				fi
> +				__gitcomp "$(__git --list-cmds=3D$list_cmds)"
>  			fi
>  			;;
>  		esac

Having said all that, assuming that including "builtins" is a good
enough approximation (which I do not have no opinion on), the
implementation looks good to me.

> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 98c62806328..e3ea6a41b00 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -2432,6 +2432,33 @@ test_expect_success 'option aliases are shown wi=
th GIT_COMPLETION_SHOW_ALL' '
>  	EOF
>  '
> =20
> +test_expect_success 'plumbing commands are excluded without GIT_COMPLE=
TION_SHOW_ALL_COMMANDS' '
> +	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
> +	sane_unset GIT_TESTING_PORCELAIN_COMMAND_LIST &&

As we've done dot-sourcing of the file at the beginning of the
script already, dot-sourcing the same thing again would only
overwrite what was done before, without clearing the deck.  Which
may not hurt for the purpose of _this_ test _right_ _now_q.

But as this is not done inside a subshell, whetever we dot-source
here will persist til the end of the script.  Which may be more
problematic as it will affect the tests that come (and new tests
that will be added) after this point.

The same comment applies to the other new test added immediately
after this one.

Other than that, looks sensible to me.

Thanks.
