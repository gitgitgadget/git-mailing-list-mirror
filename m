From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] rev-list/log: document logic with several limiting options
Date: Wed, 12 Sep 2012 15:43:13 +0200
Message-ID: <50509171.9060604@drmicha.warpmail.net>
References: <b23f3c547358b79731c7a25d9ac496138e6ab74d.1347374615.git.git@drmicha.warpmail.net> <7vsjaoil6d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 15:43:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBnDv-00073e-R9
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 15:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721Ab2ILNnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 09:43:16 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47032 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751188Ab2ILNnP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Sep 2012 09:43:15 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id B115E21615;
	Wed, 12 Sep 2012 09:43:14 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 12 Sep 2012 09:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=XkB+hYiuV8rXiKAG2d2qdj
	/JXkk=; b=ASvkiJxgCIFVR2TgpwJfRr69ZZqRhHVbttdVudyO4FvOdoH3El81gP
	aXlFBtrb6vnVpajZPEN5JW4SugbtaC6QBSZGMW8ui2cXAXbdNu/OcRupGGwlUBNy
	l/TDDKcCnfdlj08D5Y3SBAmTO3VBh6GEztYXoWiz9/7wZLcfB1Qp0=
X-Sasl-enc: ZfdnZfgEXjGh2DTpr2hbjKLW0GEgDFr60uCUDe0/oWVc 1347457394
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 3D06D8E0113;
	Wed, 12 Sep 2012 09:43:14 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7vsjaoil6d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205288>

Junio C Hamano venit, vidit, dixit 11.09.2012 18:22:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> The current behavior is probably as useful as it is confusing. In any
>> case it is going to stay. So, document it.
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>> I would have written a test but don't really know where to stick it in.
>> rev-list has many small tests where it doesn't fit.
> 
> "git log" would be the more natural place, I would say.

Well, to me, "git log" is the ui to "git rev-list", so everything which
tests the revision walker should be tested using "git rev-list". But I
don't care as long as it fits in - and can be found later.

That being said, I now see lots of "log --grep" and "log --author" tests
in the grep-test. So I guess there it fits best (despite the misnomer).

>>
>>  Documentation/rev-list-options.txt | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
>> index 5436eba..9c13df3 100644
>> --- a/Documentation/rev-list-options.txt
>> +++ b/Documentation/rev-list-options.txt
>> @@ -6,6 +6,12 @@ special notations explained in the description, additional commit
>>  limiting may be applied. Note that they are applied before commit
>>  ordering and formatting options, such as '--reverse'.
>>  
>> +All occurrences of the same option are ORed: '--grep=foo --grep=bar'
>> +limits to commits which match at least one of these conditions.
> 
> How would this interact with "--all-match"?

Badly.

It was introduced in 0ab7befa with a clear meaning (AND everything),
then the general logic (without --all-match) was modified in 80235ba7
(to take headermatch AND (all greps ORed)), and 5aaeb733 finally made
multiple authors resp. committers get ORed among each other. All of this
in an attempt to make the standard usage most useful, of course. As a
consequence, --all-match does not influence multiple --author options at
all (contrary to the doc), e.g.

I don't see any of this reflected in the doc, though. I noticed only by
reading t/t7810-grep.sh. Before that, I had only gone by my own testing
which didn't reveal the multiple author multiple special casing effect.

I guess I'll have to wrap my head around the current implementation a
few more times before trying to describe the status quo in the
documentation...
