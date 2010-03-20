From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Sat, 20 Mar 2010 14:36:25 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1003201432410.7596@pacific.mpi-cbg.de>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>  <alpine.DEB.1.00.1003201209260.7596@pacific.mpi-cbg.de> <41f08ee11003200610n2c7c9684l6ca200cffdfdb434@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 14:35:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsyps-0003iC-0O
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 14:35:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640Ab0CTNfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 09:35:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:51594 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751527Ab0CTNfW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 09:35:22 -0400
Received: (qmail invoked by alias); 20 Mar 2010 13:35:20 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp023) with SMTP; 20 Mar 2010 14:35:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Y5VAN1zNYSayVdhsfSDrXxVjK0+1jhfdEszp0GW
	5Aj63eqqs4kh/+
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <41f08ee11003200610n2c7c9684l6ca200cffdfdb434@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55000000000000004
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142708>

Hi,

[please do not cull the Cc: list]

On Sat, 20 Mar 2010, Bo Yang wrote:

> I (Johannes) wrote:
>
> > I think that that might be good for starters, but one could imagine 
> > that an integration into "git log" might be even better, so that gitk 
> > can use this without any further changes.
> 
> So, I think add some new options to 'git log' is preferred.

Yes, I think that this should be the target for the user interface. 
However, the logic should be different enough to merit a completely new 
file for the code (think "git add --interactive").

> > It would be good if the code looked harder after failing with the 
> > simple strategy, such as looking for code removed in other files, 
> > fuzzy matching (optional), and looking for code duplication (i.e. 
> > literal copying, or slightly modified copying).
> >
> > The fuzzy matching might be necessary to catch things like a Java 
> > class moving from one file into another (and changing its name): the 
> > first line changes, but not completely.
> 
> That's really a good idea.
> So, when the program reach the end of the history thread of some
> changes of line range, it should not stop immediately. It then should
> make a harder code search and try to find whether the new add lines of
> code is moved to there or just copied from other place to there. And
> these kind of search should use fuzzy matching instead of exact string
> matching.
> 
> But notice that, detect code movement in one commit is much efficient
> than detecting code copy. So, I think we should add an option to
> control whether we detect such kind of code copy. By default, we
> detect code move but not code copy. How do you think about this?

Yes, it is much more difficult, and it is more expensive. So: there are 
several steps in the project (you could also call them "milestones"), and 
fuzzy matching end lines would come later than simple code movement. And 
still later than code movement between files.

> > Just have a look at the word-level diff (--color-words):
> >
> > http://repo.or.cz/w/git/dscho.git/blob/bc1ed6aafd9ee4937559535c66c8bddf1864bec6:/diff.c#l382
> >
> > You will see that there is a function fn_out_diff_words_aux(), which 
> > is passed to xdi_diff_outf(). That latter function calls xdiff such 
> > that the former function receives a complete line at a time. And this 
> > is what I would suggest doing in the line-level log, too.
> 
> I have look over the function fn_out_diff_words_aux, this function parse 
> each line of a memory diff. We can use it to detect the diff hunk head 
> and find the line change. If you think the performance is acceptable, I 
> think using this callback mechanism is all right.

Yes, I think that the performance is alright there, it works well enough 
for --color-words.

Thanks,
Dscho
