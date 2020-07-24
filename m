Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598A0C433EA
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 20:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CEFD206C1
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 20:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="auwdbnrs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgGXUnu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:43:50 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64928 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgGXUnu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 16:43:50 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 27EB2DD8A8;
        Fri, 24 Jul 2020 16:43:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vMoRAap9rzJySDJvhK4KKw2wksM=; b=auwdbn
        rsFhpEYTh+GUjbjC/7GID8h2Bf8Qw4IwOjHw4EADKoNonYq8om9KO9X1/O78p7iZ
        xPK21xe+XRGL2x2yzUuM6jAJC+vGtNG30EBL8to+AtyqKSwnPVyf3Vp6pwpRHaZ7
        m5qYdJFjLEcGnaq7LWHfiblcpZy1ifOAWB2bQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qx9hOLTyU9hSOo8O23WFM9nFOdNuyFbK
        Usdav+0sOm4JX/8bznEdIa16lk7nQkfaZ1K5d70HX1lts5j3xwhzYr5Cve+PL7tL
        OmhG/QAyIUKUjoKSxNwOTX60WnbuJWOVh7nfPL5i+XofnxuRqzwVhqONvIvQQddE
        4GV+GpjKUog=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 20216DD8A7;
        Fri, 24 Jul 2020 16:43:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6E447DD8A4;
        Fri, 24 Jul 2020 16:43:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Tommaso Ercole <Tommaso.Ercole@qlik.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Creation of a branch named that has a directory prefix equal to the name of another branch fail.
References: <DM5PR1801MB2076F807C0B9F29A152DBEB7F0760@DM5PR1801MB2076.namprd18.prod.outlook.com>
        <DM5PR1801MB20762477763E6298C7FE6315F0770@DM5PR1801MB2076.namprd18.prod.outlook.com>
        <20200724160045.GA10590@syl.lan>
        <20200724200042.GC4013174@coredump.intra.peff.net>
Date:   Fri, 24 Jul 2020 13:43:43 -0700
In-Reply-To: <20200724200042.GC4013174@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 24 Jul 2020 16:00:42 -0400")
Message-ID: <xmqqv9ick5j4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E34E408-CDEE-11EA-ABDC-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Note that even though packed-refs does not have this limitation, we
> still enforce it in order to avoid headaches when moving between loose
> and packed refs.
>
> Likewise, we'll probably[1] continue to enforce it with reftables, at
> least for a while, to make things less confusing when pushing and
> pulling between repositories with different storage.

Yup, that coincides with my understanding.

The files backend could also learn encoding/decoding refnames and
that could be used to transition, if/when we decide to discard the
"refs are organized in a directory-tree like fashion" design we have
been using, to a new world order where a branch M and branches M/A,
M/B, and M/C can co-exist.  Encoding/decoding refname to map to the
filename would also help those on case insensitive filesystems.

Thanks to the recent preparation work for reftable, we are ensuring
that we do not leave direct accesses to $GIT_DIR/refs/* in our
codebase outside the files backend implementation, such a transition
hopefully is getting much easier to do than before.
