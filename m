From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git diff: add option for omitting the contents of deletes
Date: Mon, 28 Feb 2011 14:05:37 +0100
Message-ID: <4D6B9DA1.4070805@drmicha.warpmail.net>
References: <AANLkTi=++gcw5CDQnTRbhUGkvWc9Zm+Ct4Zm5oGGYKUh@mail.gmail.com> <7vk4gm7dz3.fsf@alter.siamese.dyndns.org> <4D6A6291.8050206@drmicha.warpmail.net> <7v7hclulz0.fsf@alter.siamese.dyndns.org> <7v39n9uldp.fsf@alter.siamese.dyndns.org> <4D6B4F6B.1040209@drmicha.warpmail.net> <20110228121726.GA5197@sigill.intra.peff.net> <20110228122335.GB5197@sigill.intra.peff.net> <4D6B95E3.7040603@drmicha.warpmail.net> <20110228125909.GA9054@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?TWFydCBTw7VtZXJtYWE=?= <mrts.pydev@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 28 14:09:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu2qZ-00089l-N6
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 14:09:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022Ab1B1NJC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 08:09:02 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:41386 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753876Ab1B1NJB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 08:09:01 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8A8AE207C4;
	Mon, 28 Feb 2011 08:09:00 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 28 Feb 2011 08:09:00 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=2UizuoILDbU/W6/p3O5PNt6xdE8=; b=QSREf+lRxbzJjLXbDVBV5v1SwsU8SksWfKbQoazU7pTDZ/7Lk17dmWWf7mE/xRL3tHLMrh983cinn9WzoGjCNOurAVQ3Q53BBCMBYMfgm8DDB/SGhxWVgdV/+7BWBI84p2IDAB5Xi73m7qZgB4J5APOYQaEiGoQWEVERqinKIA4=
X-Sasl-enc: wbhdLmj4N+QksftS8KiAg9RuUEAICTcRjLtqdrTj+jIj 1298898540
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id CAE1340BDEA;
	Mon, 28 Feb 2011 08:08:59 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <20110228125909.GA9054@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168109>

Jeff King venit, vidit, dixit 28.02.2011 13:59:
> On Mon, Feb 28, 2011 at 01:32:35PM +0100, Michael J Gruber wrote:
> 
>>> Actually, thinking on this a bit more, I guess "-M" and "-C" are usable
>>> without the sha1. In fact, we don't even provide it for a strict 100%
>>> rename, and for a rename-with-patch, you can apply the patch, assuming
>>> you have the original file in any form. So they are really about "is
>>> your recipient using git", not "is your recipient using git _and_ will
>>> he/she have the right sha1".
>>
>> $ git mv Makefile Dofile
>> $ git staged # yadayada
>> diff --git c/Makefile i/Dofile
>> similarity index 100%
>> rename from Makefile
>> rename to Dofile
>>
>> Same with copy.
>>
>> But that's not good, is it? I mean, Alice sends me her "copy patch" and
>> I send her my Makefile patch, both on top of the same base. We both
>> apply each other's patch cleanly. We end up with different "Dofile".
>> Checking the sha1 would prevent this. It's no surprise that patch
>> application is non-commutative, but shouldn't we catch this?
> 
> Won't you either get a conflict or end up with the same Dofile? Clearly
> you will have a Dofile with your Makefile changes, as you applied the
> movement on top of your changes.
> 
> Alice will either:
> 
>   1. Apply not using rename detection (e.g., not using git, or using
>      "git am" without "-3"). In this case, she gets a conflict because
>      she no longer has Makefile.
> 

When I said "copy patch" I actually meant a patch which records the copy
"Makefile -> Dofile". What is it today? Is it me? I know I wrote the
"mv" example first, but still :)

I mean, Alice:
cp Makefile Dofile
sends me a -C patch

I:
Break everything by hacking Makefile
send her a crappy patch

Both:
apply the received patch

Now I end up with a borked Makefile and a borked Dofile, but Alice still
has a good Dofile, and it's all my fault, so I don't deserve any better.
But still.

>   2. Apply using rename detection (e.g., via "git am -3"). In this case,
>      we will notice the movement of Makefile to Dofile, and apply the
>      patch to Dofile.
> 
> Still, I do wonder if we should be including an index line on a straight
> rename patch. It lets the recipient check that what is being renamed is
> what they have (IOW, it gives the same check that they would do if they
> ahd the whole patch text). And then the recipient can decide how to
> resolve the conflict.

I think so. (Or make -f force it.)

This is orthogonal to the "-D" suggestion", but "-D" could write the
index line to start with.

Michael
