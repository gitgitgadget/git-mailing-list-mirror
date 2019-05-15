Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94C8A1F461
	for <e@80x24.org>; Wed, 15 May 2019 02:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfEOC6F (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 22:58:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65422 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfEOC6F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 22:58:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BFFE1436E0;
        Tue, 14 May 2019 22:58:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KJvk7SHaHMwq/CN7Eb3m65trf9E=; b=CjW65i
        4tVijPNk8T7FjTR2n8EgQimPn6DQrjaAxGKEsj8fV2wvGk+53VgFvwJ1fvfwbYau
        IGezhTRfx1lvA67C4q1+fRWyU1gXcbvBek3cJmjsuzKjOf+l9Pr2R4uslP4kE3OH
        c4F7WITZGPxPaKAdo4ex3VvUhJWY6j1K1H/cc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MGD6P3XDsbEGR0dWcZoAR+qQks67ps6J
        fhzvJPlrYYtkBc9hjjiM4anRakv6KxR7DsTpYHzewqsTG+A7EV1p0T/++8FA8AE3
        sbkelVYwLDO2TWNBQp4oBMCVQ/lzRLP6jxQBInwheWgwleHw+zpPWLiyusQShx5v
        CVQUuPEtAAo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 238621436DF;
        Tue, 14 May 2019 22:58:03 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8F1D51436DC;
        Tue, 14 May 2019 22:58:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] merge: add --quit
References: <20190509101028.24656-1-pclouds@gmail.com>
        <20190514091322.12427-1-pclouds@gmail.com>
        <20190514091322.12427-3-pclouds@gmail.com>
        <nycvar.QRO.7.76.6.1905141540300.44@tvgsbejvaqbjf.bet>
Date:   Wed, 15 May 2019 11:58:01 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1905141540300.44@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 14 May 2019 15:44:26 +0200 (CEST)")
Message-ID: <xmqqlfz877ba.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 412F061A-76BD-11E9-8EEA-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> +test_expect_success 'merge --quit' '
>> +	git reset --hard c2 &&
>> +	test_must_fail git -c rerere.enabled=true merge master &&
>
> This makes me really worried. It is the same `master` (i.e. *not* a tag)
> that broke this test case in the previous round.

I'll let you two figure this out, but I tend to agree.

>> +	test_path_is_file .git/MERGE_HEAD &&
>> +	test_path_is_file .git/MERGE_MODE &&
>> +	test_path_is_file .git/MERGE_MSG &&
>> +	test_path_is_file .git/MERGE_RR &&
>
> Isn't this a clear implementation details of `git rerere` that you just
> taught `git merge`'s regression test?
> ...
> It would probably make a ton more sense to look at the output of `git
> rerere status` instead.

While I understand your concern, it is not the business of this test
to detect a bug in "git rerere status", either.  The safest thing to
do would be to test both ;-)

t4151 that tests "am --abort" already looks at MERGE_RR for the same
"we want to make sure that the rerere state is cleared" purpose, so
I'd not be worried too much about this particular test.

Thanks.
