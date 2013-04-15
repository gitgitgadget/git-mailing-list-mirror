From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Mon, 15 Apr 2013 19:15:51 +0100
Message-ID: <20130415181551.GJ2278@serenity.lan>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
 <1365887729-9630-4-git-send-email-artagnon@gmail.com>
 <vpq38us2oov.fsf@grenoble-inp.fr>
 <CALkWK0mdC_tK2CGqAa67fr189PQCjSjzAOPujipOHFfoiYW0qA@mail.gmail.com>
 <vpqppxvoqsc.fsf@grenoble-inp.fr>
 <7vobdfztz9.fsf@alter.siamese.dyndns.org>
 <CALkWK0=cNEkE0bUoWJg119o+FaQywJhgkUxiFfLGPSsLrFVZ=A@mail.gmail.com>
 <7vr4ibu14j.fsf@alter.siamese.dyndns.org>
 <CALkWK0=6E=s6kJysMo2yC22c3pvCWn90S5neRyP0jpzpYrZboA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 20:16:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URnwn-000653-3y
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 20:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756523Ab3DOSQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 14:16:04 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:57288 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753Ab3DOSQD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 14:16:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id A5008CDA5AF;
	Mon, 15 Apr 2013 19:16:01 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7wTijk7MlJFz; Mon, 15 Apr 2013 19:16:00 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 498F3CDA599;
	Mon, 15 Apr 2013 19:15:53 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CALkWK0=6E=s6kJysMo2yC22c3pvCWn90S5neRyP0jpzpYrZboA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221282>

On Mon, Apr 15, 2013 at 11:38:20PM +0530, Ramkumar Ramachandra wrote:
> Junio C Hamano wrote:
> > If "rebase -m" were to be taught to do this, the natural way to do
> > so is to
> >
> >   (1) Prepare the todo the usual way
> >   (2) Do those two commits for index and working tree
> >   (3) Append two insns (exec reset HEAD^ and exec reset --soft
> >       HEAD^) at the end of the rebase todo file.
> 
> Er, no.  I don't want to touch the instruction sheet.  It becomes
> especially problematic in -i, when the instruction sheet is
> user-editable.
> 
> > "rebase--am" could also be told to generate (on the preparation
> > side) and notice (on the application side) a pair of patch files at
> > the end that represent the index state and the working tree state
> > and apply them without making the WIP part into a commit.
> 
> Ugh, no.  I don't want to leak the implementation detail of autostash
> into specific rebases.  Why can't I wrap the last statment in
> git-rebase.sh in git stash/ git stash pop like I did with git-pull.sh?

How does that work with the following:

- run_specific_rebase fails, so the user needs to fix it up and then run
  "git rebase --continue".  We don't want to pop the stash in this case.

- the user runs "git rebase --continue" with staged changes, knowing the
  git-rebase will commit those.  We don't want to create a stash in this
  case since it will remove the changes the user wants to commit.
