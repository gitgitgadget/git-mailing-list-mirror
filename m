From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git diff: add option for omitting the contents of deletes
Date: Mon, 28 Feb 2011 13:32:35 +0100
Message-ID: <4D6B95E3.7040603@drmicha.warpmail.net>
References: <AANLkTi=++gcw5CDQnTRbhUGkvWc9Zm+Ct4Zm5oGGYKUh@mail.gmail.com> <7vk4gm7dz3.fsf@alter.siamese.dyndns.org> <4D6A6291.8050206@drmicha.warpmail.net> <7v7hclulz0.fsf@alter.siamese.dyndns.org> <7v39n9uldp.fsf@alter.siamese.dyndns.org> <4D6B4F6B.1040209@drmicha.warpmail.net> <20110228121726.GA5197@sigill.intra.peff.net> <20110228122335.GB5197@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?TWFydCBTw7VtZXJtYWE=?= <mrts.pydev@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 28 13:36:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu2KZ-00009F-Rl
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 13:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753825Ab1B1Mf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 07:35:59 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50527 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753812Ab1B1Mf6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 07:35:58 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B35C4207E9;
	Mon, 28 Feb 2011 07:35:57 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 28 Feb 2011 07:35:57 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=1TSLBU94gmy/5Ct9CwYYNFb8ADQ=; b=QE2z7/LlF9d5Ru/7fljtwpwAsgdMppcMrUrIZM/nFoSvTj7cw3xMTfOOChitn6OsIaJGbFTJawlsymP6tSmOTwJn3in7HgiYCl4RWyP4ekOCdwshB/SNeEdrlah/vFEZYI8sAXVa6gIFVLvYaU2gKCLwKEqKG7/QH3nN0V1MR74=
X-Sasl-enc: ty/cnTx3bWRTshoQkMwievorDjhUIITFsSAs3T6IM8U2 1298896557
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 00461400723;
	Mon, 28 Feb 2011 07:35:56 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <20110228122335.GB5197@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168103>

Jeff King venit, vidit, dixit 28.02.2011 13:23:
> On Mon, Feb 28, 2011 at 07:17:26AM -0500, Jeff King wrote:
> 
>>> That aspect is similar to -M and -C, though - unless we check the sha1
>>> of the blobs before applying the patch (which would be possible for -D
>>> also) - do we?
>>
>> Yes, I think we do check the sha1s for a "-M" patch. And we should do so
>> for a "-D" patch, too. Which would make it just as likely to conflict as
>> a version with the actual patch content, _except_ that it relies on the
>> recipient having that sha1.
>>
>> I don't see how "-D" is any less reversible than -M or -C, though. If I
>> get your -D patch, I use the index line to see that the blob went from
>> 1234abcd to 0000000, check that we are at 1234abcd, and then delete the
>> file. To reverse it, I reinstate 1234abcd from nothing (and conflict if
>> the file exists). _Neither_ case works without the sha1.
>>
>> So I think the problem is not about "this cannot be reversed" but about
>> "the recipient must have your sha1 to make sense of it, in either
>> direction". Which is the same case as with "-M" and "-C", and why we
>> have long cautioned about their use on mailing lists. But the right rule
>> is not "do not use on mailing lists" but rather "do not use on mailing
>> lists for projects where the recipients will not be using git to apply".
> 
> Actually, thinking on this a bit more, I guess "-M" and "-C" are usable
> without the sha1. In fact, we don't even provide it for a strict 100%
> rename, and for a rename-with-patch, you can apply the patch, assuming
> you have the original file in any form. So they are really about "is
> your recipient using git", not "is your recipient using git _and_ will
> he/she have the right sha1".

$ git mv Makefile Dofile
$ git staged # yadayada
diff --git c/Makefile i/Dofile
similarity index 100%
rename from Makefile
rename to Dofile

Same with copy.

But that's not good, is it? I mean, Alice sends me her "copy patch" and
I send her my Makefile patch, both on top of the same base. We both
apply each other's patch cleanly. We end up with different "Dofile".
Checking the sha1 would prevent this. It's no surprise that patch
application is non-commutative, but shouldn't we catch this?

Michael
