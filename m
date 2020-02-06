Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5B4C33CAC
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 19:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C46220838
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 19:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ha6G7WIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgBFTEC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:04:02 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63915 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbgBFTEB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 14:04:01 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1750B4CA35;
        Thu,  6 Feb 2020 14:03:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Z9fXfXco8E8w
        UyGkG8jpfzFW8+8=; b=Ha6G7WIW3QeisuEWIChSG+pw+inmtEoG1wwb/RbjT9aY
        UAPA8mg0GB7h3uBVmkFDpGRLRdAFSYvnOhoi9HZilbZt9GCahukKSIe3Xu8lKaX7
        5Eyf499pPQrzQhGjLx1c5Lcgk844E4sF42l9ee5QxQxWY7SJOgjgEgJOp5LMd+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=JOISho
        wkEuWDTK/I9V1rUPuGhcD+bTpWhLnPxaiC12C4n+xRCEDczOtS7dWvL7ozIQ6Gk0
        JdTjeVq7R2RoSV/nBLSVIf1pjYF9AbxENHagwWSjxSVaSFlmaxQCWPMmZTTYv3fO
        tHN2caZcvyQekpmGo/9dODF6dl3NsZclDymbg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D61B4CA34;
        Thu,  6 Feb 2020 14:03:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5F01A4CA32;
        Thu,  6 Feb 2020 14:03:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Markus Klein via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Markus Klein <masmiseim@gmx.de>
Subject: Re: [PATCH v2] clone: use submodules.recurse option for automatically clone submodules
References: <pull.695.git.git.1580505092071.gitgitgadget@gmail.com>
        <pull.695.v2.git.git.1580851963616.gitgitgadget@gmail.com>
Date:   Thu, 06 Feb 2020 11:03:52 -0800
In-Reply-To: <pull.695.v2.git.git.1580851963616.gitgitgadget@gmail.com>
        (Markus Klein via GitGitGadget's message of "Tue, 04 Feb 2020 21:32:42
        +0000")
Message-ID: <xmqq1rr7fsh3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6AD98C64-4913-11EA-AF00-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Markus Klein via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Markus Klein <masmiseim@gmx.de>
>
> Simplify cloning repositories with submodules when the option
> submodules.recurse is set by the user. This makes it transparent to the
> user if submodules are used. The user doesn=E2=80=99t have to know if h=
e has to add
> an extra parameter to get the full project including the used submodule=
s.
> This makes clone behave identical to other commands like fetch, pull,
> checkout, ... which include the submodules automatically if this option=
 is
> set.

I am not sure if it is even a good idea to make clone behave
identically to fetch and pull.  We cannot escape from the fact that
the initial cloning of the top-level superproject is a special
event---we do not even have a place to put the configuration
specific to that superproject (e.g. which submodules are good ones
to clone by default) before that happens.

You misspelt "submodule.recurse" everywhere in the log message, by
the way, even though the code seems to react to the right variable.

> It is implemented analog to the pull command by using an own config
> function instead of using just the default config.=20

I am not sure if this is worth saying, but it is not incorrect per-se.

> In contrast to the pull
> command, the submodule.recurse state is saved as an array of strings as=
 it
> can take an optionally pathspec argument which describes which submodul=
es
> should be recursively initialized and cloned.

Sorry, but I do not think I get this part at all.  Your callback
seems to add a fixed string "true" to option_recurse_submodules
string list as many times as submodule.recurse variable is defined
in various configuration files.  Does anybody count how many and
react differently?  You mention "pathspec" here, but how does one
specify a pathspec beforehand (remember, this is clone and there is
no superproject repository or its per-repository configuration file
yet before we clone it)?

> To recursively initialize and
> clone all submodules a pathspec of "." has to be used.
> The regression test is simplified compared to the test for "git clone
> --recursive" as the general functionality is already checked there.

Documentation/config/submodule.txt says submodule.recurse says

    Specifies if commands recurse into submodules by default. This
    applies to all commands that have a `--recurse-submodules`
    option, except `clone`.  Defaults to false.

so I take that the value must be a boolean.  So I am lost what
pathspec you are talking about here.

> +/**
> + * Read config variables.
> + */

That's a fairly useless comment that does not say more than what the
name of the function already tells us X-<.

> +static int git_clone_config(const char *var, const char *value, void *=
cb)
> +{
> +	if (!strcmp(var, "submodule.recurse") && git_config_bool(var, value))=
 {
> +		string_list_append(&option_recurse_submodules, "true");
> +		return 0;

The breakage of this is not apparent, but this is misleading.  If
submodule.recurse is set to a value that git_config_bool() would say
"false", the if statement is skipped, and you end up calling
git_default_config() with "submodule.recurse", even though you are
supposed to have already dealt with the setting.

	if (!strcmp(var, "submodule.recurse")) {
		if (git_config_bool(var, value))
			...
		return 0; /* done with the variable either way */
	}

is more appropriate.  I still do not know what this code is trying
to do by appending "true" as many times as submodule.recurse appears
in the configuration file(s), though.

When given from the command line, i.e.

	git clone --no-recurse-submodules ...
	git clone --recurse-submodules    ...
	git clone --recurse-submodules=3D<something> ...

recurse_submodules_cb() reacts to them by

 (1) clearing what have been accumulated so far,
 (2) appending the match-all "." pathspec, and
 (3) appending the <something> string=20

to option_recurse_submodules string list.  But given that
submodule.recurse is not (and will not be without an involved
transition plan) a pathspec but merely a boolean, I would think
appending hardcoded string constant "true" makes little sense.
After sorting the list, these values become values of the
submodule.active configuration variable whose values are pathspec
elements in cmd_clone(); see the part of the code before it makes a
call to init_db().

So, I would sort-of understand if you pretend --recurse-submodules
was given from the command line when submodule.recurse is set to
true (which would mean that you'd append "." to the string list).
But I do not understand why appending "true" is a good thing at all
here.

Another thing I noticed.

If you have "[submodule] recurse" in your $HOME/.gitconfig, you'd
want to be able to countermand from the command line with

    git clone --no-recurse-submodules ...

so that the clone would not go recursive.  And that should be
tested. =20

You'd also want the opposite, i.e. with "[submodule] recurse=3Dno" in
your $HOME/.gitconfig and running

    git clone --recurse-submodules ...

should countermand the configuration.

Thanks.

> +test_expect_success 'use "git clone" with submodule.recurse=3Dtrue to =
checkout all submodules' '
> +	git clone -c submodule.recurse=3Dtrue super clone7 &&
> +	(
> +		git -C clone7 rev-parse --resolve-git-dir .git --resolve-git-dir nes=
ted1/nested2/nested3/submodule/.git >actual &&
> +		cat >expect <<-EOF &&
> +		.git
> +		$(pwd)/clone7/.git/modules/nested1/modules/nested2/modules/nested3/m=
odules/submodule
> +		EOF
> +		test_cmp expect actual
> +	)
> +'

