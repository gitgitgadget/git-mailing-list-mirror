Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E58C38A30
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 01:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 085CD2078C
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 01:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pye0e7/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgDUBpG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 21:45:06 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51533 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgDUBpF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Apr 2020 21:45:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 067ADB04A7;
        Mon, 20 Apr 2020 21:45:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U2RSkSF/KYthspPU+E2UFKgnTRI=; b=pye0e7
        /TWMmrEK5oJ0M2ls+idymRq40XRzfAtd7Yij5ZEufGzPr05YVhaXknjlXfcvvPHi
        JWGnMTOwGZc8vePweluAsrVwau6huOFRKSYbD1kDlf22jvPds702CzS1cTQKCRFx
        cTrJ/ODPrsEWUfgUg28H1gGwmN9KKSn/X77BU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gFnpFYh6n7ZduPc/k0INKXV0dkPl15sV
        +2wr1iB7q2D4vuy9vbDixAhwwY3RAG0/L4PIuhX0zjkeFz2q+BmfZ7TpZMg20zK1
        L6N6Cdd5unIGVoUtW/kVsN5cHDORdVznyqjWa/BKphPxAVjlrTdftlfkaYxVhvGl
        +JIbGs1ROmI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F25BCB04A6;
        Mon, 20 Apr 2020 21:45:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B1CC4B049D;
        Mon, 20 Apr 2020 21:45:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] osxkeychain: restrict queries to requests with a valid host
References: <20200420224310.9989-1-carenas@gmail.com>
        <xmqqa735rbyh.fsf@gitster.c.googlers.com>
        <CAPUEspiBqCGTOfEESAqY=JR5jHhARSAODjsg5rGLxWEqzFH0zw@mail.gmail.com>
Date:   Mon, 20 Apr 2020 18:44:58 -0700
In-Reply-To: <CAPUEspiBqCGTOfEESAqY=JR5jHhARSAODjsg5rGLxWEqzFH0zw@mail.gmail.com>
        (Carlo Arenas's message of "Mon, 20 Apr 2020 16:20:55 -0700")
Message-ID: <xmqqd081pq79.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6AB5C38-8371-11EA-8350-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> On Mon, Apr 20, 2020 at 4:09 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Just to clarify, you do not need this patch to "fix" it, as long as
>> you are running up-to-date Git, right?  In other words, this is more
>> like a belt-and-suspender protection, isn't it?
>
> the fixes in master do most of the work, but the way the underlying
> macOS function
> used works, will still randomly select a credential for cases where host=""

That is like saying "most of the work but as a protection it does
not work at all and still allows a random stuff to be chosen", no?
