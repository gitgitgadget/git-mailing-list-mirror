From: Andreas Ericsson <ae@op5.se>
Subject: Re: Problem with large files on different OSes
Date: Wed, 27 May 2009 13:37:56 +0200
Message-ID: <4A1D2614.5060303@op5.se>
References: <submission.1M9Gk0-0000N8-MQ@mail.cs.st-andrews.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Christopher Jefferson <caj@cs.st-andrews.ac.uk>
X-From: git-owner@vger.kernel.org Wed May 27 13:38:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9HSv-0007TP-Q9
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 13:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761648AbZE0LiE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 07:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761588AbZE0LiE
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 07:38:04 -0400
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:57287 "HELO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757436AbZE0LiD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 May 2009 07:38:03 -0400
Received: from source ([72.14.220.154]) by na3sys009aob112.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSh0mFSPsQkeGNTXumh6QCDkYkL/Pyuv/@postini.com; Wed, 27 May 2009 04:37:58 PDT
Received: by fg-out-1718.google.com with SMTP id e12so1693484fga.10
        for <git@vger.kernel.org>; Wed, 27 May 2009 04:37:56 -0700 (PDT)
Received: by 10.86.49.13 with SMTP id w13mr23009fgw.31.1243424276393;
        Wed, 27 May 2009 04:37:56 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 4sm15779938fgg.13.2009.05.27.04.37.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 May 2009 04:37:55 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <submission.1M9Gk0-0000N8-MQ@mail.cs.st-andrews.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120059>

Christopher Jefferson wrote:
> I recently came across a very annoying problem, characterised by the 
> following example:
> 
> On a recent ubuntu install:
> 
> dd if=/dev/zero of=file bs=1300k count=1k
> git commit file -m "Add huge file"
> 
> 
> The repository can be pulled and pushed successfully to other ubuntu 
> installs, but on Mac OS X, 10.5.7 machine with 4GB ram git pull produces:
> 
> remote: Counting objects: 6, done.
> remote: git(1533,0xb0081000) malloc: *** mmap(size=1363152896) failed 
> (error code=12)
> remote: *** error: can't allocate region
> remote: *** set a breakpoint in malloc_error_break to debug
> remote: git(1533,0xb0081000) malloc: *** mmap(size=1363152896) failed 
> (error code=12)
> remote: *** error: can't allocate region
> remote: *** set a breakpoint in malloc_error_break to debug
> remote: fatal: Out of memory, malloc failed
> error: git upload-pack: git-pack-objects died with error.
> fatal: git upload-pack: aborting due to possible repository corruption 
> on the remote side.
> remote: aborting due to possible repository corruption on the remote side.
> fatal: protocol error: bad pack header
> 
> 
> The problem appears to be the different maximum mmap sizes available on 
> different OSes. Whic I don't really mind the maximum file size 
> restriction git imposes, this restriction varying from OS to OS is very 
> annoying, fixing this required rewriting history to remove the commit, 
> which caused problems as the commit had already been pulled, and built 
> on, by a number of developers.
> 
> If the requirement that all files can be mmapped cannot be easily 
> removed, would be it perhaps be acceptable to impose a (soft?) 1GB(ish) 
> file size limit?

Most definitely not. Why should we limit a cross-platform system for
the benefit of one particular developer's lacking hardware?

Such a convention should, if anything, be enforced by social policy,
but not by the tool itself.

Otherwise, why not just restrict the tool that created the huge file
so that it makes smaller files that fit into git on all platforms
instead? (No, that wasn't a real suggestion. It was just to make the
point that your suggestion for git to impose artificial limits is
equally ludicrous)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
