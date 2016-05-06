From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/15] diff: ignore submodules excluded by groups
Date: Thu, 05 May 2016 23:08:53 -0700
Message-ID: <xmqqa8k37m6i.fsf@gitster.mtv.corp.google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
	<1461703833-10350-12-git-send-email-sbeller@google.com>
	<xmqqlh3wxnuq.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaOXxqDEqVnf5K3QjXg5bfmKW2XkmPT-mqJ93+RF5N40g@mail.gmail.com>
	<CAGZ79ka37jWYDJrAWy5KLhaaJmrLRbmTzRC6A5DneuE63+XCeQ@mail.gmail.com>
	<xmqqy47o9s1h.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYGbjOKPQk8A-ag+JgvybW4Kf5=g8azVAOoMq79oXc5-Q@mail.gmail.com>
	<xmqqfutw9mfs.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYKbef7DTkmE3Vf3C=PLfgB3xf0ikVKHFUfQ8+KkgGHPg@mail.gmail.com>
	<xmqqfutw85oz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Duy Nguyen <pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 06 08:09:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayYwi-0006y4-4w
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 08:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbcEFGI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 02:08:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51690 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751053AbcEFGI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 02:08:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A7C8B10859;
	Fri,  6 May 2016 02:08:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/8GIhzXHQnKM360ESh9QiCTwVPs=; b=DayGSz
	H/GfjDnwoiSpp4nyQV3/rAtDKRg0IZYoAb8hesgRvN1Y7SBGBiRfrrgOKY9Pgy3+
	fATT/GCXNEc0DNRiRArTWK85h79UzX/XPBhOkMd0jmDFV5RL7X/Xo7Ql96hfwJWR
	nebGkUxKNq7z04Bm1SNVcQQHBVl/+jYgMlNRw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ESfjr3Igtzn0E2D4ed7xUwo4sAqHUhoz
	DwSUkhQUW1jWSYv1IPr1V6Xjf5TscOaLh67950cH/9whwoC73FVwSDjWG6tJ9Wkk
	7W7zyiFK7U0JkRMncxqHRW7MWF8V+FaJuEB8XgDCTnA3dKw+qgNeT3Mx6kjNBOHw
	JUhs8sSGhWc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9EDF510858;
	Fri,  6 May 2016 02:08:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 281B810857;
	Fri,  6 May 2016 02:08:55 -0400 (EDT)
In-Reply-To: <xmqqfutw85oz.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 05 May 2016 16:07:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 03682122-1351-11E6-9BA2-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293743>

Junio C Hamano <gitster@pobox.com> writes:

> The set of submodules you "init" to the working tree are the ones
> that are interesting to you.  So once the tree is populated, you do
> not ever have to look at the "defaultGroup" configuration.  You just
> need to look at the working tree.
> ...

I forgot to prefix the first few paragraphs of that message with
"Here is how my version of the world should work."  I did not mean
to say "Here is how you must make your work work, or I won't talk to
you."  I was just hurried as I had to tend to other topics.

I actually do not care too deeply (except for the "automatically
remove" part, which I do not think we should do), as I do not think
there is a big fundamental difference between the two views.  To
make sure we are on the same page, let me rephrase the two views I
have in mind.

The difference is what should happen when the user does not give any
pathspec, *label, or :name to limit the set of submodules to act on,
which, traditionally meant to work on everything, and we are trying
to change that to some "default".

 (1) The default set is what the configuration file says is the
     default group.  The working tree state is ignored.

 (2) The default set is what the configuration file says is the
     default group, plus those the user showed interest by doing
     "submodule init".

Suppose that the user has a mostly satisfactory default configured,
i.e. the set of submodules the configuration file says is the default
is both necessary and sufficient to carry out her daily task.  Then
there is no difference between the two.

Further suppose that the user needs to view a submodule outside the
default group temporarily (imagine: for a day or two), while
carrying out some specific task.  Perhaps she is working on the
documentation submodule, which is her primary task hence her
configuration file specifies it as the default, but needs to see the
submodule that houses the implementation to describe the behaviour.

So she does "init code-module/"; this has explicit pathspec, so
there is no difference between the two.  Now, while reading the code
module, she finds a typo in a comment, and wants to fix it.  We will
start to see differences.

 * When she wants to get a bird's eye view of everything she cares
   about at the moment, i.e. wants to view the state of her usual
   modules plus the code-module she is visiting, (1) is more
   cumbersome.

   With (1), "diff --recursive" will not step outside of her
   configured default, so she says "diff --recursive \*default
   code-module/" to say "I want to see both my default submodule(s)
   and the one I checked out by hand".

   With (2), she does not have to do anything special, as manually
   checked out code-module/ will be acted upon, in addition to the
   configured default.


 * When she wants to see her usual modules ignoring the one-off
   checkout, (1) is easier.

   With (1), she can say "diff --recursive" and done. 

   With (2), she needs to say "diff --recursive \*default" to
   explicitly state "I may have checkouts of other submodules, but
   this time I want to view only the usual default of mine".

The difference is not that big either case.

Whichever way we choose to make the default behaviour, the user
needs to type a bit extra when asking a behaviour that is different
from the default behaviour.

The amount of "extra" in the first use case necessary for (1) is
greater than the amount of "extra" in the second use case necessary
for (2), though.  In addition, in the second use case, (1) makes it
easier for the user to miss important changes she made outside the
area of her usual attention, while (2) forces her to make a
conscious effort to exclude them.  These are the reasons why I have
a slight preference for (2) over (1).
