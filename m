Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F21C920A25
	for <e@80x24.org>; Fri, 15 Sep 2017 04:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750837AbdIOEoQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 00:44:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53331 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750720AbdIOEoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 00:44:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 492C4B4675;
        Fri, 15 Sep 2017 00:44:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/xl4Q4hzoPHwosr290BotS1TT74=; b=p+ZwCO
        vsRDnCZJBwaRsWXL3LZ87AkJ/BDJln6Ni3LXihnM4bYl7m33vJY5QuUpGiqSlPh/
        Tbv1NomQDFwg2tf9sO13S3mWPj1ELoQWYLrw74Z1o2yqH0q7T864rQIkuPonp3dI
        QCXeEHTJYPvFd1v/9tZpJ1Lt5jVRKy+deyrSw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YPD1DRJfnphvnlW7hWsBRnwAyFbnZerW
        kVmHIacUcOv01X1sdNqU/Os4jWua/phbD0hDBR7bBqeZLj9xvVSlKsajSz0RIyiq
        J4VjqKvHIPrX6icM2M7sCLMrqU/nCaGpHxTklY7QbO49ahLxB8UAxOZzj8mbC8Fq
        fSKgqCntSeU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4248CB4674;
        Fri, 15 Sep 2017 00:44:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8BF3FB4673;
        Fri, 15 Sep 2017 00:44:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] imap_send: setup_curl: retreive credentials if not set in config file
References: <828c6333-0ba0-2a01-324e-f910a8042ca1@morey-chaisemartin.com>
        <accffa40-3559-5f65-3149-aaa86a2278fc@morey-chaisemartin.com>
Date:   Fri, 15 Sep 2017 13:44:13 +0900
In-Reply-To: <accffa40-3559-5f65-3149-aaa86a2278fc@morey-chaisemartin.com>
        (Nicolas Morey-Chaisemartin's message of "Thu, 14 Sep 2017 09:52:06
        +0200")
Message-ID: <xmqqwp50y3j6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8670DF4E-99D0-11E7-971A-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com> writes:

> +	if (cred.username)
> +		if (res == CURLE_OK)
> +			credential_approve(&cred);
> +#if LIBCURL_VERSION_NUM >= 0x070d01
> +		else if (res == CURLE_LOGIN_DENIED)

A slight tangent.  This is in line with the way in which we do
conditional compilation to work with different versions of libCurl,
but we recently had discussion on modernizing these version based
conditional compilation to use feature based one in another topic.
We may want to switch to

	#if defined(CURLE_LOGIN_DENIED)
		...

(cf.
https://public-inbox.org/git/cover.1502462884.git.tgc@jupiterrise.com/
the entire thread).

No need to change _this_ patch in this series, but something to keep
in mind planning for a future follow-up work to clean things up.

Thanks.
