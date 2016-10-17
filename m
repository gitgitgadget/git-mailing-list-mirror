Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AE691F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 22:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933172AbcJQWtS (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 18:49:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53827 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757548AbcJQWtR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 18:49:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C5C8946994;
        Mon, 17 Oct 2016 18:49:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+me7yT/twRwTWDS5wjMuqAqjZFs=; b=IF9Znq
        zg6OLomLjVINjeXzfelCS6JUdD2WcNAvjluIL41pwkhaLY75uSsuSo/iDOYyrplx
        E2+piwNHtw3P/BSJsulp+Oqa1QbL+guDy7cA3Js82qcfN7qREnt36/EOmemLBeeF
        YRmtWAd0o6XJVgLl62zt3q478V8mLjmnwmtHo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vcqL74CRpH5gA8CTlSnugqyYlQDeJHrt
        B8L2XHbbzt835WXYeYIYumhXovSoXTj5SrG5NdS05rxDIdPvSIlLNL6B28ccnFd4
        fLNNYi51AOLNVfm04QLDYtqXnilcuJYwLhZ33I23NPrsjhPZ0saXjcuhm6PlICq1
        ZAh+Q5HL1ko=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BBB8046993;
        Mon, 17 Oct 2016 18:49:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1BB8546991;
        Mon, 17 Oct 2016 18:49:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     j6t@kdbg.org, Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        venv21@gmail.com, dennis@kaarsemaker.net, jrnieder@gmail.com
Subject: Re: [PATCH] submodule--helper: normalize funny urls
References: <20161017221623.7299-1-sbeller@google.com>
Date:   Mon, 17 Oct 2016 15:49:13 -0700
In-Reply-To: <20161017221623.7299-1-sbeller@google.com> (Stefan Beller's
        message of "Mon, 17 Oct 2016 15:16:23 -0700")
Message-ID: <xmqqbmyisiae.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EDDE2936-94BB-11E6-A691-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +static void strip_url_ending(char *url, size_t *_len)
> +{
> +	int check_url_stripping = 1;
> +	size_t len = _len ? *_len : strlen(url);
> +
> +	while (check_url_stripping) {
> +		check_url_stripping = 0;
> +		if (is_dir_sep(url[len-2]) && url[len-1] == '.') {

This is "strip /. at the end" it seems.

Does anything in the loop control guarantees 2 <= len at this point?

> +			url[len-2] = '\0';
> +			len -= 2;
> +			check_url_stripping = 1;
> +		}
> +
> +		if (is_dir_sep(url[len-1])) {

This is "strip / at the end" it seems.

Does anything in the loop control guarantees 1 <= len at this point?

> +			url[len-1] = '\0';
> +			len--;
> +			check_url_stripping = 1;
> +		}
> +	}
