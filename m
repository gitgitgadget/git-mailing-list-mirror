Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 954EC1F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 20:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753598AbdAZUty (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 15:49:54 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65522 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752878AbdAZUtx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 15:49:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE38363BF8;
        Thu, 26 Jan 2017 15:49:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4elgbrG3/cke6dfElZn3f8oX6h8=; b=YSZWZM
        BxNza4lP+0+FJVznjAGxjPtiksEz14tuHy/FU+L+loARFesnYPx9kje1TxxgXJEA
        y9Mi6xtzbUQovZyJDWvLtU8UWmTPLPSbtjn+N7hLLpx/tQ0rrdkGUPS5FJsKGkkV
        WgvJRkwbMQUGTDEDss1rvuKF8+02hTDLRD038=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HvjNY2BMPQhvIp1zxTYX2tZadv8wHb+m
        6YuQCe3OVdRU4EMePZlnN8rF3+bhXBWe8ENDEU62K4B9Hfwz2m+2DK9Aj9bLUzoA
        TxzCv8cNOV6/W6W8Cz2HXJSfnp0lLZ69kKAcqk8gM1snI5/PELIHMd7bwulxpJgl
        SiL+vYi+v/4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B678163BF7;
        Thu, 26 Jan 2017 15:49:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 237B963BF3;
        Thu, 26 Jan 2017 15:49:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <patrick.steinhardt@elego.de>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v3 4/4] urlmatch: allow globbing for the URL host part
References: <20170125095648.4116-1-patrick.steinhardt@elego.de>
        <20170123130635.29577-1-patrick.steinhardt@elego.de>
        <20170125095648.4116-5-patrick.steinhardt@elego.de>
        <xmqq7f5h4kng.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 26 Jan 2017 12:49:12 -0800
In-Reply-To: <xmqq7f5h4kng.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 26 Jan 2017 12:43:31 -0800")
Message-ID: <xmqq37g54kdz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E5710CEA-E408-11E6-B543-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> +	while (url_len && pat_len) {
> +		const char *url_next = end_of_token(url, '.', url_len);
> +		const char *pat_next = end_of_token(pat, '.', pat_len);
> + ...
>  	}
>  
> +	return 1;

Embarrassing.  The last one must be "have they both run out?" i.e.

	return (!url_len && !pat_len);

