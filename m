Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AB851F462
	for <e@80x24.org>; Tue, 28 May 2019 16:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfE1Qjx (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 12:39:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65117 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfE1Qjw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 12:39:52 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 99A581436DB;
        Tue, 28 May 2019 12:39:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RkIs2GKdxPfKNZOxjVZLcQdi3S8=; b=k96oUU
        zTCwLwd3xPK0fpLoYDhov5CzlsGIxb4WpaGhv0ZjVoSaA+wg9qNN0nGpe4K5sVOM
        F9cHzsKAyTT4Fxdf5+wTPoAW9WaKlF1E8ge7FS7hpZJjjTDY7TE6kUM6gHmwz/0S
        CtxnVQYksjm67NV8UKtZMJA3WLb/eXX2Ar/fo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VnmvjclUUudr37l1UQV/WP81vswPgny6
        EdSpsywykvZOdN6HxV/pVe1EMySzBM5uXSqn/64Tn+u4Yw6DBHBbm7Eag675hIZ7
        DNPYDGY4s4p2lXFjkW6hxPswzwBLSnLqvtgJI1JFkpY2bd+E34ynoIx8rOrUeDFk
        PLoxzgfsBHg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9012F1436DA;
        Tue, 28 May 2019 12:39:50 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 032871436D9;
        Tue, 28 May 2019 12:39:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Barret Rhoden <brho@google.com>
Cc:     Michael Platings <michael@platin.gs>,
        Git mailing list <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
        Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v7 7/8 (edit)] blame: add a fingerprint heuristic to match ignored lines
References: <20190515214503.77162-8-brho@google.com>
        <20190516215713.100523-1-brho@google.com>
        <xmqqftpd3br1.fsf@gitster-ct.c.googlers.com>
        <CAJDYR9Qm+oQ=Lv53v_zrYaG2pW_TggD4q2ENEa7bR4z900fXyw@mail.gmail.com>
        <d182d854-24b6-bbc4-e567-27ecbc933d69@google.com>
Date:   Tue, 28 May 2019 09:39:48 -0700
In-Reply-To: <d182d854-24b6-bbc4-e567-27ecbc933d69@google.com> (Barret
        Rhoden's message of "Mon, 20 May 2019 16:34:22 -0400")
Message-ID: <xmqqlfyq4jor.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3612E0BC-8167-11E9-B36B-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Barret Rhoden <brho@google.com> writes:

> Hi -
>
> On 5/20/19 4:32 PM, Michael Platings wrote:
>> Hi Junio,
>> The SQUASH??? patches look good to me. Please squash away!
>> Thanks,
>> -Michael
>
> I can squash them into the next version of the patch set too, pending
> other comments / changes.

Thanks for the offer.  Very much appreciated.

Unless the fix-up is for the very tip commit, I'd prefer to leave
the fixes to the topic author(s).  IOW, these SQUASH??? patches are
emergency fixes I had to make on top to keep the tip of 'pu' build
and/or test, and may not be separated to be squashable into
individual steps.
