Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD19C433DB
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 05:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7124D22DA7
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 05:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbhAOFta (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 00:49:30 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53900 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbhAOFta (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 00:49:30 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6C25211691B;
        Fri, 15 Jan 2021 00:48:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GvUVUXUZHPxtBBKkwNUsUYdzjcM=; b=UfTovy
        tbeD6/CjQ0gFaT7WlvYj8fc1EhjrHqfRgnZn20TJqqNA0H+fygfhhx5to4xONUc6
        kKJa2VC9cQZNbz0mePeoGClFbQ25AE8yIQ35omEieAO4sGgDl1vXhLU/7oN0ItKd
        xKgWzh0ZkVmH+rfCEzoZrKcdkewOL/5XNKAoY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NyllifLbAM6zrhCO16XZAGDjD7KgSTv5
        4d/O4oc+rCFass7tx1p8qYsSmnmJpDMb3iOq3MIZkMUBl5jrT0IWweTx0Zcqm5H6
        4Dd56/54ugg73qQt16cMml5+5ZuTbqCHhYfzMXv9UQIyrnwgmcz67iC6gD/cnfLX
        vkZ7L8LqfF8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6492E11691A;
        Fri, 15 Jan 2021 00:48:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 96079116919;
        Fri, 15 Jan 2021 00:48:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: [PATCH] ci/install-depends: attempt to fix "brew cask" stuff
References: <xmqqk0sevqlh.fsf@gitster.c.googlers.com>
Date:   Thu, 14 Jan 2021 21:48:41 -0800
In-Reply-To: <xmqqk0sevqlh.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 14 Jan 2021 19:14:34 -0800")
Message-ID: <xmqqa6tavjgm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53B5315A-56F5-11EB-BC8B-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> It seems that homebrew suddenly started giving us trouble, like this:
>
> https://github.com/git/git/runs/1705953982?check_suite_focus=true#step:3:70
>
> Here is my attempt to work it around by blindly following the
> suggested course of action in the error message, without knowing
> what I am doing X-<.  I am not a Mac person.
>
> What is frustrating is that every time we hit a minor snag like this
> to break one of the jobs, all other unrelated jobs are also taken
> down.
>
> Help by those who know what they are doing on macOS would greatly be
> appreciated.  Thanks.

After seeing 'seen' with this patch at its tip pass the tests [*1*],
I prepared a merge of this change into the tip of 'next' and
tentatively updated 'seen' with it.

The test is still running [*2*], but the problematic part in the
macOS build has already passed, so I am planning to fast-track this
change down to 'next', 'master' and eventually down to 'maint' to
keep the CI going to help other platforms catch more interesting
problems.

Help from those who are more familiar with macOS and homebrew is
still appreciated, though.


[References]

*1* https://github.com/git/git/actions/runs/486978562
*2* https://github.com/git/git/runs/1706704233?check_suite_focus=true#step:3:81


> ----- >8 ----- >8 ----- >8 ----- >8 ----- >8 ----- >8 -----
> We run "git pull" against "$cask_repo"; clarify that we are
> expecting not to have any of our own modifications and running "git
> pull" to merely update, by passing "--ff-only" on the command line.
>
> Also, the "brew cask install" command line triggers an error message
> that says:
>
>     Error: Calling brew cask install is disabled! Use brew install
>     [--cask] instead.
>
> In addition, "brew install caskroom/cask/perforce" step triggers an
> error that says:
>
>     Error: caskroom/cask was moved. Tap homebrew/cask instead.
>
> Attempt to see if blindly following the suggestion in these error
> messages gets us into a better shape.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  ci/install-dependencies.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 0229a77f7d..0b1184e04a 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -44,13 +44,13 @@ osx-clang|osx-gcc)
>  	test -z "$BREW_INSTALL_PACKAGES" ||
>  	brew install $BREW_INSTALL_PACKAGES
>  	brew link --force gettext
> -	brew cask install --no-quarantine perforce || {
> +	brew install --cask --no-quarantine perforce || {
>  		# Update the definitions and try again
>  		cask_repo="$(brew --repository)"/Library/Taps/homebrew/homebrew-cask &&
> -		git -C "$cask_repo" pull --no-stat &&
> -		brew cask install --no-quarantine perforce
> +		git -C "$cask_repo" pull --no-stat --ff-only &&
> +		brew install --cask --no-quarantine perforce
>  	} ||
> -	brew install caskroom/cask/perforce
> +	brew install homebrew/cask/perforce
>  	case "$jobname" in
>  	osx-gcc)
>  		brew install gcc@9
