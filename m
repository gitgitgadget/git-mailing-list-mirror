From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/3] notes remove: allow removing more than one
Date: Thu, 19 May 2011 09:31:08 +0200
Message-ID: <4DD4C73C.7020600@drmicha.warpmail.net>
References: <1305764061-21303-1-git-send-email-gitster@pobox.com> <1305764061-21303-2-git-send-email-gitster@pobox.com> <4DD4BC0D.2000805@drmicha.warpmail.net> <7v1uzv9oab.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 19 09:31:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMxhV-0001QA-Ci
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 09:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304Ab1ESHbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 03:31:11 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:34681 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756305Ab1ESHbK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2011 03:31:10 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1D164207F6;
	Thu, 19 May 2011 03:31:10 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 19 May 2011 03:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=4YCIPUwudvxdjf3VFj82qJHBf1Y=; b=hiUEOx3tQ51bWZ7UIsEddaRQgcIem2+qjT1a1SogDQlBocK8DiQrV0S/RjAYQeDnb49Ymb4H9Ixa9N4JgJ7Nf8umSz8871TnWzARnhCMSBoM4OTlmbd5EH2gBuJzSjiGpzT49W5jz8FRA50LBgtorfuUciqMUmQ4Bk1tMyC5Dm8=
X-Sasl-enc: lGIbGJyVs6pftezRO4t18PH1kzCUqoTZE6SZ6BHx6krj 1305790269
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9927B44743A;
	Thu, 19 May 2011 03:31:09 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <7v1uzv9oab.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173944>

Junio C Hamano venit, vidit, dixit 19.05.2011 08:50:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
> [jc: cull the part you did not comment on, thanks]
> 
>>> +test_expect_success 'removing more than one' '
>>> +	before=$(git rev-parse --verify refs/notes/commits) &&
>>> +	test_when_finished "git update-ref refs/notes/commits $before" &&
>>> +	git notes remove HEAD^^ HEAD^^^ &&
>>> +	git diff --name-only refs/notes/commits^ refs/notes/commits >actual &&
>>> +	test 2 = $(wc -l <actual) &&
>>> +	git ls-tree -r --name-only refs/notes/commits >actual &&
>>> +	>empty &&
>>> +	test_cmp empty actual
>>> +'
>>
>> You're not really testing that this removes the correct notes. Actually,
>> you're not even testing that this removes only 2 notes when there are
>> more than 2, are you?
> 
> In the test vector, there are only two notes, and I am testing removal of
> multiple.  What do you want me to do?  Test removing one and make sure the
> other one survives ;-)? 

The test has two notes because it was created when remove would remove
one note at a time only, and the test made sure it did not remove the
other one (!).

If you want a meaningful test which tests that "git notes remove A B"
removes exactly 2 notes (not more) you need to add another note first.
Otherwise it could be that your new code simply nukes the notes tree. (I
know it does not, but only by looking at the source; this test does not
check it.)

Checking that it actually removes *those* 2 notes would give extra
credit but may not be necessary (since we know it removes the correct
one in single mode).

> Patches on top of it is very welcome, but I wouldn't bother.

Is that the kind of response you accept from submitters to your (valid)
requests that they provide negative tests in addition to positive ones?

I don't mind helping out with a test patch (later this UTC day) but I'm
concerned about the attitude someone may read into this and may want to
follow as an example. In terms of code-with-test habits, I would claim
that git.git is really an exemplary standard to follow (and to keep).

Cheers,
Michael
