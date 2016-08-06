Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A45F1F859
	for <e@80x24.org>; Sat,  6 Aug 2016 20:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbcHFUOx (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 16:14:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57664 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751321AbcHFUOw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 16:14:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E5C42FD38;
	Sat,  6 Aug 2016 12:37:47 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fhz82MatNI5YYhRjzGFp0WE19eU=; b=gr0ijN
	21mg6MgbNY2YTIq2Y3xkM3up9Jkpogotx/eXOQbcSe06Xp+cj71WfVlqC45CAvt/
	+EQsUDlOjQ6MDqrtO7tZLr+2RvjKDkYY+5grIWtsO40eEDgFvK3kqV1N5r0csaMP
	iMeFHWv2NTMx2DKcoMgc3uVrtpQETP1ckr+Zs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gKWG5IpcLsXiop8PbtxcCszFGM/NJF00
	YZoYFYGfbK9pKVi1Fh3yulRBsn8nm2w/Iib6fL0gA1Yazst7CxRyHOsA25BtGLNd
	pKs0CWyr2ZTkPu72Q8EJJB3yCsjhcjBCVqnmd8nJ2S6P6pVpb1z1zdJSisNICQYL
	eBQ1pkGNFds=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 16E7B2FD37;
	Sat,  6 Aug 2016 12:37:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 926B12FD36;
	Sat,  6 Aug 2016 12:37:46 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v6 16/16] merge-recursive: flush output buffer even when erroring out
References: <cover.1469547160.git.johannes.schindelin@gmx.de>
	<cover.1470051326.git.johannes.schindelin@gmx.de>
	<3b4494c586574b59d80d0f1b88bd4c3d56b678cf.1470051326.git.johannes.schindelin@gmx.de>
	<xmqq7fbw4cqo.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1608051739170.5786@virtualbox>
Date:	Sat, 06 Aug 2016 09:37:44 -0700
In-Reply-To: <alpine.DEB.2.20.1608051739170.5786@virtualbox> (Johannes
	Schindelin's message of "Fri, 5 Aug 2016 17:41:44 +0200 (CEST)")
Message-ID: <xmqq4m6xkg4n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B18DC08-5BF4-11E6-A1C8-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 4 Aug 2016, Junio C Hamano wrote:
>
>> OK.  Even though I really wanted to see somebody else review this
>> series as well, I finished reading it through one more time before
>> that happened, which is unfortunate because I think this is ready to
>> start cooking in 'next' even though I no longer have much faith in
>> my eyes alone after staring at this series so many times---you start
>> missing details.
>
> Yeah, well, it is a rather crucial piece of the code.
> ...
> Thank you so much for your patient reviews!

Thanks for working on this to you, too ;-)
