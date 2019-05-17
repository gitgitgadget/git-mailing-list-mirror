Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D1FB1F461
	for <e@80x24.org>; Fri, 17 May 2019 04:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfEQEMI (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 00:12:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53768 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfEQEMI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 00:12:08 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11B4C1575B3;
        Fri, 17 May 2019 00:12:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bhChLWG2xvTS
        OXDsHtxzt52ao/s=; b=JCQhmxb+5AFaP4nabyogHnw45rYcgmxEfBA7T93XUMoK
        9rg/vxO5IH0rhG5M7NbNMyqGodhpjEmWzZ6bVyph17p8GRk+ivqf6mGgR+22a5bg
        22jGq90w0U4fxO8sUw4aau62P20kbfDU4rMhSL9spps2RoFpdDfgZ/u5OjAumdc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=HSV/UE
        yVJ/cYx7J6pUPwXQ9WrBm8GhPnzoTyppVmqHlwE+/0rXHfKY2SStPgSbewe+OEJ1
        TXdCJxA624nxvav7PdSx8K0T4ha+89f7LRJYGOcEfbmHP1b3KQ5KgdhWxQeqB6Ib
        wPw25ealWmGm4UqQkc7K0cNFs/4k7y7xfdxbQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EF1F51575B1;
        Fri, 17 May 2019 00:12:05 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 582EF1575B0;
        Fri, 17 May 2019 00:12:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 0/6] teach branch-specific options for format-patch
References: <cover.1557072929.git.liu.denton@gmail.com>
        <cover.1558052674.git.liu.denton@gmail.com>
Date:   Fri, 17 May 2019 13:12:04 +0900
In-Reply-To: <cover.1558052674.git.liu.denton@gmail.com> (Denton Liu's message
        of "Thu, 16 May 2019 20:27:38 -0400")
Message-ID: <xmqqk1ep3ejv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EE1BEAA8-7859-11E9-A49C-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> diff --git a/Documentation/config/format.txt b/Documentation/config/for=
mat.txt
> index dc77941c48..d387451573 100644
> --- a/Documentation/config/format.txt
> +++ b/Documentation/config/format.txt
> @@ -28,14 +28,22 @@ format.headers::
> =20
>  format.to::
>  format.cc::
> +format.<branch-name>.to::
> +format.<branch-name>.cc::
>  	Additional recipients to include in a patch to be submitted
> -	by mail.  See the --to and --cc options in
> -	linkgit:git-format-patch[1].
> +	by mail.  For the <branch-name> options, the recipients are only
> +	included if patches are generated for the given <branch-name>.
> +	See the --to and --cc options in linkgit:git-format-patch[1].

An obvious question that somebody else may raise is:

    What makes the branch name that special?  What guarantees that
    it would stay to be the *only* thing that affects the choice of
    these variables?

An obvious answer to that is "nothing---we are painting ourselves in
a corner we cannot easily get out of with this design".

If we want to drive format-patch differently depending on the
combination of the worktree location *and* the branch the patches
are generated from, we can do something like:

	[includeif "gitdir:/path/to/worktree/1"] path =3D one.inc
	[includeif "gitdir:/path/to/worktree/2"] path =3D two.inc

and then have one.inc/two.inc have customized definition of these
format.<branch>.{to,cc,...} variables.

But at that point, =C3=86var's "wouldn't this fit better with includeif"
suggestion becomes more and more appropriate.  Once we invent the
way to combine the conditions for includeIf, it would benefit not
just this set of variables but all others that will follow in the
future.

Having said that, as long as we are fine with the plan to deprecate
and remove these three-level variables this patch introdues in the
future, I think it is OK to have them as a temporary stop-gap
measure.

> +format.<branch-name>.coverSubject::
> +	When format-patch generates a cover letter for the given
> +	<branch-name>, use the specified subject for the cover letter
> +	instead of the generic template.

I still think it is a mistake that this has to be given separately
and possibly redundantly from the branch description.

> +static const char *branch_specific_config[] =3D {
> +	"branch",
> +	"format",
> +	NULL
> +};

Yuck.  This will break a workflow where a fixed branch with a known
configuration is deleted and recreated over and over again
(e.g. think of "for-linus" branches used for request-pull in each
merge window).

>  static void delete_branch_config(const char *branchname)
>  {
>  	struct strbuf buf =3D STRBUF_INIT;
> -	strbuf_addf(&buf, "branch.%s", branchname);
> -	if (git_config_rename_section(buf.buf, NULL) < 0)
> -		warning(_("Update of config-file failed"));
> +	int i;
> +	for (i =3D 0; branch_specific_config[i]; i++) {
> +		strbuf_addf(&buf, "%s.%s", branch_specific_config[i], branchname);
> +		if (git_config_rename_section(buf.buf, NULL) < 0)
> +			warning(_("Update of config-file failed"));
> +		strbuf_reset(&buf);
> +	}

This will hardcode the unwarranted limitation that the second level
of the format.*.var hierarchy MUST be branch names and nothing else,
won't it? =20

