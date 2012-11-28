From: Andreas Ericsson <ae@op5.se>
Subject: Re: Possible vulnerability to SHA-1 collisions
Date: Wed, 28 Nov 2012 10:35:05 +0100
Message-ID: <50B5DAC9.7020609@op5.se>
References: <50B0AB9C.2040802@caltech.edu> <CAJo=hJsZdduMdSbN+3Ei-7vx3_Q7tO88LywWj5Vw3Ngs0QgsZg@mail.gmail.com> <20121127230753.GA22730@sigill.intra.peff.net> <20121127233016.GC3937@pug.qqx.org> <20121128002714.GA23224@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Michael Hirshleifer <111mth@caltech.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 10:35:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tde3H-0002g8-C5
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 10:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687Ab2K1JfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 04:35:14 -0500
Received: from mail-wg0-f44.google.com ([74.125.82.44]:59900 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084Ab2K1JfL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 04:35:11 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr13so3503030wgb.1
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 01:35:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=QvZZ00lRL/KdLYJqlEgCW0AZqImusKp9NXLS3h0khRA=;
        b=LWIQdPJDR4VIA5CkdZ2OJ33RC+T7F6W1CRTyBizyiwHuMVlJYnTH9TtFiRG1Wu0vDq
         j01s8medukNKSjij4sXRdKJqxJa5nd8va9fJCWN/4Zml2D4xih5ogJv8kh/cSGEmVH4S
         BfJpqzWay9YT8478wxO+kM+jZwojDdUlk6FmoCIwaUXE3nsuFSWOvZS/mXMWZntqOdNR
         +V32f0mpMFM+Efz5+zKFB61A+LDGDS4NGUas7WVjz6hDPj0b3PM5TR7zpmYw2OSVqzSo
         iDlglC6dkwo7E+xZ0SYn0EYVcGZhHzmKARQycmB6cSG6V2KLaJ7w+U6DyNnvLQdedlbM
         pQQw==
Received: by 10.216.201.130 with SMTP id b2mr7173697weo.13.1354095309858;
        Wed, 28 Nov 2012 01:35:09 -0800 (PST)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id w5sm7024857wiz.10.2012.11.28.01.35.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Nov 2012 01:35:07 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121029 Thunderbird/16.0.2
In-Reply-To: <20121128002714.GA23224@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQkzsGGSTY6X2YGoQKpeebq/11CBwl1af2EY++112g7uc0uhY94ODB2kRW5uGFwWzNkyv9is
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210724>

On 11/28/2012 01:27 AM, Jeff King wrote:
> On Tue, Nov 27, 2012 at 06:30:17PM -0500, Aaron Schrab wrote:
> 
>> At 18:07 -0500 27 Nov 2012, Jeff King <peff@peff.net> wrote:
>>> PS I also think the OP's "sockpuppet creates innocuous bugfix" above is
>>>   easier said than done. We do not have SHA-1 collisions yet, but if
>>>   the md5 attacks are any indication, the innocuous file will not be
>>>   completely clean; it will need to have some embedded binary goo that
>>>   is mutated randomly during the collision process (which is why the
>>>   md5 attacks were demonstrated with postscript files which _rendered_
>>>   to look good, but contained a chunk of random bytes in a spot ignored
>>>   by the postscript interpreter).
>>
>> I don't think that really saves us though.  Many formats have parts
>> of the file which will be ignored, such as comments in source code.
> 
> Agreed, it does not save us unconditionally. It just makes it harder to
> execute the attack. Would you take a patch from a stranger that had a
> kilobyte of binary garbage in a comment?
> 
> A more likely avenue would be a true binary file where nobody is
> expected to read the diff.
> 
>> With the suggested type of attack, there isn't a requirement about
>> which version of the file is modified.  So the attacker should be
>> able to generate a version of a file with an innocuous change, get
>> the SHA-1 for that, then add garbage comments to their malicious
>> version of the file to try to get the same SHA-1.
> 
> That's not how birthday collision attacks usually work, though. You do
> not get to just mutate the malicious side and leave the innocuous side
> untouched. You are mutating both sides over and over and hoping to find
> a matching sha1 from the "good" and "evil" sides.
> 
> Of course, I have not been keeping up too closely with the efforts to
> break sha-1. Maybe there is something more nefarious about the current
> attacks. I am just going off my recollection of the md5 collision
> attacks.
> 

AFAIR, collision attacks can be executed with a 2^51 probability (with
a 2^80 claim, that's pretty bad), but preimage attacks are still stuck
very close to the claimed 2^160.

That means every attack involving SHA1 means Mr. Malicious creates
both the involved files or does exceptional research without sharing
it.

I think git's job is to make sure that write access to only one of
the repositories is insufficient to launch an attack. If the attacker
manages to change all repositories involved then the hash function
used is really quite irrelevant.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
