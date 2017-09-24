Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 457D6202A5
	for <e@80x24.org>; Sun, 24 Sep 2017 06:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751059AbdIXG4I (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Sep 2017 02:56:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55204 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750880AbdIXG4H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2017 02:56:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D175B59A9;
        Sun, 24 Sep 2017 02:56:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KPYtiCBrJlcTwuPcOzfeKCxWtZU=; b=CLRG4H
        mrn8bfVZ93RNAdz8Iz159oU61U+kWKKsev0MuvGzea5gqYYoAxqG/BpDDeGmWBhC
        rm19bBNEHn1JoDlb6e5q7ggTPV9HdzPZW9YqqYIhRu/QIbzlIFinTsGS5rbAVtoH
        oJ0CGI1aLHvwWmp/59hrefWOINYBedQJSr3Rc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t39Zb9pqL+hbkTIHnD8tlTS7jwlZo3/E
        JhYQn8Wh3BZpnZD/fRY7h4XBF6UlwaRbdhVbAMOubBtp4d5RnUG87f7r9PHXlIzx
        qwfjzoX8kLA+EOsG94NIGgbYCBAS/NJEADaPiMBmyCamHKVQKGXfzLOvCimaueyE
        jNG2aZBTkkk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3524DB59A8;
        Sun, 24 Sep 2017 02:56:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 879BFB59A7;
        Sun, 24 Sep 2017 02:56:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 13/21] packed_ref_cache: keep the `packed-refs` file mmapped if possible
References: <cover.1505799700.git.mhagger@alum.mit.edu>
        <b32234e07a1bd1e60442a13d97d7c4e51edf3336.1505799700.git.mhagger@alum.mit.edu>
        <354c8088-ae24-479d-3b4e-fe8e189223b2@alum.mit.edu>
Date:   Sun, 24 Sep 2017 15:56:04 +0900
In-Reply-To: <354c8088-ae24-479d-3b4e-fe8e189223b2@alum.mit.edu> (Michael
        Haggerty's message of "Tue, 19 Sep 2017 14:44:24 +0200")
Message-ID: <xmqqlgl4h9ff.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F826056-A0F5-11E7-A560-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> +	struct stat st;
>> +	size_t size, bytes_read;
>
> Coverity helpfully pointed out that `bytes_read` has to be signed:
> `ssize_t`. I'll fix that in the next round after waiting for other comments.

Thanks.  

The macOS build at Travis also was also upset about it, so I'd
tentatively queue a trivial squash on top.

