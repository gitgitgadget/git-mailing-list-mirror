Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FF192070C
	for <e@80x24.org>; Wed,  6 Jul 2016 19:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbcGFTP0 (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 15:15:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52817 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932150AbcGFTPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 15:15:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6881329C05;
	Wed,  6 Jul 2016 15:15:24 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mVqI1I66PBvilw1qS9WzVtvFDxc=; b=JLE1qr
	YMaeSDZ72uW9/z18KDP3UmrKHMkOt9yW+sBH680GQHOGqK1jZJCRa49IoR9eBwmV
	AwLsd4w06otpES+JxxhoXGL/FWd+NEtj+UepdI9T3CoMVBInLV/YBAOJYcnQylpN
	t3ArIc81CHkFzM/YmV+YmluroPHl+DM474kUc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bc6bob70MRvYWoy9uGv9mZDEnpx+0BOp
	J1MPjfXadgcFMzH4bLxBUA1Dnm7CAiBs4KUx6HVQVdPjNBejxcmwlqXXXteXsLaI
	jlr9BP9dcZJjHjMwYhNNRCZEV6fwToXZAtK9tLzPtJJ50LdVuHxAqAVp6BgsOyz0
	QKPYa85l5y0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5ED6029C04;
	Wed,  6 Jul 2016 15:15:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DCA8D29C03;
	Wed,  6 Jul 2016 15:15:23 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Armin Kunaschik <megabreit@googlemail.com>
Cc:	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] t7610 test for mktemp existence
References: <57780F9F.3050802@googlemail.com>
	<xmqqr3b6sk08.fsf@gitster.mtv.corp.google.com>
Date:	Wed, 06 Jul 2016 12:15:21 -0700
In-Reply-To: <xmqqr3b6sk08.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 06 Jul 2016 11:23:51 -0700")
Message-ID: <xmqqinwishme.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD4844E2-43AD-11E6-AB2D-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> -test_expect_success 'temporary filenames are used with mergetool.writeToTemp' '
>> +test_lazy_prereq MKTEMP '
>> +	tempdir=$(mktemp -d -t foo.XXX) &&
>> +	test -d "$tempdir"
>> +'
>
> This makes me wonder what would happen to the leftover directory,
> though.  Would it be a better idea to clean it up as well, i.e.
>
> 	tempdir=$(mktemp -d -t foo.XXXXXX) &&
> 	test -d "$tempdir" &&
>         rmdir "$tempdir"

It turns out that this is not necessary since day one of
lazy_prereq.  I forgot what I wrote in 04083f27 (test: allow
prerequisite to be evaluated lazily, 2012-07-26).

Thanks.
