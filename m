Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05B912047F
	for <e@80x24.org>; Fri, 29 Sep 2017 08:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbdI2IJL (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 04:09:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55204 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750877AbdI2IJH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 04:09:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 80C8A9CF1D;
        Fri, 29 Sep 2017 04:09:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ax+mBjh2PGhAkD3y0sVEFvb/rPw=; b=WzQSb5
        q3PRtxPBCq96FKNhx+Rxi/jS514lrK+bE/RTtj25fzSRXJ1hzDNkFqlKgsqb9OhM
        i9B83YL3lNuYZK6wHcF1B4czt27LaELcth5C9xwYorXMwIsFVUFWeDPnht4Z5nR2
        cIylf5/7K9w7RNFhe3rixSPj8N08Y+1P/zyqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CFJhPS1jICKJk9CqxU79pF1vbcXPZ25o
        NBa8IsYap4kmW2jJKZyABTUD5cdlKCTqHhHiINDvUlCyOHwvBGoj2QywRO6smnm8
        3D0ltdBMWoI8hFm8mD6zp3HJoCjeMJMmWLW+qar6Bb2hVhW98CctOCsFrZf1Puth
        Qx6T1tiCoTU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 774B39CF1B;
        Fri, 29 Sep 2017 04:09:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CB1049CF19;
        Fri, 29 Sep 2017 04:09:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Shawn Pearce <spearce@spearce.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, bmwill@google.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Masaya Suzuki <masayasuzuki@google.com>, demerphq@gmail.com,
        The Keccak Team <keccak@noekeon.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4] technical doc: add a design doc for hash function transition
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
        <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
        <20170307001709.GC26789@aiede.mtv.corp.google.com>
        <CAJo=hJtoX9=AyLHHpUJS7fueV9ciZ_MNpnEPHUz8Whui6g9F0A@mail.gmail.com>
        <20170928044320.GA84719@aiede.mtv.corp.google.com>
        <xmqqo9puvy1w.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 29 Sep 2017 17:09:04 +0900
In-Reply-To: <xmqqo9puvy1w.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 29 Sep 2017 15:06:19 +0900")
Message-ID: <xmqqk20ivsdb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 766CE3B8-A4ED-11E7-9EF5-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Or perhaps we could.  There is nothing that says a signed tag
> created in the SHA-1 world must have the PGP/SHA-1 signature in the
> NewHash payload---it could be split off of the object data and
> stored in a local metadata cache, to be used only when we need to
> convert it back to the SHA-1 world.
> ...
>> +The format allows round-trip conversion between newhash-content and
>> +sha1-content.
>
> If it is a goal to eventually be able to lose SHA-1 compatibility
> metadata from the objects, then we might want to remove SHA-1 based
> signature bits (e.g. PGP trailer in signed tag, gpgsig header in the
> commit object) from NewHash contents, and instead have them stored
> in a side "metadata" table, only to be used while converting back.
> I dunno if that is desirable.

Let's keep it simple by ignoring all of the above.  Even though
leaving the sha1-gpgsig and other crufts would etch these
compatibility metadata in objects forever, these remain only in
objects that originate from SHA-1 world, or in objects created in
the NewHash world only while the project participants still care
about SHA-1 compatibility.  Strictly speaking, it would be super
nice if we can do without contaminating these newly created objects
with SHA-1 compatibility headers, just like we wish to be able to
drop the SHA-1 vs NewHash mapping table after projects participants
stop careing about SHA-1 compatiblity, it may not be worth it.  Of
course, if we decide to spend a bit more brain cycle to design how
we push these out of the object proper, the same solution would
automatically allow us to omit SHA-1 compatibility headers from the
objects that were converted from SHA-1 world.
>
>> +  - A table of 4-byte CRC32 values of the packed object data, in the
>> +    order that the objects appear in the pack file. This is to allow
>> +    compressed data to be copied directly from pack to pack during
>> +    repacking without undetected data corruption.
>
> An obvious alternative would be to have the CRC32 checksum near
> (e.g. immediately before) the object data in the packfile (as
> opposed to the .idx file like this document specifies).  I am not
> sure what the pros and cons are between the two, though, and that is
> why I mention the possiblity here.
>
> Hmm, as the corresponding packfile stores object data only in
> NewHash content format, it is somewhat curious that this table that
> stores CRC32 of the data appears in the "Tables for each object
> format" section, as they would be identical, no?  Unless I am
> grossly misleading the spec, the checksum should either go outside
> the "Tables for each object format" section but still in .idx, or
> should be eliminated and become part of the packdata stream instead,
> perhaps?

Thinking about this a bit more, I think a single table per .idx file
would be the right way to go, not a checksum immediately after or
before the object data that is embedded in the pack stream.  In the
NewHash world (after this initial migration), we would want to be
able to stream NewHash packstream that comes from the network
straight to disk, which would mean these in-line CRC32 data would
need to be sent over the wire (i.e. 4-byte per object sent); that is
an unneeded overhead, as the packstream has its trailing checksum to
protect the whole thing anyway.
