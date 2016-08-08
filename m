Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B9312018E
	for <e@80x24.org>; Mon,  8 Aug 2016 22:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbcHHWgq (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 18:36:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50076 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751036AbcHHWgp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 18:36:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6144134145;
	Mon,  8 Aug 2016 18:36:44 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n3b95+EaA23f5DwiWBWfy2Hrn18=; b=eLa23J
	YtXDlLl6hnQpKsEQ9vnM0TH3m8uyOOPm2vQFXW3BPCVnV7spsO1tTaI9FwMn231/
	xRozRTFnVFESNwlG71NdmlbOUEp6MeziW3xvRSKiwXOXmMglFKvagHXB2S4B0yv7
	GIt7G+NnJ0frKeaaCUbFRJPoAMfT1MDtecqqc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BjdvQZVfTiJtnMBGTSI4wjJ16T40Xeqd
	63oAB5OXvyWItSofPHd/7nAJQHHm4/yS9ki/4pyoLMZExs0rwhaPaKhmhjf6NYEU
	T3Ae9r4ucqmQV6guG9XiX590x+k7SIcTKPH7/K5vgfcHpU7PbFMqew+rmhuy2jEd
	f8RxL7bWkAw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 584A634144;
	Mon,  8 Aug 2016 18:36:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CF67F34141;
	Mon,  8 Aug 2016 18:36:43 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Na?= =?utf-8?Q?r=C4=99bski?= <jnareb@gmail.com>,
	Richard Ipsum <richard.ipsum@codethink.co.uk>,
	Eric Wong <e@80x24.org>, Josh Triplett <josh@joshtriplett.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16] merge_recursive: abort properly upon errors
References: <cover.1469547160.git.johannes.schindelin@gmx.de>
	<cover.1470051326.git.johannes.schindelin@gmx.de>
	<8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de>
	<xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1608021004080.79248@virtualbox>
	<xmqqy44ec15p.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1608031021050.79248@virtualbox>
	<CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
	<alpine.DEB.2.20.1608031753431.107993@virtualbox>
	<CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
	<alpine.DEB.2.20.1608041730130.5786@virtualbox>
	<6c937f79-2b82-619d-51fe-adccbe09bd66@alum.mit.edu>
Date:	Mon, 08 Aug 2016 15:36:41 -0700
In-Reply-To: <6c937f79-2b82-619d-51fe-adccbe09bd66@alum.mit.edu> (Michael
	Haggerty's message of "Tue, 9 Aug 2016 00:20:22 +0200")
Message-ID: <xmqqshuedh1i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9529BF2E-5DB8-11E6-A57C-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Is it *really* so insane to consider moving collaboration on the Git
> project to GitHub or some other similar platform?

I only know how "pull requests" and "issues" discussion in GitHub
Web interface _currently_ looks like, so if you have even more
wonderful thing in the works, I _might_ be swayed otherwise, but I
do not think it is sane to expect that the same quality and quantity
of reviews as we do here can be maintained with that thing.
