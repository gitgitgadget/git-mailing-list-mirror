Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CCCC48BE8
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 14:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF66B6157F
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 14:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhFOOsR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 10:48:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62790 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhFOOsR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 10:48:17 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F18B6CB58B;
        Tue, 15 Jun 2021 10:46:11 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=zyGTu12+PE0ps1OflD7gTrROydnCqIy1obxtDl
        Ro1Us=; b=Z8WFxJdZdRHpOjoZfITxqtwBoTXscMmxHbBiNH/jJbVsdsLteWocBl
        A6aOuItnY78+3FkvzTP11HGFomRDQvtqBt4mqgp7gEt2N+dq4i1Elhy8ynAQq9QA
        OdJ1OlenvBARqUVnP5cipXMXnK1RVLZGb/9HdVJOIUK2Sg12sx0ug=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA480CB58A;
        Tue, 15 Jun 2021 10:46:11 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=zyGTu12+PE0ps1OflD7gTrROydnCqIy1obxtDlRo1Us=; b=UPt4DcJWpVswHeAqDsTnbh4+EyTdviBu+aMtGC1n7xxtU+vPpAxo3TF/ww9+LM0NWNdw8sPOwzShJGP5oIKJuJ7RjVntoWJofRQ3zEmR3P/JeFnfdMudiRsmgBaUo2k3o3lZ08vBJBwqNfeMgdH1hB2cLagt2Toh7xmJynH0uwQ=
Received: from yoda.home (unknown [96.21.170.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6C829CB588;
        Tue, 15 Jun 2021 10:46:11 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 53AE52DA003C;
        Tue, 15 Jun 2021 10:46:10 -0400 (EDT)
Date:   Tue, 15 Jun 2021 10:46:10 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jiang Xin <worldhello.net@gmail.com>,
        =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/4] sideband: append suffix for message whose CR in
 next pktline
In-Reply-To: <xmqqh7hzwx9f.fsf@gitster.g>
Message-ID: <5098143-7947-3pr7-31o7-9396s4no82s@syhkavp.arg>
References: <87im2s5jjm.fsf@evledraar.gmail.com> <20210612050711.4057-4-worldhello.net@gmail.com> <xmqqim2hyuj1.fsf@gitster.g> <CANYiYbGtfgZepnfTWGjbmOh2bxa8tZ7bvgtVTo6qTQpCP9MPag@mail.gmail.com> <xmqqk0mwylhc.fsf@gitster.g>
 <CANYiYbG6bKwheThWz2ecHUTh7JFmTsi-F9FtYkcoS0az=f=m6Q@mail.gmail.com> <0pqq6s9-n238-95ss-nsqr-42o75sr933r@syhkavp.arg> <CANYiYbFsqj9j_UT9-mF+BSOAHU4=On+BUxCU4w6rXhhMaeo=zg@mail.gmail.com> <r8ss67nn-31s4-o429-828p-s787sr2481@syhkavp.arg>
 <xmqqh7hzwx9f.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 6D4A0C20-CDE8-11EB-BA82-FD8818BA3BAF-78420484!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 15 Jun 2021, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > On Tue, 15 Jun 2021, Jiang Xin wrote:
> >
> >> The issue this patch try to fix is like the following example:
> >> 
> >>     PKTLINE(\2 "<progress-1>" CR "<progress-2>")
> >>     PKTLINE(\2 CR "<message-3>" LF)
> >> 
> >> The message "<progress-2>" is displayed without a proper clear-to-eol
> >> suffix, because it's eol (CR) is in another pktline.
> >
> > I'd fix this issue with the following logic:
> >
> > bool pending_clear_to_eol;
> >
> > my_putchar(c) {
> > 	switch (c) {
> > 	case '\r':
> > 	case '\n':
> > 		pending_clear_to_eol = true;
> > 		break;
> > 	default:
> > 		if (pending_clear_to_eol) {
> > 			clear_to_eol();
> > 			pending_clear_to_eol = false;
> > 		}
> > 		break;
> > 	}
> > 	putchar(c);
> > }
> >
> > In other words, you clear the line after printing "remote:" but only if 
> > there is a non \n or \r coming next.
> 
> What puzzles me the most in this discussion is why we do this for
> LF.  I do understand why we need it for CR---the line we are going
> to show message on after emitting CR would be full of leftover
> letters we previously have written before emitting CR, so we'd show
> the message (to overwrite the initial part enough to show our own
> message) and then clear to the end with either ANSI sequence of
> sufficient number of whitespaces.  But line feed would take us to a
> fresh and blank line---there is nothing to clear, no?

Depends. Suppose the local process is doing the progress report with CR.

Then the remote sends a single line with LF.

You expects the remote line to be displayed over the local progress 
report and the local progress report to be resumed on the following 
line. Without the line clearing you might have leftover garbage on the 
remote message line.


Nicolas
