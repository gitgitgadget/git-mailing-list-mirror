Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C106F20756
	for <e@80x24.org>; Fri, 13 Jan 2017 18:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750969AbdAMSk4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 13:40:56 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55269 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750927AbdAMSkz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 13:40:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B0785DE18;
        Fri, 13 Jan 2017 13:40:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BI4v/10J7g70CEbvK3mN5yhi9/M=; b=vpWjJz
        f3QKPOZyt6aBw/HNaEqCA4/zZcAW/uIZtlDKYy8oaxw9lFL8SruiQtaRQjz5Jj3T
        s/Nfsspq3zA5eiRqUWyIE2cxoQcnJ7hLaQComGpQ2Qu35kLRPkm3ODXD5I8XlrDT
        6qAa6sgpCZFkcCP1Mii2nIUNA9eFnueeBwMmE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Tmv4gVWUL2Kp+9p/CxU8dK8yvB3DbvIj
        bDDep45ICLlLp0xAp0ANeWtLUxDkdaFy+dB5UVqRWBODfTAHVU+T1Bexq4daugl9
        GI62Gw/VLIaZyzayEevpIF6nBro6be6L8xGKnbpL3VHs3tpqgqLUH/VO6x4Nd/RR
        zqdT5RB+cdg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 033225DE17;
        Fri, 13 Jan 2017 13:40:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 577195DE16;
        Fri, 13 Jan 2017 13:40:52 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] lib-submodule-update.sh: drop unneeded shell
References: <20170111184732.26416-1-sbeller@google.com>
Date:   Fri, 13 Jan 2017 10:40:51 -0800
In-Reply-To: <20170111184732.26416-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 11 Jan 2017 10:47:32 -0800")
Message-ID: <xmqqtw92hkgc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF725140-D9BF-11E6-8159-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> In modern Git we prefer "git -C <cmd" over "(cd <somewhere && git <cmd>)"
> as it doesn't need an extra shell.

There is a matching '>' missing.  The description is correct (I am
not sure if there actually is "preference", though), but I found the
title a bit misleading.  With 'drop unneeded subshell', I would
imagine a patch like

		(
	-		( do something )
	+		do something;
			do something else;
		)

It looks more like "reduce use of subshell by using 'git -C <dir>'"
to me.

> And because it is in a setup function, we actually save the invocation
> of 22 shells for a single run of the whole test suite.

Nice.

>
> Noticed while adding a lot more in near vincinity, though not as near
> to cause merge conflicts, so sending it extra.
>
> Thanks,
> Stefan
>
>  t/lib-submodule-update.sh | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
> index 79cdd34a54..915eb4a7c6 100755
> --- a/t/lib-submodule-update.sh
> +++ b/t/lib-submodule-update.sh
> @@ -69,10 +69,7 @@ create_lib_submodule_repo () {
>  
>  		git checkout -b "replace_sub1_with_directory" "add_sub1" &&
>  		git submodule update &&
> -		(
> -			cd sub1 &&
> -			git checkout modifications
> -		) &&
> +		git -C sub1 checkout modifications &&
>  		git rm --cached sub1 &&
>  		rm sub1/.git* &&
>  		git config -f .gitmodules --remove-section "submodule.sub1" &&
