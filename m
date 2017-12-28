Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF41E1F406
	for <e@80x24.org>; Thu, 28 Dec 2017 19:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753843AbdL1Trf (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 14:47:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51038 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751209AbdL1Tre (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 14:47:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BEFDCAD51;
        Thu, 28 Dec 2017 14:47:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WuPABy+A9HJgmAiwF8ff6FGGU8Y=; b=Jgpz4M
        7vbgM+yg3SVsr/G7yPKZ85CSNGNeB4QNkPzJRQeEElxEr6dJkZBd409lQ6G8dUju
        2/Zm+hA9bvpsJ8rF3TBUkNvDQ2RLQvM9hihgFYyKHvXRYVmyz5N7X4WLCVVZ5bjH
        SsHhmfp1xHLSvscsSz2/NuJzpc2z5d7rRGAEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VLtXfycHYqD3IFZE0kO5HFdmlgQALtm8
        kTJ/UTam1oMlE1LySEYM2pG7Y81tLeseus3bocw4dFT0TYlgKamOLLYSCQFvYGMa
        rdwcGwCGVyJl7m5b9DvP0/HXV6PddcjfVteyE/J2u0PCDU0j5b2LoVy+UY6Bq05k
        5aUKOVPoq0U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 640DBCAD50;
        Thu, 28 Dec 2017 14:47:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C9296CAD4F;
        Thu, 28 Dec 2017 14:47:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v2 3/7] perf/aggregate: implement codespeed JSON output
References: <20171226215908.425-1-chriscool@tuxfamily.org>
        <20171226215908.425-4-chriscool@tuxfamily.org>
Date:   Thu, 28 Dec 2017 11:47:32 -0800
In-Reply-To: <20171226215908.425-4-chriscool@tuxfamily.org> (Christian
        Couder's message of "Tue, 26 Dec 2017 22:59:04 +0100")
Message-ID: <xmqqlghmk52j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2B646F6-EC07-11E7-955A-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> ...
> +sub print_codespeed_results {
> +	my ($results_section) = @_;
> +
> +	#use Data::Dumper qw/ Dumper /;
> +	#print Dumper(\@data);

Perhaps lose these.  It is OK to keep the code live and hide it
behind --debug or something, but it seems to me that you are done
debugging it pretty much so...

> +	use JSON;

Have this at the top, perhaps?  It's not like this would let us
avoid loading JSON module when not doing codespeed (you need
'require' for that, right?).

> +	print to_json(\@data, {utf8 => 1, pretty => 1}), "\n";
> +}
> +
>  binmode STDOUT, ":utf8" or die "PANIC on binmode: $!";
>  
> -print_default_results();
> +if ($codespeed) {
> +	print_codespeed_results($results_section);
> +} else {
> +	print_default_results();
> +}
