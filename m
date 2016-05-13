From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug report: Duplicate CRLF rewrite warnings on commit
Date: Fri, 13 May 2016 12:46:57 -0700
Message-ID: <xmqq1t55agge.fsf@gitster.mtv.corp.google.com>
References: <20160513134953.GE2345@dinwoodie.org>
	<20160513181255.GA30700@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 13 21:47:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1J3D-0005kM-TY
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 21:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbcEMTrD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 15:47:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57151 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932165AbcEMTrB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 15:47:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 994F5177A7;
	Fri, 13 May 2016 15:47:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oSKC84IPALcIvHTpIti/x4cRXcw=; b=SiXiG0
	yoVrfZwN6UPZitbrXyT0hup6KSkKHeg6ueVHb726JkFMnFMPt3X6IXc3+Fr91njt
	kLw5dgMEv60K4EBz9hSF91Tz4/SEjVvOHUuXEt5JeUJNBIMrCbMfsiOfnRzyCj52
	BXVhMQbgW1kSQzYOuN+wv7J33Y+hJ/SBpJ3DE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xmyzDezbWzO101ATt/kvOGlCozf4BcwO
	YOVwfpttV3aRB+bqDdgJrUP9AUlNn9R2HsznDdkmaPKam27oRtzemT3ghoU0jK5Z
	+W+nUV8nPht3kvNqI/uWV5BakMJso8uQ27DHQH033RQlvT4XZi3qSfYMwFkCnB0E
	b7oPYuCT4kM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8EBC5177A6;
	Fri, 13 May 2016 15:47:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D9794177A5;
	Fri, 13 May 2016 15:46:59 -0400 (EDT)
In-Reply-To: <20160513181255.GA30700@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 13 May 2016 14:12:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7512AFAC-1943-11E6-94A4-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294561>

Jeff King <peff@peff.net> writes:

> On Fri, May 13, 2016 at 02:49:53PM +0100, Adam Dinwoodie wrote:
>
>> (Tangentially: what's the accepted practice for submitting failing test
>> scripts?  I've written a short test case to add to t0020 that shows this
>> bugged behaviour, but I've got the vague impression from past emails
>> that leading with the patch email adding the failing test case is not
>> the expected way to do things on this list...)
>
> We don't want commits that fail the test suite, since it makes bisection
> more difficult. But you can mark known bugs like:
>
>    test_expect_failure 'git-foo should output bar' '
> 	...
>    '
>
> I think it's OK to submit a patch like that. Hopefully somebody picks
> that up and combines it with their fix patch, but if not, then it at
> least documents the failure for later generations.

... but we do not want to overdo this.

An expect_failure helps when somebody is actually starting to work
on a breakage by setting a goal, but otherwise nobody would look at
them.  I do not think we know if 120+ instances of expect_failure in
t/ we already have are still all valid; some of them even might be
requesting a behaviour that we decided is a wrong expectation later.
