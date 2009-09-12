From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv5 00/14] git notes
Date: Sat, 12 Sep 2009 17:50:00 +0200
Message-ID: <200909121750.00733.johan@herland.net>
References: <1252376822-6138-1-git-send-email-johan@herland.net>
 <200909080512.34634.johan@herland.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org
To: git@vger.kernel.org, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Sep 12 17:52:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmUtc-0004W0-40
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 17:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754680AbZILPuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 11:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753953AbZILPuE
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 11:50:04 -0400
Received: from smtp.getmail.no ([84.208.15.66]:38667 "EHLO
	get-mta-out03.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752625AbZILPuD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Sep 2009 11:50:03 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPV003RB7ZFQZ60@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Sat, 12 Sep 2009 17:50:03 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPV00EAJ7ZDA320@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 12 Sep 2009 17:50:03 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.9.12.153620
User-Agent: KMail/1.12.1 (Linux/2.6.30-ARCH; KDE/4.3.1; x86_64; ; )
In-reply-to: <200909080512.34634.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128255>

On Tuesday 08 September 2009, Johan Herland wrote:
> Algorithm / Notes tree   git log -n10 (x100)   git log --all
> ------------------------------------------------------------
> before / no-notes              4.78s              63.90s
> before / no-fanout            56.85s              65.69s
> 
> 16tree / no-notes              4.77s              64.18s
> 16tree / no-fanout            30.35s              65.39s
> 16tree / 2_38                  5.57s              65.42s
> 16tree / 2_2_36                5.19s              65.76s
> 
> flexible / no-notes            4.78s              63.91s
> flexible / no-fanout          30.34s              65.57s
> flexible / 2_38                5.57s              65.46s
> flexible / 2_2_36              5.18s              65.72s
> flexible / ym                  5.13s              65.66s
> flexible / ym_2_38             5.08s              65.63s
> flexible / ymd                 5.30s              65.45s
> flexible / ymd_2_38            5.29s              65.90s
> flexible / y_m                 5.11s              65.72s
> flexible / y_m_2_38            5.08s              65.67s
> flexible / y_m_d               5.06s              65.50s
> flexible / y_m_d_2_38          5.07s              65.79s

Ok, I have been pondering this back and forth, and I'm not sure what to 
think. It seems allowing (not mandating) date-based fanout gives a slight 
runtime advantage if used correctly, but I'm not sure the slight runtime 
improvement is worth the added code complexity and worse maintainability. 
I'm starting to lean against SHA1-based fanout being "good enough".

But when we look at the memory consumption, it's clear that SHA1-based 
fanout loses out (because you cannot throw away subtrees without fear that 
they will be needed again soon). Then again, memory consumption has not been 
the major focus of the git project, and 14 MB (for holding all ~157000 notes 
in the kernel repo example) is not excessive for an average desktop 
computer.

Shawn, do you have any additional defence for the date-based fanout? Are 
there untested reasonable scenarios that would show the benefits of date-
based fanout? How does the plan for notes usage in your code-review thingy 
compare to my test scenario?


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
