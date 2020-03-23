Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2043CC3F2CD
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 16:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C118820714
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 16:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TvtudLTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgCWQFB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:05:01 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62178 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbgCWQFA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 12:05:00 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C0B3DB8047;
        Mon, 23 Mar 2020 12:04:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MjDUvEnGqDZH66teeMyUxVzTd/8=; b=TvtudL
        TbRiAGP7dd2LFZyRnAmj7jq9Qh43mB0Hd0SWUY3jla9FaEC8kCYfcPz8paDPmHE1
        MOrlO46Wrtgp4dl05UTjeKEV9rzpaK82sno9Qc6putxkMR9wLTjexex1EnK2s7we
        aXmy2t3xfUXhx9OgLvZI/KR5LUXuDd2Jp8Fio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gbLIwdpFFnGHgnZNZLwXxCphjPkx1VJn
        slJEYJRYHjqFWEqI3k0FpbfTRZSvRGpWwsYj6tyTHUSACiNbtRG5gGerw1bW9itc
        HXkEy1zu+gDkY7Itsk5jK6nLD8g4cn4d7Ke5Piq+wcUk6j2rkdPFolNB88OQgdeV
        huWI6EP97bA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B9D7AB8046;
        Mon, 23 Mar 2020 12:04:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D2363B8044;
        Mon, 23 Mar 2020 12:04:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Abhishek Kumar <abhishekkumar8222@gmail.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC][GSoC] Implement Generation Number v2
References: <20200322093526.GA4718@Abhishek-Arch> <86eetkrw8p.fsf@gmail.com>
        <20200323042517.GA1258@Abhishek-Arch>
        <xmqq369z7i1b.fsf@gitster.c.googlers.com> <86mu87qj92.fsf@gmail.com>
Date:   Mon, 23 Mar 2020 09:04:54 -0700
In-Reply-To: <86mu87qj92.fsf@gmail.com> (Jakub Narebski's message of "Mon, 23
        Mar 2020 14:43:37 +0100")
Message-ID: <xmqqtv2f5a6x.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 09C8F5BE-6D20-11EA-9DE4-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> About moving commit data with generation number v2 to "CDA2" chunk: if
> "CDAT" chunk is missing then (I think) old Git would simply not use
> commit-graph file at all; it may crash, but I don't think so.  If "CDAT"
> chunk has zero length... I don't know what would happen then, possibly
> also old Git would simply not use commit-graph data at all.

Yeah, if it makes it crash, then we cannot use that "missing CDAT"
approach.

> Putting generation number v2 into separate chunk (which might be called
> "GEN2" or "OFFS"/"DOFF") has the disadvantage of increasing the on disk
> size of the commit graph, and possibly also increasing memory
> consumption (the latter depends on how it would be handled), but has the
> advantage of being fullly backward compatibile.  Old Git would simply
> use generation numbers v1 in "CDAT", new Git would use generation
> numbers v2 in "OFFS" -- combining commit creation date from "CDAT" and
> offset from "OFFS"),

Do we have an option *not* to record meaningful generation numbers
in CDAT and have the current Git binaries understand and still use
the rest of the graph file, while not using the optimizations that
rely on having generation numbers?  If not, then the new version of
Git that tries to be compatible with old one needs to compute both
generation numbers, and we would need to keep the topological number
for quite some time.

> and there should be no problems with updating
> commit-graph file (either rewriting, or adding new commit-graph to the
> chain).

Would merging by the current Git also work well (meaning, would
"GEN2" or whatever it does not understand be omitted)?

Thanks.
