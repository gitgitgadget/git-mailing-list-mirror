Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919E0C433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 15:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 248F12222D
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 15:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lR5qdwpF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgIQPm7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 11:42:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64287 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbgIQPmu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 11:42:50 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D832860D0;
        Thu, 17 Sep 2020 11:37:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Lxzw5WFIugjz
        eOQETyxd5CJ+OYM=; b=lR5qdwpFfgWTUFbHLJhVSHrc015u/wT5QL1Dyf9EI6sL
        B8jjRvF/VVi0/3BYUq/0Mpz2eURjvVENw2+SenImD7nC1EvB3gkAy9GRMKLntbrj
        +dwDvnpes4I+lAzTK7oQSgAo58kT5xHnOrr9jpySEYPtBYEwcsxE9qRXcgSNris=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rFT7ZS
        IX+2H1I08dS2j+3e4vzd8Ox/aqf47R5oUK0e4dDdvT0OkY2Hic6Sbft6GTn/VCbt
        dsnrLk11eMkzSoodlZ4zIvhqSmjN0+KrgOXG9gGgSeEyoIGy9QqkOdY4AK0gGxO2
        ey5CAe2vMRddrKiOWqOhsE7+Orgy5YaVBzcsg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 54C41860CE;
        Thu, 17 Sep 2020 11:37:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A9A4D860CB;
        Thu, 17 Sep 2020 11:37:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, tytso@mit.edu,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] sha1-file: fsync() loose dir entry when
 core.fsyncObjectFiles
References: <87sgbghdbp.fsf@evledraar.gmail.com>
        <20200917112830.26606-2-avarab@gmail.com>
        <20200917140912.GA27653@lst.de>
        <20200917145523.GB3076467@coredump.intra.peff.net>
        <20200917145653.GA30972@lst.de>
Date:   Thu, 17 Sep 2020 08:37:19 -0700
In-Reply-To: <20200917145653.GA30972@lst.de> (Christoph Hellwig's message of
        "Thu, 17 Sep 2020 16:56:53 +0200")
Message-ID: <xmqqzh5os9cg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AD5B3C8E-F8FB-11EA-8212-01D9BED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> On Thu, Sep 17, 2020 at 10:55:23AM -0400, Jeff King wrote:
>> On Thu, Sep 17, 2020 at 04:09:12PM +0200, Christoph Hellwig wrote:
>>=20
>> > On Thu, Sep 17, 2020 at 01:28:29PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>> > > Change the behavior of core.fsyncObjectFiles to also sync the
>> > > directory entry. I don't have a case where this broke, just going =
by
>> > > paranoia and the fsync(2) manual page's guarantees about its behav=
ior.
>> >=20
>> > It is not just paranoia, but indeed what is required from the standa=
rds
>> > POV.  At least for many Linux file systems your second fsync will be
>> > very cheap (basically a NULL syscall) as the log has alredy been for=
ced
>> > all the way by the first one, but you can't rely on that.
>>=20
>> Is it sufficient to fsync() just the surrounding directory? I.e., if I
>> do:
>>=20
>>   mkdir("a");
>>   mkdir("a/b");
>>   open("a/b/c", O_WRONLY);
>>=20
>> is it enough to fsync() a descriptor pointing to "a/b", or should I
>> also do "a"?
>
> You need to fsync both to be fully compliant, even if just fsyncing b
> will work for most but not all file systems.  The good news is that
> for those common file systems the extra fsync of a is almost free.

Back to =C3=86var's patch, when creating a new loose object, we do these
things:

 1. create temporary file and write the compressed contents to it
    while computing its object name

 2. create the fan-out directory under .git/objects/ if needed

 3. mv temporary file to its final name

and the patch adds open+fsync+close on the fan-out directory.  In
the above exchange with Peff, we learned that open+fsync+close needs
to be done on .git/objects if we created the fan-out directory, too.

Am I reading the above correctly?

Thanks.
