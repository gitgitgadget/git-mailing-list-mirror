Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70C261F406
	for <e@80x24.org>; Fri, 12 Jan 2018 19:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965116AbeALTZE (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 14:25:04 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56406 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965044AbeALTZD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 14:25:03 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 07B68D5109;
        Fri, 12 Jan 2018 14:25:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rvSrEBUASFZI/z5SlqLup3+PqVs=; b=mrYB4/
        x8tCYrUf/9HEBp6KJElqVJT6rJVz5ehN1Gne9zFNYVxBlXj4tthdd6RmxQsCgfUF
        kHKclrRx+6elCAvBZaMjvN22y1OXYzcL9FgU+hAMa9g2ZeF8xE2rUteWLPb3bOvP
        YOVl1ouvf00HNCMFCfyIrfjug84lnbCJQGTuM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EycweCKBNrR7Zrtr3PPfjFL4YFfNTiXj
        D7X0S4Lf1q7yeLvP+eVGVid+h8LqoHGWOr2xE+fOg/nLSYQIaluRD34hsyv88Sia
        Yqvpit1AJA7jpA7EB8w299ivX3mJ8/KAP70frIdrqzLudV7GV71q8vg51wMqGGR6
        ijIpA24t2gU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F0864D5107;
        Fri, 12 Jan 2018 14:25:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0BDC3D5103;
        Fri, 12 Jan 2018 14:25:01 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     randall.s.becker@rogers.com
Cc:     git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] Fixed pervasive enumeration warning in convert.h.
References: <20180112163644.14108-1-randall.s.becker@rogers.com>
Date:   Fri, 12 Jan 2018 11:25:00 -0800
In-Reply-To: <20180112163644.14108-1-randall.s.becker@rogers.com> (randall
        s. becker's message of "Fri, 12 Jan 2018 11:36:44 -0500")
Message-ID: <xmqqh8rqx4kz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4926AF2C-F7CE-11E7-B87C-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

randall.s.becker@rogers.com writes:

> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>
> The actual enum value should be used rather than 0 and was causing
> a warning in an inline proc.
>
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  convert.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/convert.h b/convert.h
> index 4f2da22..a9a6658 100644
> --- a/convert.h
> +++ b/convert.h
> @@ -79,7 +79,7 @@ extern int renormalize_buffer(const struct index_state *istate,
>  static inline int would_convert_to_git(const struct index_state *istate,
>  				       const char *path)
>  {
> -	return convert_to_git(istate, path, NULL, 0, NULL, 0);
> +	return convert_to_git(istate, path, NULL, 0, NULL, SAFE_CRLF_FALSE);
>  }

I think this is being solved a bit differently with a1fbf854
("convert_to_git(): safe_crlf/checksafe becomes int conv_flags",
2018-01-06), and 0 becomes the right value to pass at this caller to
say "I am passing none of the flag bit".

I am hoping that the series that ends at f3b11d54 ("convert: add
support for 'checkout-encoding' attribute", 2018-01-06) will be
rerolled and hit 'master' early in the next cycle.

Thanks.
