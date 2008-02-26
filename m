From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Correcting timestamps when importing archives to git
Date: Tue, 26 Feb 2008 12:17:35 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802261215171.17164@racer.site>
References: <47C3FBC4.4030206@dgreaves.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Greaves <david@dgreaves.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 13:19:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTyle-0000VM-KQ
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 13:18:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbYBZMSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 07:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750695AbYBZMSE
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 07:18:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:60604 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750720AbYBZMSD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 07:18:03 -0500
Received: (qmail invoked by alias); 26 Feb 2008 12:18:01 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp032) with SMTP; 26 Feb 2008 13:18:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX188qacBbHg8iZ+cIYSuNNEGT6pnWXQZR5GUqsjQWf
	p1UdyZS/QbzI40
X-X-Sender: gene099@racer.site
In-Reply-To: <47C3FBC4.4030206@dgreaves.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75125>

Hi,

On Tue, 26 Feb 2008, David Greaves wrote:

> I recently converted a set of patches to a git repository.
> 
> In order to use the correct timestamps my script used a 'faketime' 
> solution I found here:
>
>   http://www.code-wizards.com/projects/libfaketime/
> 
> I used a perl subroutine that takes a time (obtained by stat()ing the 
> original patch or looking in logs) and then the normal 'system()' args.
> 
> sub faketime_system {
>     my $time=shift;
> 
> $ENV{"LD_PRELOAD"}="/everything/devel/faketime/libfaketime-0.6/libfaketime.so.1";
>     $ENV{"FAKETIME_FMT"}='%s';
>     $ENV{'FAKETIME'}=$time;
>     system @_;
>     $ENV{"LD_PRELOAD"}="";
> }
> 
> 
> so:
> 	$time=(stat("$tarfile"))[9];
> 	faketime_system ($time, "tar xfj $tarfile");
> 
> or:
>     $time=(stat("$patchfile"))[9];
>     faketime_system ($time, "zcat $patchfile | patch -f -p1");
>     faketime_system ($time, "git add .");
> 
> HTH someone else...

Wow.  That is sure one of the most complicated ways to go about it.

IMO GIT_AUTHOR_DATE and GIT_COMMITTER_DATE (mentioned in 
Documentation/git.txt, and described in Documentation/git-commit-tree.txt) 
would have been the tools to use.

Hth,
Dscho
