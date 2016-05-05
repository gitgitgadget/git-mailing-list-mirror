From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/15] diff: ignore submodules excluded by groups
Date: Thu, 05 May 2016 16:07:24 -0700
Message-ID: <xmqqfutw85oz.fsf@gitster.mtv.corp.google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
	<1461703833-10350-12-git-send-email-sbeller@google.com>
	<xmqqlh3wxnuq.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaOXxqDEqVnf5K3QjXg5bfmKW2XkmPT-mqJ93+RF5N40g@mail.gmail.com>
	<CAGZ79ka37jWYDJrAWy5KLhaaJmrLRbmTzRC6A5DneuE63+XCeQ@mail.gmail.com>
	<xmqqy47o9s1h.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYGbjOKPQk8A-ag+JgvybW4Kf5=g8azVAOoMq79oXc5-Q@mail.gmail.com>
	<xmqqfutw9mfs.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYKbef7DTkmE3Vf3C=PLfgB3xf0ikVKHFUfQ8+KkgGHPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Duy Nguyen <pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 06 01:07:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aySMp-0006ny-D4
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 01:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757193AbcEEXHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 19:07:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53660 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757173AbcEEXH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 19:07:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4925419258;
	Thu,  5 May 2016 19:07:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U8OgdVIUtK6ifUhY4qSTp1waweg=; b=rHPHps
	DJHK3n0aZSVo8S/JmiLRbvd+Lg9jK2l8ot8xbUcemmVoW9h+Re6uZLT4gixig0yU
	KhK9EZ1NQD5WJrMNhTfqgRhdE3ST/Jyrcq0kv8QjmvKh++7QLBjSSPDUnoijTbAL
	qDDVJcnRrcE8sdAF7i4WTRlB/TAumta8b5s4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M51m6gjpnCtc0y38rbWPqpRGUpA72Ti6
	XWyoU7N0kXszvV3SGkl0xdTChnnvIhtif7sq/EU2+k7Me//8hVWZZeXX39F20aBX
	KmPT3JJL1TAkdua1cGbt6M6zTNzRQaoyZGLFmhq9Lm0GJCi7rGxA3+AZROoreJi4
	Yin0YBVU1TM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4127819257;
	Thu,  5 May 2016 19:07:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ABD2819256;
	Thu,  5 May 2016 19:07:25 -0400 (EDT)
In-Reply-To: <CAGZ79kYKbef7DTkmE3Vf3C=PLfgB3xf0ikVKHFUfQ8+KkgGHPg@mail.gmail.com>
	(Stefan Beller's message of "Thu, 5 May 2016 15:50:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 21B5F23E-1316-11E6-8124-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293721>

Stefan Beller <sbeller@google.com> writes:

> I am aware that other operations such as a build system would be glad to
> have the contents of the submodules there. But those would not use a
> restrictive default group?

The set of submodules you "init" to the working tree are the ones
that are interesting to you.  So once the tree is populated, you do
not ever have to look at the "defaultGroup" configuration.  You just
need to look at the working tree.

But there is a chicken-and-egg problem.  What should happen after
the initial clone, or you switched to a different branch in the
superproject.

The concept of "default" would help by limiting these "checkout to
reflect my interest to my working tree" step.

So "if the user inititializes a submodule and we detect that it is
not in the default, add it to the default configuration" pretty much
feels like a tail wagging a dog arrangement to me.

Then there is another interesting issue: what should happen when the
project added a submodule when you decided what your "default" set
should be and wrote it in your configuration already.  I suspect
that an idea similar to "the elaborate thing proposed (by whom I no
longer rememvber) in the ancient days" I mentioned earlier might
leads us to a nice solution.  When you define a default group, you
remember what the set of available submodules were, and tie your
choice to that "available set".

E.g. there may be submodules A, B and C in .gitmodules, and you
chose to record a "default" that contains only A and B.  The exact
way you chose does not matter; it could have been using labels, or
you may have explicitly named it.  When you record, you remember
that the decision of using A and B was made when A, B and C were the
available submodules.  Next time when you see .gitmodules talks
about A, B and D but no longer C, then instead of using the previous
"default" choice blindly, you ask.  If the user says it still is the
right "default" to use A and B, then you _also_ remember the set.
So that when the user switches between the state of the project with
submodules A, B and C (original) and A, B and D (updated), the user
does not have to answer the same question twice.
