Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11E181F461
	for <e@80x24.org>; Thu, 16 May 2019 07:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfEPHtT (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 03:49:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64914 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfEPHtS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 03:49:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8020B148537;
        Thu, 16 May 2019 03:49:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vEiVpE3llrfHT4MFqQFluPmTQVg=; b=eRA2e8
        nR6MNdEdYsDYJaAKC1bSFPEJrTp8DR5500tdjUuy8bX/LcCvn/WP5Qi6TlczanhF
        4yvcyr7wm8FiMQJGeukSn38ZQpAcmnhkH1kUjc8mH2kHr091W5Y7DVZADDAfEbQI
        NVHcJpj8dDnELqqoCQaCLhEi/AQtLxIak9hV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G3Rpmp3lymp1ejV+jmxu5G79Yg13nK2O
        n7gEPsIug3ib8eISdO19qJfkeuV4rdDUoTN+T6yOOUyy5sGOm26WVWCzNwVd13DU
        gGijgQlYD22eUrOjPBVFFxXePoyQjo54WCP+EyHj5fbZ4kWdhnp/D+rsQCEIUfu+
        GikU7eDk+Qs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 679F0148536;
        Thu, 16 May 2019 03:49:16 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BEDFC148535;
        Thu, 16 May 2019 03:49:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Barret Rhoden <brho@google.com>
Cc:     git@vger.kernel.org, Michael Platings <michael@platin.gs>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v7 7/8] blame: add a fingerprint heuristic to match ignored lines
References: <20190515214503.77162-1-brho@google.com>
        <20190515214503.77162-8-brho@google.com>
Date:   Thu, 16 May 2019 16:49:14 +0900
In-Reply-To: <20190515214503.77162-8-brho@google.com> (Barret Rhoden's message
        of "Wed, 15 May 2019 17:45:02 -0400")
Message-ID: <xmqqpnoi4z5x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A6EFF1A-77AF-11E9-934D-E828E74BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Barret Rhoden <brho@google.com> writes:

> From: Michael Platings <michael@platin.gs>
>
> +test_expect_success setup '
> +	{ for ((i=2;i<=$last_test;i++))

Crap.

What language are you writing this in?

Please make it a habit to try running the test suite with a shell
that is *not* bash, after you are happy with your tests in bash, e.g.

	$ make SHELL_PATH=/bin/dash test

Thanks.

> +	do
> +		# Append each line in a separate commit to make it easy to
> +		# check which original line the blame output relates to.
> +
> +		line_count=0 &&
> +		{ while IFS= read line
> +		do
> +			line_count=$((line_count+1)) &&
> +			echo "$line" >>"$i" &&
> +			git add "$i" &&
> +			test_tick &&
> +			GIT_AUTHOR_NAME="$line_count" git commit -m "$line_count"
> +		done } <"a$i"
> +	done } &&
