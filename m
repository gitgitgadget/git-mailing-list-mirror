Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5FA31F667
	for <e@80x24.org>; Wed, 16 Aug 2017 19:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752417AbdHPTcb (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 15:32:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53950 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752376AbdHPTc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 15:32:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8ED53B05EA;
        Wed, 16 Aug 2017 15:32:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ICGhNiPApACmbej08t2iLkeYIDM=; b=qMY7J7
        s2nHMWNV75fuaO9pSiNPvXahtgdhPCu2+yUkDriR7PH/+GCNAuGTFUEN+RCtAOLj
        pS5EYSlfuM4XIeybNIOnABIuJhyJgIEJvetNu34nHvetE54RQ8Kf+so4J/0uYObz
        yvDw1g41lnP/jCY5IHDXDUVpCTRxmxhqhfvYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uO7nRGCjmzMmZqs6FKkmUtlomhgC/Wbc
        hxb5rWo9kBuFvphJ3NZ+iOnvKRyjGm7VOuGsBdUvDVvQu60S3Cb6tUQ/gA3n8pQL
        Z019ZAe/+0vqUhofSNRSjUyz7tv3i63fitS/34OOwRB2WPv+qHlnWBxx2aQtBPB1
        TcRsU1HbvRY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87502B05E9;
        Wed, 16 Aug 2017 15:32:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E57C2B05E8;
        Wed, 16 Aug 2017 15:32:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/5] sha1_file: fix hardcoded size in null_sha1
References: <cover.1502796628.git.patryk.obara@gmail.com>
        <a21088f049390828cdee957f88503e8466e1d34e.1502796628.git.patryk.obara@gmail.com>
        <xmqq1socsnay.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaCA29j6ON4KSsB=EH8FPfZGE56hVGSAAepcPiH952v6g@mail.gmail.com>
        <xmqqbmngr6wq.fsf@gitster.mtv.corp.google.com>
        <CAJfL8+R6SK3RGEGXcr5N-btKKjHCUcT95r7oOOsWgY1RXwEEtA@mail.gmail.com>
Date:   Wed, 16 Aug 2017 12:32:19 -0700
In-Reply-To: <CAJfL8+R6SK3RGEGXcr5N-btKKjHCUcT95r7oOOsWgY1RXwEEtA@mail.gmail.com>
        (Patryk Obara's message of "Wed, 16 Aug 2017 14:11:19 +0200")
Message-ID: <xmqqr2wbjol8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F32A9FA-82B9-11E7-9CA0-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patryk Obara <patryk.obara@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>
>> I said this is OK for "null" because we assume we will use ^\0{len}$
>> for any hash function we choose as the "impossible" value, and for
>> that particular use pattern, we do not need such a union.  Just
>> letting the caller peek at an appropriate number of bytes at the
>> beginning of that NUL buffer for hash the caller wants to use is
>> sufficient.
>
> Do you think I should record this explanation as either commit message
> or comment in sha1_file.c?
>
>> MAX is inevitable only if we envision that we have to handle objects
>> named using two or more hashing schemes at the same time, with the
>> same binary and during the same run inside a single process.
>
> I think this will be the case if "transition one local repository at
> a time" from Jonathan Nieder's transition plan will be followed.
> This plan assumes object_id translation happening e.g. during fetch
> operation.

It would be good if that assumption is made explicit.

Thanks.
