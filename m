Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03D171F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 04:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeKNOQg (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 09:16:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61682 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbeKNOQg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 09:16:36 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7AA9A11C850;
        Tue, 13 Nov 2018 23:15:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xyEeHU/eBwDE
        ylvo3h1IMzylBLU=; b=umuOCe83iCehLEJMfW3+OFN4GAKwDcAiXogJgiQv5eCl
        iJXkU9FD+YMSUuLZcTGScJmloAdA+ct5siIBCQH+52Pw1xvLMV2z2WLeNEmJw45T
        t2VWaz1Bazwd9XX8uypk5RmJ6OaU3UvRKENgRYhZ6EtJT36m1qBQ5b9qCcFH2I8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=waAAXF
        c8TNrwg3w1kX9b+9EKAYMX3QxS9cjgC9tL196snTKczB4FEI+Npnxh/lFFQCUteo
        9UXEWKFuX8dAxItIOYmOYJ4pdIDUuhNWWnr2p6kmJLHqTOHk+4HhdlPB78xBs+kI
        EgxdDNznVuAAxmnvF29xtFcrwpNnwCXJsiwBs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7308611C84F;
        Tue, 13 Nov 2018 23:15:09 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E8D6011C84E;
        Tue, 13 Nov 2018 23:15:08 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] Makefile: add pending semantic patches
References: <20181030220817.61691-2-sbeller@google.com>
        <20181108205255.193402-1-sbeller@google.com>
        <xmqqzhui4ymh.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kbdewnxe=uC4GScvjJTgsru75O2FzSckjWoin2g1yXyPw@mail.gmail.com>
        <20181113154818.GE30222@szeder.dev>
Date:   Wed, 14 Nov 2018 13:15:07 +0900
In-Reply-To: <20181113154818.GE30222@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Tue, 13 Nov 2018 16:48:18 +0100")
Message-ID: <xmqq4lckqoqc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DF87E572-E7C3-11E8-8162-063AD72159A7-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> > inifinite recursion)?  Or are they "correct but not immediately
>> > necessary" (e.g. because calling read_cache() does not hurt until
>> > that function gets removed, so rewriting the callers to call
>> > read_index() with &the_index may be correct but not immediately
>> > necessary)?
>>=20
>> the latter. I assume correctness (of the semantic patch) to be a given=
,
>
> I'm afraid we can't assume that.  As far as correctness is concerned,
> I think semantic patches are not different from any other code we
> write, i.e. they are potentially buggy.  Perhaps even more so than the
> "usual" Git code, because we have long experience writing C and shell
> code (with all their quirks and error-proneness), but none of us is
> really an expert in writing semantic patches.

All correct.

And applying semantic patches generated from buggy sources can
produce buggy code, just like merging a buggy topic branch does.

These days, I ran coccicheck at the tip of 'pu' (even though this
cost me quite a lot a few times every day) and feed its findings
back to authors of topics that introduce new ones, so that their
topics next time do not need the fix-up at the tip of 'pu' in the
next integration cycle.  That way, the changes mechanically
suggested by coccicheck can still be reviewed in small bite-sized
chunks and hopefully possible problems caused by buggy sources can
either be found in the review process, or discovered at the tip of
'pu'.


