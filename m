From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC-PATCHv6 4/4] pathspec: allow querying for attributes
Date: Tue, 17 May 2016 11:05:10 -0700
Message-ID: <xmqqposkwofd.fsf@gitster.mtv.corp.google.com>
References: <20160517031353.23707-1-sbeller@google.com>
	<20160517031353.23707-5-sbeller@google.com>
	<xmqqvb2dxomo.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbYB_4KO+XpYa0OhAcU63Q2M2kLWa03HcxeYS1HJOgfZw@mail.gmail.com>
	<xmqq37pgy4fn.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYbUTC7m-5kdTbvxmSkq__5BVz5x1UeieHhB4TVSqssHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 17 20:05:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2jMv-0006G8-9O
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 20:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbcEQSFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 14:05:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51681 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751741AbcEQSFO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 14:05:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AAEC61C9F2;
	Tue, 17 May 2016 14:05:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4+PE7WhvY0/JDRzNSRm3J5S+6jg=; b=JQ2Ioh
	J+aHleudc1P2Bk245hnMmQ4H5AEItymBonW9JKTccg3tSR5bFkbOSvrMmji8irZE
	eoi7elOdlcAVEgcANJL0kKetyV0ii1fNFS1iLlhwZeiOfoEzsgUgl3WQC7IXYhYE
	dF18ZeOmthYqSwVKoUZ3zy59DcCIwYoXzY5ok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UeNM93gFXT2yv+Hryaz6NLJSU+GmLWoL
	U66FSeOjluwIcDCsWyw8uYUdUl9jG8eC2y4sgA3SbfRNEZgfv0+0STkVPMim9Rf3
	RRhlXnp3XIgCrvz6hrJ9yRmfGZU71RZUYoxqfa/7tM04SkbvwbianUrJ3iHt6l4+
	/XEJWgjLKDs=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A246F1C9F1;
	Tue, 17 May 2016 14:05:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C3571C9EB;
	Tue, 17 May 2016 14:05:11 -0400 (EDT)
In-Reply-To: <CAGZ79kYbUTC7m-5kdTbvxmSkq__5BVz5x1UeieHhB4TVSqssHw@mail.gmail.com>
	(Stefan Beller's message of "Tue, 17 May 2016 10:45:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E62AF51E-1C59-11E6-92E4-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294887>

Stefan Beller <sbeller@google.com> writes:

> I am not talking about crazy stuff here, but consider our own
> .gitattributes file:
>
>     * whitespace=!indent,trail,space
>     *.[ch] whitespace=indent,trail,space
>     *.sh whitespace=indent,trail,space
>
> Now I want to search for
>
>     "the whitespace attribute that is set to at least trail and space"

With :(attr:VAR=VAL) syntax, you can only look for whitespace
attribute exactly set to "!indent,trail,space", so you can't.  So
you are talking about crazy stuff after all, aren't you?  Are you
now extending it to do "whitespace~=indent" or something like that?

You do not even need VAR=VAL form for your main topic.  You only
need group-doc group-code etc. to look for "set to TRUE", no?

I do not want to see us wasting too much time over-engineering it
without having a concrete and useful use case, and "find path to
whom whitespace checks are set for 'trail' and 'space'" is not.
These comma-separated tokens augment WS_DEFAULT_RULE which has
'trail' already, so you do not look for 'trail' in the first place.

"I want submodules under subs/ that is in either group-doc or
group-code" is more reasonable and realistic use case, but that does
not need any crazy stuff.  Either two separate pathspec elements,

	":(attr:group-doc)subs/" ":(attr:group-code)/subs/"

or if we are to do the "ORed collection of ANDed attrs", it would be
something like:

	":(attr:group-doc):(attr:group-code)/subs/"

no?
