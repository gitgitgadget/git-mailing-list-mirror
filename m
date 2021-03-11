Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC99C433DB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94EEC64FBF
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhCKAby (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 19:31:54 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52632 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhCKAbg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 19:31:36 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E5146124B39;
        Wed, 10 Mar 2021 19:31:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=nzUEEk7KR+30bYC20vNpF3Tz5NM=; b=cJdDy7OsctDG6GeMuUdH
        Uw1TdnVPCHVG1FWRwUK0/ptyMACUsSI/Dy7agdMiaDR6MGAul7NGGZ7POUN39VSa
        xeWgy4Hx3eG/quxljoH7mA4GAI9MKzCqUYGYywsP4xZakItKM/i/LPZGFpyocnw4
        7x740WqYQVqgQc8cgG2SRj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=f41bqLkWFCu4Rk4ZEi/jtVwhDKP6NuKrQGGtyrzFsCu/0+
        jlg1pvtMTOzTnMHJHInE4wyRfVUDntsDpQojgghelGpl5km/hBt8avWzd3aVzGq7
        0mLTQp6xPuVp5cma/HYOpXoC5l4hXrQSfRha0e7wpYhY/BbFaq88cIJj7u4fI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DE0B7124B38;
        Wed, 10 Mar 2021 19:31:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 36DF6124B37;
        Wed, 10 Mar 2021 19:31:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        chriscool@tuxfamily.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 3/6] commit: add a reword suboption to --fixup
References: <20210301084512.27170-1-charvi077@gmail.com>
        <20210310194306.32565-4-charvi077@gmail.com>
Date:   Wed, 10 Mar 2021 16:31:31 -0800
Message-ID: <xmqqpn06h6os.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 216E6BE4-8201-11EB-B90B-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

>  		 * reference for example: --fixup="HEAD^{/^area: string}" or
>  		 * a suboption of `--fixup`.
>  		 *
> -		 * As `amend` suboption contains only alpha character.
> -		 * So check if first non alpha character in fixup_message
> -		 * is ':'.
> +		 * As `amend`/`reword` suboptions contains only alpha
> +		 * characters. So check if first non alpha character
> +		 * in fixup_message is ':'.

Sorry, but I cannot quite follow the logic.  

	We limit --fixup's suboptions to only alpha characters.  If
	the first character after a len of alpha is colon, then the
	part before the colon may be a known suboption name like
	`amend` or `reword`, or a misspelt suboption name.

	Otherwise, we are dealing with --fixup=<commit> that happens
	to have a colon in <commit> object name.

perhaps?
