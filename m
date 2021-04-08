Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E183C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 17:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51AA5610F8
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 17:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhDHRqL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 13:46:11 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51615 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbhDHRqK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 13:46:10 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8642812E3A8;
        Thu,  8 Apr 2021 13:45:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Mcz7SQ7soZ4H
        m5lcp1IRPZFwIBA=; b=bKKmxQgoNi+Sr59/NJ49VHsNk2GlrRX0QWBPwUs+eNGx
        aWPkrsIE0Q/9uaqr2w1SRArRJKOG7Xu2Hb2b00UfDxZBtBqLy5oV7JTnXlGMheL4
        w+cPXL7naQGtXQSiWz5GAde0NDUQASff2CDhP6gQc5nd4cm/EgFprZupJiDC0F0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=uu3wTx
        bYoI5KSEtyjmii7W8lbIoSBv6k3knDdpHoZ5TOqc6vuvf2/hCuO6CVg22T3mHmCe
        q2iPJ+ZT0u33A7/srkxW12sl1gPoQ/iYsa8nFKpZgLZ90dRJHBxZb+tTZ5upBjp3
        HaYUpIHS9DCrDwbYDK4VlATBlZIUAxVPupIo4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7EBD912E3A6;
        Thu,  8 Apr 2021 13:45:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C6D6112E3A5;
        Thu,  8 Apr 2021 13:45:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ville =?utf-8?Q?Skytt=C3=A4?= <ville.skytta@iki.fi>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] completion: audit and guard $GIT_* against unset use
References: <20210408070641.360431-1-ville.skytta@iki.fi>
Date:   Thu, 08 Apr 2021 10:45:55 -0700
In-Reply-To: <20210408070641.360431-1-ville.skytta@iki.fi> ("Ville
 =?utf-8?Q?Skytt=C3=A4=22's?=
        message of "Thu, 8 Apr 2021 10:06:41 +0300")
Message-ID: <xmqqv98wu0to.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 45C7ACEC-9892-11EB-9C2D-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ville Skytt=C3=A4 <ville.skytta@iki.fi> writes:

> $GIT_COMPLETION_SHOW_ALL and $GIT_TESTING_ALL_COMMAND_LIST were used
> without guarding against them being unset, causing errors in nounset
> (set -u) mode.
>
> No other nounset-unsafe $GIT_* usages were found.
>
> While at it, remove a superfluous (duplicate) unset guard from $GIT_DIR
> in __git_find_repo_path.
>
> Signed-off-by: Ville Skytt=C3=A4 <ville.skytta@iki.fi>
> ---
>  contrib/completion/git-completion.bash | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Looks good to me.  Will queue.  Thanks.

>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
> index e1a66954fe..29b859a0b8 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -77,7 +77,7 @@ __git_find_repo_path ()
>  		test -d "$__git_dir" &&
>  		__git_repo_path=3D"$__git_dir"
>  	elif [ -n "${GIT_DIR-}" ]; then
> -		test -d "${GIT_DIR-}" &&
> +		test -d "$GIT_DIR" &&
>  		__git_repo_path=3D"$GIT_DIR"
>  	elif [ -d .git ]; then
>  		__git_repo_path=3D.git
> @@ -427,7 +427,7 @@ __gitcomp_builtin ()
> =20
>  	if [ -z "$options" ]; then
>  		local completion_helper
> -		if [ "$GIT_COMPLETION_SHOW_ALL" =3D "1" ]; then
> +		if [ "${GIT_COMPLETION_SHOW_ALL-}" =3D "1" ]; then
>  			completion_helper=3D"--git-completion-helper-all"
>  		else
>  			completion_helper=3D"--git-completion-helper"
> @@ -1910,7 +1910,7 @@ _git_help ()
>  		return
>  		;;
>  	esac
> -	if test -n "$GIT_TESTING_ALL_COMMAND_LIST"
> +	if test -n "${GIT_TESTING_ALL_COMMAND_LIST-}"
>  	then
>  		__gitcomp "$GIT_TESTING_ALL_COMMAND_LIST $(__git --list-cmds=3Dalias=
,list-guide) gitk"
>  	else
