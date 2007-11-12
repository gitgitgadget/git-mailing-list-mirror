From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 12 Nov 2007 12:21:34 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711121203150.4362@racer.site>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org>
 <7vmytycykt.fsf@gitster.siamese.dyndns.org> <7vr6j6ve90.fsf@gitster.siamese.dyndns.org>
 <7vir4d40sw.fsf@gitster.siamese.dyndns.org> <7vwsso3poo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 13:22:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrYIp-0002Ya-Bt
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 13:22:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758011AbXKLMVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 07:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758174AbXKLMVu
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 07:21:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:38506 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757929AbXKLMVt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 07:21:49 -0500
Received: (qmail invoked by alias); 12 Nov 2007 12:21:47 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 12 Nov 2007 13:21:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18r/pR3NgUrssBPEpfU4CwtmkptEg78/K7PvzSTcO
	wDbFG7IV7aLFNE
X-X-Sender: gene099@racer.site
In-Reply-To: <7vwsso3poo.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64608>

Hi,

On Sun, 11 Nov 2007, Junio C Hamano wrote:

> * js/rebase-detached (Thu Nov 8 18:19:08 2007 +0000) 1 commit
>  + rebase: operate on a detached HEAD

Note: this might have a subtle bug when the last patch in the series 
failed.  If I was not too tired this morning (which might well have been 
the case), rebase could not switch back to the branch correctly with this.

> ----------------------------------------------------------------
> [Approaching 'next']
> 
> * kh/commit (Sun Nov 11 17:36:52 2007 +0000) 12 commits
>  - builtin-commit: Add newline when showing which commit was created
>  - builtin-commit: resurrect behavior for multiple -m options
>  - builtin-commit --s: add a newline if the last line was not a S-o-b
>  - builtin-commit: fix --signoff
>  - git status: show relative paths when run in a subdirectory
>  - builtin-commit: fix author date with --amend --author=<author>
>  - builtin-commit: Refresh cache after adding files.
>  - builtin-commit: fix reflog message generation
>  - launch_editor(): read the file, even when EDITOR=:
>  - Port git commit to C.
>  - Export launch_editor() and make it accept ':' as a no-op editor.
>  - Add testcase for ammending and fixing author in git commit.
> 
> Dscho fixed a handful obvious glitches.  I am hoping that this
> series should be in "testable" shape now.  Will merge to "next"
> after giving it a final round of eyeballing.

FWIW I am running 'next'+builtin-commit+a couple of other patches I am 
brewing.  These issues are on my TODO list (most pressing first):

- commit --amend <file> erroneously commits other files that were
  git-add'ed
- under certain circumstances (my maildir update script) does not
  show newly created and deleted files anymore.
- do not rebuild the whole index when committing just one file,
  instead use the old index, and then adjust it to the HEAD.
- remove "launching editor, logfile (null)" message
- forward port 6d4bbebd35e3a6e8091d7188f1c4d49af7f054e3 to builtin-commit
- when a message is given and no editor should be launched, avoid
  lengthy runstatus calculation

Clarification for the "do not rebuild" thingie:  ATM it seems that there 
is a lengthy calculation going on, even if the index is clean and you only 
passed one single filename on the command line.

> * sp/refspec-match (Sun Nov 11 15:01:48 2007 +0100) 4 commits
>  - refactor fetch's ref matching to use refname_match()
>  - push: use same rules as git-rev-parse to resolve refspecs
>  - add refname_match()
>  - push: support pushing HEAD to real branch name
> 
> This changes the semantics slightly but I think it is a move in
> the right direction.

We could add a "--matching" option and output a warning when it is not 
passed.  I would like this pretty soon, and would not be sad if it went 
into 'next' before this topic.

> * cr/tag-options (Fri Nov 9 14:42:56 2007 +0100) 1 commit
>  - Make builtin-tag.c use parse_options.
> 
> This changes the handling of multiple -m option without much
> good reason.  It should be a simple fix, once we know what we
> want.  I think the existing behaviour of refusing multiple -m
> is probably the most sane at this point.

I tend to agree.

> * sb/clean (Tue Nov 6 23:18:51 2007 -0600) 1 commit
>  - Make git-clean a builtin

Time is fleeting, so I could not yet look into the ambiguity problem where 
help was requested.

> ----------------------------------------------------------------
> [Others]
> 
> * jc/branch-contains (Wed Nov 7 14:58:09 2007 -0800) 1 commit
>  - git-branch --with=commit
> 
> I did this just for my own fun.

As I already said, I'd like this, but renamed to --containing=.  In fact, 
I just scrapped a script of mine to do the same, in excited expectation of 
this feature.

Ciao,
Dscho
