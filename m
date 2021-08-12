Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E9CC4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 04:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06A1C60231
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 04:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhHLEV0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 00:21:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50792 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhHLEVY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 00:21:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 90FA6D7829;
        Thu, 12 Aug 2021 00:20:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cCNA2lKCKODpw2egFq129JPAuzh/33ZWw7w4mN
        yaKQ8=; b=ncLBGxkaTAPRTtKdezP2MapWX+npWF2L+/h4nv+0sFXO2cq5Pyr8hI
        zsEKuZMkswexQN3JFfcMsVvidevnnLaM3iYesz2awDRDTW3ggo825fmXsvSwxbaW
        0eJ1xmpMkgF/URsYPE8hKf1RMfJ+J/1CuGnidktKlzLU4CFnijnOQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 899B6D7828;
        Thu, 12 Aug 2021 00:20:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0EBEAD7825;
        Thu, 12 Aug 2021 00:20:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Mahi Kolla via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Mahi Kolla <mahikolla@google.com>
Subject: Re: [PATCH v5] clone: set submodule.recurse=true if user enables
 feature.experimental flag
References: <pull.1006.v4.git.1628536305810.gitgitgadget@gmail.com>
        <pull.1006.v5.git.1628736366133.gitgitgadget@gmail.com>
Date:   Wed, 11 Aug 2021 21:20:58 -0700
In-Reply-To: <pull.1006.v5.git.1628736366133.gitgitgadget@gmail.com> (Mahi
        Kolla via GitGitGadget's message of "Thu, 12 Aug 2021 02:46:06 +0000")
Message-ID: <xmqqeeaz70ph.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B220497C-FB24-11EB-A8AF-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Mahi Kolla via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Mahi Kolla <mahikolla@google.com>
>
> Currently, when running 'git clone --recurse-submodules', developers do not expect other commands such as 'pull' or 'checkout' to run recursively into active submodules. However, setting 'submodule.recurse' to true at this step could make for a simpler workflow by eliminating the '--recurse-submodules' option in subsequent commands. To collect more data on developers' preference in regards to making 'submodule.recurse=true' a default config value in the future, deploy this feature under the opt in feature.experimental flag.

Please wrap overlong lines in your proposed log message to say 70 or
so columns.

>
> Since V1: Made this an opt in feature under the experimental flag. Updated tests to reflect this design change. Also updated commit message.

This does not belong to the commit log message proper.  Noting the
difference between the version being submitted and the pervious one
this way is a way to help reviewers and is very much appreciated,
but please do so below the three-dash line below your sign-off.

> Signed-off-by: Mahi Kolla <mahikolla@google.com>
> ---
>     clone: set submodule.recurse=true if feature.experimental flag enabled

The proposed approach misuses feature.experimental flag, which was
designed to turn on many new features at once.  The features covered
by the flag share one common trait: they all have gained consensus
that in the longer term we would hopefully be able to make it on by
default, and give early adopters an easy way to turn them all on.

I do not think setting submodule.recurse=true upon "clone --recurse"
falls into that category just yet.  If we were to make this opt-in,
we'd want a separate flag, so that those early adopters who are
dogfooding other features that have consensus that they are
hopefully the way of the future won't have to be forced into this
separate feature.

Perhaps a separate (and new) configuration variable (in ~/.gitconfig
perhaps) can be used as that opt-in flag (I wonder if the existing
submodule.recurse variable can be that opt-in flag, though).

