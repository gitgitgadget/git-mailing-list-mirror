Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39630202A0
	for <e@80x24.org>; Fri, 17 Nov 2017 01:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754369AbdKQBG6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 20:06:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52674 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754360AbdKQBG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 20:06:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 57CB39E1A4;
        Thu, 16 Nov 2017 20:06:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Mi9qk/CsiOz0RM7pOWOPYz3JVcI=; b=UF4yZZ
        FcPGpgq3JoD9jIQsu/8JsQ7u0fc9fXoo80kmxpxEIWiu4hTZIjMIDmQ4R9qtt8/t
        0+cMeXGPPrU7u1a1vJxLmUEKSySsWBUapXfWEdLOZY8ogWtOfOpyLU5s8ikQtta4
        /IgYAmuwmdIq1ZtrlTuZyOdU+/lhuMjsS2up8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZS+YExsYd455I4u5lCBffPOWVqV9OZdN
        7AI4apBo/qEnkzuAYehz+fh/DhDSZElOtgPDvGJ+Ke4pAsz34VsJ36pSiplZQ6i4
        sOHmoep5NJqCj7wEgr4kSvo/2uQEBut4W7wkkCgASQQsbMtafHCtuP74IfTA69Jm
        CLzDrKq+nyY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 507F39E1A1;
        Thu, 16 Nov 2017 20:06:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C461F9E19F;
        Thu, 16 Nov 2017 20:06:54 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCHv4 7/7] builtin/describe.c: describe a blob
References: <20171115003043.24080-1-sbeller@google.com>
        <20171115003043.24080-8-sbeller@google.com>
        <20171114175207.f23d492045d52b8aa16c00be@google.com>
        <CAGZ79kaum5py=14kdFy1a+K_0MzfaD5boYStixh=1aY2tUCV-Q@mail.gmail.com>
        <xmqq7eurxak0.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kY109yTQESzVg69nsibucAhvP0m+vKUH21xB9m7WTGaFg@mail.gmail.com>
        <xmqq375fx9ly.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 17 Nov 2017 10:06:53 +0900
In-Reply-To: <xmqq375fx9ly.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 16 Nov 2017 11:04:09 +0900")
Message-ID: <xmqqd14hvhle.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A284236-CB33-11E7-9F70-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>>     grep "fatal: test-blob-1 is neither a commit nor blob" actual
>
> OK, that might be somewhat unsatisfying from end-user's point of
> view (logically "test-blob-1" is already a name based on the 'graph
> relations' that is satisfactory).

... but that is correct and I think we need any further updates to
address it.  If a user starts with a tag object, the user already
has one usable human-readable name.  By "unsatisfying", I didn't
mean that it is something we need to spend more cycles.

