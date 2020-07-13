Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46DBC433DF
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 19:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91B6220773
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 19:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="I25V2uPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgGMTgn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:36:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52002 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGMTgn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 15:36:43 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9086767957;
        Mon, 13 Jul 2020 15:36:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I72KS4JFXd0gzV4xq9gqcz6Nk6w=; b=I25V2u
        PvDbtG81yx/1LpNC+m9ptuf9XtyilieSTt0WV+9vrzQF8kxpINoW3bGiWcHFvjiw
        p3YXseMMJAyIKIuj1HGURtYm0pdGi9igdLWBkRzsxCyYJMsRGPltqz3JOt61+ehb
        QiOnSF1qr8lGsXaCBdV7cR3M9npZdJT5+BFj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K2QJdjMwhkR0j/GHjpnBQVjxfKOFNgV8
        PKUWv48oD3zeTGrMtV84fcVaiJxm2z/uhWUWOXbVb1epMiY/LkyTmFAgxx3Tj+8j
        lhK+WUOTqy0XQ3cpPKnDStTD0Hey86GxJ3d/J8e+QMEaT5/m6al0RyKCruO58g7D
        bsPX2dEKny8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8895267956;
        Mon, 13 Jul 2020 15:36:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E87BA67955;
        Mon, 13 Jul 2020 15:36:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, delphij@google.com,
        peff@peff.net, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] setup: warn if extensions exist on old format
References: <pull.674.git.1594668051847.gitgitgadget@gmail.com>
Date:   Mon, 13 Jul 2020 12:36:37 -0700
In-Reply-To: <pull.674.git.1594668051847.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Mon, 13 Jul 2020 19:20:51
        +0000")
Message-ID: <xmqqblkjnr5m.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B169DE8-C540-11EA-BBD0-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Prior to 14c7fa269e4 (check_repository_format_gently(): refuse extensions
> for old repositories, 2020-06-05), Git was honoring configured
> extensions, even if core.repositoryFormatVersion was 0 (or unset). This
> was incorrect, and is now fixed.
>
> The issue now is that users who relied on that previously bad behavior
> will upgrade to the next version of Git and suddently be in a bad
> situation. In particular, users of the 'git sparse-checkout' builting
> will rely on the extensions.worktreeConfig for the core.sparseCheckout
> and core.sparseCheckoutCone config options. Without that extension,
> these users will suddenly have repositories stop acting like a sparse
> repo.

s/builting/command/ perhaps???

>
> What is worse is that a user will be confronted with the following
> error if they try to run 'git sparse-checkout init' again:
>
> 	warning: unable to upgrade repository format from 0 to 1
>
> This is because the logic in 14c7fa269e4 refuses to upgrae repos when
> the version is unset but extensions exist.
>
> While it is important to correct this improper behavior, create a
> warning so users in this situation can correct themselves without too
> much guesswork. By creating a warning in
> check_repository_format_gently(), we can alert the user if they have a
> ocnfigured extension but not a configured repository version.

s/ocn/con/

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---

Thanks for a thoughtful analysis of the situation and coming up with
a plan to remedy.

> +	if (candidate->version == 0 && candidate->has_extensions) {
> +		warning(_("some extensions are enabled, but core.repositoryFormatVersion=0"));
> +		warning(_("if you intended to use extensions, run 'git config core.repositoryFormatVersion 1'"));
> +	}

That reads well.

An alternative may be to grandfather some extensions that were
enabled by git by mistake without updating the format version, and
we update the repository even if the repository has extensions that
should not exist, but those offending extensions are limited only to
those that we decide to special case.  That would make the end-user
experience even smoother.

Is extenions.worktreeCOnfig the only one that needs this escape
hatch?


