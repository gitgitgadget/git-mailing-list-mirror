Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 628C21F406
	for <e@80x24.org>; Fri, 22 Dec 2017 20:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756799AbdLVUME (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 15:12:04 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61416 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755940AbdLVUMD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 15:12:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2CD94BC5AA;
        Fri, 22 Dec 2017 15:12:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aSGBWMQz+gxzOxNSthBb/sqoLp0=; b=UrVQ2t
        6jdWcvzd3GIQonZDJQADuQE4RfWTicoCKuT8AwUOTtrXbHD2/BL5O1X8eDAITS/W
        wCS4QYM1pBYFGkwDVMDqr+d+bEenN5GmhCKbXq8upiPlIXlQnkYDYxgQ1JwmZXpZ
        fh8GvFCVRIkab8ZJTo124aB7I6OjZ2FSiY4lg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yKJ56sh2hD1Yj5tBw8tLWpHMH13sGFkT
        dGmxCLXnLS5Zipv99c8spRuY2FSEgmZYuRfBI2Zmt5gw1nIz2Y++8m5JdsWA/k8e
        VlbuCQSpwIQYw4hmEIpWT6MrcGgjfUex9Vbvq3pywn1YMf3A23QIamOcxvgVpKSl
        scBgn7ECQzs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 25EF8BC5A9;
        Fri, 22 Dec 2017 15:12:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 85510BC5A8;
        Fri, 22 Dec 2017 15:12:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] oidmap.h: strongly discourage using OIDMAP_INIT directly
References: <940d8daa8eb8d42b9f0a3ebf4c25fb6417e71bc8.1513940345.git.johannes.schindelin@gmx.de>
        <20171222171635.GA230194@google.com>
Date:   Fri, 22 Dec 2017 12:12:00 -0800
In-Reply-To: <20171222171635.GA230194@google.com> (Brandon Williams's message
        of "Fri, 22 Dec 2017 09:16:35 -0800")
Message-ID: <xmqqlghur08f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F9F93B6-E754-11E7-92E3-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>> -#define OIDMAP_INIT { { NULL } }
>> +/*
>> + * This macro initializes the data structure only incompletely, just enough
>> + * to call oidmap_get() on an empty map. Use oidmap_init() instead.
>> + */
>> +#define OIDMAP_INIT_INCOMPLETELY { { NULL } }
>
> This is one way of approaching the problem.  Couldn't we also take the
> approach like we have with oidset and ensure that when oidmap_get() or
> _put() are called that if the oidmap isn't initialized, we simply do
> that then?

Hmph.  Can you show how the alternative code would look like?
