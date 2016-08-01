Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF44F1F855
	for <e@80x24.org>; Mon,  1 Aug 2016 21:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbcHAVKZ (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 17:10:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58274 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752839AbcHAVKW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2016 17:10:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 88AA73263E;
	Mon,  1 Aug 2016 17:04:47 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9JilANMffczn
	oxsC2ear9LOa3uc=; b=Ty500aUa0MIprwqSWZIr87FL9g5mNExbV6bsc+Oxkuyu
	o4qNDgWLAbHmgPIS1y0fVTDv+F9s4YQ6RpiHTR+49uxefELUXNl10V342jgpDvAC
	CPSDfQAdqwnPYNw9ibq/jr0dApulUM/Cv9jK9eevx/sg2vHEkF25d3ffQFTYxPI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jIILXh
	TcYhTXZJC8no7FJEScQkHTfj8yF9BjnyReJNU/86A0uknEr/n913HbX7U9kpF9qq
	XuSNfADHtjLVVxvhLlWX/aRAgXd8QKa+wgWtXBeKR1Agg10knsgr3tlJv0cUHe87
	gLRVzw6ZSr/a9zsMiLNRBQzNVVm87GZQUudQY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 81D103263D;
	Mon,  1 Aug 2016 17:04:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0BAD73263B;
	Mon,  1 Aug 2016 17:04:46 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Torstem =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	"e\@80x24.org" <e@80x24.org>
Subject: Re: [PATCH] t7063: work around FreeBSD's lazy mtime update feature
References: <20160718223038.GA66056@plume>
	<20160730182005.14426-1-pclouds@gmail.com>
	<6955746D-E47E-4BB8-AB0E-44D461E67AD6@web.de>
	<CACsJy8D=dZeE1tLFRaCefkkNX8dHQfTL134Nv--5=BXvnUm1ZQ@mail.gmail.com>
Date:	Mon, 01 Aug 2016 14:04:44 -0700
In-Reply-To: <CACsJy8D=dZeE1tLFRaCefkkNX8dHQfTL134Nv--5=BXvnUm1ZQ@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 1 Aug 2016 19:10:28 +0200")
Message-ID: <xmqq4m74i4k3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 93F622C4-582B-11E6-90C1-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Aug 1, 2016 at 3:37 AM, Torstem Bögershausen <tboegi@web.de> wrote:
>> the term FREEBSD may be too generic to point out a single feature
>> in an OS distributution.
>> Following your investigations, it may even be possible that
>> other systems adapt this "feature"?
>>
>> How about
>> LAZY_DIR_MTIME_UPDATE
>> (or similar)
>
> This feature was added in 1998, so yes there's a chance it has spread
> to a few fbsd derivatives (not sure if openbsd or netbsd is close
> enough and they ever exchange changes). But I'd rather wait for the
> second OS to expose the same feature before renaming it.

I think a name based on the observed behaviour ("feature") would be
more appropriate because I'd be more worried about us finding other
glitches we see (initially) only on FBSD.  People who need to adjust
tests that use the same FBSD prereq would have to wonder which
prereq-skip is due to which glitch.
