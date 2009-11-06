From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Timur Sufiev: Re: [PATCH I18N filenames v2 3/3] Provide
 compatibility with MinGW
Date: Fri, 06 Nov 2009 15:55:20 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0911061549380.31816@perkele.intern.softwolves.pp.se>
References: <4af3f3cb.0305560a.7a34.0f43@mx.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Timur Sufiev <tsufiev@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 16:55:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6R9x-0000eH-GN
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 16:55:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759363AbZKFPzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 10:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759351AbZKFPzT
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 10:55:19 -0500
Received: from smtp.getmail.no ([84.208.15.66]:59011 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758489AbZKFPzR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Nov 2009 10:55:17 -0500
X-Greylist: delayed 3601 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Nov 2009 10:55:17 EST
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KSP0003D049C720@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 06 Nov 2009 15:55:21 +0100 (MET)
Received: from perkele ([84.215.142.63]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KSP005N00480M00@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 06 Nov 2009 15:55:21 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.11.6.144541
Received: by perkele (Postfix, from userid 501)	id 25C2C2FC20; Fri,
 06 Nov 2009 15:55:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id 228012FC1F; Fri, 06 Nov 2009 15:55:20 +0100 (CET)
In-reply-to: <4af3f3cb.0305560a.7a34.0f43@mx.google.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132309>

Timur Sufiev:

> 1. Many git front-ends, e.g. TortoiseGit, use 8-bit set, not UTF-16:

All of them do, that is because the output is using 8-bit. That is why the 
internal encoding need to remain eight-bit, for instance UTF-8.

> they call git plumbing commands and pass filenames to command line (in 
> local 8-bit encoding).

Well, yes. On Windows, however, there is the complication that the command 
line is available in two versions. There is a eight-bit and a UTF-16 version 
of it. Which one is constructed from which depends on how the application 
was launched. We can read the UTF-16 version and hope that it contains 
proper names (possibly looking at the eight-bit version as UTF-8 if 
necessary).

> 2. UTF-16 is a proper solution for Windows, but my patch is useful for 
> other OSes with locales different from UTF-8 (e.g. Linux with KOI8-R 
> locale).

Well, your patch re-implements the fopen() calls, converting the file name 
at that point (as well as readdir() and friends). I would do that on Windows 
as well, with the modification that on Windows, I would convert to UTF-16 
and use _wfopen() instead. On systems that have it, you could also make it 
convert to UTF-32 and use their wfopen() (I'm not aware of many other OSes 
having those functions, though).

> Still there is a possibility that one day we'll stumble upon some UTF-8 
> symbol which cannot not be correctly mapped into 8-bit encoding. UTF-16 
> would be a remedy in this case, but what if don't have it (see 2)?

That is of course an issue. There are several approaches to that:

- Fail with an error.
- Convert to a place-holder character.
- QP encode the file name, perhaps?

-- 
\\// Peter - http://www.softwolves.pp.se/
