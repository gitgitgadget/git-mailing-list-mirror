Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 977D21F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 01:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbeKTMDS (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 07:03:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52018 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeKTMDS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 07:03:18 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E0FB6124D8D;
        Mon, 19 Nov 2018 20:36:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=p1q54MjGcYbC
        1pNrq6CXfj0cuNA=; b=rwewxDkjMWbo+yao93bF5h5oE7sElEf+rkfSmUqqWvMR
        eXzX60QteiVcTQ3gATQY/A34DvQPPK/LG7Luh8/WAsrQW1z8+Qha03tH3BO0gK7t
        25qFxbc0bWchhOEDD7jF5iS/cHQITMDly15/P2JELtJpgaTh4QtNcYIqEqUP1po=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=WDFIkb
        fmulcmnNrHRIMi7QYgVGxtZqB2qcOqi7yFCdJaAfPfaWWArVS4S5+gqVZ7+asAcU
        ZbVv1E/hBQ1da3/bP6o5QGU7VEbY887/VkqL3TihMEiNqwC7Ox3mZ1ubMhApkltk
        xDlcVaV5TxNNSmAcKYqbmV2GxrNlxwVY0aVoI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D8B0C124D8C;
        Mon, 19 Nov 2018 20:36:43 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4B41D124D8B;
        Mon, 19 Nov 2018 20:36:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH/RFC v1 1/1] Use size_t instead of unsigned long
References: <20181117151139.22994-1-tboegi@web.de>
        <c09938cf-7631-ef89-d8fc-d952f9b121c8@gmail.com>
        <20181119163323.GA15913@tor.lan>
Date:   Tue, 20 Nov 2018 10:36:42 +0900
In-Reply-To: <20181119163323.GA15913@tor.lan> ("Torsten =?utf-8?Q?B=C3=B6g?=
 =?utf-8?Q?ershausen=22's?=
        message of "Mon, 19 Nov 2018 17:33:23 +0100")
Message-ID: <xmqqin0scyxh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BC33F516-EC64-11E8-928A-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> The only problematic system is Win64, where "unsigned long" is 32 bit,
> and therefore we must use size_t to address data in memory.
> This is not to be confused with off_t, which is used for "data on disk"
> (and nothing else) or timestamp_t which is used for timestamps (and not=
hing else).
>
> I haven't followed the "coccinelle script" development at all, if someo=
ne
> makes a patch do replace "unsigned long" with size_t, that could replac=
e
> my whole patch. (Some of them may be downgraded to "unsigned int" ?)

This paragraph makes it sound as if this patch is s/ulong/size_t/,
but that contradicts with the previous paragraph, no?  It is much
better to leave a ulong that is not about the size of a memory
region as-is, to be turned into appropriate and correct type later,
than changing it into another wrong type (size_t).

In short, we could do ulong to size_t with Coccinelle, but I do not
think we want to blindly rewrite all.

