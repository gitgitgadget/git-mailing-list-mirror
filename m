Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D5C420958
	for <e@80x24.org>; Sat,  1 Apr 2017 17:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751808AbdDARr2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 13:47:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52152 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751776AbdDARr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 13:47:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8BE6D6AE73;
        Sat,  1 Apr 2017 13:47:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bKklYSdzjAv0PYCFrfbcSLZVWoI=; b=LlyYom
        +laAwsDfDmoOUmOB+pPJEtzctOxCi3l2husleVTzlXKWyLZc41Y647cSKg96mM8K
        P6e+ULMwbvK03TMzpr1A+W0IiZb1kGsqDVtuLeNAxwcSXurMvN/bmxPxRw0A2zGY
        3IbDoqyYT1Bf7xbMhl5pxOeDcnPuCiOlIe4UE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AGvBYxJIlNCo8TUMRO5X+x5W/TcmU5q0
        AHVe9Eqfp0yM1lzuUA2/52qvlQO7vHBjyZFI1ymdk9venDN3usWjEY7ck88BY1rD
        LXQ9kLF+KXEJ0MMuRaaEWMQ0cX0GAB8MXBM9HJ4WB6HPv3+HXlkj8SHZ5m5ouoPY
        Rk3Ii4rj0x0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 839E66AE72;
        Sat,  1 Apr 2017 13:47:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 98C4F6AE6D;
        Sat,  1 Apr 2017 13:47:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] sha1_loose_object_info: return error for corrupted objects
References: <20170401080349.lccextuc3l6fgs6j@sigill.intra.peff.net>
        <20170401080521.ehjc6jomjd5py3lj@sigill.intra.peff.net>
Date:   Sat, 01 Apr 2017 10:47:23 -0700
In-Reply-To: <20170401080521.ehjc6jomjd5py3lj@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 1 Apr 2017 04:05:21 -0400")
Message-ID: <xmqqwpb4uij8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 444E156E-1703-11E7-9509-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> When sha1_loose_object_info() finds that a loose object file
> cannot be stat(2)ed or mmap(2)ed, it returns -1 to signal an
> error to the caller.  However, if it found that the loose
> object file is corrupt and the object data cannot be used
> from it, it stuffs OBJ_BAD into "type" field of the
> object_info, but returns zero (i.e., success), which can
> confuse callers.

Thanks for a nice analysis and a fix.

