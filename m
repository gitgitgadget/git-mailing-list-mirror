From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Approxidate with YYYY.MM
Date: Tue, 10 May 2011 09:08:01 +0200
Message-ID: <4DC8E451.7090702@drmicha.warpmail.net>
References: <CAE5FB52-0F90-4F21-828F-7E40ED596B33@gernhardtsoftware.com> <4DC8DCC2.8050208@drmicha.warpmail.net> <4DC8E129.2020306@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue May 10 09:08:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJh3G-0003yp-2O
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 09:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216Ab1EJHIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 03:08:05 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:46554 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751140Ab1EJHID (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2011 03:08:03 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id F35A420A10;
	Tue, 10 May 2011 03:08:02 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute4.internal (MEProxy); Tue, 10 May 2011 03:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=g4cLiWtsBc4hrXztCUrXiSq6ufM=; b=LJ9FtYSyCpzvi4IHCn+ygLp/ZysCi7m6AjoMyhkL+kvs/6U9XYIePSE8t+NX3LQmOP0zHWz0a+BCdtn6QFjvcOhxppWHtU/tGX7f1mIw21Lpv/5VXFAWKcNUTtvMtrNOKDvZds7rJaSf+MI52W9GMcGG8+bgs17rbz7zZBSLVXY=
X-Sasl-enc: p/ZjjO18e8chXYT+iFMlRY6aR2gG48wP0s8K0LE4hyB0 1305011282
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 61D4144742F;
	Tue, 10 May 2011 03:08:02 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <4DC8E129.2020306@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173318>

Andreas Ericsson venit, vidit, dixit 10.05.2011 08:54:
> On 05/10/2011 08:35 AM, Michael J Gruber wrote:
>> Brian Gernhardt venit, vidit, dixit 09.05.2011 21:02:
>>> (This is in response to a discussion on #parrot.)
>>>
>>> Rakudo (https://github.com/rakudo/rakudo/) uses tags of the form
>>> YYYY.MM for their monthly releases.  When we were attempting to find
>>> the cause of a slowdown, somewhat was trying to find what commits
>>> occurred after the 2011.01 release with "git log --after=2011.01".
>>> His mistake was pointed out but this led to the confusion of why this
>>> was parsed as "May 1 2011" instead of "Jan 1 2011".  Shouldn't
>>> date.c:match_multi_number() parse something with only two numbers as
>>> a beginning of month instead of allowing it to pass through to the
>>> generic parsing?
>>
>> I just don't think there is a format like that. There is dd.mm.[yy]yy
>> and apparently also yyyy.mm.dd, but without leading zeros in mm for the
>> latter. Our date parser also takes "." for a space so that you don't
>> need to quote a space ("1.day.ago"). I can see the logic behind parsing
>> 2011.01 as January 2011, but it's a stretch from the existing formats:
>>
> 
> It would be far more logical to parse "2011-01" as "January 2011" as
> that's the preferred way to write month-precision dates in most
> countries that use both the metric system and the gregorian calender.
> 
> I've never seen that date-type with dot as a separator, but with the
> dash it's very, very common.
> 

Exactly that's what I wrote. People misuse the dot format probably as
frequently as the dash format, in the sense that the use an ordering
which is wrong for the respective separator. We currently parse n.m as
day n of month m of the current year for certain n only: We parse

31.3. as March 3rd of the current year
32.3. as May 3rd of 2032

(because May is the current month) which does not make that much sense,
admittedly. I would have hoped the latter to be April 1st (current
year). I agree that defaulting the month to the current month in the dot
format makes no sense, but I think (and I guess we disagree here) that
it's a matter of garbage in - garbage out. As for turning that garbage
into marbles: 32.3. == 1.4. seems more logical to me. Note that for example

2020.9.11 -> 2020-11-09 07:06:16 +0000

which means that we *never* parse the Chinese yyyy.mm.dd correctly, not
even the complete form!

Michael
