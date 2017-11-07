Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44FBD20A10
	for <e@80x24.org>; Tue,  7 Nov 2017 01:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965025AbdKGBTQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 20:19:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54171 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754084AbdKGBTD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 20:19:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 375BBA54C8;
        Mon,  6 Nov 2017 20:19:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6/svsBNLsmG72Ad/6ECwiFBnV2I=; b=b/RlZo
        jT7xqrX5H9+pVDTfx1iW3Imr/JvJiTjytJ8KWoSTKgcMucJDyfFRqV1g0ZwYtico
        npuRUshb9ZNdDnrquUPYQBGOpb2uv8PFtlf96bQhFD6dw8d3rn5N2IpClxan1MoJ
        oTAOv7HSaC7HF3S/LFAEp5JHvVoL4iuzSi47o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OtdJv594EgLxO/pNbrtJFzFzBxYkjZ6/
        yw+6c4CDKwkGXiYZh7yvR3GjJXSjiiiUGLWdXZRjvlmvpTsxkS2js3wtVnnY6C6Z
        EQCx0XDeNdBF10Rc06Fi/Zb8fj2fyimrfpJxGgkiTxXpSLW7QAL8bZhCAGF+0OFG
        R6rp47rIjJ4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D736A54C6;
        Mon,  6 Nov 2017 20:19:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 46122A54C4;
        Mon,  6 Nov 2017 20:19:01 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 6/8] t0021/rot13-filter: refactor checking final lf
References: <20171105213836.11717-1-chriscool@tuxfamily.org>
        <20171105213836.11717-7-chriscool@tuxfamily.org>
Date:   Tue, 07 Nov 2017 10:18:59 +0900
In-Reply-To: <20171105213836.11717-7-chriscool@tuxfamily.org> (Christian
        Couder's message of "Sun, 5 Nov 2017 22:38:34 +0100")
Message-ID: <xmqqk1z2hon0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3131BF0-C359-11E7-83C9-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> As checking for a lf character at the end of a buffer
> will be useful in another function, let's refactor this
> functionality into a small remove_final_lf_or_die()
> helper function.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  t/t0021/rot13-filter.pl | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
> index 2f74ab2e45..d47b7f5666 100644
> --- a/t/t0021/rot13-filter.pl
> +++ b/t/t0021/rot13-filter.pl
> @@ -93,12 +93,20 @@ sub packet_bin_read {
>  	}
>  }
>  
> -sub packet_txt_read {
> -	my ( $res, $buf ) = packet_bin_read();
> -	unless ( $res == -1 or $buf eq '' or $buf =~ s/\n$// ) {
> +sub remove_final_lf_or_die {
> +	my $buf = shift;
> +	unless ( $buf =~ s/\n$// ) {
>  		die "A non-binary line MUST be terminated by an LF.\n"
>  		    . "Received: '$buf'";
>  	}
> +	return $buf;
> +}
> +
> +sub packet_txt_read {
> +	my ( $res, $buf ) = packet_bin_read();
> +	unless ( $res == -1 or $buf eq '' ) {
> +		$buf = remove_final_lf_or_die($buf);
> +	}

After patch 2/8 I found the "unless" in packet_txt_read impossible
to read, but this makes it a bit more understandable.

