Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC1DF1F461
	for <e@80x24.org>; Mon,  8 Jul 2019 20:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731949AbfGHUYN (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 16:24:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54028 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfGHUYN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 16:24:13 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 731EB15A9B6;
        Mon,  8 Jul 2019 16:24:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J3vT/HSY0mt54UMEVyb/dDIoSck=; b=qrTH3/
        YQEVXNbjX9oV7RcPtNq/SkNIObrfVx1/bb+k38Iu2c+OY2j1zXoMvyAdiyuzDzxT
        +XYkY8EQrotFC8L5XYamxz+1ROSmaOWZJUfTd29+rCURHqvfCsNNuaj+OsyNa2AD
        slDkVTIcVrR0OzDmG8VvgboYh7ICmmzDO/b0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yTzaG2wxeA5/eiIM0L1s99IyO1YD2EU8
        wvsB6ZLQNSAyYofhTznXwjSE0jD2lpdHtHGd/xcezPOyvAJXgZc00peuc89CI1hE
        USuL9q96Umvr1NuJXJl2Qs9473fWc5SrY60E8TBxFo2/wAu2V6nfasCESid2G2vL
        +yiUOx/KHWo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BA4B15A9B5;
        Mon,  8 Jul 2019 16:24:11 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DCC9515A9B4;
        Mon,  8 Jul 2019 16:24:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH 0/5] oidmap: handle entries with the same key
References: <20190707083002.7037-1-chriscool@tuxfamily.org>
Date:   Mon, 08 Jul 2019 13:24:09 -0700
In-Reply-To: <20190707083002.7037-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Sun, 7 Jul 2019 10:29:57 +0200")
Message-ID: <xmqqd0ikxok6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58530CE8-A1BE-11E9-9C07-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> This is an RFC patch series that is not intended to be merged for now,
> as it looks like we don't need oidmaps that can handle several entries
> with the same key yet.

What does it even mean for a map to allow multiple entries per key?
When you have a key and its value, you must retrieve all existing
entries for the key and see their values before deciding if you want
to add yet another entry to the already existing set?  When you have
a key, you must retrieve all existing entries to see if any of them
is what you want?

What I am wondering is if people usually do "a single list/set of
values that is associated with each key" for such an application.
Obviously you do not need a map that allows multiple entries per key
if you did so---is there an advantage of a map that allows multiple
entries per key?

> As I needed this for my work on reftable, I thought that...

I actually think that showing how it is used in the real application
(reftable?) is the best way to illustrate why this is useful and to
get opinions from others.
