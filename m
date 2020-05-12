Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED34CA90AF
	for <git@archiver.kernel.org>; Tue, 12 May 2020 18:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A44132176D
	for <git@archiver.kernel.org>; Tue, 12 May 2020 18:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yDEjS+mF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbgELSyE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 14:54:04 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62646 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgELSyE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 14:54:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 862C8BBE72;
        Tue, 12 May 2020 14:53:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HmN6a3jeakl8Q/d0wFCZ/djQEu4=; b=yDEjS+
        mF0YtR9xJjJsnWoTUb5CXA9EHVaukREXvXblS1sYuAtDVb/Ndn5sF5DOJ8PGPMkE
        79ByW6LWzVBsErzKz/jr3re0BKZ4rufLneAf4jpQ1Ncjr0pVsPatI8QIwBd1Csw2
        6wV7Hv6cwb69ZtfB368/C/Lk+n3z3cNxpnAKU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FLEtGy3kWZpNCGqxv9WwzLHU57pVOcIU
        9s0P2ReyzmfuIe+k0lATiRIIVe2MZnYho4tsmW1mpuuxKuG2s11a13A8vJDXPCW1
        JUPNMoD7iTaZ2rOQhJnmeZkm9PEYECIjxjiopUepr21oCQQcVG6kZ8A4isuh2Pnp
        Tkk+7+jhpwA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F8B1BBE71;
        Tue, 12 May 2020 14:53:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.99.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C1C35BBE70;
        Tue, 12 May 2020 14:53:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Guillaume G. via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "Guillaume G." <guillaume.galeazzi@gmail.com>
Subject: Re: [PATCH] submodule--helper.c: add only-active to foreach
References: <pull.631.git.1589099162707.gitgitgadget@gmail.com>
Date:   Tue, 12 May 2020 11:53:54 -0700
In-Reply-To: <pull.631.git.1589099162707.gitgitgadget@gmail.com> (Guillaume
        G. via GitGitGadget's message of "Sun, 10 May 2020 08:26:02 +0000")
Message-ID: <xmqq8shxc7ct.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EEE7B940-9481-11EA-A135-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Guillaume G. via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Guillaume Galeazzi <guillaume.galeazzi@gmail.com>
>
> On repository with some submodule not active, it could be needed to run
> a command only for active submodule. Today it can be achived with the
> command:
>
> git submodule foreach 'git -C $toplevel submodule--helper is-active \
> $sm_path && pwd || :'

"it could be needed" is being too modest.

	To iterate only on active submodules, we can do ...

	 ... << the above command >> ...

	but it is inefficient to ask about each and every submodule.

may be convincing enough.  

If iterating over only active ones is useful, surely it would also
be useful to be able to iterate over only inactive ones, right? 

So, before getting married too much to the use-case of "only active
ones" and getting our eyes clouded from seeing a larger picture,
let's see what other "traits" of submodules we can use to pick which
ones to act on.

Are there attributes other than "is-active" that we may want to and
can check about submodules?  There is is_submodule_populated() next
to is_submodule_active(), which might be a candidate. IOW, what I am
wondering is if it makes sense to extend this to

	git submodule foreach --trait=is-active ...
	git submodule foreach --trait=!is-active ...
	git submodule foreach --trait=is-populated ...

to allow iterating only on submodules with/without given trait (I am
not suggesting the actual option name, but merely making sure that
'is-active' is not anything special but one of the possibilities
that can be used to limit the iteration using the same mechanism).

>  builtin/submodule--helper.c  |  8 +++++++-
>  t/t7407-submodule-foreach.sh | 16 ++++++++++++++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 1a4b391c882..1a275403764 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -450,6 +450,7 @@ struct foreach_cb {
>  	const char *prefix;
>  	int quiet;
>  	int recursive;
> +	int only_active;

And I tend to agree with Eric downthread that active_only would be a
more natural name if we want to have this field.

> @@ -464,6 +465,9 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
>  	struct child_process cp = CHILD_PROCESS_INIT;
>  	char *displaypath;
>  
> +	if (info->only_active && !is_submodule_active(the_repository, path))
> +		return;
> +
>  	displaypath = get_submodule_displaypath(path, info->prefix);
>  
>  	sub = submodule_from_path(the_repository, &null_oid, path);
> @@ -565,11 +569,13 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
>  		OPT__QUIET(&info.quiet, N_("Suppress output of entering each submodule command")),
>  		OPT_BOOL(0, "recursive", &info.recursive,
>  			 N_("Recurse into nested submodules")),
> +		OPT_BOOL(0, "only-active", &info.only_active,
> +			 N_("Call command only for active submodules")),
>  		OPT_END()
>  	};
>  
>  	const char *const git_submodule_helper_usage[] = {
> -		N_("git submodule--helper foreach [--quiet] [--recursive] [--] <command>"),
> +		N_("git submodule--helper foreach [--quiet] [--recursive] [--only-active] [--] <command>"),
>  		NULL
>  	};
>  
> diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
> index 6b2aa917e11..f90a16e3e67 100755
> --- a/t/t7407-submodule-foreach.sh
> +++ b/t/t7407-submodule-foreach.sh
> @@ -80,6 +80,22 @@ test_expect_success 'test basic "submodule foreach" usage' '
>  	test_i18ncmp expect actual
>  '
>  
> +sub3sha1=$(cd super/sub3 && git rev-parse HEAD)
> +cat > expect <<EOF
> +Entering 'sub3'
> +$pwd/clone-foo3-sub3-$sub3sha1
> +EOF
> +
> +test_expect_success 'test "submodule--helper foreach --only-active" usage' '
> +	test_when_finished "git -C clone config --unset submodule.foo1.active" &&
> +	(
> +		cd clone &&
> +		git config --bool submodule.foo1.active "false" &&
> +		git submodule--helper foreach --only-active "echo \$toplevel-\$name-\$path-\$sha1" > ../actual
> +	) &&
> +	test_i18ncmp expect actual
> +'
> +
>  cat >expect <<EOF
>  Entering '../sub1'
>  $pwd/clone-foo1-sub1-../sub1-$sub1sha1
>
> base-commit: b994622632154fc3b17fb40a38819ad954a5fb88
