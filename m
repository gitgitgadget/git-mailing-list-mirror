Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77742C48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 04:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 445E46128C
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 04:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhFPEZr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 00:25:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50686 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhFPEZr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 00:25:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8788BD0DBC;
        Wed, 16 Jun 2021 00:23:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=k5E3o4zn6GI4
        lKGLhBZ/rnbW7iDDNsBCYteNrJSRp7Q=; b=LCHQoHRCzlTQgVXexO2012uF9DVE
        cUxqYfibAOeU87L+tnWeUyvq8jlqll6tZsFC36KQzLZUzNI3G82bgenNnWSZjtOm
        KDgcBWBNBN0cCzds5oXa/USIpQtDTBchbz8YrGKNHKG+fVu6+sG/vlgT2fMs56wM
        TF4V5yAT49sVdbg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7FD15D0DBB;
        Wed, 16 Jun 2021 00:23:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 09B2DD0DBA;
        Wed, 16 Jun 2021 00:23:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Daniel_H=C3=B6pfl_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Daniel =?utf-8?Q?H=C3=B6pfl?= <github@hoepfl.de>,
        Daniel =?utf-8?Q?H?= =?utf-8?Q?=C3=B6pfl?= <daniel@hoepfl.de>
Subject: Re: [PATCH] Add config variable besides env variable to squelch
 "do-not-use" warning.
References: <pull.912.git.git.1623785914202.gitgitgadget@gmail.com>
Date:   Wed, 16 Jun 2021 13:23:40 +0900
In-Reply-To: <pull.912.git.git.1623785914202.gitgitgadget@gmail.com>
 ("Daniel
        =?utf-8?Q?H=C3=B6pfl?= via GitGitGadget"'s message of "Tue, 15 Jun 2021
 19:38:33
        +0000")
Message-ID: <xmqqy2baqvxv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A1213E70-CE5A-11EB-9E7B-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Daniel H=C3=B6pfl via GitGitGadget"  <gitgitgadget@gmail.com> writes:

> From: =3D?UTF-8?q?Daniel=3D20H=3DC3=3DB6pfl?=3D <daniel@hoepfl.de>
>
> In addition to the environment variable FILTER_BRANCH_SQUELCH_WARNING,
> the git config filter-branch.squelchWarning is checked to see if the
> usage warning should be squelched.

Thanks for trying to improve the system.

A configuration variable that is used to squelch warning messages
related to migration and transition typically lives under advice.*
hierarchy, so something ike "advice.weanOffOfFilterBranch" may be a
more appropriate name for this new knob.

Having said that.

As this message with environment as an escape hatch was added as a
way to strongly discourage users from keep using the command, I am
fairly negative to a change that adds yet another way to make it
easier to keep using it.

Elijah, who did 9df53c5d (Recommend git-filter-repo instead of
git-filter-branch, 2019-09-04), added to CC list for input.

Thanks.

> Signed-off-by: Daniel H=C3=B6pfl <daniel@hoepfl.de>
> ---
>     Add filter-branch.squelchWarning git config alongside
>     FILTER_BRANCH_SQUELCH_WARNING
>    =20
>     In addition to the environment variable FILTER_BRANCH_SQUELCH_WARNI=
NG,
>     the git config filter-branch.squelchWarning is checked to see if th=
e
>     usage warning should be squelched.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-9=
12%2Fdhoepfl%2FFILTER_BRANCH_SQUELCH_WARNING-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-912/=
dhoepfl/FILTER_BRANCH_SQUELCH_WARNING-v1
> Pull-Request: https://github.com/git/git/pull/912
>
>  git-filter-branch.sh | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index fea796461721..d33db14a2a84 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -83,7 +83,8 @@ set_ident () {
>  	finish_ident COMMITTER
>  }
> =20
> -if test -z "$FILTER_BRANCH_SQUELCH_WARNING$GIT_TEST_DISALLOW_ABBREVIAT=
ED_OPTIONS"
> +if test -z "$FILTER_BRANCH_SQUELCH_WARNING$GIT_TEST_DISALLOW_ABBREVIAT=
ED_OPTIONS" &&
> +   test "$(git config --bool filter-branch.squelchWarning)" !=3D true
>  then
>  	cat <<EOF
>  WARNING: git-filter-branch has a glut of gotchas generating mangled hi=
story
> @@ -91,7 +92,12 @@ WARNING: git-filter-branch has a glut of gotchas gen=
erating mangled history
>  	 alternative filtering tool such as 'git filter-repo'
>  	 (https://github.com/newren/git-filter-repo/) instead.  See the
>  	 filter-branch manual page for more details; to squelch this warning,
> -	 set FILTER_BRANCH_SQUELCH_WARNING=3D1.
> +	 set FILTER_BRANCH_SQUELCH_WARNING=3D1 or run the following command:
> +
> +	    git config filter-branch.squelchWarning true
> +
> +	 You can replace "git config" with "git config --global" to disable
> +	 the warning for all repositories.
>  EOF
>  	sleep 10
>  	printf "Proceeding with filter-branch...\n\n"
>
> base-commit: e4d83eee9239207622e2b1cc43967da5051c189c
