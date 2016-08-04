Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F348820193
	for <e@80x24.org>; Thu,  4 Aug 2016 16:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbcHDQGB (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 12:06:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60809 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964981AbcHDQGA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 12:06:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5402930F36;
	Thu,  4 Aug 2016 12:05:59 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2UtmctPfT9OHURxFoLrOHzZ+0LA=; b=k8+OJ9
	L3LNp461LNlJvezGY+hUrcQ3xu9iVRu9il+FQkqE9nG+EtPYMgc2pj05Ft/RnWG3
	UjkSvVo+Rip+LWmI9tG4A2r6j998jzRcUzSUs/qZf3ErO5CJ21NH+0N5wdLStBt9
	i+pmTbXxiDb/Goayo3KwPV2UuXE3fZIjaVtQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uAnHWFoT+BHv4Vf7h2ELfe7H2wRmU907
	Kef+UstJNKd0xrC/bOpdgKAkPOJb4fSlpZPFopp1jCuDRo6101/jbnmUxSs3uKbn
	f8qThaYKEtIKxfJOd+hxtXCy5PXK9RUxny1UuL8ptX4HaqXlm+CFQ2AMKNFLeIPV
	8AEumXm2loQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B0A130F35;
	Thu,  4 Aug 2016 12:05:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B593A30F34;
	Thu,  4 Aug 2016 12:05:58 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Michael Haggerty <mhagger@alum.mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC/PATCH] rebase--interactive: Add "sign" command
References: <20160803084743.3299-1-judge.packham@gmail.com>
	<alpine.DEB.2.20.1608031621590.107993@virtualbox>
	<xmqqr3a5al7z.fsf@gitster.mtv.corp.google.com>
	<20160803180820.2raazmsfjavoaogo@sigill.intra.peff.net>
Date:	Thu, 04 Aug 2016 09:05:56 -0700
In-Reply-To: <20160803180820.2raazmsfjavoaogo@sigill.intra.peff.net> (Jeff
	King's message of "Wed, 3 Aug 2016 14:08:20 -0400")
Message-ID: <xmqqinvg5xjv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5522AE4E-5A5D-11E6-B674-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Aug 03, 2016 at 09:08:48AM -0700, Junio C Hamano wrote:
>
>> > However, I could imagine that we actually want this to be more extensible.
>> > After all, all you are doing is to introduce a new rebase -i command that
>> > does nothing else than shelling out to a command.
>> 
>> Yup, I tend to agree.
>> 
>> Adding "sign" feature (i.e. make it pass -S to "commit [--amend]")
>> may be a good thing, but adding "sign" command to do so is not a
>> great design.
>
> I'm not sure what you mean by "feature" here, but it reminded me of
> Michael's proposal to allow options to todo lines:
>
>   http://public-inbox.org/git/530DA00E.4090402@alum.mit.edu/
>
> which would allow:
>
>   pick -S 1234abcd
>
> If that's what you meant, I think it is a good idea. :)

Yes, by "feature" I meant "giving the ability to decide if the
resulting commit gets signature", which can and should be orthogonal
to the choice of using editor to reword the message when the commit
is created or "--no-edit" is passed and the original message is used
verbatim.
