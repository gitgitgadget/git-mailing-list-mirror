From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: squashing patches
Date: Mon, 9 Jun 2008 18:29:09 +0200
Message-ID: <20080609162909.GC8079@leksak.fem-net>
References: <20080607220101.GM31040@leksak.fem-net> <20080609114550.GA8079@leksak.fem-net> <484D47C9.9050509@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Joerg Sommer <joerg@alea.gnuu.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jun 09 18:30:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5kG2-0001G3-7C
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 18:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbYFIQ3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 12:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbYFIQ3P
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 12:29:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:43460 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750699AbYFIQ3O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 12:29:14 -0400
Received: (qmail invoked by alias); 09 Jun 2008 16:29:12 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp062) with SMTP; 09 Jun 2008 18:29:12 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18FfW4oF6gFscD1cQed9fVWRrnI8tQKpWNL4HwrP4
	NCdz4zMBUit0Lx
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K5kF3-0003OW-2M; Mon, 09 Jun 2008 18:29:09 +0200
Content-Disposition: inline
In-Reply-To: <484D47C9.9050509@gnu.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84398>

Hi,

> My feedback is in the message from the "-s theirs" thread that I CCed  
> you on.

Well, I've noticed and read it, but haven't knowm what I wanted to 
reply. :)

> Basic points:
>
> 1) I would like a "--strategy" option for cherry-pick and for the  
> sequencer's "pick";

If somebody adds a --strategy option to cherry-pick and it gets
into "next", I have no problem to let sequencer pass the option to
cherry-pick ;)

Btw, I like the idea of cherry-pick --strategy=theirs (though I don't
know if I'd ever use it), but this is currently beyond my task ;-)

> 2) What about
>
>   mark :1
>   pick a
>   file b
>   pick c
>   squash --up-to :1

I like the idea.  And the others?

--- a/Documentation/git-sequencer.txt
+++ b/Documentation/git-sequencer.txt
@@ -212,6 +216,12 @@ squash [<options>] <commit>::
 +
 See 'GENERAL OPTIONS' for values of `<option>`.
 
+squash [<options>] --up-to <mark>::
+	Squash all commits up to the given mark into one commit.
+	There must not be any merge commits in between.
++
+See 'GENERAL OPTIONS' for values of `<option>`.
+
 
 tag <tag>::
 	Set tag `<tag>` to the current HEAD,

> or, to specify a commit message
>
>   mark :1
>   file a
>   pick b
>   squash --up-to :1 -C HEAD^

Reusing the commit message may be useful, too, agreed.
I think that this is something that can be put to the 
"GENERAL OPTIONS" section:

--- a/Documentation/git-sequencer.txt
+++ b/Documentation/git-sequencer.txt
@@ -240,6 +250,12 @@ when finished.
 	Override the author name and e-mail address used in the commit.
 	Use `A U Thor <author@example.com>` format.
 
+-C <commit-ish>::
+--reuse-message=<commit-ish>::
+	Reuse message from specified commit.
+	Note, that only the commit message is reused
+	and not the authorship information.
+
 -F <file>::
 --file=<file>::
 	Take the commit message from the given file.
--

Ok?


If you want also the authorship information, there's the --reference
which is atm only available for the "merge" insn.
Currently I also wonder, why only merge has this option ;-)

Should this be a General Option, too?

--- a/Documentation/git-sequencer.txt
+++ b/Documentation/git-sequencer.txt
@@ -182,9 +189,6 @@ or `--standard`), an editor will be invoked.
 +
 See the following list and 'GENERAL OPTIONS' for values of `<option>`:
 
-	--reference=<commit-ish>;;
-		Take author and commit message of <commit-ish>.
-	
 	--standard;;
 		Generates a commit message like 'Merge ... into HEAD'.
 		See also linkgit:git-fmt-merge-msg[1].
@@ -247,6 +263,10 @@ when finished.
 -m <msg>::
 --message=<msg>::
 	Use the given `<msg>` as the commit message.
+	
+--reference=<commit-ish>::
+	Take author and commit message of <commit-ish>.
+	
 
 -s::
 --signoff::
--

> or also
>
>   mark :1
>   file a
>   pick b
>   squash --up-to :1 -C HEAD^ -s
>
> to merge all signoffs.

Hm, this is a bit too specific I think.
Do I interpret your example right, that you want to 
squash "a" and "b", reuse the commit message of the
newly commited patch "a", but also add the signoff of
"b"? (And perhaps, if not set, the own signoff?)

If I put this into sequencer, I'd like to name
that --squash-signoffs (or --merge-signoffs) or something,
because -s/--signoff is a general option atm, that adds
your signoff.

What do the others think? (Sorry for my questions to "the others", 
but I need some input. *grin*)

> This could be done by providing a stand-alone  
> git-squash command; or alternatively, it could be done in the sequencer  

The git-squash approach looks clean to me.

>   (echo 'mark :1'
>    git-rev-list --reverse $1.. | sed 's,^,pick '
>    echo "squash --up-to :1 $*") | git-sequencer

I notice that you indirectly changed the synopsis, intuitively.
This shows me, that we should change it ;-)
According to the current SYNOPSIS you have to do "git-sequencer -"
to read from stdin.

> 3) I would like a totally batch mode-of-operation, which would fail if  
> user intervention was needed

I like the idea.

--- a/Documentation/git-sequencer.txt
+++ b/Documentation/git-sequencer.txt
@@ -8,7 +8,7 @@ git-sequencer - Execute a sequence of git instructions
 SYNOPSIS
 --------
 [verse]
-'git-sequencer' [-v | --verbose] <file> [<branch>]
+'git-sequencer' [--batch] [-v | --verbose] <file> [<branch>]
 'git-sequencer' --continue | --skip | --abort | --edit

@@ -59,6 +59,13 @@ OPTIONS
 <branch>::
 	Working branch; defaults to HEAD.
 
+--batch::
+	Run in batch mode. If unexpected user intervention is needed
+	(e.g. a conflict or the need to run an editor), git-sequencer fails.
++
+Note that the sanity check fails, if you use this option
+and an instruction like `edit` or the `--edit` option.
+
 --continue::
 	Restart the sequencing process after having resolved a merge conflict.
 
--

Ok?

> (the user could choose whether to not edit the editor,
> or whether to use a no-op for GIT_EDITOR).

I don't understand ;-)

> 4) I think the sequencer is an opportunity to improve some commands,  
> e.g. git-cherry-pick should grow more or less the same options as  
> git-sequencer's pick.

Hmmmmm, basically I like this approach.
Let's for example take the "merge --reference=<commit>" option.
It fetches the information from a former commit, and then does
git merge with different authorship information and -m "message bla".
So the basics are there, they just have to be put together.
Do you think it's useful to add something like --reference (or -C,
or however it is called) to git-merge?

Thanks and regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
