Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3889B1F404
	for <e@80x24.org>; Tue,  6 Mar 2018 20:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753785AbeCFUeB (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 15:34:01 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44807 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753070AbeCFUd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 15:33:59 -0500
Received: by mail-wr0-f195.google.com with SMTP id v65so22281042wrc.11
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 12:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wFbBj4N74gNMy5GsM5S3V9oHOq9pMSnpzEB+M9HF7b0=;
        b=EwiTnVSfuVF74b4hAamLEnTtKdEepaKg3NFMgZ3Y2PNWjBRT7zKgst649UH9NwQwPu
         cPYQGLUxNy7YQsDRdFnshSL/xQfULkZ+LYZCqtNkjW/ryD3+Ounpp6SOgrNhSfpfHbE2
         v/cjmCUvxsYtcSI3wY6oQAGqFzAf5mmzhOcuKuu79R2PNr1T8SenercGXf476L8hxWog
         btmUiwmdWTJRMMKUv1LEXJKvf6FWWJW63uSno/lk+81OnDcO5LWi8BKC3F5yLRanEBI+
         gUP7ogd/NblB15VX7zhjUG+r0UpekxESBlE8Ynr476dJPcvvaaD8uRwdYKCMSw7cd0JQ
         MgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wFbBj4N74gNMy5GsM5S3V9oHOq9pMSnpzEB+M9HF7b0=;
        b=qqhIsRznjCUfgVMnPPryel16GrhVN3EncaVjpnWvOYUnA8VFnJ0yNeueCCnzBI54mQ
         1oxjbg+c+8Jv5/XHlhqwDUQAsJwsMWVn6HAy4LN+K6flz9zTHSiSytpw4dd3PYavzZ1x
         0l4dAC9xE35BP+SjllUSsehG6fY3W2X08M7XXAdB0ABVl6SF5U+JQETFIwC54RKI6hKb
         dxz+8NV5ZrpbOe1lpEgxpjGKpEI3kD9tA+94imdY9RUX9NSyK6SwccBY87oom/+4lXqf
         J80zcHh+QAvmTHGbPM8jqT9KJsPgqJi1G2bAkH37HSjGG+b6yqk5kbhctrDtUjRWrtVW
         J3oA==
X-Gm-Message-State: APf1xPB+6yTvR0Rg3thakVqM0PS4uDSSXM0W3SPnfcA5Ogl70JXSM/bq
        Lb4gl7dWXdTbaySubzSmrDC0bXlshC4=
X-Google-Smtp-Source: AG47ELtbGRf7YMDARTA/++I8k2SkE7s+Th6VCTLPvdgzv2XC5xkyGC+V8mk4z4YOSL/Wr6y3vP43SQ==
X-Received: by 10.223.150.102 with SMTP id c35mr17355828wra.225.1520368438608;
        Tue, 06 Mar 2018 12:33:58 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id z3sm12731003wme.3.2018.03.06.12.33.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Mar 2018 12:33:57 -0800 (PST)
Subject: Re: [PATCH v2 3/3] add -p: optimize line selection for short hunks
To:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gustavo Leite <gustavoleite.ti@gmail.com>
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
 <20180306101750.18794-1-phillip.wood@talktalk.net>
 <20180306101750.18794-4-phillip.wood@talktalk.net>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <caf6cd4a-d45f-1a8d-428e-abf9c623a1ef@gmail.com>
Date:   Tue, 6 Mar 2018 21:33:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180306101750.18794-4-phillip.wood@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/03/2018 11:17, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> If there are fewer than ten changes in a hunk then make spaces
> optional when selecting individual lines. This means that for short

Not sure if using s/selecting individual lines/staging individual lines/ 
would make sense here, too, but not that important (as you later do 
say "to stage lines").

> hunks one can just type -357 to stage lines 1, 2, 3, 5 & 7.
> 
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  Documentation/git-add.txt  |  3 ++-
>  git-add--interactive.perl  | 30 ++++++++++++++++++++++++++++++
>  t/t3701-add-interactive.sh |  2 +-
>  3 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index 0e2c11e97b..d52acfc722 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -340,7 +340,8 @@ patch::
>  If you press "l" then the hunk will be reprinted with each insertion
>  or deletion labelled with a number and you will be prompted to enter
>  which lines you wish to select. Individual line numbers should be
> -separated by a space or comma, to specify a range of lines use a dash
> +separated by a space or comma (these can be omitted if there are fewer
> +than ten labelled lines), to specify a range of lines use a dash
>  between them. To invert the selection prefix it with "\^" so "^3-5,8"
>  will select everything except lines 3, 4, 5 and 8.
>  +
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 6fa3d0a87c..9a6bcd5085 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -1082,6 +1082,33 @@ sub check_hunk_label {
>  	return 1;
>  }
>  
> +sub split_hunk_selection {
> +	local $_;
> +	my @fields = @_;
> +	my @ret;
> +	for (@fields) {
> +		if (/^(-[0-9])(.*)/) {
> +			push @ret, $1;
> +			$_ = $2;
> +		}
> +		while ($_ ne '') {
> +			if (/^[0-9]-$/) {
> +				push @ret, $_;
> +				last;
> +			} elsif (/^([0-9](?:-[0-9])?)(.*)/) {
> +				push @ret, $1;
> +				$_ = $2;
> +			} else {
> +				error_msg sprintf
> +				    __("invalid hunk line '%s'\n"),
> +				    substr($_, 0, 1);
> +				return ();
> +			}
> +		}
> +	}
> +	return @ret;
> +}
> +
>  sub parse_hunk_selection {
>  	local $_;
>  	my ($hunk, $line) = @_;
> @@ -1100,6 +1127,9 @@ sub parse_hunk_selection {
>  			}
>  		}
>  	}
> +	if ($max_label < 10) {
> +		@fields = split_hunk_selection(@fields) or return undef;
> +	}
>  	for (@fields) {
>  		if (/^([0-9]*)-([0-9]*)$/) {
>  			if ($1 eq '' and $2 eq '') {
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 89c0e73f2b..d3bce154da 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -410,7 +410,7 @@ test_expect_success 'setup expected diff' '
>  '
>  
>  test_expect_success 'can reset individual lines of patch' '
> -	printf "%s\n" l "^1 3" |
> +	printf "%s\n" l ^13 |
>  	EDITOR=: git reset -p 2>error &&
>  	test_must_be_empty error &&
>  	git diff --cached HEAD >actual &&
> 
