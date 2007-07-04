From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] git-repack: generational repacking (and example hook
 script)
Date: Wed, 04 Jul 2007 12:05:54 +1200
Message-ID: <468AE462.1040202@vilain.net>
References: <1183193781941-git-send-email-sam.vilain@catalyst.net.nz> <11831937813223-git-send-email-sam.vilain@catalyst.net.nz> <11831937822346-git-send-email-sam.vilain@catalyst.net.nz> <11831937823184-git-send-email-sam.vilain@catalyst.net.nz> <11831937823982-git-send-email-sam.vilain@catalyst.net.nz> <1183193782172-git-send-email-sam.vilain@catalyst.net.nz> <11831937822249-git-send-email-sam.vilain@catalyst.net.nz> <11831937823756-git-send-email-sam.vilain@catalyst.net.nz> <11831937822950-git-send-email-sam.vilain@catalyst.net.nz> <11831937823588-git-send-email-sam.vilain@catalyst.net.nz> <1183193782608-git-send-email-sam.vilain@catalyst.net.nz> <alpine.LFD.0.999.0707022331080.26459@xanadu.home> <4689D77D.20601@vilain.net> <alpine.LFD.0.999.0707031020300.26459@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Jul 04 02:06:34 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5sO8-0005Bh-LD
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 02:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286AbXGDAGU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 20:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753462AbXGDAGU
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 20:06:20 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:47323 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930AbXGDAGT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 20:06:19 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 854CB13A4F6; Wed,  4 Jul 2007 12:06:16 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 7F25E13A4EA;
	Wed,  4 Jul 2007 12:06:12 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <alpine.LFD.0.999.0707031020300.26459@xanadu.home>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51553>

Nicolas Pitre wrote:
>> 1. Do you agree that some users would want their git repositories to be
>> "maintenance free"?
>
> I'm not so sure.

Well, no offence, but I think you should withhold from voicing a
fundamental concern as this, because you're not one of its target users.

I'd be more than happy to reshape the patch so that it does not
introduce this "complexity" into the current code path.  Potentially it
could entirely fit into the post-commit hook, which should not upset
anybody as they don't have to turn it on.  I just noticed that the
"repack -a" code path was already doing a lot of what a generational
repack would have to do, so thought I'd re-use the code.

Of course your critical analysis of code is more than welcome.

> And even if your developers are completely inept to the point of not 
> wanting to run 'git gc' once a week for example, 

This kind of characterisation does not help the discussion.

> I'm sure you can automate 
> some of that maintenance asynchronously from a simple post commit hook 
> or something, based on the output of 'git count-objects -v'.

Yet another little command that I didn't know about that could make the
 patch simpler.

Potentially the calculations could be performed in count-objects.  I'll
investigate that.

>> 2. Do you agree that having thousands of packs would add measurable
>> overhead?
> 
> Sure it would, but far less as it used to when we last discussed this 
> since performances in those cases has been improved significantly.

Far less for examining recent history.  It would however make examining
older history, and potentially blame operations slower.  Just how much
slower I don't know, but I'd guess that random access with 1000 small
indices scanned sequentially is slower than with 10 larger indices.

> And if you end up with thousands of packs in the first place I think you 
> have a more fundamental problem to fix, something that generational 
> repacking would just paper over.

Right, but only if you are of the opinion that a repack is something
that is best run off-line from normal work flow.  If you want it to run
in-line, then the fundamental problem would be "a simple operation now
takes much longer because a huge repack is occurring".

So I think this fundamental decision is more of a user preference.

Sam.
