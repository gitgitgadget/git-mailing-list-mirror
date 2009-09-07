From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: tracking branch for a rebase
Date: Mon, 07 Sep 2009 10:14:06 +0200
Message-ID: <4AA4C0CE.2070300@drmicha.warpmail.net>
References: <20090904135414.GA3728@honk.padd.com> <4AA124DD.1030208@drmicha.warpmail.net> <20090904181846.GC19093@coredump.intra.peff.net> <20090904185949.GA21583@atjola.homenet> <20090905061250.GA29863@coredump.intra.peff.net> <20090905140127.GA29037@atjola.homenet> <20090905142841.GB15631@coredump.intra.peff.net> <7vfxaz9wfi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 10:14:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkZNA-0000X0-RD
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 10:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbZIGIOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 04:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751921AbZIGIOS
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 04:14:18 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37238 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751909AbZIGIOR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Sep 2009 04:14:17 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3D71565E52;
	Mon,  7 Sep 2009 04:14:19 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 07 Sep 2009 04:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=hvahCYL5SLP6wFCCUPjRJSLu7ck=; b=YBqf6npnS8ATzxuZUmfOTOmXE1QtHhUIqX/2PZCLX6a/+Ut12epBmtiBAp6bYB8RMIGhmOas8keBG13ROgzy8lx3RcL1Bxt9KX1qMYPOoGx8EDGqaC+H/i8WHwUpFArrCaOwOeInZiUqSudLfKGqjjh/zpD7OJklgzk/TPLltBs=
X-Sasl-enc: 59sw419UUY69OfPR85Pn6/yOSIQRpirD2l2xGYBIDDQF 1252311258
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 369604844;
	Mon,  7 Sep 2009 04:14:18 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20090902 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <7vfxaz9wfi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127899>

Junio C Hamano venit, vidit, dixit 07.09.2009 07:05:
> Jeff King <peff@peff.net> writes:
> 
>>> Hm, I'd prefer a shorthand for "upstream for this branch", instead of
>>> magic defaults.
>>
>> The more I think about, the more I think that is the right solution.
>> Because magic defaults for "rebase -i" don't help when you want to do
>> "gitk $UPSTREAM..".
>>
>> The previous discussion on the topic seems to be here:
>>
>>   http://article.gmane.org/gmane.comp.version-control.git/113666
>>
>> And apparently you and I both participated in the discussion, which I
>> totally forgot about.
>>
>> Looks like the discussion ended with people liking the idea but not
>> knowing what the specifier should look like. Maybe tightening the ref
>> syntax a bit to allow more extensible "special" refs is a good v1.7.0
>> topic? I dunno.
> 
> At-mark currently is reserved for anything that uses reflog, but we can
> say that it is to specify operations on refs (as opposed to caret and
> tilde are to specify operations on object names).
> 
> It specifies what ref to work on with the operand on its left side (and an
> empty string stands for "HEAD"), and what operation is done to it by what
> is in {} on the right side of it.  This view is quite consistent with the
> following existing uses of the notation:
> 
> 	ref@{number}	-- nth reflog entry
>         ref@{time}	-- ref back then
> 	@{-number}	-- nth branch switching
> 
> So perhaps ref@{upstream}, or any string that is not a number and cannot
> be time, can trigger the magic operation on the ref with ref@{magic}
> syntax?

Even @{} is not taken so far... Alternatively, most people associate '^'
with 'up', just the way we use it for "upwards parentship" ref^ (and
somewhat the way we use it for upwards/backwards tag reference
relationship resolving ref^{type}), so
@^
or
@{^}
would be an option. Read "at upstream" :)

Michael
