Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 039951F406
	for <e@80x24.org>; Thu, 28 Dec 2017 19:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754134AbdL1TlC (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 14:41:02 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60428 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751229AbdL1TlB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 14:41:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 54A9AC5179;
        Thu, 28 Dec 2017 14:41:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qBGRsPknVeP/9tb35bp2hM6j23c=; b=cQa5z5
        MLoQ35Myrk4T+AOoaUEQu97CKYVAacpppT5HpzZdcz8AmcXHAup128K+wMDlO02E
        wJOYlZVCXSyJm8vzn1rfCLATGdytEHjhHp5mzXgIL92ElvxLA+ONvgbopm8ROkqL
        WeFIHSCzLOU2dRv+g9rvM3en0yALmlbzcxhmI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ne1pdRHpr1brBmVVS54bDzA28FukoPNW
        Swf2LNJceQxZHcp1LofZSFFdE6fAYOuhDEurUiczT3Tt2lrTRHwBed8Fja9wTk/m
        rM5Jpkiqg96kdCtW/Yabcf7/K4tj/ap1IWrKMpunrtAu4C39SEd83CBzHmfoEPPa
        1FHh/+pgQNI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 43A01C5178;
        Thu, 28 Dec 2017 14:41:00 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 79133C5176;
        Thu, 28 Dec 2017 14:40:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v2 1/7] perf/aggregate: fix checking ENV{GIT_PERF_SUBSECTION}
References: <20171226215908.425-1-chriscool@tuxfamily.org>
        <20171226215908.425-2-chriscool@tuxfamily.org>
Date:   Thu, 28 Dec 2017 11:40:58 -0800
In-Reply-To: <20171226215908.425-2-chriscool@tuxfamily.org> (Christian
        Couder's message of "Tue, 26 Dec 2017 22:59:02 +0100")
Message-ID: <xmqqpo6yk5dh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 07AC7540-EC07-11E7-BE11-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  t/perf/aggregate.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
> index e401208488..769d418708 100755
> --- a/t/perf/aggregate.perl
> +++ b/t/perf/aggregate.perl
> @@ -70,7 +70,7 @@ if (not @tests) {
>  }
>  
>  my $resultsdir = "test-results";
> -if ($ENV{GIT_PERF_SUBSECTION} ne "") {
> +if (exists $ENV{GIT_PERF_SUBSECTION} and $ENV{GIT_PERF_SUBSECTION} ne "") {
>  	$resultsdir .= "/" . $ENV{GIT_PERF_SUBSECTION};
>  }

It appears that this is the only remaining environment variable
reference that could trigger comparison between undef and "" that
may be flagged by use of strict & warnings?  A good change.

