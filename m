Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F14BC48BDF
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 02:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4228C61369
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 02:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhFPCWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 22:22:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55252 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhFPCWw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 22:22:52 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F2B4D0317;
        Tue, 15 Jun 2021 22:20:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yZqnNbozslGpBJlcisgffUVZSzfy0kJbddNghc
        K3cpc=; b=T853vQ71D4T2MlOalv21eZxr9gygZuyq6PQGiJSrCq+iOu7iKA7tpj
        QdGz3LCWr2W8Fo1sSTljmaVlhKZRW3aAakQ058jAkCA6mqGHknGuOBWs7iEuFKWA
        MIqWpGwxB2mXrhAfyYNvVDjPy97VNxmztTEY0MA26mttotnKp8HmQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5655FD0316;
        Tue, 15 Jun 2021 22:20:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C06FED0315;
        Tue, 15 Jun 2021 22:20:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] doc: builtin add -i is enabled by feature.experimental
References: <20210615164522.1079951-1-tmz@pobox.com>
Date:   Wed, 16 Jun 2021 11:20:45 +0900
In-Reply-To: <20210615164522.1079951-1-tmz@pobox.com> (Todd Zullinger's
        message of "Tue, 15 Jun 2021 12:45:22 -0400")
Message-ID: <xmqq4kdyturm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75BB59CA-CE49-11EB-A763-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> Note that add.interactive.useBuiltin is enabled by feature.experimental.
> It was added in 2df2d81ddd (add -i: use the built-in version when
> feature.experimental is set, 2020-09-08).
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>

> ---
> I was checking my configuration to see if I still needed to have
> add.interactive.useBuiltin set and noticed that it wasn't listed in the
> settings enabled by feature.experimental.

So together with the fetch.negotiationAlgorithm only two knobs are
affected by feature.experimental?  Or is this patch only about add-i
because that is the only thing you found out about?

Explicitly state that these are the only two that are affected by
this bit in the log message so that readers of "git log" do not have
to ask the question.

The other configuration feature.experimental controls is described
in Documentation/config/fetch.txt like this:

    fetch.negotiationAlgorithm::
            Control how information about the commits in the local repository is
            sent when negotiating the contents of the packfile to be sent by the
            ...
            The default is "default" which instructs Git to use the default algorithm
            that never skips commits (unless the server has acknowledged it or one
            of its descendants). If `feature.experimental` is enabled, then this
            setting defaults to "skipping".
            Unknown values will cause 'git fetch' to error out.

> diff --git a/Documentation/config/add.txt b/Documentation/config/add.txt
> index c9f748f81c..7d6d325571 100644
> --- a/Documentation/config/add.txt
> +++ b/Documentation/config/add.txt
> @@ -9,4 +9,5 @@ add.ignore-errors (deprecated)::
>  add.interactive.useBuiltin::
>  	[EXPERIMENTAL] Set to `true` to use the experimental built-in
>  	implementation of the interactive version of linkgit:git-add[1]
> -	instead of the Perl script version. Is `false` by default.
> +	instead of the Perl script version.  If `feature.experimental` is
> +	enabled, this setting is `true`.  By default, it is `false`.

The added sentence doesn't exactly make sense.  If the experimental
bit is set, this setting _defaults_ to true.  If you set this
explicitly, the experimental bit would not override it, would it?

I prefer to see things described only once, so I am wondering if we
can get away by doing these instead:

 - Start the description of fetch.negotiationAlgorithm with
   [EXPERIMENTAL] like this one does, and remove the sentence about
   the experimental bit from there.

 - Leave the description of add.interactive.useBuiltin as is.

 - Use the change you made to Documentation/config/feature.txt below.

Additionally, it may help readers without hurting maintainability to
say "[EXPERIMENTAL] (see also `feature.experimental`)" to refer them
to the description of the defaults set by the experimental bit.

Alternatively, we can 

 - Remove the description of other configuration variables affected
   by feature.experimental from the description of the experimental
   bit in Documentation/config/feature.txt, and replace it with "The
   default values for configuration variables marked with
   '[EXPERIMENTAL]' are affected by setting this bit", and

 - Start the description of fetch.negotiationAlgorithm with
   [EXPERIMENTAL] like this one does, and remove the sentence about
   the experimental bit from there.

 - Use the change you made to Documentation/config/add.txt as is.

That would also reduce duplicates.  From organizational point of
view, I prefer the latter slightly more.  It makes the readers who
want to learn what knobs would be tweaked to run "grep" on the
documentation set, but it may not be too much to expect from the
more adventuous types.  I dunno.

I am sending this also to Derrick (for adding the experimental bit
and threw negotiate knob into it) and Jonathan Tan (for adding and
describing negotiate) for their input.

Thanks.

> diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
> index cdecd04e5b..caaa97dc61 100644
> --- a/Documentation/config/feature.txt
> +++ b/Documentation/config/feature.txt
> @@ -12,6 +12,10 @@ feature.experimental::
>  	setting if you are interested in providing feedback on experimental
>  	features. The new default values are:
>  +
> +* `add.interactive.useBuiltin=true` which enables the built-in implementation
> +of the interactive version of linkgit:git-add[1] instead of the Perl script
> +version.
> ++
>  * `fetch.negotiationAlgorithm=skipping` may improve fetch negotiation times by
>  skipping more commits at a time, reducing the number of round trips.
>  
>  feature.manyFiles::
>  	Enable config options that optimize for repos with many files in the
