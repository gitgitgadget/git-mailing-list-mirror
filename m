From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 1/2] pull: respect rebase.autostash
Date: Fri, 14 Jun 2013 13:29:50 +0100
Message-ID: <20130614122950.GE23890@serenity.lan>
References: <1371200178-9927-1-git-send-email-artagnon@gmail.com>
 <1371200178-9927-2-git-send-email-artagnon@gmail.com>
 <CABURp0pVzQ2rVB-B2L+uCMtPV7QFPSgkZnHitCsrPCrR9LJOVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 14:30:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnT8n-0003hw-LF
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 14:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576Ab3FNMaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 08:30:00 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:38870 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552Ab3FNM37 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 08:29:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 011AF198010;
	Fri, 14 Jun 2013 13:29:59 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I55xT2N8-RXK; Fri, 14 Jun 2013 13:29:58 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id C44156064D0;
	Fri, 14 Jun 2013 13:29:52 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CABURp0pVzQ2rVB-B2L+uCMtPV7QFPSgkZnHitCsrPCrR9LJOVA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227816>

On Fri, Jun 14, 2013 at 08:12:56AM -0400, Phil Hord wrote:
> On Fri, Jun 14, 2013 at 4:56 AM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
> > If a rebasing pull is requested, pull unconditionally runs
> > require_clean_worktree() resulting in:
> >
> >   # dirty worktree or index
> >   $ git pull
> >   Cannot pull with rebase: Your index contains uncommitted changes.
> >   Please commit or stash them.
> >
> > It does this to inform the user early on that a rebase cannot be run on
> > a dirty worktree, and that a stash is required.  However,
> > rr/rebase-autostash lifts this limitation on rebase by providing a way
> > to automatically stash using the rebase.autostash configuration
> > variable.  Read this variable in pull, and take advantage of this
> > feature.
> 
> This commit message does not tell me what this commit does.  It mostly
> describes the current situation.  Then it refers to something called
> "rr/rebase-autostash" which will lose meaning in the future when this
> commit is no longer current on the list.  A better way to refer to
> this commit is to say "this commit".  However, even this is not the
> norm for this project.  The norm here is to avoid such noise by
> speaking in the imperative mood.  That is, do not tell me what this
> commit does; instead, tell the code what to do.  See
> Documentation/SubmittingPatches:

It seems to me that Ram's message is already in the imperative.  The
only (slight) issue is that rr/rebase-autostash will become hard to find
once Junio cleans up feature branches that have graduated.  Since that
branch has graduated to master, it would be clearer to refer to commit
5879477 (rebase: implement --[no-]autostash and rebase.autostash,
2013-05-12).  Is something like this clearer?

    "git pull" currently cannot be used with the "autostash" feature
    added to "git rebase" by commit 5879477 (rebase: implement
    --[no-]autostash and rebase.autostash, 2013-05-12) because it
    unconditionally calls requre_clean_worktree early on, which results
    in:

        # dirty worktree or index
        $ git pull
        Cannot pull with rebase: Your index contains uncommitted changes.
        Please commit or stash them.

    Remove this restriction by skipping the call to
    require_clean_worktree if the "rebase.autostash" configuration
    variable is set.
