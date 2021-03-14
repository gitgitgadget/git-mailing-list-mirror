Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DB5C433E0
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 23:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1B6B64E10
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 23:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhCNXxX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 19:53:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63509 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhCNXw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 19:52:56 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87BF4BFB0D;
        Sun, 14 Mar 2021 19:52:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KAEVJS+wUOmgG5QZsMr61I6zEPo=; b=aUFwSC
        b4WoQNOMxExpuVJ6VNb9cfWGqIlKhSPzSmgOdLs7J82a+mwQzCHl3i5BftaOfob8
        QzIeQ1x7atLAfFol/Jbs1prHPwyVt3S3iuB6YTRbC3rY/e+EP8k9WSMvyYp/m2YR
        hxSD0UM/tlp2FxK6vszrDdiIaKMuMEKi9E8vM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nBZ5pUDd3GljR09vGx0L/abxqxFdLtk6
        DmPvfGzWQNyhY8o9dooQcT/U0EXJetBED0MutDAec0cqNus+2dPJmEs9JNIz0+9S
        DQd+Tv59jG5gqNadiZPNgtmcvrIF/sMVJty70DxQva4JY8bcSNjWb1xlZ8gjU8nT
        WivcnG/U54Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F186BFB0C;
        Sun, 14 Mar 2021 19:52:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 01099BFB0B;
        Sun, 14 Mar 2021 19:52:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v4] [GSOC] commit: add --trailer option
References: <pull.901.v3.git.1615726978059.gitgitgadget@gmail.com>
        <pull.901.v4.git.1615737505834.gitgitgadget@gmail.com>
Date:   Sun, 14 Mar 2021 16:52:54 -0700
In-Reply-To: <pull.901.v4.git.1615737505834.gitgitgadget@gmail.com> (ZheNing
        Hu via GitGitGadget's message of "Sun, 14 Mar 2021 15:58:25 +0000")
Message-ID: <xmqqh7ld2syx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 655263A2-8520-11EB-87B1-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -958,6 +970,12 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  
>  	fclose(s->fp);
>  
> +	if (run_trailer.args.nr != 4) {
> +		run_trailer.git_cmd = 1;
> +		run_command(&run_trailer);

This hardcoded magic 4 is very brittle.  It probably makes sense to
have another string vector, that is used only to accumulate
--trailer arguments and nothing else, and check if that string
vector is empty here.

IOW this part would become ...

	if (trailer_args.nr) {
		strvec_pushl(&run_trailer.args,	"interpret-trailers", 
			     "--in-place", ...);
		strvec_pushv(&run_trailer.args, trailer_args.v);
		run_trailer.git_cmd = 1;
		run_command(&run_trailer);
	}

> +	} else
> +		strvec_clear(&run_trailer.args);

... and there is no need to have "else" that won't need to do
anything.

>  	/*
>  	 * Reject an attempt to record a non-merge empty commit without
>  	 * explicit --allow-empty. In the cherry-pick case, it may be
> @@ -1507,6 +1525,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		OPT_STRING(0, "fixup", &fixup_message, N_("commit"), N_("use autosquash formatted message to fixup specified commit")),
>  		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
>  		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
> +		OPT_CALLBACK(0, "trailer", &trailer, N_("trailer"), N_("trailer(s) to add"), opt_pass_trailer),
>  		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
>  		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
>  		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
> @@ -1577,6 +1596,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  			die(_("could not parse HEAD commit"));
>  	}
>  	verbose = -1; /* unspecified */
> +	strvec_pushl(&run_trailer.args, "interpret-trailers",
> +		    "--in-place", "--where=end", git_path_commit_editmsg(), NULL);

And this line will be gone.

>  	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
>  					  builtin_commit_usage,
>  					  prefix, current_head, &s);
