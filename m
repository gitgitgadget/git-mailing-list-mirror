Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 439462018B
	for <e@80x24.org>; Mon, 18 Jul 2016 17:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbcGRRTO (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 13:19:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55579 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751370AbcGRRTN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 13:19:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 949432CA20;
	Mon, 18 Jul 2016 13:19:11 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e0Tdfo/sYAlfTbEAiqZDH8xf714=; b=KKnta/
	QIzt77U51FK6rNALtD1KrdoKsfJ8XnFMmofZPnvoSpesSwdLRr/yeLPdzXj9uGdl
	XFfZEgq7eq173DTjVVO6VowarayJ9crh6H+pENlkXaD0foVovOtM65VeSL6E3ByM
	Nq59GjRzvggpPZ/+ZpMUTK1Dr3lTIIcGBWZZI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rQW6hMW57pvEuPSvwNc3RV2pK1BHIkoK
	DsxffCYSMGWoR6YgDol+7oScd+NdWkAy8cHGlR6TArQG1joXNCiZhaIS2RcKeqs+
	NLk7A+zsN7HUG5KW9WrAGYsaTLkgUvUWPl7rpbCGtPbET++e6MpxN64lV+AhyB2B
	LQjoqrP1kMo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C1F32CA1F;
	Mon, 18 Jul 2016 13:19:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0E9E52CA1D;
	Mon, 18 Jul 2016 13:19:11 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Eric Wong <e@80x24.org>, norm@dad.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, l.s.r@web.de,
	git@vger.kernel.org
Subject: Re: [PATCH] pager: disable color when pager is "more"
References: <201607171726.u6HHQShO005227@shell1.rawbw.com>
	<alpine.DEB.2.20.1607180922580.28832@virtualbox>
	<20160718091907.GA13588@starla>
	<20160718131653.GC19751@sigill.intra.peff.net>
Date:	Mon, 18 Jul 2016 10:19:09 -0700
In-Reply-To: <20160718131653.GC19751@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 18 Jul 2016 07:16:53 -0600")
Message-ID: <xmqq8twylv8y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE238B70-4D0B-11E6-8A20-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jul 18, 2016 at 09:19:07AM +0000, Eric Wong wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> > On Sun, 17 Jul 2016, norm@dad.org wrote:
>> > > 'git diff' outputs escape characters which clutter my terminal. Yes, I
>> > > can sed them out, but then why are they there?
>> > 
>> > Those are most likely the ANSI sequences to add color. Can you call Git
>> > with the --no-color option and see whether the escape characters go away?
>> 
>> Norm: do you have PAGER=more set by any chance?
>> Perhaps changing it to "less" will allow you to preserve colors.
>> 
>> I saw a similar or identical problem during my vacation in
>> FreeBSD-land.  Perhaps the out-of-the-box experience can be
>> improved:
>> 
>> -----8<-----
>> Subject: [PATCH] pager: disable color when pager is "more"
>
> This is the tip of a smaller iceberg. See
>
>   http://public-inbox.org/git/52D87A79.6060600%40rawbw.com/t/#u
>
> for more discussion, and some patches that fix more cases (like "LESS"
> without "R", or "more" that _does_ understand "R"). I think it was
> discarded as being a little too intimate with the details of pagers, but
> it does suck that the out-of-the-box experience on FreeBSD is not good.
> Maybe we should revisit it.

Yup, the three-patch series at

    http://public-inbox.org/git/20140117041430.GB19551%40sigill.intra.peff.net/

would be a safe starting point that is low-impact.  I think what
ended up being discarded was a more elaborate side topic that
started from exploring the possibility of checking if LESS has 'R'
in it to see if it is possible to help people with LESS that does
not allow coloring explicitly exported.

I do not think the approach in the same thread suggested by Kyle

  http://public-inbox.org/git/62DB6DEF-8B39-4481-BA06-245BF45233E5%40gmail.com/

is too bad, either.
