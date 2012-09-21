From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/test-lib.sh: do not trust $SHELL
Date: Fri, 21 Sep 2012 14:59:04 -0700
Message-ID: <7vlig33umv.fsf@alter.siamese.dyndns.org>
References: <505CCA55.6030609@gmail.com>
 <1348260766-25287-1-git-send-email-artagnon@gmail.com>
 <20120921205834.GC22977@sigill.intra.peff.net>
 <CALkWK0kRzN_yQZ1JqJogBs6Z1nLhofBijHzeWR5YfQYHOtpaBA@mail.gmail.com>
 <20120921211217.GA24134@sigill.intra.peff.net>
 <CALkWK0nLLEF7wnUhF0JUAZVP6GG3KHmuYSDZLPS7uGCZPfhV3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 23:59:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFBFm-0003wZ-NV
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 23:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758180Ab2IUV7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 17:59:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47005 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752207Ab2IUV7I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 17:59:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2ABA9F8A;
	Fri, 21 Sep 2012 17:59:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VhUZkEq0Vb+qMv0zfCTlE+2IWBQ=; b=J7fZwO
	sRzN+4oM/DSMARi6vECuM65lo6/Hn5uO8/wZwa4cDHiBSg18eyAzDBR4EU2xvCq9
	HlHfBflN6u+aNuERyaam0GRwPVI/cNTBpvrJUNDIQIsb9u1abNpRgR0omzNSBpGV
	CSjZR1tn9Wix857ID0FifuzO4LDruiCo6gwUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KEOV0/uz8emh1+FV1y/hTNKTB9wpFu2j
	8wD9XCbWskx1dMRuOxjdH0yRZVFm1HWuch51IbZ0To9LxbJaCg9sP6VrVFUxZBP0
	F3cnvra9NI4s9mYPbgTIx5kgjwzCUx6SrumgrN0KXyi3+Zg/Y9YbfZisrnKkoip2
	SmoGtxw3VKs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FD759F89;
	Fri, 21 Sep 2012 17:59:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1327A9F85; Fri, 21 Sep 2012
 17:59:05 -0400 (EDT)
In-Reply-To: <CALkWK0nLLEF7wnUhF0JUAZVP6GG3KHmuYSDZLPS7uGCZPfhV3w@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Sat, 22 Sep 2012 03:04:50 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 900AADAC-0437-11E2-ADFD-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206174>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Hi Peff,
>
> Jeff King wrote:
>> On Sat, Sep 22, 2012 at 02:37:38AM +0530, Ramkumar Ramachandra wrote:
>>
>>> > I don't think that is the right thing to do. The point of SHELL is to
>>> > point at a bourne-compatible shell. On some systems, the main reason to
>>> > set it is that /bin/sh is _broken_, and we are trying to avoid it.
>>>
>>> But you're only avoiding it in the --tee/ --va* codepath.  In the
>>> normal codepath, you're stuck with /bin/sh anyway.
>>
>> No, the #!-header is only information. When you run "make test" we
>> actually invoke the shell ourselves using $SHELL_PATH.
>
> My SHELL_PATH is not set, and I can see SHELL_PATH ?= $(SHELL) in the
> Makefile.  Which shell is it supposed to point to?

SHELL_PATH is always supposed to point to a Bourne that can be used
to run POSIXy shell scripts.  I think the fallback you pointed out
above assumes that the majority of people who type "make" use Bourne
compatibles as their $SHELL and the default is to help the majority.

It may not hurt to add a note to INSTALL for people who use $SHELL
that is not Bourne (csh and zsh users, but there may be others) that
they need to set SHELL_PATH, of course.
