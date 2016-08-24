Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE1491F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 17:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753192AbcHXRw6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 13:52:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63489 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753078AbcHXRw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 13:52:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E67BC3719B;
        Wed, 24 Aug 2016 13:52:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f3g83ZWGcEJP4XGulOiaX66t+PQ=; b=bFsKV7
        kYF5hriPKkigIzrrxDs3eujAI6w9HdweYxGbEbjtf8SIdCEflEeN1Xa4tdNaX0UA
        cEpFm/aQQvofXMHr+5Go7VN8sCrHTrqvYotJKG32rDBqz2JRC8wJQAVYJ3CjY/Ow
        3/qv2hrLZPvdNDSXBdDItiPxhA2DgZkdCa/r0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FKl8R51ErvNR/koAcu2OBqzrMJdQSWEf
        ywD+yXHG+7Vz4nXzjSbhW4L6L3oykR1dtkY3wEGnqBWCKxkmqtoNOg4nFUdGRF3s
        E9tVNu38wCpTp+/LZYGJWAgjhdPxhDde3DsC4aG5juMMIvOBWPZH7s7m/Gvr79AS
        lMgZXf0xW9Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DE53F37199;
        Wed, 24 Aug 2016 13:52:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4565337195;
        Wed, 24 Aug 2016 13:52:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/4] cat-file: introduce the --filters option
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
        <cover.1472041389.git.johannes.schindelin@gmx.de>
        <320f5e862e8df12bbd1d918f0b347aeacbd25d17.1472041389.git.johannes.schindelin@gmx.de>
        <xmqqmvk2qcv8.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 24 Aug 2016 10:52:41 -0700
In-Reply-To: <xmqqmvk2qcv8.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 24 Aug 2016 10:46:03 -0700")
Message-ID: <xmqqeg5eqck6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8EC455D2-6A23-11E6-9DB2-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +test_expect_success 'setup ' '
>> +	echo "*.txt eol=crlf diff=txt" >.gitattributes &&
>> +	echo "hello" | append_cr >world.txt &&
>> +	git add .gitattributes world.txt &&
>
> 	git update-index --cacheinfo :world.txt,$EMPTY_BLOB,symlink &&

Sorry, last-minute-edit-gone-bad-without-proofreading.  It should
have been something like:

	git update-index --add --cacheinfo 160000,$EMPTY_BLOB,symlink &&

or

       	sym=$(echo "hello" | git hash-objects --stdin -w) &&
	git update-index --add --cacheinfo 160000,$sym,symlink &&
