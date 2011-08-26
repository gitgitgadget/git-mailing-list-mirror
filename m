From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] replace: List replacement along with the object
Date: Fri, 26 Aug 2011 09:38:09 +0200
Message-ID: <4E574D61.8050501@drmicha.warpmail.net>
References: <bae5a8f7d30417864d972390f9f6b4470cf4e5bf.1314283118.git.git@drmicha.warpmail.net> <CAP8UFD2Cr4UQjWa=pRvcqgyX_Ed+qjts=TujWRdyk4dUZsd_7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 26 09:38:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwqza-0003X2-Jn
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 09:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306Ab1HZHiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 03:38:13 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:46823 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750704Ab1HZHiM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2011 03:38:12 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C1D472095E;
	Fri, 26 Aug 2011 03:38:11 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 26 Aug 2011 03:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=91i+eqtVkw8lj9IGf7d0YH
	hfd10=; b=EXFhym22U4ZWhLQU8yjPln95oFrHGW+rqvaSaXgdCxAFFWvjuuws3W
	LITI+LtdM2F/NfpOM+TTgIvsFj5nCaXIAxviqaRazc1Zln64KZsPDE5PZxGnXhSZ
	lkE54U66LFLXnbFcObsoilJF0abSabqwuRqe/bR5xAXYGzluum+Kg=
X-Sasl-enc: cZVGCB2XkRFUB3CVVyGzJh3Ihvim9g1JHpIPfbFkiSIx 1314344291
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2CC4F441F74;
	Fri, 26 Aug 2011 03:38:11 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <CAP8UFD2Cr4UQjWa=pRvcqgyX_Ed+qjts=TujWRdyk4dUZsd_7Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180154>

Christian Couder venit, vidit, dixit 25.08.2011 18:29:
> On Thu, Aug 25, 2011 at 4:39 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> The documentation could be misunderstood as if "git replace -l" lists
>> the replacements of the specified objects. Currently, it lists the
>> replaced objects.
> 
> You could just change the documentation to make it more explicit.

Well, sure. I just didn't find the current form that useful.

>> Change the output to the form "<object> <replacement>" so that there is
>> an easy way to find the replacement, besides the more difficult to find
>> git show-ref $(git replace -l).
> 
> I shamelessly copied the "-l <pattern>" feature and the documentation
> from "git tag". If you just change the output of "git replace -l" it
> will make the UI inconsistent between both commands.

I don't think many people will expect consistency between branch and tag
on the one hand, and replace refs on the other hand. It requires the
knowledge that a replacement is basically a lightweight tag stored in a
different namespace in refs/, which I would actually consider an
implementation detail.

> Maybe you could add a "-L <pattern>" feature to "git replace", "git
> tag" and "git branch" that would output "<ref name> <ref content>"?

I'd use "-v" then if this is about consistency, because that *always*
means "verbose", and migrate the misnamed "git tag -v"...

Junio C Hamano venit, vidit, dixit 25.08.2011 21:07:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> The documentation could be misunderstood as if "git replace -l" lists
>> the replacements of the specified objects. Currently, it lists the
>> replaced objects.
> Seeing that you had to change existing tests, I do not think this is an
> improvement. The existing scripts can read the list of objects and find
> replacement themselves (if they want to find that out, that is), no?

If "replace -l" is considered fair game for scripts then the output
should probably not change, though I left the meaning of "$1" for each
line of the output as is on purpose.

But, how would scripts find the replacement? rev-parse does not do it,
rev-list does not do it, and using show-ref requires the user to know
about the actual implementation as refs under refs/replace.

Seems that the doc change is the only option.

Michael
