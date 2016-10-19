Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 848F420988
	for <e@80x24.org>; Wed, 19 Oct 2016 02:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933943AbcJSCFw (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 22:05:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61816 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932201AbcJSCFu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 22:05:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B1E547848;
        Tue, 18 Oct 2016 22:05:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nvU6hU0bNAek+PXcqARTCdzmeuQ=; b=w1KLdq
        ATlQ4ygDpQpvDhFi8iBR5lkXOEJ36WpFixZ5J2UxRxf5VHZ9MTwo3tUjH0HHJUTT
        bIoYP4BkgpPPirFvYFxQ4/fSaSRgsYWUtXMSZFevieyuLGa3OXUrRX8VfZxDrsrB
        HRkoa1QAMO2l6L0FpKOK/BflDFqlePaqk7k00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rFdGsHTRZHd+LiyDmhdmX+yWHnKi1PFf
        thv2YpvlRyyjcGql7QJhDjgLXg5koxUdq2V50T0IrNUT65eESZh0yXGvqE9CK0mi
        w0rjYIfMtewMQekM03UnCI3cwf3lWVvFXFbGRZmmpAAyeSjj9o6RMRPEr1CiDzYz
        I+fuqo4sqys=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6152047847;
        Tue, 18 Oct 2016 22:05:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D423E47844;
        Tue, 18 Oct 2016 22:05:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "Karl A." <venv21@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3] submodule--helper: normalize funny urls
References: <20161018210623.32696-1-sbeller@google.com>
        <xmqqzim1nyz0.fsf@gitster.mtv.corp.google.com>
        <xmqqshrtnynj.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZHLVpxbJ_C-dM2LDA64-_TJNyY+52fTWkOvLvvAq2XDg@mail.gmail.com>
        <xmqq60opnolz.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYrKGLEOO72aWuX5OOM-AecdFZFXRqBkRzhdAM-VbPFxA@mail.gmail.com>
Date:   Tue, 18 Oct 2016 19:05:46 -0700
In-Reply-To: <CAGZ79kYrKGLEOO72aWuX5OOM-AecdFZFXRqBkRzhdAM-VbPFxA@mail.gmail.com>
        (Stefan Beller's message of "Tue, 18 Oct 2016 18:04:09 -0700")
Message-ID: <xmqqwph5m6th.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8DE8020A-95A0-11E6-B8A3-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> I am not sure.  Certainly we would want to make sure that the normal
>> case (i.e. no funny trailing junk) to work correctly, but we do want
>> to protect the fix from future breakage as well, no?
>
> Exactly. So not intermediate "root" that we clone from, but adapting the
> relative URLs. Maybe half the broken tests can switch to 'root' and the others
> go with the current behavior of cloning . to super.
>>
>> Perhaps we can do a preliminary step to update tests to primarily
>> check the cases that do not involve URL with trailing "/." by either
>> doing that double clone, or more preferrably, clone from "$(pwd)"
>> and adjust the incorrect submodule reference that have been relying
>> on the buggy behaviour.  With that "root" trick, the test would pass
>> with or without the fix under discussion, right?
>
> I assume so, (not tested).

OK.  Thanks for sticking with it.
