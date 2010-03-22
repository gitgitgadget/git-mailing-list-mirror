From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Mon, 22 Mar 2010 19:21:59 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1003221910520.7596@pacific.mpi-cbg.de>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com> <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com> <4BA544FC.7050007@gmail.com> <41f08ee11003202316w2fddc5f4jebda47f325451577@mail.gmail.com> <4BA61CF9.7040104@gmail.com>
 <41f08ee11003212052p6b0a7495j2e38f24839541ffb@mail.gmail.com> <m3hbo8jr2e.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bo Yang <struggleyb.nku@gmail.com>, gitster@pobox.com,
	gitzilla@gmail.com, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 19:22:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtmGS-0006Jj-HB
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 19:22:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753581Ab0CVSWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 14:22:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:57819 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752767Ab0CVSWD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 14:22:03 -0400
Received: (qmail invoked by alias); 22 Mar 2010 18:22:00 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp062) with SMTP; 22 Mar 2010 19:22:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/gCUlVxzPg0dg4wrF3ujZbxCfenbKcIH4pisBBOq
	rnAqwBQf5xJhDz
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <m3hbo8jr2e.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.56000000000000005
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142955>

Hi,

On Mon, 22 Mar 2010, Jakub Narebski wrote:

> Bo Yang <struggleyb.nku@gmail.com> writes:
> 
> > This project will add a new feature for 'git log' to display line 
> > level history. It can trace the history of any line range of certain 
> > file at any revision. For simplity, users can run the command like: ' 
> > git log -L builtin/diff.c:6,8 ', he will get the change history of 
> > code between line 6 and line 8 of the diff.c file.
> 
> I think that, at least at first, line-level log should follow the
> git-blame, i.e.
> 
>   git log -L <begin>,<end>  <revs>  -- <file>
> 
> If we want (in the future) to follow history of some lines from one
> file, and other lines from other file together, we do not need to use
> 
>   -L <file>:<begin>,<end>
> 
> syntax.  If parseopt allows, we can use posotion of parameters, i.e.
> 
>   <file1> -L <m>,<n>   <file2> -L <k>,<j>

Oh, is it bikeshedding time already? /me might have missed the start 
signal.

> > And for each history entry, it will provide the commits, the diff 
> > block which contains changes of users' interested lines.
> 
> The most important *new* algorithm you need to implement is, after 
> finding (blame-like) the commit that created given version of given 
> line, what was previous version of given line and which line that was.
> 
> You can probably find some heuristic in existing merge tools, like
> emerge from GNU Emacs, or graphical diff tools.

I do not think that these tools can help, as they never look further than 
identical lines (and they mustn't, either).

More importantly, the first step really is about driving the libxdiff in 
such a way that you can recognize the exact same lines.

(One point to note for the technical details: the algorithm has to expect 
opposite code moves, i.e. it must cope well when the diff shows the code 
in question removed in one hunk and added in another.)

We also should not get ahead of ourselves, but allow the student to get a 
full understanding of the requirements, from which he can then make a 
project plan (with milestones, Christian, no problem).

BTW by "requirements" I do not mean something as technical as the syntax, 
but rather a definition what people should be able to expect to do with 
this at the end of the summer.

As to fuzzy matching of lines that could not be attributed otherwise, I 
think that that will require a lot of playing around with different ideas. 
A simple Levenshtein-Damerau is highly unlikely to be enough.

Ciao,
Dscho
