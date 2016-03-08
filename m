From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Adding RFC 3161 timestamps to git tags
Date: Tue, 08 Mar 2016 09:59:39 -0800
Message-ID: <xmqqfuw0luk4.fsf@gitster.mtv.corp.google.com>
References: <9bf0ad940a5ce20c0c3742a3dfca70f8.squirrel@faumail.uni-erlangen.de>
	<56DED396.5070009@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Anton Wuerfel <anton.wuerfel@fau.de>, git@vger.kernel.org,
	i4passt@cs.fau.de, phillip.raffeck@fau.de
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 08 19:00:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adLvb-00072m-C9
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 19:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbcCHSAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 13:00:12 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51061 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750932AbcCHSAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 13:00:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 965E0490F6;
	Tue,  8 Mar 2016 13:00:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sQjitHJCIzRPyx1a+hQwTUhCLnQ=; b=FWB/pZ
	hVo/Lux2Rfq/JHidQBYD6vIK8v9/DZd+Brjw5DDzR0v+r9ZUrechsvX9WgRw9cy7
	M7DuJJa8Q4QCJtuW7HwqfOyZcMLBmskWi1VdG9HYygp0E56w8FhCcDc34HHUyOri
	knKWi0DucdW9hx78O+NQHp4uDYezvMkJmWNjc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HuVc90Br0pHfwuh6zOBJX3+aOaXc4yt1
	AyZqa5Vpu87DVwxTr7WoPjwmDLDFMtvvo9qYjiTU9HjB/L8ANmVg+eJ7uE21vbJj
	dAUTfpc+jPZLzUFqrtCNpAfTWzjwZ1z+ynjcSFmjnn+SiWTD4ZMcBUlL3tQHmFjr
	Z+uzcxWwtE4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 26DC5490EF;
	Tue,  8 Mar 2016 13:00:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 735E6490CC;
	Tue,  8 Mar 2016 12:59:40 -0500 (EST)
In-Reply-To: <56DED396.5070009@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Tue, 8 Mar 2016 14:28:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 879E5A10-E557-11E5-AB57-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288443>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Anton Wuerfel venit, vidit, dixit 07.03.2016 15:15:
>> Hello,
>> 
>> as part of an university project we plan to implement time stamp
>> signatures according to RFC 3161. This enables users to create and verify
>> cryptographic time stamp signatures to prove that a commit existed at a
>> certain point in time.
>
> Before talking about a specific header format (and, possibly, repeating
> mistakes of the past) we should take a step back to exactly here: What
> is the goal that you are trying to achieve?
>
> "prove that a commit existed at a certain point in time" is a good
> definition for that goal.

Moving the timestamp signature out of line has merits and demerits.

 - Inline timestamp signature proves that the commit existed at a
   certain point in time, and also it proves that any descendant
   commit was not there before that time.  Also, the object name
   of the signed object itself protects the fact that it was created
   with the signature (i.e. if you replace the signature, its object
   name would change)--this can be a feature or inconvenience,
   depending on your use case.

 - Out of line timestamp signature allows you to say "I didn't
   bother timestamping that commit I made 5 days ago, and it now is
   buried 200 commits deep in the history from the tip, but I am
   asking a timestamping service that the commit existed as of
   now--I cannot go back and prove that it actually was made 5 days
   ago, but at least the timestamp proves it was there today".

   It does not allow you to say anything about descendant commits,
   though, like an inline timestamp would.

There is a convenience argument, too, for and against inline vs out
of line signatures.

 - The original "signed tag" is a good out-of-line signature
   mechanism that you can add signed attestation to a different
   object (i.e. you made a commit either 2 seconds or 5 days ago,
   and then you certify that you would want to call that with a
   tagname with some messages and cryptgraphically sign that
   retroactively).  Being in the ref namespace, it didn't scale for
   use cases where you would want to have as many signatures as you
   would have commits, though.

 - The "signed commit" is made in-line, and for those who want to
   always validate each and every commit, not having to maintain a
   separate collection of signatures was a convenience.

 - The "merge signed tags" is also made in-line, primarily for
   convenience benefit, i.e. not having to keep collection of all
   pull request tags out of line.

I haven't thought deeply enough between in-line and out-of-line
which would suit better for timestamp signatures, though.
