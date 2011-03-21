From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 3/3] rev-list --min-parents,--max-parents: doc and test
 and completion
Date: Mon, 21 Mar 2011 15:56:20 +0100
Message-ID: <4D876714.8040604@drmicha.warpmail.net>
References: <cover.1300459016.git.git@drmicha.warpmail.net> <182c5ece22835559a9762e242adb701547cf6575.1300459017.git.git@drmicha.warpmail.net> <20110318194802.GB27825@sigill.intra.peff.net> <4D871401.6020900@drmicha.warpmail.net> <20110321105431.GB16334@sigill.intra.peff.net> <4D873F56.1060803@drmicha.warpmail.net> <7vbp14ttgu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 16:00:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1gaM-0004A8-Mn
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 15:59:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470Ab1CUO7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 10:59:54 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:33172 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751259Ab1CUO7x (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 10:59:53 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 690AE20AEE;
	Mon, 21 Mar 2011 10:59:52 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 21 Mar 2011 10:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=UHG2XjqrjwnGg2Z6k/a21Begsss=; b=m+RYlh5tgnkAnK7Whs/eWYPh4afQFv7JX74CfuJMzH4myvlwZFnjaloVq+Xg/bffazvPbJh5HH+/oDfRidevzQp5JRqdjN+IZFCIm2ZYSAdl6Yp4KAzrugme8YxNYGjeOandLWcZ/o3AquB3SdpoTybmhVvYBamsiOmPgSlCgPs=
X-Sasl-enc: XhSDbjUcMhYdF4KT2TaVkRDNxu+PdSdlMkaaSc7WWk4Z 1300719592
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AB723441DD1;
	Mon, 21 Mar 2011 10:59:51 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <7vbp14ttgu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169599>

Junio C Hamano venit, vidit, dixit 21.03.2011 15:54:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Jeff King venit, vidit, dixit 21.03.2011 11:54:
>>> On Mon, Mar 21, 2011 at 10:01:53AM +0100, Michael J Gruber wrote:
>>>
>> In my community it is very common, which may partly be due to the fact
>> that there is a strong proportion of non-native speakers. It took it for
>> granted that it's a standard expression.
> 
> Perhaps in math circles or something?

Yeah, those (us) weirdos ;)

> 
>>> I really think "Show only commits which have at least (or at most,
>>> respectively) that many commits" says the same thing, but is way more
>>> accessible.
>>
>> Sounds good, I'm happy with that. Resend or squash on apply?
> 
> The "... A resp. B" composition did made me go "huh?", even though I
> managed to guess what you meant; I agree Jeff's rewrite is much more
> approacheable.
> 
> The code part of the patch needs a bit of touch-up anyway, so let's do a
> v2.
> 
> It is not like you will have a million copies of "struct rev_info", while
> you will be reading from and comparing with the field for each commit
> during the traversal, so I'd rather see these max/min stored in the usual
> "int", not squashed into bitfields.  Also initialize max to the magic
> token that means "unlimited" in init_revisions() without swapping the
> meaning of comparison.  One initialization assignment you can omit there
> is not worth the resulting confusion.
> 
>>>>> That way it is obvious that "--merges" cancels a previous --min-parents
>>>>> on the command line (maybe the text should be "this is an alias for..."
>>>>> to make it clear that doing it is exactly the same).
>>>>
>>>> Yes, that is helpful. I have doubts about "alias" for. Without wanting
>>>> to sound elitist or something, I have the impression that we start
>>>> catering for users who understand "equivalent" more reliably than "alias".
>>>
>>> I just wanted to make sure people didn't think "equivalent" meant "has a
>>> similar effect to" as opposed to "is exactly as if you did". But reading
>>> it again, I think "equivalent" is fine, and I see you picked it up in
>>> the latest series.
>>
>> I may be wrong about what is common in this case, too. For me, "alias"
>> is foremost a technical term, and I would guess that many non-native
>> speaker know "alias" either in the technical sense or not at all, but
>> not so much in the common English sense. But either way is fine.
> 
> We would want to make sure the reader understands that saying --no-merges
> is _exactly the same_ (your words above) as saying --max-parents=1, so why
> not spell that out, i.e. "This is exactly the same as `--max-parents=1`"?
> 
> Thanks.

I guess you haven't seen v2 yet, where most of these changes are
incorporated.

For the doc, "exactly the same" is clean and simple and understandable
for both Jeff and myself, I guess ;)

Michael
