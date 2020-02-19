Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82B9C5ACC4
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 23:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8740207FD
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 23:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OByo5IKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgBSXYZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 18:24:25 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57313 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgBSXYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 18:24:25 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 95179C67FF;
        Wed, 19 Feb 2020 18:24:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=McbdEyzygKRQB4hOwHqSpudO86E=; b=OByo5I
        Kef3XDIIytYUTzUzAfoTK/iyaLMl1iP3lpgh+13jWBTvDQ99CXrHPqJ8x6XNYvmN
        Z9JbMg3MJnZP43ji9tq04Jr5ROmlKdIyO4jpi0SN01Urp/ZReEOYq7Y2WgQDp2kK
        xf4Okq66jGAHJMnwO0EdMW85RRPDTN3ifYsfk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sIztHiP8XS653vWkMi4V5XjVaFa+TCkU
        xM7am00wJvirYmtKQnNmJreZNaC2PEUgrEK9oWadaA/K5b45Lt7K49lsMwPNpAn0
        QwkKX0MJHjH1vmkRbRzdZrdXaa4dVjZOmKyRkp1CnLlp7lVrJvtzzkq2zIpg081g
        Qz/rxmKmTcU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8D587C67FE;
        Wed, 19 Feb 2020 18:24:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BC60FC67FD;
        Wed, 19 Feb 2020 18:24:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 03/15] bugreport: add tool to generate debugging info
References: <20200214015343.201946-1-emilyshaffer@google.com>
        <20200214015343.201946-4-emilyshaffer@google.com>
        <xmqqzhdlnksn.fsf@gitster-ct.c.googlers.com>
        <20200215015729.GN190927@google.com>
        <xmqq1rqvogif.fsf@gitster-ct.c.googlers.com>
        <20200218234628.GA1461@google.com> <20200218235622.GB1461@google.com>
        <20200219231554.GB79731@google.com>
Date:   Wed, 19 Feb 2020 15:24:18 -0800
In-Reply-To: <20200219231554.GB79731@google.com> (Emily Shaffer's message of
        "Wed, 19 Feb 2020 15:15:54 -0800")
Message-ID: <xmqqlfoycg9p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F4DD4F9E-536E-11EA-9FCA-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> On Tue, Feb 18, 2020 at 03:56:22PM -0800, Emily Shaffer wrote:
>> On Tue, Feb 18, 2020 at 03:46:28PM -0800, Emily Shaffer wrote:
>> > On Sat, Feb 15, 2020 at 10:24:40AM -0800, Junio C Hamano wrote:
>> > > I am actually OK if we limit the use of this tool to "use with a
>> > > repository that is not corrupt", as coping with these kinds of
>> > > breakages that in the main Git executable we deem "needs manual
>> > > intervention" inside a single process is too painful (it would have
>> > > been easier to cope with these too if we stuck with a script that
>> > > invokes many discrete commands and acts on their errors, but that is
>> > > optimizing for rare case and not recommended).  But we should tell
>> > > users about the limitation and encourage them to ask for help in non
>> > > automatable means.
>> > 
>> > I think you're saying, "Mention this drawback in the manpage for
>> > git-bugreport." Sounds like a good idea to me, so I'll add it for v8.
>> 
>> I'm pretty unsure about how you wanted this to sound; rather than
>> sending a v8 only to revise it a lot, I'll send the paragraph for
>> wordsmithing beforehand. Is this what you meant?
>> 
>>   This tool is invoked via the typical Git setup process, which means that in some
>>   cases, it might not be able to launch - for example, if a relevant config file
>>   is unreadable. In this kind of scenario, it may be helpful to manually gather
>>   the kind of information listed above when manually asking for help.
>
> Since I saw lots of replies from Junio elsewhere in this thread, I'll
> take the silence here as assent. v8 on its way momentarily.

Heh, it's just I have too little time to allocate on this single
topic X-<.  Don't take silence as anything else.

