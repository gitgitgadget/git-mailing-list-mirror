Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95509C433DF
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 18:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 627F4206A2
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 18:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jdli8j//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgFCSD0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Jun 2020 14:03:26 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53065 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFCSD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jun 2020 14:03:26 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A664DDD429;
        Wed,  3 Jun 2020 14:03:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B+NUdjCFoS4SPs28v/Uw8I9k3WQ=; b=Jdli8j
        //IvQ+vt6yqqTNUlcGTRBqc19JlqGBed6Rb7Ca5t3Ub1egWmC4dO3i5T1MX1APoT
        CgDutjzR63k94eMd6b38ED1r+HsNh2vx9bATsmeOU41pQYbXdr0ufSJVShPU00k3
        zQYCFlQD3R1XkGOC7uKNWBT3hlAAorAzqroQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AyVGwbISbVfdZg7cLCKAqwzAD2IDzyUO
        j9wk3XBnfqCVBZbfCydpUkXqDaC/w1a0mjzvz43Dbo1m85tqejevUqSwpIpua2Xg
        DeBJp3Xq1BaQJgU4ricaQXZQZ6jBuHRhtqQdGyQ4FcFKAIQ/W0kIZ9BZDjARh2FS
        dri51heq3yc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9E34EDD428;
        Wed,  3 Jun 2020 14:03:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D8798DD425;
        Wed,  3 Jun 2020 14:03:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2] refs: implement reference transaction hook
References: <1d1a94426f95d842e0e3ea6a1569c0c45239229c.1591086316.git.ps@pks.im>
        <04116cc57ab37eeb50bd51a065a7c06503493bf3.1591186875.git.ps@pks.im>
        <CAFQ2z_OSfsKKkOu_wKEAWi-Zihp4g265jtmXzteaU=BQZohEAQ@mail.gmail.com>
Date:   Wed, 03 Jun 2020 11:03:17 -0700
In-Reply-To: <CAFQ2z_OSfsKKkOu_wKEAWi-Zihp4g265jtmXzteaU=BQZohEAQ@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Wed, 3 Jun 2020 19:44:05 +0200")
Message-ID: <xmqq7dworpqy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 81DADA68-A5C4-11EA-AD50-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

>> +For each reference update that was added to the transaction, the hook
>> +receives on standard input a line of the format:
>> +
>> +  <old-value> SP <new-value> SP <ref-name> LF
>
> Does this work for symrefs as well? Should it?

That's a good question.

I am assuming that you are asking about updating the value of the
underlying ref the symbolic ref points at (i.e. <ref-name> would be
"HEAD" and old- and new-value are commits at the tip of the branch
that is currently checked out), and not about repointing the
symbolic ref to a different underlying ref.  I suspect we do not
want to.  In such a case, we'd have a separate "refs/heads/master
moved from old to new" record anyway, so we probably should not even
talk about symbolic refs when we report "a ref got updated to point
a different object" in the above format.

And obviously the above format cannot talk about repointing HEAD to
a different branch (well, it can in a sense that old and new branch
both would have some object name that can be filled in the old- and
new-value fields, but the record misses the most interesting part of
the "branch switching" without the actual old and new refnames), so
there must be another format that allows us to report such an event.

    "Sym" SP <old-refname> SP <new-refname> SP <symbolic-ref-name> LF

or something like that, so that

	$ git checkout next

may yield

    "Sym" SP "refs/heads/master" SP "refs/heads/next" SP "HEAD"

if we originally were on the 'master' branch.  Obviously we need a
way to represent different kinds of transition, like (1) a new
symbolic ref has been created, pointing at some underlying ref
(which may or may not exist), (2) an existing ref that pointed
directly at an object now has become a symbolic ref, (3) a symbolic
ref stopped pointing at a ref and now points directly at an object,
and (4) a symbolic ref has been removed.

Both (1) and (4) would be a trivial variation of the above format, I
guess, using some special token to denote void (say, we'd use an
empty string for that):

    "Sym" "" SP <new-refname> SP <symbolic-ref-name> LF
    "Sym" <old-refname> SP "" SP <symbolic-ref-name> LF

(2) and (3) are interesting.  We could represent them as two
separate operations inside the same transaction, e.g.

    "Sym" "refs/heads/master" SP "" SP "HEAD" LF
    "0{40}" SP "b3d7a52fac39193503a0b6728771d1bf6a161464" SP "HEADD" LF

or we'd need to invent different type of record to represent such
"detaching" and "reattaching" events.


    



