From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH 2/2] status -s: obey color.status
Date: Fri, 27 Nov 2009 10:17:00 +0100
Message-ID: <4B0F990C.2010805@drmicha.warpmail.net>
References: <cover.1259248243.git.git@drmicha.warpmail.net> <26d0a2022638ad7b75268ca291b8d02a22f1f66c.1259248243.git.git@drmicha.warpmail.net> <7vws1cwnu0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 10:18:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDwyH-00065l-AV
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 10:18:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbZK0JSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 04:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbZK0JSG
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 04:18:06 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:49468 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750983AbZK0JSF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Nov 2009 04:18:05 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 92665C2025;
	Fri, 27 Nov 2009 04:18:10 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 27 Nov 2009 04:18:10 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=WDxSFM8vQ55c7cwbU3L37TJQ+bQ=; b=sIiYVDJpclXibWwWXAxjMUBV+fs14dJ1AHZBLQh0PUa9yi4PFW9wbimhZpCiLEE+SdOySUc6ZEDqARa/uvqiI4/vI1RulkEpijtzEc+V/VIZoQOAcbXwJMLSW0/U4LVlT347QBmbzvC9OK3sYStO/O0+Lt+OtQdiuwVcDAsUfSI=
X-Sasl-enc: WDMo+iAATvECNjrHx8MPw8n6gecFhWUU1YeVPhksdzXE 1259313490
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F342016D3C;
	Fri, 27 Nov 2009 04:18:09 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091125 Lightning/1.0pre Shredder/3.0.1pre
In-Reply-To: <7vws1cwnu0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133881>

Junio C Hamano venit, vidit, dixit 27.11.2009 06:15:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> * Should I rename wt-status.c's color() into something more unique when
>>   I export it?
> 
> Is it an option to instead move short_unmerged(), short_status() and
> friends to wt-status.c from builtin-commit.c?  It's been quite a while
> since I worked on the code, so I don't recall why it needs such cross
> references at low level between two files.

I didn't notice, but I'll look into it during the rewrite.

>> * Is there any policy regarding use of putchar/puts vs. printf?
> 
> J6t addressed it.  You have mixture of putchar(' ') and printf(" ") which
> looks somewhat funny ;-)

;) I'm happy with printf("c"), I just thought someone would find printf
overkill for a format less char.

>> * The way it is done now I "color" a space, otherwise one would need to
>>   break down the print statements even more. Since we always color the
>>   foreground only it is no problem, is it?
> 
> Some people do configure to use "reverse".  For example, I have:
> 
>     [diff.color]
>             old = red reverse
>             whitespace = blue reverse
> 
>     [status.color]
>             updated = green
>             changed = red
>             untracked = blue reverse
> 
> The output should be consistent between long and short format (I do not
> offhand recall what we do for the long format, though).

Oh, I didn't know about reverse. In this case I have to change the code
and leave the space alone. (The one between ?? and the filename.) Will do.

In the long format, only the file name is colored. Note that in the
short format, it does not make sense to color the file name because one
line may represent two pieces of status information. That is why I color
the two status letters and not the file name.

Michael
