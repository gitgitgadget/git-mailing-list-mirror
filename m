From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/2] git p4: Fixing script editor checks
Date: Wed, 11 Apr 2012 12:06:55 -0700
Message-ID: <7vpqbejdf4.fsf@alter.siamese.dyndns.org>
References: <1334157684-31402-1-git-send-email-luke@diamand.org>
 <1334157684-31402-2-git-send-email-luke@diamand.org>
 <7vpqbekx7h.fsf@alter.siamese.dyndns.org>
 <CAE5ih7_X=4gewga8fMzaEvowsJsA1Ta9PQ2bGixx5eVvykputA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 21:07:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI2sm-00066R-U4
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 21:07:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932916Ab2DKTHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 15:07:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52490 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755073Ab2DKTHA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 15:07:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5740690D;
	Wed, 11 Apr 2012 15:06:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/7ZfZh56B7nUeTebQGX7AlSKt6w=; b=Svb/GL
	KZnOO8HW97klzR4YcyYqXsi7lItLzyKObggU+/8aYm8LDJatF2AlFrAoj4EBSxhI
	qRjWlA+695PcmOnaY/I3byjVyCa1wah98X4GomAufIPOohKua30B2RtfP/pQDf0p
	7L3RlGr+QntSAs6OJ5XCHzz1wix8ixdglIJAk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZwqeB6S4J9QCmIwUYv+nXjWNJBdKzwNg
	ueAP2hsWZn0atKDOX38qwmVZAJevxUgZerXG7zxkREW2Eaq3h+wdvzBoAHOVPiCC
	Ev5rI6DcJa9kNnDCR3IhZHsfutdJCcr6y+KWay3RrCgMa6Lb+hpfVN7/YuMmRe6f
	Jy4+7l2XcLM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC40D690C;
	Wed, 11 Apr 2012 15:06:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F011690A; Wed, 11 Apr 2012
 15:06:57 -0400 (EDT)
In-Reply-To: <CAE5ih7_X=4gewga8fMzaEvowsJsA1Ta9PQ2bGixx5eVvykputA@mail.gmail.com> (Luke
 Diamand's message of "Wed, 11 Apr 2012 20:51:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 824B01DE-8409-11E1-A447-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195240>

Luke Diamand <luke@diamand.org> writes:

> On Wed, Apr 11, 2012 at 7:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Luke Diamand <luke@diamand.org> writes:
>>
>>> If P4EDITOR is defined, the tests will fail when "git p4" starts an
>>> editor.
>>
>> Is that a problem specific to tests, or should "git p4" itself unset that
>> environment? If it is a problem specific to tests, would it be a better
>> fix to add "P4EDITOR=:" like we do for EDITOR in t/test-lib.sh?
>
> Yes and no - git-p4.py will run $P4EDITOR if it is set, even if it's
> just empty. So it would need a small fix to check for an empty string.
> I can submit a suitable patch.

How does real "p4" run $P4EDITOR?  For example, if you have:

	P4EDITOR='vi -e'

does it start "vi" in its "ex" mode, implying that it behaves as if the
invocation were like this in a hypothetical implementation of "p4" as a
shell script:

	#!/bin/sh
        ... do some stuff p4 does ...
	$P4EDITOR file-to-be-edited

Whatever it does needs to be emulated by the code in git-p4.py that runs
it, as that is the way the end users expect, and if it turns out to be
like the above, setting P4EDITOR to ':' just like we do to EDITOR in
t/test-lib.sh should be the right thing to do.  The always-true command
colon will leave the file-to-be-edited unmodified and report success.

Similarly, what happens with "p4" when $P4EDITOR is set to an empty
string?  If it ignores and falls back to the other usual way to find your
preferred editor, you should emulate that as well in git-p4.py.

Thanks.
