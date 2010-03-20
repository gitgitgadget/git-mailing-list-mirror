From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Sat, 20 Mar 2010 12:30:02 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1003201209260.7596@pacific.mpi-cbg.de>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 12:29:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NswrU-00007I-NF
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 12:29:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650Ab0CTL24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 07:28:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:41441 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751458Ab0CTL2z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 07:28:55 -0400
Received: (qmail invoked by alias); 20 Mar 2010 11:28:53 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp013) with SMTP; 20 Mar 2010 12:28:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ozvwKmIvoOhx9z3Km/Ec3oRn0Dg87gIaoLAr2SF
	9hP1Q4zglW/Rtf
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53000000000000003
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142703>

Hi,

On Sat, 20 Mar 2010, Bo Yang wrote:

> I am very interested in the project 'Line-level history browser', after 
> some days consideration, now I made up a draft of my proposal, I think 
> it is helpful to send it to the list before submitting it. Could you 
> please give me some advise?

I like it very much already! You obviously put in a substantial amount of 
time to learn intricate details about the way Git operates, and what is 
already available.

And you also provided a patch (unrelated to line-level history browser), 
so you proved that you actually cloned Git, and that you can actually 
patch it and use Git itself to send a patch to this list.

Very good.

Just a few constructive criticisms (inlined):

> This project will add a new utility for git called 'git line-log'. It 
> can trace the history of any line range of certain file at any revision.

I think that that might be good for starters, but one could imagine that 
an integration into "git log" might be even better, so that gitk can use 
this without any further changes.

> For simplity, users can run the command like: ' git line-log 
> builtin/diff.c 6..8 ', he will get the change history of code between 
> line 6 and line 8 of the diff.c file.

It would be good if the code looked harder after failing with the simple 
strategy, such as looking for code removed in other files, fuzzy matching 
(optional), and looking for code duplication (i.e. literal copying, or 
slightly modified copying).

The fuzzy matching might be necessary to catch things like a Java class 
moving from one file into another (and changing its name): the first line 
changes, but not completely.

> After reading some libxdiff document and code, I find that libxdiff 
> output all the diff blocks as string into a memory file.

Almost.

Just have a look at the word-level diff (--color-words):

http://repo.or.cz/w/git/dscho.git/blob/bc1ed6aafd9ee4937559535c66c8bddf1864bec6:/diff.c#l382

You will see that there is a function fn_out_diff_words_aux(), which is 
passed to xdi_diff_outf(). That latter function calls xdiff such that the 
former function receives a complete line at a time. And this is what I 
would suggest doing in the line-level log, too.

Ciao,
Dscho
