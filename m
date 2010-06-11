From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] read_cache: cast types from stat to ce_cache
Date: Fri, 11 Jun 2010 16:59:00 +0200
Message-ID: <4C124F34.7050904@drmicha.warpmail.net>
References: <a06cc84698f174d914350d6fd6e6b4739d22aa45.1276161176.git.git@drmicha.warpmail.net>	<7vmxv2nar5.fsf@alter.siamese.dyndns.org>	<4C123AD4.6070606@drmicha.warpmail.net> <AANLkTimC9RAD0OGArk3JAIAnDHNskJRgX1nBlcrhc7vX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Jun 11 16:59:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON5hU-0003TY-Sd
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 16:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744Ab0FKO7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 10:59:09 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52761 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750781Ab0FKO7G (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jun 2010 10:59:06 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 06950F8C78;
	Fri, 11 Jun 2010 10:58:56 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 11 Jun 2010 10:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=ArtkZwskkKjmZwBkQ6HmCXPkwqI=; b=rnOY3etZtMX48Cy0RyIzFlFdiERAveDHNIE+me6kS3pzQBYinE4FEcEvDzL6PrQEiww1aKycnJo9eiS45KYVD9DFDUx3BmH5sqQwAA+9Tsl11a8R1+Cxv29mHLACEZnFsr59HSz2DME4YNTQ9NoMaI6MbAaSDKyrkqPrSSO1P88=
X-Sasl-enc: MxpM3oM5lVw6MovfUq3MTYkCztJaWDW4Dd+bX2gZdPki 1276268330
Received: from localhost.localdomain (p5485A0CC.dip0.t-ipconnect.de [84.133.160.204])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B1B2E4AC3BC;
	Fri, 11 Jun 2010 10:58:49 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100610 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <AANLkTimC9RAD0OGArk3JAIAnDHNskJRgX1nBlcrhc7vX@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148950>

Erik Faye-Lund venit, vidit, dixit 11.06.2010 16:15:
> On Fri, Jun 11, 2010 at 3:32 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Junio C Hamano venit, vidit, dixit 10.06.2010 17:54:
>>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>>
>>>> -    ce->ce_dev = st->st_dev;
>>>> -    ce->ce_ino = st->st_ino;
>>>> -    ce->ce_uid = st->st_uid;
>>>> -    ce->ce_gid = st->st_gid;
>>>> -    ce->ce_size = st->st_size;
>>>> +    ce->ce_dev = (unsigned int)st->st_dev;
>>>> +    ce->ce_ino = (unsigned int)st->st_ino;
>>>> +    ce->ce_uid = (unsigned int)st->st_uid;
>>>> +    ce->ce_gid = (unsigned int)st->st_gid;
>>>> +    ce->ce_size = (unsigned int)st->st_size;
>>>
>>> I haven't had my morning coffee yet, but wouldn't the conversion be
>>> automatic by assignment anyway?
>>
>> Well, we do cast from dev_t etc. to unsigned int in all other places in
>> read_cache.c.
>>
> 
> The only cases where we cast anything to unsigned in on assignment in
> read-cache.h is where we assign the second-part of the ce_ctime and
> ce_mtime members:
> 	ce->ce_ctime.sec = (unsigned int)st->st_ctime;
> 	ce->ce_mtime.sec = (unsigned int)st->st_mtime;
> 
> These are indeed superfluous (as yours are) as far as I can tell.
> There's also some casts on comparison, and I think they also are
> superfluous. The current casts originate from commits fba2f38a,
> 5bcf109c, e1afca4f and 7a51ed66.
> 
> They don't do any harm though, so I don't think it makes much sense to
> remove them.
> 

OK, then we can leave them resp. leave them out until a compiler complains.

I just stumbled upon this "inconsistency" when hunting down that fs
boundary warning.

Michael
