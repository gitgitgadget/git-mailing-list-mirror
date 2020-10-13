Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56132C433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 19:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7F4C20EDD
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 19:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WQOv+vC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgJMTHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 15:07:15 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63355 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgJMTHO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 15:07:14 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E790210108A;
        Tue, 13 Oct 2020 15:07:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jEQ2p7p5qVkNhaSK7L7jDqW6Eug=; b=WQOv+v
        C6noFYcs+um1HWk8ldAs8AuK+gaQY9gQ+6qJGXCNbdh2R/+qqVT9KKAkP88yFyLt
        KBhVmA6si5C4XDzTngKerQuwxn6qYRxz5M/04tJQUqXmpBAXG89FEDoeRqNcUnkL
        ZJwQMKRDwwsyalfD6nP7K06F14Jx19KlUnWE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G4NbCqZsNwxHAqmVv70rOSopVTlfKz5g
        D3HJmxzpvoh4URmn0Tw7MQHnM4aHSalepohUF9b4w2SAtRtnUF5Yiv39wecxsJiy
        PbZyINDiBJsY2Z2ZiDFm5mmy34x7pniQSquTS6PuNwl8aRHp4Zs6eZ17L+WIJrmT
        WKpilUqRtw4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E00D2101089;
        Tue, 13 Oct 2020 15:07:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 213E8101088;
        Tue, 13 Oct 2020 15:07:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t5500.43: make the check a bit more robust
References: <pull.753.git.1602600323973.gitgitgadget@gmail.com>
        <20201013185515.GA2994107@coredump.intra.peff.net>
Date:   Tue, 13 Oct 2020 12:07:08 -0700
In-Reply-To: <20201013185515.GA2994107@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 13 Oct 2020 14:55:15 -0400")
Message-ID: <xmqqtuuyj677.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B63FC8C-0D87-11EB-8A85-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>>     Work around flakiness in t5500.43
>>     
>>     It seems that this test became flaky only recently, although I have to
>>     admit that I have no idea why: the involved code does not seem to have
>>     changed recently at all. It should have been fixed by 
>>     https://lore.kernel.org/git/20200506220741.71021-1-jonathantanmy@google.com/
>>     , but apparently wasn't completely fixed, despite what I said in that
>>     thread.
>
> I think this is a real bug, and we shouldn't be changing the tests to
> accommodate. Users may actually see the broken lines, and our tests are
> telling us that.

True; I reacted too hastily.  Will not queue the workaround ;-)

