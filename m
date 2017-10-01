Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37B0A20281
	for <e@80x24.org>; Sun,  1 Oct 2017 09:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751078AbdJAJA3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 05:00:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57050 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751035AbdJAJA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 05:00:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B7BB39694A;
        Sun,  1 Oct 2017 05:00:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CYB24vlWrFxgAsh0LerdkHEz3Y0=; b=TCZdcs
        oTofaqGDXiUSr5iZLu5zJAAYPprLthgOTjRS5GAVCrXVKOnd23mW1F3wMmEiiznK
        u0x+XV0leFfL8oXf+vcGWlizR8uvAZkNCXATMy1Z/B5uyG9lW5y28tTCYsIPzlCj
        DjECSNf74OeOsml7CawcPuySt8oDsF/KmtWLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=e7+ziIUESXKGeOLltqkN1TYO9hEY0X4o
        uLI6g/DbEQ9rOWmqlDBG4CaS0TXGJzN8bBSfmRSkhLN6H+FiCz1iel1J4hjto+PS
        OguHFEkpRaJy55r09AT+2OKW2AoH7bMjgcsi1q1T7HEaJnk8ZGJdyaGArSOB4htU
        9Vq8np+/R6I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AE4D096949;
        Sun,  1 Oct 2017 05:00:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 11F4B96948;
        Sun,  1 Oct 2017 05:00:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 4/5] ref-filter.c: use trailer_opts to format trailers
References: <20170930062238.87077-1-me@ttaylorr.com>
        <20170930062238.87077-5-me@ttaylorr.com>
Date:   Sun, 01 Oct 2017 18:00:25 +0900
In-Reply-To: <20170930062238.87077-5-me@ttaylorr.com> (Taylor Blau's message
        of "Fri, 29 Sep 2017 23:22:37 -0700")
Message-ID: <xmqqbmlrutsm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F7C6C524-A686-11E7-A94E-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 2a9fcf713..2bd0c5da7 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -597,6 +597,9 @@ Acked-by: A U Thor
>    <author@example.com>
>  EOF
>  
> +unfold () {
> +	perl -0pe 's/\n\s+/ /'
> +}

For the purpose of the current shape of the test, the above might be
sufficient, but the lack of "/g" at the end means that the script
will happily stop after unfolding just one line, which probably is
not what you intended.
