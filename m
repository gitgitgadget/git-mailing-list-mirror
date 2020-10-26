Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CCAC4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 21:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A74502084C
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 21:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QHipl2oS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732730AbgJZVZA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 17:25:00 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51660 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732700AbgJZVZA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 17:25:00 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3DA80E497A;
        Mon, 26 Oct 2020 17:24:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+qRjrRNkDNgwJRUrFICqBdcLos0=; b=QHipl2
        oSgb9yBmlyad2kFJJMPptzvjbp8cTiSh+CBwjyeicj1AHljsalFhTci3ha58um0D
        eB75cdR1qR/5uDbTx6Bwezkcj2XHKy42vcFBf0PH5LSwW3puQ1XHxvFB9WriGv/q
        AH2BYGvN0yJDVA0Pwvy/uo51RuGZGwQyxhQ7E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oovNYbx2qjchj0Kvd6cOOx8KBNEX5t5Z
        sAeprlEtRnnOF4T/SH4oDS7Ad+fOqpmEfAp3TvEUc6KcANB2MibvLdUxzxuCtLOs
        7gwb8N+TqPmh9SljJ/ssyn2726by4vzjxn0gmc1dSNKQrESyH5mJgfk43g2SvfUJ
        BlB32IZC7Eo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 37DF5E4979;
        Mon, 26 Oct 2020 17:24:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6F7D3E4977;
        Mon, 26 Oct 2020 17:24:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Joey S <jgsal@protonmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [OUTREACHY][PATCH v2] t7006: Use test_path_is_* functions in
 test script
References: <KHJW7elqEfVsIp1V0WKPRVAB5xqCDJjjqLv8flthlDiSsSWjND-VVGG2zL-xOYMstk-q0JR3OiSggcMlFgzkIKm2podjzAyamb0pW-wx1ZY=@protonmail.com>
        <20201026205028.GC2645313@google.com>
Date:   Mon, 26 Oct 2020 14:24:52 -0700
In-Reply-To: <20201026205028.GC2645313@google.com> (Jonathan Nieder's message
        of "Mon, 26 Oct 2020 13:50:28 -0700")
Message-ID: <xmqqwnzcd6jf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B0AD9130-17D1-11EB-9683-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Overall (as someone who's worked a bit with this test script before),
> looks good to me.  Thanks for your work.
>
>> -		${if_local_config}test -e core.pager_used
>> +		${if_local_config}test_path_is_file core.pager_used
>
> This bit is a little subtle: ${if_local_config} is either '' or '! ',
> and in the latter case the benefit of test_path_is_file printing a
> message if and only if the result is false goes away.
>
> Would the following, squashed in, make sense?

Thanks for a great suggestion.  The if_local_config thing was
inherited and not a problem introduced by Joey, but it is a good
idea to clean it up at the same time, I think.



> Thanks,
> Jonathan
>
> diff --git i/t/t7006-pager.sh w/t/t7006-pager.sh
> index fdb450e446a..11327944741 100755
> --- i/t/t7006-pager.sh
> +++ w/t/t7006-pager.sh
> @@ -411,13 +411,13 @@ test_PAGER_overrides() {
>  }
>  
>  test_core_pager_overrides() {
> -	if_local_config=
> +	pager_wanted=true
>  	used_if_wanted='overrides PAGER'
>  	test_core_pager "$@"
>  }
>  
>  test_local_config_ignored() {
> -	if_local_config='! '
> +	pager_wanted=
>  	used_if_wanted='is not used'
>  	test_core_pager "$@"
>  }
> @@ -432,18 +432,23 @@ test_core_pager() {
>  		export PAGER &&
>  		test_config core.pager 'wc >core.pager_used' &&
>  		$full_command &&
> -		${if_local_config}test_path_is_file core.pager_used
> +		if test -n '$pager_wanted'
> +		then
> +			test_path_is_file core.pager_used
> +		else
> +			test_path_is_missing core.pager_used
> +		fi
>  	"
>  }
>  
>  test_core_pager_subdir() {
> -	if_local_config=
> +	pager_wanted=true
>  	used_if_wanted='overrides PAGER'
>  	test_pager_subdir_helper "$@"
>  }
>  
>  test_no_local_config_subdir() {
> -	if_local_config='! '
> +	pager_wanted=
>  	used_if_wanted='is not used'
>  	test_pager_subdir_helper "$@"
>  }
> @@ -464,7 +469,12 @@ test_pager_subdir_helper() {
>  			cd sub &&
>  			$full_command
>  		) &&
> -		${if_local_config}test_path_is_file core.pager_used
> +		if test -n '$pager_wanted'
> +		then
> +			test_path_is_file core.pager_used
> +		else
> +			test_path_is_missing core.pager_used
> +		fi
>  	"
>  }
>  
