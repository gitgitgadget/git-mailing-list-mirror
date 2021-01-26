Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C179C433E6
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2721120658
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbhAZWAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:00:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59304 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387955AbhAZRrY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 12:47:24 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 507F99A701;
        Tue, 26 Jan 2021 12:46:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=AKugtansvqnk
        vPZkhKTH1mH0Ixo=; b=VCqIseJoM8zv//n+hTDewPccOR8CWDjbjJ5GBR5+x8tr
        YkgoIgq8U1hfqMWfkcDYijTQCiKFrZx1311oUHQ1V0XJptVffSllgTbyYIH9KTDh
        yycKrUeuveicy5fwhb4+nJVvHrTssP6saOjziEOwDWmsxrI+1SgZceHQ7xdDqeE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=iCL9M3
        OZm7pNeMQzrq6G4oUI47vsC9oLpx1MBphnMgITKIiHIzPkJNv7iz0zqaD/+hurRY
        ozs5Vy5/A+cGI1SRbcfolptA0Z7rANg3k8B3L/6QJ8JV5Jhlx0NK85lGgLTNp0f5
        p6Ity4VC/wYUxVP40a4PNuwfE6BsZ74EpW0DQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 48C949A700;
        Tue, 26 Jan 2021 12:46:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CE4AC9A6FD;
        Tue, 26 Jan 2021 12:46:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        jeffhost@microsoft.com, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 1/1] upload-pack.c: fix filter spec quoting bug
References: <YA81LEon1RPzT0T9@coredump.intra.peff.net>
        <20210125230952.15468-1-jacob@gitlab.com>
        <20210125230952.15468-2-jacob@gitlab.com>
        <874kj46mwf.fsf@evledraar.gmail.com>
        <CADMWQoP+hgPiSHJ5D-3G0+-bZOYm1hr=ojBeSmUJhiS7bp0zPg@mail.gmail.com>
Date:   Tue, 26 Jan 2021 09:46:24 -0800
In-Reply-To: <CADMWQoP+hgPiSHJ5D-3G0+-bZOYm1hr=ojBeSmUJhiS7bp0zPg@mail.gmail.com>
        (Jacob Vosmaer's message of "Tue, 26 Jan 2021 11:29:55 +0100")
Message-ID: <xmqqpn1r3827.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 69F0191E-5FFE-11EB-994E-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Vosmaer <jacob@gitlab.com> writes:

> Thanks for the feedback =C3=86var. I am not sure if I am still supposed=
 to
> make changes to the patch now that it is in "seen" as
> 7c6e2ea381d9aafe0a1eff0616013f81d957c0fd. Am I?

Being in 'seen' does not mean all that much.  You are free to
improve your patch by replacing until you and everybody else
please.

It is when it hits 'next' that replacement no longer becomes
feasible and it gets cast in stone and goes on track to be hopefully
part of the next release.

Thanks.
