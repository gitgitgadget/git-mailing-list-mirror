From: Steve Diver <squelch@think.zenbe.com>
Subject: Re: [RFC] Is using git describe resilient enough for setting the
  build version of git?
Date: Sun, 21 Feb 2010 08:42:15 +0000
Message-ID: <4B80F1E7.4030803@think.zenbe.com>
References: <4B8082ED.7020505@think.zenbe.com> <32541b131002202207s7e9794cdg94d4bc305a0e9213@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 21 10:42:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nj7OY-0002dV-Mo
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 09:42:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498Ab0BUImX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2010 03:42:23 -0500
Received: from smb-out-1.zenbe.com ([67.228.244.51]:60618 "EHLO
	smb-out-1.zenbe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119Ab0BUImW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 03:42:22 -0500
Received: from cl1.app01.zenbe.com (ec2-174-129-108-13.compute-1.amazonaws.com [174.129.108.13])
	by smb-out-1.zenbe.com (Postfix) with ESMTPSA id 235F8242441;
	Sun, 21 Feb 2010 02:42:22 -0600 (CST)
X-DKIM: Sendmail DKIM Filter v2.5.4 smb-out-1.zenbe.com 235F8242441
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenbe.com; s=smb;
	t=1266741742; i=@think.zenbe.com; bh=WG+JLokcJcAutuLj0Vah3xdmoN2NE6
	pIVPaS4hInX8s=; h=Message-ID:Date:From:MIME-Version:To:CC:Subject:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding; b=o
	6yglUShEg1ez8SRbHEbqiz5TeG1n+aQxLYL9pL0jwZjExG/o1pu/MJ0gKImaTxaDAe4
	GY+3NoBMsbF9K1QqOn9REzYicpovtOIqPxokchR5whmoKKuygorNjvulFUl3alxR5Ws
	MDDQBXlJcGKNNrXe1kaYARWPyOxw1NRSYmy8=
Received: from cl1.mailapp01.zenbe.com (domU-12-31-39-00-78-F6.compute-1.internal [10.254.127.4])
	by cl1.app01.zenbe.com (Postfix) with ESMTP id A0B70321F7;
	Sun, 21 Feb 2010 08:42:21 +0000 (UTC)
Received: from [10.0.0.16] (unknown [78.145.130.107])
	by cl1.app01.zenbe.com (Postfix) with ESMTP id 2C249340A6;
	Sun, 21 Feb 2010 08:42:18 +0000 (UTC)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.1.7) Gecko/20100111 Lightning/1.0b1 Thunderbird/3.0.1
In-Reply-To: <32541b131002202207s7e9794cdg94d4bc305a0e9213@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140603>

On 21/02/2010 06:07, Avery Pennarun wrote:
>
> On Sat, Feb 20, 2010 at 7:48 PM, Steve Diver<squelch@think.zenbe.com>  wrote:
>> Reading the manual entry for "git describe"[1] there is a note saying that
>> the hash suffix does not guarantee disambiguity, and given that a tag may be
>> incorrect or missing, there is a chance - albeit with diminishing odds -
>> that the 5 digit hash/tag combination might lead to some obscure problems at
>> some point along the line.
>>
>> The chance of this happening really is low, but there is a chance all the
>> same. We cannot foresee all errors, but identifying, and further reducing
>> the odds of some must be good. Without doing the math, a guess would be that
>> the probability of a repeat 5 digit abbreviated hash suffix increases the
>> longer a tagged version is in place, so never will be 100% safe.
>
> Not really.  Note that the number *before* the hash is the number of
> commits between your version and the tag.  So the only way to get an
> actual undetectable overlap would be to have two commits that are both
> the same number of commits on top of the given tag, *and* both start
> with the same first five digits.  It's just not very likely at all.
> Besides which, using the hash code feature of git-describe is most
> useful for the short periods between versions, not as a long-term
> thing.  After a new release comes out it's unlikely anyone will care
> if the previous hash prefixes were overlapping.
>
Thanks for pointing that out, and I concede that it is most unlikely. 
Testing for a minor build revision is probably not a good idea anyway. I 
was thinking along the lines of testing for version integrity.

>> I may be wrong, but the only scenario where I see DEF_VER being used by
>> GIT-VERSION-GEN, would be when there are no tags for git describe to
>> retrieve. ie "git pull --no-tags"
>>
>> If my understanding is correct, DEF_VER is unique and set at the same time
>> as the tagged version, so wouldn't it be desirable to cross check, or
>> include this value instead of relying solely on the tag when present during
>> the generation of GIT-VERSION-FILE at build time?
>
> If I recall correctly, the main reason for DEF_VER is when building
> git from a tarball, in which case 'git describe' wouldn't be able to
> tell you anything useful.
>
I suppose my point is that relying on the tag alone via git describe, 
does not guarantee the correct displayed version. The actual minor build 
is less important. This was the only mechanism that allowed me to 
recognise something was amiss. It is the major version number that 
interests me.

Take for example a client application that tests for the git version, 
avoids problems in older versions, and utilizes features from the latest 
and greatest. This could all happen at run time, and would be fairly 
resilient, except for when the version is incorrectly applied.

If the client app used the output from my 1.7.0 build which was 
incorrectly labelled, it would not try to use feature x or would fail 
with a prompt to install a newer version. The situation could be far 
more serious if the advertised version was 1.7.0 based on a rogue tag, 
and the build was 1.5.0 - extreme and unlikely, but hopefully 
illustrates my point

What I am suggesting is that DEF_VER is not only used as fail over where 
git describe does not yield anything useful, but is also used for 
"checks and balances" purposes where git describe generates something 
different from DEF_VER.

Steve
