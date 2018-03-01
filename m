Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A7081F404
	for <e@80x24.org>; Thu,  1 Mar 2018 20:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161494AbeCAUOj (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 15:14:39 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51981 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161420AbeCAUOh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 15:14:37 -0500
Received: by mail-wm0-f66.google.com with SMTP id h21so14469308wmd.1
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 12:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=5Eb6Tu7ABlhxStX+0lv6lCXCwSE8UIwoGqqJOmPXEMc=;
        b=GpWrdT5l1TQDUkjfS8qvQldXUYAV+EervwijlUl2vD2uU7aUP/zh+971jiYWvBqqwT
         RPq+Cc9eDplUD8jkA/qDBP29su1yFc8kzXNAxsJ2CIpAt5+xN/9WCQWCsjG1wwIcGHu8
         0hmFTzpCBp0mxRw4VLMBEK8y+X3Kdt45rzqvd1acZeBukkDqAQzUTOpzTuZkxkmiZEgt
         +veWYFlAeWSFG+h2akLzJQAR27h8Q5XLODrM0nvoG3Ezj0mws2RetCPbVgN1840M/rUP
         srEJJo7njM9AalK9G9IDIcCALzZiHTxMM/2kGW7NOtCtQ1bc/3qit8pdaJHwgGAC4RXp
         pkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=5Eb6Tu7ABlhxStX+0lv6lCXCwSE8UIwoGqqJOmPXEMc=;
        b=XPdcUy65NqW1D2jgmSqe+iZqOsljBQnE0vZkSedrte00Bu6klUy5uAcAA9C9f0imSp
         OnTH8xTHNOob14odmw5GuV5z1mALIMVa0yt02pwBusZfCR+IeB93FqPxm1Wn6G4PPMDJ
         OKBf8rOAUc4lao5t9T0QbuLve+HOU3Rr7ZYArIZSdzR2UO86JVvW306HO0cb4PYo/3Rv
         y89fxX9qfUdXbNZXBfX1nWFXNr/Be6IaGb/xeEO6jzKWLwgYoDFCUPP+bRUC3+02l7WT
         RG2W1OLhFzqMgpnmcbBRvVqgvK5+LSH4xQTrjbcH+TGHYej+iI3nrf2UJgpS4+W7Agot
         T2Gg==
X-Gm-Message-State: AElRT7HYcSOmEDlyKMM3ReUGN4lNpDzyrS4wn5/W2lTyqTLAZmi8kWek
        vpuxJBu+3gmu2h1sCjc2YgA=
X-Google-Smtp-Source: AG47ELtPUq5P/2rh0jORHr+EniY0ZDYZ7dvUPF0IJsQg0Q2kzwo+pW7nsAe9oGMhMUz/OPqyRfOe1A==
X-Received: by 10.28.122.11 with SMTP id v11mr2607022wmc.38.1519935275776;
        Thu, 01 Mar 2018 12:14:35 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a14sm4686132wrf.22.2018.03.01.12.14.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 12:14:33 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 7/9] add -p: calculate offset delta for edited patches
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
        <20180301105103.24268-1-phillip.wood@talktalk.net>
        <20180301105103.24268-8-phillip.wood@talktalk.net>
Date:   Thu, 01 Mar 2018 12:14:33 -0800
In-Reply-To: <20180301105103.24268-8-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Thu, 1 Mar 2018 10:51:01 +0000")
Message-ID: <xmqqwoyvft92.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Recount the number of preimage and postimage lines in a hunk after it
> has been edited so any change in the number of insertions or deletions
> can be used to adjust the offsets of subsequent hunks. If an edited
> hunk is subsequently split then the offset correction will be lost. It
> would be possible to fix this if it is a problem, however the code
> here is still an improvement on the status quo for the common case
> where an edited hunk is applied without being split.
>
> This is also a necessary step to removing '--recount' and
> '--allow-overlap' from the invocation of 'git apply'. Before
> '--recount' can be removed the splitting and coalescing counting needs
> to be fixed to handle a missing newline at the end of a file. In order
> to remove '--allow-overlap' there needs to be i) some way of verifying
> the offset data in the edited hunk (probably by correlating the
> preimage (or postimage if the patch is going to be applied in reverse)
> lines of the edited and unedited versions to see if they are offset or
> if any leading/trailing context lines have been removed) and ii) a way of
> dealing with edited hunks that change context lines that are shared
> with neighbouring hunks.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---

Thanks for clear description of what is going on in the series.

> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 7a0a5896bb..0df0c2aa06 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -938,13 +938,19 @@ sub coalesce_overlapping_hunks {
>  						parse_hunk_header($text->[0]);
>  		unless ($_->{USE}) {
>  			$ofs_delta += $o_cnt - $n_cnt;
> +			# If this hunk has been edited then subtract
> +			# the delta that is due to the edit.
> +			$_->{OFS_DELTA} and $ofs_delta -= $_->{OFS_DELTA};

The pattern

	<<conditional>> and <<statement with side effect>>;

is something you are newly introducing to this script.  I am not
sure if we want to see them.  I somehow find them harder to read
than the more straight-forward and naïve

	if (<<conditional>>) {
		<<statement with side effect>>;
	}


> +		# If this hunk was edited then adjust the offset delta
> +		# to reflect the edit.
> +		$_->{OFS_DELTA} and $ofs_delta += $_->{OFS_DELTA};

Likewise.

> +sub recount_edited_hunk {
> +	local $_;
> +	my ($oldtext, $newtext) = @_;
> +	my ($o_cnt, $n_cnt) = (0, 0);
> +	for (@{$newtext}[1..$#{$newtext}]) {
> +		my $mode = substr($_, 0, 1);
> +		if ($mode eq '-') {
> +			$o_cnt++;
> +		} elsif ($mode eq '+') {
> +			$n_cnt++;
> +		} elsif ($mode eq ' ') {
> +			$o_cnt++;
> +			$n_cnt++;
> +		}
> +	}
> +	my ($o_ofs, undef, $n_ofs, undef) =
> +					parse_hunk_header($newtext->[0]);
> +	$newtext->[0] = format_hunk_header($o_ofs, $o_cnt, $n_ofs, $n_cnt);
> +	my (undef, $orig_o_cnt, undef, $orig_n_cnt) =
> +					parse_hunk_header($oldtext->[0]);
> +	# Return the change in the number of lines inserted by this hunk
> +	return $orig_o_cnt - $orig_n_cnt - $o_cnt + $n_cnt;
> +}

OK.

> @@ -1114,25 +1144,32 @@ sub prompt_yesno {
>  }
>  
>  sub edit_hunk_loop {
> -	my ($head, $hunk, $ix) = @_;
> -	my $text = $hunk->[$ix]->{TEXT};
> +	my ($head, $hunks, $ix) = @_;
> +	my $hunk = $hunks->[$ix];
> +	my $text = $hunk->{TEXT};
> ...
> +		$newhunk->{OFS_DELTA} = recount_edited_hunk($text, $newtext);
> +		# If this hunk has already been edited then add the
> +		# offset delta of the previous edit to get the real
> +		# delta from the original unedited hunk.
> +		$hunk->{OFS_DELTA} and
> +				$newhunk->{OFS_DELTA} += $hunk->{OFS_DELTA};

Ahh, good point.

