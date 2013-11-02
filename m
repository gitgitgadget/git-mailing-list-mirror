From: John Keeping <john@keeping.me.uk>
Subject: Re: Git 1.8.4.2: 'git-rev-parse --is-inside-git-dir' wrong output!
Date: Sat, 2 Nov 2013 14:06:57 +0000
Message-ID: <20131102140656.GE24023@serenity.lan>
References: <CACbqpSvU4qxc0WtquP6Eq8bZGjLxTrVhtT2Nqw90wb23ESkfcw@mail.gmail.com>
 <20131102105816.GC24023@serenity.lan>
 <11593D3DCFCD4D24BB881B9E5FAB79C0@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ville Walveranta <walveranta@gmail.com>, git@vger.kernel.org
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sat Nov 02 15:07:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vcbr4-0000Vo-Oz
	for gcvg-git-2@plane.gmane.org; Sat, 02 Nov 2013 15:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590Ab3KBOHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Nov 2013 10:07:06 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:50926 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576Ab3KBOHF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Nov 2013 10:07:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 53455CDA5C3;
	Sat,  2 Nov 2013 14:07:04 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GCBeII8PNiYN; Sat,  2 Nov 2013 14:07:03 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 56379CDA57D;
	Sat,  2 Nov 2013 14:06:58 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <11593D3DCFCD4D24BB881B9E5FAB79C0@PhilipOakley>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237244>

On Sat, Nov 02, 2013 at 01:47:02PM -0000, Philip Oakley wrote:
> From: "John Keeping" <john@keeping.me.uk>
> Sent: Saturday, November 02, 2013 10:58 AM
> > On Fri, Nov 01, 2013 at 06:19:51PM -0500, Ville Walveranta wrote:
> >> "git-rev-parse --is-inside-git-dir" outputs "fatal: Not a git
> >> repository (or any of the parent directories): .git", instead of
> >> "false" when outside of a git directory.  "--is-inside-work-tree"
> >> behaves the same way. Both commands work correctly (i.e. output
> >> "true") when inside a git directory, or inside a work tree,
> >> respectively.
> >
> > I think that's intentional - and it looks like the behaviour has not
> > changed since these options were added.  With the current behaviour 
> > you
> > get three possible outcomes from "git 
> > rev-parse --is-inside-work-tree":
> >
> >    if worktree=$(git rev-parse --is-inside-work-tree 2>/dev/null)
> >    then
> >        if test "$worktree" = true
> >        then
> >            echo 'inside work tree'
> >        else
> >            echo 'in repository, but not in work tree'
> >        fi
> >    else
> >        echo 'not in repository'
> >    fi
> > --
> 
> 
> Shouldn't this case which produces "fatal:..." need to be documented in 
> the man page?
> https://www.kernel.org/pub/software/scm/git/docs/git-rev-parse.html 
> doesn't mention it.

I'm not sure where it should go in there.  The documentation for
--git-dir says:

   If $GIT_DIR is not defined and the current directory is not detected
   to lie in a Git repository or work tree print a message to stderr and
   exit with nonzero status.

but there reality is that if you do not specify --parseopt or --sq-quote
then the command expects to be run in a Git repository [1], so perhaps
it would be better to say something under "Operation Modes" or in the
description.


[1] After taking account of $GIT_DIR, $GIT_WORK_TREE, and arguments to
    the base "git" driver that affect these variables.
