Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14F961F404
	for <e@80x24.org>; Tue, 28 Aug 2018 18:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeH1WAQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 18:00:16 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36352 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbeH1WAP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 18:00:15 -0400
Received: by mail-wm0-f67.google.com with SMTP id j192-v6so2944281wmj.1
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 11:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sTFlEshTA10aDIc9O44ffpkwsAFrkFF3OGM7EmVKNcs=;
        b=p2w4F4GSEnJZCawy9gyL1rlzH8YmmSp46V4xQnTzn38Yv85tKAL2xi8axfaWdisAW7
         h46pV6vF3A/iMeKGEporU6IWwnihyhVmXs4DBcJUiFjjFhGfNwDmQ+yASncqOcHs8f3/
         l9Zm/bIKcb4ZV6X6oO86tGQ7X22LO9gjT50i3R4OzctbUf23c/llKJZOlZ3n9/vY+uzM
         /hCMFPq/OtLa3XBwWEAokFKonHon4txKwX3vZBSSkduLDHw7YX9NqsSm78sBTvMm0Sw0
         o9ty3n6E9E88ejKHVEXqFqHzg/iw+oFCW/8+DWrgjgkpSq4MEP1O64RNqVkGG+Ux2czF
         3aHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sTFlEshTA10aDIc9O44ffpkwsAFrkFF3OGM7EmVKNcs=;
        b=CmVoCO6FjPY2DxrkM0RHmoDlasOzcOHU5kOyIAJHPr2wIY57jVP6YkqGJyGmydbENp
         eA9YrNs6kPMxVZ6etNDOPQNjimPiW2oNVIDo4Gr3EpkCvX5SKMF122g1/H6/PkkI8dIB
         TuSONqnQJkdKa6/9Jv1DTQ0X6X2U68iAoVV0IQx7dHE5La3tPl51MecOR3SDI//aN2jK
         nuqIT2oc49AGvKs4xFgWBvQDhPr4CP8ekc2cCbAR2lwEaLQbXIq6C6QyAJIjOgV/8POL
         cEIq1HrzpcM3dfUPFbZkKFEulLwMVMrtDmC96BhrXWNs7y9fbvTzccBzJSEwlJoX4vXi
         Z6yw==
X-Gm-Message-State: APzg51C/TH1iEXC5tghNd93cgUNRHG8KYmPK3NER/BV2Tief/i612ytR
        ravKoMaGOZ85bj4c4uwBmEw=
X-Google-Smtp-Source: ANB0VdYYqPNa4Z7TYzIq9toSzraXwmGWoe8s8kDnkKSkHAbrvaCeizZJpnRgnu46mqa9/c2KxncnZQ==
X-Received: by 2002:a1c:f11a:: with SMTP id p26-v6mr2128032wmh.92.1535479644075;
        Tue, 28 Aug 2018 11:07:24 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q3-v6sm1318024wma.45.2018.08.28.11.07.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 11:07:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jochen Sprickerhof <git@jochen.sprickerhof.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] add -p: coalesce hunks before testing applicability
References: <20180828085858.3933-1-git@jochen.sprickerhof.de>
Date:   Tue, 28 Aug 2018 11:07:21 -0700
In-Reply-To: <20180828085858.3933-1-git@jochen.sprickerhof.de> (Jochen
        Sprickerhof's message of "Tue, 28 Aug 2018 10:58:58 +0200")
Message-ID: <xmqq36uygyau.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jochen Sprickerhof <git@jochen.sprickerhof.de> writes:

> When a hunk was split before being edited manually, it does not apply
> anymore cleanly. Apply coalesce_overlapping_hunks() first to make it
> work. Enable test for it as well.
>
> Signed-off-by: Jochen Sprickerhof <git@jochen.sprickerhof.de>
> ---
>  git-add--interactive.perl  | 8 ++++----
>  t/t3701-add-interactive.sh | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 36f38ced9..c9f434e4a 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -1195,10 +1195,10 @@ sub edit_hunk_loop {
>  		# delta from the original unedited hunk.
>  		$hunk->{OFS_DELTA} and
>  				$newhunk->{OFS_DELTA} += $hunk->{OFS_DELTA};
> -		if (diff_applies($head,
> -				 @{$hunks}[0..$ix-1],
> -				 $newhunk,
> -				 @{$hunks}[$ix+1..$#{$hunks}])) {
> +		my @hunk = @{$hunks};
> +		splice (@hunk, $ix, 1, $newhunk);
> +		@hunk = coalesce_overlapping_hunks(@hunk);
> +		if (diff_applies($head, @hunk)) {
>  			$newhunk->{DISPLAY} = [color_diff(@{$newtext})];
>  			return $newhunk;
>  		}

OK.  I think I understand how this may be needed in certain forms of
edit.  I do not think coalesce would reliably work against arbitrary
kind of edit, but the function is called at the end of the loop of
the caller of this function anyway, so it is not like this is making
anything worse at all.  Let's queue it and try it out.

Thanks.

All of the following is a tangent for future/further work, and
should not be done as part of your patch.  While this change may
work around the immediate issue of diff_applies() returning "no", it
makes it feel a bit iffy to keep the interface to return $newhunk.

With the current interface, the function is saying the caller "here
is a text that shows a new hunk, when spliced back into the @hunk
array and coalesced together with others, would apply cleanly to the
current index".  But the corrected code is already doing a trial
splice with trial coalescing anyway, so perhaps it may make more
sense to update the interface into this function for the caller to
say "the user asks to edit $ix'th hunk in @$hunks" and the function
to answer "Here is the edited result in @$hunks; I've made sure it
would cleanly apply".

Incidentally, that would make it possible in the future to allow
edit_hunk_loop to be told "the user wants to edit this $ix'th hunk",
allow the editor to split that hunk into multiple hunks, and return
the result by stuffing them (not just a single $newhunk) into the
@hunk array.  The caller's loop could then further select or join
these hunks---such an interaction is impossible with the current
interface that allows edit_hunk_loop to take a single hunk and
return a single newhunk.

But again, all of the above is a tangent for future/further work,
and should not be done as part of your patch.
