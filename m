Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB11620899
	for <e@80x24.org>; Mon, 21 Aug 2017 05:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751019AbdHUFAE (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 01:00:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59088 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751050AbdHUFAE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 01:00:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C742A5931;
        Mon, 21 Aug 2017 01:00:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6JpTnYzR7kljk2nAPscSg2/Mxqo=; b=o9owoq
        zU9dXCb66oVjEsdQPvntGPN7AgAhbf5Ne4XCsEcmQMkRnQ5fxlMQ6Bscypg5KNLj
        tqaw5sN7x+M5agEKlqH783N5I7LmdNDFJDAv5p2avO3YKXgZckva7galMIvlVY9k
        zXs7xqqFyVdcX7zUHQaQt9pBE2YR81MG+6E10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P42LpxycniHZpnQVH9fXx6O9VDupvJhn
        z1I97roQW6mxOhmOLfqHzOCY9pbK1CeZw2ube8JkoB9Na4epeovGe7sn9iHUJnah
        ZCRtC1MIo0wdMloEiTMst/1Ipc+3XgBTlYqjnMtnY0jwBpeNoUw7iVNWPO1c/cCZ
        hUdCqlV5+6o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A84CA592E;
        Mon, 21 Aug 2017 01:00:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7C3C2A591E;
        Mon, 21 Aug 2017 00:59:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Patryk Obara <patryk.obara@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/6] Convert hash-object to struct object_id
References: <cover.1503258223.git.patryk.obara@gmail.com>
        <20170820202511.m23njssyika5ufa6@genre.crustytoothpaste.net>
Date:   Sun, 20 Aug 2017 21:59:58 -0700
In-Reply-To: <20170820202511.m23njssyika5ufa6@genre.crustytoothpaste.net>
        (brian m. carlson's message of "Sun, 20 Aug 2017 20:25:11 +0000")
Message-ID: <xmqq60dh7bxt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9556953C-862D-11E7-AE28-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Sun, Aug 20, 2017 at 10:09:25PM +0200, Patryk Obara wrote:
>> This enabled conversion of few functions in sha1_file, which
>> had almost all callers converted already.
>> 
>> I hope I'm not stepping on anyone's toes with this patch series.
>> If I do - is there some email thread or document in which I can
>> coordinate with other developers, regarding which code regions
>> are being converted to struct object_id next?
>
> We don't have a coordinated thread at the moment.  You can see what I'm
> working on at https://github.com/bk2204/git.git in the object-id-part10
> and object-id-part11 branches (based on an older next).
>
> However, having said that, I don't mind if you or others pick up various
> parts of the codebase.  At worst, I drop a few patches for things others
> have already converted.

Thanks for working well together ;-)

I've scanned these patches and they looked OK.  There still are
places that dereferences oid->hash when making a call instead of
passing a pointer to the whole oid, but that is not making things
worse.

As to the naming (your comments on 5/6), I agree that we would need
to switch s/sha1/oid/ in the names in the endgame.  It may be OK to
leave it to later rounds when we do use something like your hash
algorithm abstraction throughout the codebase.


