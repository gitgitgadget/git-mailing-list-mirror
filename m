Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 765191F855
	for <e@80x24.org>; Mon,  1 Aug 2016 17:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754530AbcHARE7 (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 13:04:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52817 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754304AbcHAREv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2016 13:04:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1AA3C32D2F;
	Mon,  1 Aug 2016 12:49:39 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=P31Ptc+ZjeI7
	ZcB7pxDsMujnU5Y=; b=rr8Viab6/EV1j6iWazgg8ATgO5Zp81DZ8KjcvvkC3PN/
	sQXFDWaAbUe3eAVPltH7fdVtIzyN3jpr2iuHigOuCrDRdXio0bjsArlRHYyZqIec
	wbbXVOqrpPBhQFVvAYreyAY7qV3qWmH4MAD+D0aqvWRAEHBCKrn4XzqEAOL03o8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wnCNnP
	eBVbHWBXIXW2dQFH+aOXEQfAWhv+uByaerwsoCpj+QmPgwAz52K7keYGe7/wVAO1
	u3fSPyYZufQkVkjvmvOSm1tF4CZoyNlOC6hCmbN34A9osBw8LYKGxplzypXZcFot
	7Kg5VShDH56KXuR7pxAq1il2xEbYDMsBlL8dQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 05C3F32D2E;
	Mon,  1 Aug 2016 12:49:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7154532D2C;
	Mon,  1 Aug 2016 12:49:38 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:	Oleg Taranenko <olegtaranenko@gmail.com>, git@vger.kernel.org
Subject: Re: git bisect for reachable commits only
References: <CABEd3j8VLbpeWbA6BfHYp5aLPEy0PesqYoHM9u4OM=b7Qm=LDg@mail.gmail.com>
	<xmqqinvonwxc.fsf@gitster.mtv.corp.google.com>
	<CABEd3j-MW--YSC9=nwcgHzxd6cqmUY+ky3-wLxMiMmbBGsvS7Q@mail.gmail.com>
	<2bfd9cf5-a9fa-7650-21e9-9ceb9cc34d8b@gmail.com>
Date:	Mon, 01 Aug 2016 09:49:36 -0700
In-Reply-To: <2bfd9cf5-a9fa-7650-21e9-9ceb9cc34d8b@gmail.com> ("Jakub
	=?utf-8?Q?Nar=C4=99bski=22's?= message of "Sun, 31 Jul 2016 11:26:00
 +0200")
Message-ID: <xmqqoa5cl9i7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EF555DC0-5807-11E6-A511-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jakub Narębski <jnareb@gmail.com> writes:

> Isn't `--reachable-commits` the same as existing `--ancestry-path`
> option to `git log` and friends (I wonder if passing log options to
> bisect, that is: `git bisect --ancestry-path ...` would work)?

Yes, I somehow missed it, but you are absolutely correct to point
out that what is being requested is --ancestry-path.

My gut feeling is that by default the command should be taught to
follow the ancestry path, but I say this with reservation, as I am
not sure offhand what it means to traverse along the ancestry path
when there are multiple good commits.

Thanks.
