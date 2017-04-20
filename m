Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D87E91FE90
	for <e@80x24.org>; Thu, 20 Apr 2017 02:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965591AbdDTCVH (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 22:21:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53195 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965525AbdDTCVE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 22:21:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E34F706CC;
        Wed, 19 Apr 2017 22:21:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nkiwXSOTaAUr+oQGJ54Q7NMHpn4=; b=qADOoD
        Fj8S++sgeMiPjSA4mogua9SkcDkWYUPFQ4DBn2VPNrUnyRnwef7xwAevS5OYDwsE
        WEPkncwnI9yjqfdHIqp7/zW7N3kh9PApH7soeNfDLRVSAeQR5dWS/MI/aNykOhEx
        adaTkVwRZjk9WnxXTpSzu/0Zyr2KREOB6iBYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LPk2U3hLZEL9+3SyG8GgUduj4QFfdt58
        oEF9wnXGnQNWNZHe6Pf01OPQSPptOdMQAbHrQN9Vr/Tc7brKKS7pMxcT17LoycWU
        H9IXSWnMftqPwUQ+HGSOt19PmZQ5Tj3h1ig+3+vlVkZLkSjfDUEE9pLU1IQ2Wyz/
        K+KxSy073WU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1544D706CB;
        Wed, 19 Apr 2017 22:21:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7494F706C9;
        Wed, 19 Apr 2017 22:21:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 12/12] rev-list: expose and document --single-worktree
References: <20170217141908.18012-1-pclouds@gmail.com>
        <20170318101153.6901-1-pclouds@gmail.com>
        <20170318101153.6901-13-pclouds@gmail.com>
        <xmqq4lyq4g92.fsf@gitster.mtv.corp.google.com>
        <CACsJy8B5r9qPd9iNZnX4KG_-1WdL+LF+bSOy-zZnwiryQqRWKQ@mail.gmail.com>
Date:   Wed, 19 Apr 2017 19:21:01 -0700
In-Reply-To: <CACsJy8B5r9qPd9iNZnX4KG_-1WdL+LF+bSOy-zZnwiryQqRWKQ@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 19 Apr 2017 17:52:36 +0700")
Message-ID: <xmqqshl3akfm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 00048D36-2570-11E7-8006-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Sun, Mar 19, 2017 at 1:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
>>> index a02f7324c0..c71e94b2d0 100644
>>> --- a/Documentation/rev-list-options.txt
>>> +++ b/Documentation/rev-list-options.txt
>>> @@ -179,6 +179,14 @@ explicitly.
>>>       Pretend as if all objects mentioned by reflogs are listed on the
>>>       command line as `<commit>`.
>>>
>>> +--single-worktree::
>>> +     By default, all working trees will be examined by the
>>
>> s/working tree/worktree/?
>
> Nope. It's the "working tree" that we consistently use throughout
> git-worktree.txt

OK.
