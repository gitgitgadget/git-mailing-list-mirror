Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5E14203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 19:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbdGXTls (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 15:41:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64620 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750824AbdGXTlq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 15:41:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AA32092770;
        Mon, 24 Jul 2017 15:41:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5lyALQBgV+PwHWUxZdO20QcK5qg=; b=aB+50+
        mtyOK2O/Vh+wLR+knKb31xfAJZjXmscf5NcdzzktynfS3tez4SJS6gEUKZdfcmNN
        gpezXJKeK5L4x/C14Lo7nrwk7Z4+tkss177XCsdtazq/I0rRwhKbwKJ6p9Y/jNXr
        8Wxyi9exCz9xGqqioB2Bw7D82qmBlkbOsvyvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HYQRNAAY5OOd7SLoeM5NwMbSBtZ8aYyR
        BjQMT+uEAOd7qs6chLD1azZt7CCaYq1I22dY7+YphMdQXhPzMAfRrHPM187yNip2
        eRPxi5cf6ahWNop4BySi60GJ0X5IAhsKnUgHCjBygo7ALYvyRZtCneWiN978xncQ
        v/iIi8RRzNw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A2B2C9276E;
        Mon, 24 Jul 2017 15:41:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0702C9276D;
        Mon, 24 Jul 2017 15:41:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andrew Ardill <andrew.ardill@gmail.com>,
        Farshid Zavareh <fhzavareh@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Should I store large text files on Git LFS?
References: <AC260BC2-FED8-4811-9F5D-220EF1DAAA53@gmail.com>
        <CAH5451mrL=GE6WrX6juoyGPV6trcQhXXthKhjT2=qCDCiffeeA@mail.gmail.com>
        <CANENsPr271w=a4YNOYdrp9UM4L_eA1VZMRP_UrH+NZ+2PWM_qg@mail.gmail.com>
        <CAH5451m0P4eZMXj8ojgbd+q-8scoJpwn9UcZLvqYKM=+8hhWPg@mail.gmail.com>
        <20170724181118.ntqjqfihhblbvwmi@sigill.intra.peff.net>
Date:   Mon, 24 Jul 2017 12:41:43 -0700
In-Reply-To: <20170724181118.ntqjqfihhblbvwmi@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 24 Jul 2017 14:11:18 -0400")
Message-ID: <xmqqvamhd3m0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1FEB5CAA-70A8-11E7-94A2-61520C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jul 24, 2017 at 02:58:38PM +1000, Andrew Ardill wrote:
>
>> On 24 July 2017 at 13:45, Farshid Zavareh <fhzavareh@gmail.com> wrote:
>> > I'll probably test this myself, but would modifying and committing a 4GB
>> > text file actually add 4GB to the repository's size? I anticipate that it
>> > won't, since Git keeps track of the changes only, instead of storing a copy
>> > of the whole file (whereas this is not the case with binary files, hence the
>> > need for LFS).
>> 
>> I decided to do a little test myself. I add three versions of the same
>> data set (sometimes slightly different cuts of the parent data set,
>> which I don't have) each between 2 and 4GB in size.
>> Each time I added a new version it added ~500MB to the repository, and
>> operations on the repository took 35-45 seconds to complete.
>> Running `git gc` compressed the objects fairly well, saving ~400MB of
>> space. I would imagine that even more space would be saved
>> (proportionally) if there were a lot more similar files in the repo.
>
> Did you tweak core.bigfilethreshold? Git won't actually try to find
> deltas on files larger than that (500MB by default). So you might be
> seeing just the effects of zlib compression, and not deltas.
>
> You can always check the delta status after a gc by running:
>
>   git rev-list --objects --all |
>   git cat-file --batch-check='%(objectsize:disk) %(objectsize) %(deltabase) %(rest)'
>
> That should give you a sense of how much you're saving due to zlib (by
> comparing the first two numbers for a copy that isn't a delta; i.e.,
> with an all-zeros delta base) and how much due to deltas (how much
> smaller the first number is for an entry that _is_ a delta).

In addition to that, people need to take into account that "binary
vs text" is a secondary criteria when considering how effective our
deltifying algorithm works on their data.

We use the same xdelta algorithm that is oblivious to line breaks,
so given two pairs of input files (T1, T2) and (B1, B2), where T1
and B1 are comparative sizes and T2 and B2 are comparative sizes,
and the change made to T1 to produce T2 (e.g. copy byte range X-Y of
T1 to byte ranage starting from offset O of T2, insert this literal
byte string of length L, etc.) and the change made to B1 to produce
B2 are of comparative sizes (i.e. X-Ys and Os are similar), when T's
are text and B's are binary, you should get similarly sized delta to
represent T2 as a delta to T1 and B2 as a delta to B1.  

The reason why typical "binary" file does not delta well is not
inherent to their "binary"-ness but lies elsewhere.  It is because
tools that produce "binary" files tend not to care too much about
preserving original and only effect changes to limited part.  That
is what makes their data not delta well across versions.

Exceptions are editing exif data without changing the actual image
bits in jpeg files or editing id3 data without changing the actual
sound bits in mp3 files.  Binary files across these kind of
operations delta very well with Git, as "edit" is not done by
completely rewriting everything but is confined in a small area of
the file.


