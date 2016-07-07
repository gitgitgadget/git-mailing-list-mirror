Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFE6620705
	for <e@80x24.org>; Thu,  7 Jul 2016 21:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707AbcGGVxh (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 17:53:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50011 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751980AbcGGVxg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 17:53:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D83FD2AFB5;
	Thu,  7 Jul 2016 17:53:34 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pzwle+FqHTrdAKy91JjvzbUGmIw=; b=U5jWsz
	fp+geZoNjRe/luMo3lI79P0zYebdEqK9fYPypfLAHsw8l/mmhJGrP0WhSIUnbWDV
	4NZgt1UTIstmlR4fKMcX+ef9DpnRnplv6ml+sZDCN15QE/s+ff+X9uCKvkerc6xP
	weZmoWmhQH6OhZHPcGzqqTm5xr/ZWUj5Usvto=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uaD6cDBA9CiyIzsLnK/nuIfbKM2F13wT
	dB8NRjSag844cb59izlMzgehtAJOCm+KMeqIcQE5wX6QapPlLoABY2BpLOAUQ7of
	qn1FxfD27EDqAk6bEgYHij1cyXOQttgktRJavVyI8gutwSuhssIj38zd3+6L+G5j
	JRQu1davDIg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CD6022AFB4;
	Thu,  7 Jul 2016 17:53:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 562A32AFB2;
	Thu,  7 Jul 2016 17:53:34 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
	Dan Wang <dwwang@google.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 1/4] push options: {pre,post}-receive hook learns about push options
References: <20160707011218.3690-1-sbeller@google.com>
	<20160707011218.3690-2-sbeller@google.com>
	<xmqqeg75p5cn.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kb_oHZUv1=8Q0FSV8yVP5PrwStchXAyhZF=mHhv91APHQ@mail.gmail.com>
Date:	Thu, 07 Jul 2016 14:53:32 -0700
In-Reply-To: <CAGZ79kb_oHZUv1=8Q0FSV8yVP5PrwStchXAyhZF=mHhv91APHQ@mail.gmail.com>
	(Stefan Beller's message of "Thu, 7 Jul 2016 14:50:55 -0700")
Message-ID: <xmqqlh1dnmhv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4071D654-448D-11E6-BA9F-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> But your first patch (2/4) would not yet advertise the capability?
> Or advertise and then just ignoring it?

As I wrote...

>> If I were doing this series, I
>> would probably have done 2/4 first without plumbing it through
>> (i.e. it is sent and accumulated in a string list at the receiver,
>> and then cleared and freed without being used), and then added the
>> processing (i.e. this step) as the second patch.

... I would imagine it would advertise, allow the other side to send,
receive and collect, and then discard (properly) without using.

> It is better for documentation purposes in this patch though. It makes
> the other patch harder as "it allows transmitting push options, but
> in that patch nothing of value is done with them."
>
> So I'll see if I can reorder easily.

It does not matter too much. Let's not spend too much time on the
ordering.
