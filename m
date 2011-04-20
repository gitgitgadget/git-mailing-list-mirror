From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] date: avoid "X years, 12 months" in relative dates
Date: Wed, 20 Apr 2011 13:00:07 +0200
Message-ID: <4DAEBCB7.80707@drmicha.warpmail.net>
References: <20110420052435.GA28597@sigill.intra.peff.net> <1d0633318ffc778dfcc1c32ecf80fca0327349d6.1303290693.git.git@drmicha.warpmail.net> <20110420101800.GA24035@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 20 13:00:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCV8s-0008S9-PA
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 13:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754231Ab1DTLAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 07:00:11 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:44516 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754202Ab1DTLAK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2011 07:00:10 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2061220B1B;
	Wed, 20 Apr 2011 07:00:10 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute5.internal (MEProxy); Wed, 20 Apr 2011 07:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=7HTFOrhaY3Qj0EoGmCm1Mt0CGdA=; b=CdUwff+PKk+yI77ywhThDUZh/dOPknDHrKfnkunher7zLStRxgMcS/8waxlprbQzOU+pK+gqCHN9b8ZuTaDCoDL8pP6dCGX98odBaIaaDTuP+Ao9kWdu+8QAWL/aYIPLlY1H6A8s7ij31Y7fAD4JDSquhDFIZwMQW8SqAgDnrng=
X-Sasl-enc: cBkmMJwWfAqUqauJ/ly3kUHltQEJCsElf292FRTjV9Sw 1303297209
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9E0ED44532B;
	Wed, 20 Apr 2011 07:00:09 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110420101800.GA24035@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171859>

Jeff King venit, vidit, dixit 20.04.2011 12:18:
> On Wed, Apr 20, 2011 at 11:12:11AM +0200, Michael J Gruber wrote:
> 
>> Implement this differently with months of size
>>
>>   onemonth = 365/12
>>
>> so that
>>
>>   totalmonths = (long)( (days + onemonth/2)/onemonth )
>>   years = totalmonths / 12
>>   months = totalmonths % 12
>>
>> In order to do this without floats, we write the first formula as
>>
>>   totalmonths = (days*12*2 + 365) / (365*2)
> 
> Well now I feel like an idiot. Algebra to the rescue.

:)

> The extra multiplications introduce the possibility of overflow, but
> since the number of days was arrived at by dividing an unsigned long
> number of seconds by 86400, we are guaranteed to have room to multiply
> by 24. :)

Also, this is inside "if (diff < 1825)", so no matter where diff comes
from, "long" is really long enough.

Cheers,
Michael
