From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff-tree: stop on broken output pipe
Date: Sat, 7 Jan 2006 01:41:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601070134010.30029@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0601020116020.11331@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vhd8ht24d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 01:41:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ev29d-0003nJ-Hn
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 01:41:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbWAGAly (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jan 2006 19:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbWAGAly
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jan 2006 19:41:54 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:58278 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030247AbWAGAlx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2006 19:41:53 -0500
Received: from amavis.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3C1F513FF72; Sat,  7 Jan 2006 01:41:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by amavis.mail (Postfix) with ESMTP id 2E7C71CB6;
	Sat,  7 Jan 2006 01:41:50 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by amavis.mail (Postfix) with ESMTP id 113E61874;
	Sat,  7 Jan 2006 01:41:50 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id F24CF13FF72; Sat,  7 Jan 2006 01:41:49 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhd8ht24d.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Spam-Status: No, hits=0.0 tagged_above=0.0 required=8.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14232>

Hi,

On Fri, 6 Jan 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > 	Without this, on my iBook git-whatchanged keeps running when I 
> > 	quit "less". I have to interrupt the process a second time. No
> > 	idea why it works on Linux.
> >
> > -		if (!no_commit_id)
> > -			printf("%s%c", header, diff_options.line_termination);
> > +		if (!no_commit_id && printf("%s%c", header,
> > +				diff_options.line_termination) < 0)
> > +			die("broken output pipe");
> >  		header = NULL;
> 
> There are tons of output other than this printf() and catching
> an output error only on this one and assuming that is a broken
> pipe somehow feels doubly wrong to me.

Welcome back! Hope you had a good time, and the fish tasted fine.

There really are tons of printf(), but

- I did not want to be invasive,
- if one printf() fails, the next will, too (probably), and
- the problem occurs only on macosx here.

Maybe it is not correct to assume that the output pipe is broken, but it 
is an error to keep going when printf() fails. So I picked one printf() 
which is called regularly.

Andreas said that a SIGPIPE should be thrown, and bash should kill the 
script. I have not found out why my bash doesn't. Until I do, I will have 
this patch in my local git (and a similar patch in git-rev-list). It just 
is plain annoying when git-whatchanged (the git script I use most often) 
hangs there, burning cycles.

Ciao,
Dscho
