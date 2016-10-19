Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A9B720986
	for <e@80x24.org>; Wed, 19 Oct 2016 18:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S943125AbcJSSk5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 14:40:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57189 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932780AbcJSSk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 14:40:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 12F66475DE;
        Wed, 19 Oct 2016 14:40:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p1Hc1o8kQlP1HtAI433WQ3KyvFg=; b=CsKXNA
        NsdYkssiB9UvcCBBKRINTFeF54k5edpSBYoGGxe/N5JjkYb6nO8jt5r4U9s7xTwQ
        NqMzPbbEkp5BdwfRxhuLUryQ3Pkl1C6F+zXg2wmeA/3HWW6NyWBGidaVyGtIWYXb
        DIrasScXvBtvEGoIlpHXsT8lcEi4BpkyoF0AI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aAztUYgW+GOwHuzDvfy+D/dwIauEwktV
        VGTT5mCZRPtpjI8o04iFdDdhvetnY/dBZ0Rc1k2RRCsZaBd5K4YgzAWafCT/4RzD
        MHd5BzIV0iB/l7q3FprjQ5GOI0MkrWqqZX1SU1ap2rbfSBGV0FOslGX74zqBLfim
        CZlR37IDi9c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0622B475DC;
        Wed, 19 Oct 2016 14:40:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 78D2E475DB;
        Wed, 19 Oct 2016 14:40:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        Jakub =?utf-8?Q?Na?= =?utf-8?Q?r=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v4 05/14] i18n: add--interactive: mark plural strings
References: <20161010125449.7929-1-vascomalmeida@sapo.pt>
        <20161005172110.30801-1-vascomalmeida@sapo.pt>
        <20161010125449.7929-6-vascomalmeida@sapo.pt>
Date:   Wed, 19 Oct 2016 11:40:52 -0700
In-Reply-To: <20161010125449.7929-6-vascomalmeida@sapo.pt> (Vasco Almeida's
        message of "Mon, 10 Oct 2016 12:54:40 +0000")
Message-ID: <xmqqtwc8kwqz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 913B8BA8-962B-11E6-B3ED-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> @@ -669,12 +669,18 @@ sub status_cmd {
>  sub say_n_paths {
>  	my $did = shift @_;
>  	my $cnt = scalar @_;
> -	print "$did ";
> -	if (1 < $cnt) {
> -		print "$cnt paths\n";
> -	}
> -	else {
> -		print "one path\n";
> +	if ($did eq 'added') {
> +		printf(__n("added %d path\n", "added %d paths\n",
> +			   $cnt), $cnt);
> +	} elsif ($did eq 'updated') {
> +		printf(__n("updated %d path\n", "updated %d paths\n",
> +			   $cnt), $cnt);
> +	} elsif ($did eq 'reverted') {
> +		printf(__n("reverted %d path\n", "reverted %d paths\n",
> +			   $cnt), $cnt);
> +	} else {
> +		printf(__n("touched %d path\n", "touched %d paths\n",
> +			   $cnt), $cnt);
>  	}
>  }

Nice to see you covered all verbs currently in use and then
future-proofed by adding a fallback "touched" here.

Thanks.

