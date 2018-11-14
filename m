Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 651191F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 04:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeKNO5A (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 09:57:00 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63294 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbeKNO5A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 09:57:00 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B5D2A11CBF3;
        Tue, 13 Nov 2018 23:55:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w3gNa/QhIfhf1BskWT5KlCB/f0o=; b=c64QZd
        qigDWO5TVQNCgFpJy/kA6C5kne0KY5XvHF/RHmWKKt0p3b3y3hvb0Es+NJ1xxiZ1
        pS+RLTTCyTzLJPnyrJjuDAyzrfHN3N1EhBqO5DPeZUMTy0IDj5g0ji4a9k/OB3yt
        g+3nL+WbkSuV7LkJ8aK6zO5w38JJkumC+gpeU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BYc5PgvPtA4gO8y4zS/5TV+diRJ08EvT
        0s87G5eOjW9BD3FF1nYI522LtS/KVQPv6QL7EpfjjZ/VvOIoMxDxg3/U4Y5rp0Jw
        BceW61m7UbNKv3vJsd3cIZhSiOsXIfrqzhg+rkPeEhQvxnHcOFecGIGv/jEU9bHv
        QG0+z30R83M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA28711CBF2;
        Tue, 13 Nov 2018 23:55:26 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1AD6C11CBF1;
        Tue, 13 Nov 2018 23:55:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/5] tests: respect GIT_TEST_INSTALLED when initializing repositories
References: <pull.73.git.gitgitgadget@gmail.com>
        <948b3dc146fe353fbab6057c1376fa0e787a444f.1542030510.git.gitgitgadget@gmail.com>
Date:   Wed, 14 Nov 2018 13:55:25 +0900
In-Reply-To: <948b3dc146fe353fbab6057c1376fa0e787a444f.1542030510.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 12 Nov 2018
        05:48:34 -0800 (PST)")
Message-ID: <xmqqin10p8aq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8044AE14-E7C9-11E8-B599-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> It really makes very, very little sense to use a different git
> executable than the one the caller indicated via setting the environment
> variable GIT_TEST_INSTALLED.

Makes perfect sense.  Shouldn't we be asking where the template
directory of the installed version is and using it instead of the
freshly built one, no?

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/test-lib-functions.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 78d8c3783b..801cc9b2ef 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -900,7 +900,8 @@ test_create_repo () {
>  	mkdir -p "$repo"
>  	(
>  		cd "$repo" || error "Cannot setup test environment"
> -		"$GIT_EXEC_PATH/git-init" "--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
> +		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git" init \
> +			"--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
>  		error "cannot run git init -- have you built things yet?"
>  		mv .git/hooks .git/hooks-disabled
>  	) || exit
