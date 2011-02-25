From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Why doesn't git commit -a track new files
Date: Fri, 25 Feb 2011 10:03:16 +0100
Message-ID: <4D677054.9050908@drmicha.warpmail.net>
References: <20110224112246.3f811ac2@glyph> <4D6672F7.4020101@drmicha.warpmail.net> <20110224154908.GA29309@sigill.intra.peff.net> <4D667F1A.5060408@drmicha.warpmail.net> <20110224160027.GA30275@sigill.intra.peff.net> <4D6680F3.1000205@drmicha.warpmail.net> <20110224160932.GC30275@sigill.intra.peff.net> <4D676D99.2010600@drmicha.warpmail.net> <20110225090126.GA16861@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Marco <netuse@lavabit.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 25 10:06:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PstdN-0005U9-Mz
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 10:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755132Ab1BYJGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 04:06:39 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57734 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754387Ab1BYJGf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 04:06:35 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id CEE5A206C3;
	Fri, 25 Feb 2011 04:06:34 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 25 Feb 2011 04:06:34 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=YvCPEDHQLnD02RTvBtA+hOBUmbE=; b=ZMWuTYH+sh23nVEyFTF0do0y3hKgjJ0ya4XgGVuXjMG18Qt3DjZTUT6+vTYISr02OKo7jDJAqzYcQNnbG/jhSTmOXIyoXyQ/QRwznnL1mIH/kK8M12E2bGoLNgtivAySwXYsvFTytpAcccS2TlorElEZwckMw68JPuItanN81cY=
X-Sasl-enc: ut5RhwH36Fhwy6amC+CSonqqfs1zMzEmZVdo6lhk+Ga/ 1298624794
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 383C9406A93;
	Fri, 25 Feb 2011 04:06:34 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <20110225090126.GA16861@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167888>

Jeff King venit, vidit, dixit 25.02.2011 10:01:
> On Fri, Feb 25, 2011 at 09:51:37AM +0100, Michael J Gruber wrote:
> 
>>> I assumed that:
>>>
>>>  git commit -a <path>
>>>
>>> would behave more like the "git add -u <path>" case; add new stuff to
>>> the index from <path>, and then commit those changes plus whatever was
>>> already in the index.
>>
>> Yes, you're right. I haven't wrapped my brain completely around those
>> mixed cases yet (changes in index + pathspec argument). My aim is that
>>
>> "git commit <addoptions> <commitoptions> [<pathspec>]"
>>
>> would be equivalent to (the atomic version of)
>>
>> "git add <addoptions> [<pathspec>] && git commit <commitoptions>"
>>
>> and that is difficult because currently, pathspecs are "limiting" for
>> commit and "additive" for add without -u. I mean, I don't want to break
>> anything, at least not before 1.8.0..
> 
> I don't think there is any breakage with "-a" (or "-A") there, as you
> are adding a new mode of operation that currently doesn't work (e.g.,
> right now "git commit -a foo" will die). The only thing that would not
> work is trying to make:
> 
>   git add <path> && git commit
> 
> the same as
> 
>   git commit <path>
> 
> But I am not sure that is a good idea anyway. Yes, it is a little
> inconsistent with the other forms, but I think it is generally what you
> want

Very true. I guess that nails our specification.

> (which is why the default for commit with paths switched from "-i"
> to "-o" long ago).

...before my time (or under my radar).

Equivalent options and slightly different defaults should be fine, just
as you explained.

"-i" is implicit for "add" and "-o" is nonsensical/unnecessary (there is
no temp. index for add, but there is reset), so those need not be covered.

Michael
