Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5AB41FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 21:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932993AbcHJVQP (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 17:16:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59207 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933028AbcHJVPk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 17:15:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AF13A33352;
	Wed, 10 Aug 2016 17:14:25 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QKiihS9OYTiK3ZTfhPtRjDPlmCs=; b=LW1dlw
	zBZ+pjqIZFFgERYHDjUYIT+LrKgnN3AAEqd+WRmBht2WXE6vreubr+rW/Dhwwrsl
	KfJFz9gRSuzIHgbLqRe5OyCSmVlZDiZBc7JOIjo96ZtZ3bl3mtEl8gIl79EjEQW1
	yNtETLmZinXs7TQ5jQ7TluM061WChs4ULTXR0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WEPsdv72u3vDHfJ7c4X/L0KeOPxw1OxU
	xdfLRF0XzePRc6KOI5Xwi8+jkhJCy/1MsttdkTJRUlY7fU2SLhe7IztKh90yGVI7
	C6P3i+vdkUi6SB9QlvNuYfOiBjoClAOcWthctUgolrl20EnaTBPaokDRolM2Mlf4
	fto+Ud4jLpg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A54FF33351;
	Wed, 10 Aug 2016 17:14:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2BB0833350;
	Wed, 10 Aug 2016 17:14:25 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Eric Wong <e@80x24.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Richard Ipsum <richard.ipsum@codethink.co.uk>,
	Lars Schneider <larsxschneider@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16] merge_recursive: abort properly upon errors
References: <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1608031021050.79248@virtualbox>
	<CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
	<alpine.DEB.2.20.1608031753431.107993@virtualbox>
	<CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
	<alpine.DEB.2.20.1608041730130.5786@virtualbox>
	<6c937f79-2b82-619d-51fe-adccbe09bd66@alum.mit.edu>
	<20160809182800.GA19044@dcvr> <20160810005548.gee6ontd33ck5vej@x>
	<CANQwDwcL0etdZiiroAStwtpYurYEhJ7vcM52BUGUXh_ey+P9Kw@mail.gmail.com>
	<20160810193057.s36wfcivlfm3xmh2@x>
Date:	Wed, 10 Aug 2016 14:14:22 -0700
In-Reply-To: <20160810193057.s36wfcivlfm3xmh2@x> (Josh Triplett's message of
	"Wed, 10 Aug 2016 09:30:58 -1000")
Message-ID: <xmqqd1lg498x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A4F4EA8-5F3F-11E6-A82E-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Josh Triplett <josh@joshtriplett.org> writes:

>> But submission is less important than review. And for review it is
>> usually better (except gigantic series) to have patch text for review
>> with the review.
>
> Agreed.  However, submission typically requires more work than review,
> because the patch text must remain applicable.  For review, as long as
> the email client you use to respond doesn't do something horrible like
> *re-wrap* the quoted patch text, the result will work as a review.

Yup.  That is why we say "please send patch inline; when asked to
send it as an attachment, please do so".
