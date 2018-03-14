Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3882B1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 21:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeCNVzf (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 17:55:35 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50498 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeCNVze (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 17:55:34 -0400
Received: by mail-wm0-f68.google.com with SMTP id w128so6889746wmw.0
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 14:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vmE05UmFbTuwhelBPYSPoCjVkWjPwNggS3E/ltV5498=;
        b=SszUuT3JRlIOn2Ac+lQdCzoVlIC51LIhbswfyNLWBjSRmV45TnEbmM3qh7/0+G0knk
         aDYSUBZKmO5E0EEz2KteGQO3/X4xn+fpGxxR1PEhYG/oHwFUTvAPJhSUQYzJC/dlHAaZ
         NQoXP3Tna6O/IRS4zIEEQp9DCNh9lcgk+PJvIaH9falUyOsGgTyt/oTOJqYTe9SfsbYE
         2UiPJ7v8cZOdISPGGW/vnjrASDhVDEwLBa8nH90gbt5YuxBqST66tRrA+zilgQHRiLUe
         ygzXIA5Mx/VFbhcQnoO9kvUuU6wtN9jTciSOP5+SCgmPWsjZeKMywZLG+yow6Yupks3q
         EO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vmE05UmFbTuwhelBPYSPoCjVkWjPwNggS3E/ltV5498=;
        b=HU2SMHcT5ZoPyqy1vZc+uCGNw4Kw/6p/gAgW6WNyXPabcWGq4sBNRSt3HtKon87+jP
         AbijWiZr9j2CsTwHLDTsAPkwq30MbtsNQ6T9H1yH80XO+5eeBq3BaR+rim4dzMCGfQj6
         az8mnuoLBKHfYbjb2KzTvqUz827WYFWsJCCbvW0bFrHK7/LlaYp5HrS7QQHU7wzzgjx3
         mpkIu8v/MnIZcz7RHm4y1ZF4x1a0phmJPmAWOloaFFwJ+hQTMtR3aZJ4atrXMnsCw32+
         6+UXq7gJx93r+vjWBylPsPrPUw90K0wPs7a8vJ/Dcb0VbUMfqK1L/Ihch+MxgCE6qVTZ
         eBiA==
X-Gm-Message-State: AElRT7HWVzxNxJcq8uEv+oPU59UvclkmCoTRDfuL4RmmjzJcpXxqZQSU
        yK1dJCutLocEzxaMnDnZYXo=
X-Google-Smtp-Source: AG47ELvrjRCS8kQVnnB/k7Pyqmoa8GV6poOttBBFM57MKpgnksLyzuxzCIvQF8qoUbV7AoQmp3GsrA==
X-Received: by 10.28.23.143 with SMTP id 137mr3079203wmx.153.1521064533235;
        Wed, 14 Mar 2018 14:55:33 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j4sm4678998wrd.53.2018.03.14.14.55.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Mar 2018 14:55:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [PATCH 2/2] fetch-pack: do not check links for partial fetch
References: <cover.1521052825.git.jonathantanmy@google.com>
        <cover.1521052825.git.jonathantanmy@google.com>
        <c2f59866a1b1dc5f11713e1922eac2521ef98b07.1521052825.git.jonathantanmy@google.com>
Date:   Wed, 14 Mar 2018 14:55:31 -0700
In-Reply-To: <c2f59866a1b1dc5f11713e1922eac2521ef98b07.1521052825.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Wed, 14 Mar 2018 11:42:41 -0700")
Message-ID: <xmqqwoyexqy4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When doing a partial clone or fetch with transfer.fsckobjects=1, use the
> --fsck-objects instead of the --strict flag when invoking index-pack so
> that links are not checked, only objects. This is because incomplete
> links are expected when doing a partial clone or fetch.

It is expected that _some_ links are missing, but this makes me
wonder if we can do better than disabling the connectivity check
altogether.  Does "git fetch" lack sufficient information to attempt
the connectivity check, and when (and only when) it hits a broken
link, see if that is because the connectivity check traversal is
crossing a "partial" fetch boundary, or something along that line?

>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  fetch-pack.c             | 13 +++++++++++--
>  t/t5616-partial-clone.sh | 11 +++++++++++
>  2 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index d97461296..1d6117565 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -886,8 +886,17 @@ static int get_pack(struct fetch_pack_args *args,
>  	    ? fetch_fsck_objects
>  	    : transfer_fsck_objects >= 0
>  	    ? transfer_fsck_objects
> -	    : 0)
> -		argv_array_push(&cmd.args, "--strict");
> +	    : 0) {
> +		if (args->from_promisor)
> +			/*
> +			 * We cannot use --strict in index-pack because it
> +			 * checks both broken objects and links, but we only
> +			 * want to check for broken objects.
> +			 */
> +			argv_array_push(&cmd.args, "--fsck-objects");
> +		else
> +			argv_array_push(&cmd.args, "--strict");
> +	}
>  
>  	cmd.in = demux.out;
>  	cmd.git_cmd = 1;
> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> index 29d863118..cee556536 100755
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -143,4 +143,15 @@ test_expect_success 'manual prefetch of missing objects' '
>  	test_line_count = 0 observed.oids
>  '
>  
> +test_expect_success 'partial clone with transfer.fsckobjects=1 uses index-pack --fsck-objects' '
> +	git init src &&
> +	test_commit -C src x &&
> +	test_config -C src uploadpack.allowfilter 1 &&
> +	test_config -C src uploadpack.allowanysha1inwant 1 &&
> +
> +	GIT_TRACE="$(pwd)/trace" git -c transfer.fsckobjects=1 \
> +		clone --filter="blob:none" "file://$(pwd)/src" dst &&
> +	grep "git index-pack.*--fsck-objects" trace
> +'
> +
>  test_done
