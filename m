From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve QNX support in GIT
Date: Sun, 24 Feb 2013 23:14:40 -0800
Message-ID: <7vtxp0zwyn.fsf@alter.siamese.dyndns.org>
References: <CAHXAxrMRxKKiEarSQ0fCLt6-zyS=52B+kmZMLDf8SQAGzGbjjQ@mail.gmail.com>
 <CAHXAxrMgJf2C3dAe1O2DW5qFYFnCDhbQNmpnvK4ZOduJnqwQWg@mail.gmail.com>
 <7vvc9i5cbw.fsf@alter.siamese.dyndns.org>
 <CAHXAxrO_AeLoHw6TaVkDZsS=J6Ro+qEuMs4rbyCoFuHAGT+6vg@mail.gmail.com>
 <7vvc9h4d7c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Gorchak <mike.gorchak.qnx@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 08:15:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9sHM-0001Jf-6Z
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 08:15:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754959Ab3BYHOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 02:14:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53030 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755436Ab3BYHOu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 02:14:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE056A48C;
	Mon, 25 Feb 2013 02:14:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i3PmfCfkImH8ULITHzCvOcy4b5U=; b=npt1ji
	v6BZCLgvq90NqBteB7QPsq7lN2Td0aNguBMHIR7MIe1kG3fxStJO6epoUDJak9z9
	xYA5NBgKFDsCCiwClw3p694dQLwfkEheVjJzPYog2o0zUHBn2/9cKckT8vF9WWHv
	TNHDfn25bJTTC+mvyPCFoTzwnu3fZzSpNovOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V36D9NKOW10rVaDlCpA/6OWmcW6P0BDe
	fLGDyt2I4aBkonG724ABSbH9PB94LOagTABIftiUPNK17OOxdFiutB5SkqzRBO3x
	JzxiSVWNlK+FFqYx63bdpvrk52Ts8Oz6kehGwbK0274riLBAm9IB8KE72pfXbI0l
	SFvI5wwAchM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EEAEA487;
	Mon, 25 Feb 2013 02:14:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EF0ACA482; Mon, 25 Feb 2013
 02:14:41 -0500 (EST)
In-Reply-To: <7vvc9h4d7c.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 24 Feb 2013 13:24:55 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 063A523A-7F1B-11E2-910F-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217045>

Junio C Hamano <gitster@pobox.com> writes:

> Mike Gorchak <mike.gorchak.qnx@gmail.com> writes:
>
>> CFLAGS="-I/usr/qnxVVV/include" LDFLAGS="-I/usr/qnxVVV/lib" ./configure
>> --prefix=/usr
>
> Oh, I didn't notice that, but the definition of ALL_CFLAGS may be
> what is wrong.  It allows CFLAGS to come before BASIC_CFLAGS that
> adds -Icompat/, which goes against the whole point of having
> replacement headers in compat/ directory.

Also, in general, as the end-user input, we would want to make it
take the precedence, so that CFLAGS can be used to override the
default command line; e.g. we may have -DMACRO=value on BASIC_CFLAGS
or others on ALL_CFLAGS, and let the users who know what they are
doing use CFLAGS=-DMACRO=anothervalue to override it.

Swapping the order between CFLAGS and BASIC_CFLAGS in ALL_CFLAGS may
be a good change for that reason as well.

In any case, I won't take a patch to rename source files left and
right only to work around name collisions with random system header
files we do not even use ourselves, unless/until I know we have
tried all the other saner approaches first.  That's a workaround,
not a solution.
