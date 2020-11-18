Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BC1C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 15:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C91EE2474F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 15:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UyQV0STc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgKRPng (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 10:43:36 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54887 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgKRPng (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 10:43:36 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 775BD10BCE7;
        Wed, 18 Nov 2020 10:43:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3q/pef9u6hp94sS5m5k3eU26upA=; b=UyQV0S
        Tczhjmn/8vrtsEBtNbqbDx+sc0Pa5q2Hv24VhbPbWlDXr+GAOCSnQZIP5Z4r1cd+
        rcxs0y/61lSzMnOlfepY8cEU7AFxbiXCv3MJDQYS8f2bpOjE10+4i9kpX7giNsrO
        /JtyMJIIPqvFp/VphmeKQAKmpHHlfvFg9+o/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YM/fHcRES1xMPB1KV5ko0vwAQAcjfuEs
        5wmWBVRDoU4h2c57YnNigAaaYdXW3zvhUtsuh3YAIM6Azye5jzInda3eQQorKCRu
        PuQlqzywiETvGGLls28ieltBRlTyh/pdfxfYtu7LqQc+KTcbEgUjl0/OstnEm9DJ
        4Uboov/nLd4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6F9A910BCE6;
        Wed, 18 Nov 2020 10:43:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6F22C10BCE4;
        Wed, 18 Nov 2020 10:43:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>
Subject: Re: [PATCH 00/28] Use main as default branch name
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
        <87r1oraewl.fsf@x220.int.ebiederm.org>
        <CAMP44s2VJOd3N2zaj8YPv0iLOqTF7vWyZ=zPd9vd0+qO1DbEVA@mail.gmail.com>
        <20201117233313.GB642410@coredump.intra.peff.net>
        <xmqqr1or4jen.fsf@gitster.c.googlers.com>
        <20201118012544.GC650959@coredump.intra.peff.net>
        <20201118024028.GE360414@google.com>
        <xmqqima343vb.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2011181207220.56@tvgsbejvaqbjf.bet>
Date:   Wed, 18 Nov 2020 07:43:28 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2011181207220.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 18 Nov 2020 12:32:14 +0100 (CET)")
Message-ID: <xmqq1rgq4qn3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CEC3CD7A-29B4-11EB-A7C0-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So yes, I totally agree that triggering an interactive prompt by the empty
> value is not really a good idea (nor a particularly intuitive behavior).

Puzzled.

Nobody talked about going interactive so far and I didn't suggest
it---even though I think it is a cute idea to give a "what branch
name do you want to use?" prompt, I do not think it is practical.

I thought it was obvious, but the key to coming up with a name
dynamically instead of using a fixed string is to derive from a cue
the end user gives, not directly use what the end user gives.  I do
not think anybody in the discussion meant by "the <basename> thing"
to literally use $(basename $(cwd)) output, but use it to derive a
token that check-ref-format likes.  As you may have already known
when you wrote them, "My Documents" or the root directory case are
red herring---it would be trivial to derive "MyDocuments" or
"my-documents" for the former, and for the latter, it is totally OK
for the deriving rule to come up with any of "unnamed", "initial",
etc.

Most of the thing you said in the message I am responding to did not
make much sense to me.  Perhaps you can retry after reading the
message you are responding to again?

Thanks.
