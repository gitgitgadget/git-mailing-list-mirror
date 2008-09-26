From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] builtin-commit: avoid using reduce_heads()
Date: Fri, 26 Sep 2008 09:17:39 -0700 (PDT)
Message-ID: <m37i8y3mqt.fsf@localhost.localdomain>
References: <20080925235029.GA15837@neumann>
	<1222389359-22191-1-git-send-email-vmiklos@frugalware.org>
	<20080926010312.GE6816@neumann>
	<20080926151517.GV23137@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-15?q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes.Schindelin@gmx.de
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Sep 26 18:19:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjG1t-0004kZ-R9
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 18:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbYIZQRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 12:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752521AbYIZQRo
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 12:17:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:57866 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbYIZQRn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 12:17:43 -0400
Received: by nf-out-0910.google.com with SMTP id d3so386306nfc.21
        for <git@vger.kernel.org>; Fri, 26 Sep 2008 09:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=JNekgC/HkLiYHiHLOinGZTBaYpFHCNcovhaMj4OkFbc=;
        b=J3Tc685zAOmrYs+80Z8tIQQR9B7fKZ4UQLr+Ma9PaJIiasTjjlr4ZBfp8/oT8xSMqO
         D7ef4XISwrI/gREloAyeXjpfMv8Bsn/BRRYN/x96A9YkUlJIwxtL0YPoUjDbzampuJ5O
         JlkioL5425vjc6U/0UOr5JBf81Ka61aBUBXGE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=CUZzyVWppgFdbIEQOMtz2TuC7Hj+N12+wRJGh4UvLXdeDgoYqXLUNWay3joxstbWX9
         2g9ElbwcgA2gmcA/HiWdj/YnTLynckeaozvkR7u6hpHPN+/W7yU66LbHb1YHz69Sbscb
         8OQUEQurlJssfBoVAFHtFvTXd0U/2yE2LgzcM=
Received: by 10.103.199.16 with SMTP id b16mr1110438muq.5.1222445860812;
        Fri, 26 Sep 2008 09:17:40 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.233.191])
        by mx.google.com with ESMTPS id u9sm1987893muf.9.2008.09.26.09.17.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Sep 2008 09:17:39 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m8QGHZTr007761;
	Fri, 26 Sep 2008 18:17:36 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m8QGHVMm007757;
	Fri, 26 Sep 2008 18:17:31 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080926151517.GV23137@genesis.frugalware.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96876>

Miklos Vajna <vmiklos@frugalware.org> writes:

> OK, here is the scenario.
> 
> The basic problemis that if it's git-commit that creates the merge
> commit and not git-merge, then git-commit does not "know" that git-merge
> was invoked using --no-ff.
> 
> --no-ff means that if reduce_heads() removes a parent, that will be a
> problem, since the resulting commit will no longer be a merge commit.
> 
> I think we can't avoid storing this info in a MERGE_MODE file, because
> we have to add HEAD to the list of parents in case --no-ff is used, but
> we should not do so in case it's reachable from existing heads and
> --no-ff is not used.
> 
> I'll send a patch that does this in a bit.

The following is summary of short dicussion about this issue on #git
see: http://colabti.org/irclogger/irclogger_log/git?date=2008-09-26,Fri#l1176

The problem is that sometimes git-commit finishes doing the merge, be
it use of --no-commit option, or a conflict occurred; depending on
whether git-merge was invoked with or without --no-ff (--ff=never)
option it should recurd reduced or non-reduced heads.

The problem for example occurs in the following situation:

  .---.---.---.                  <--- a <--- HEAD
              |\
              | \-1---2          <--- b
              \
               \--x---y          <--- c

$ git merge b c

                      /------------- b 
                      v
  .---.---.---.---1---2---M     <--- a <--- HEAD
              \          /
               \--x---y-/       <--- c

$ git merge --no-ff b c

  .---.---.---.---------M         <--- a <--- HEAD
              |\       /|
              | \-1---2 |         <--- b
              \         /
               \--x---y/          <--- c



We can select one of the following solutions:

1. As proposed above save git-merge options, for example in MERGE_MODE
   or MERGE_OPTS file, so git-commit knows what options to use if it
   was invoked to finish a merge.

2. git-merge saves _reduced_ heads in MERGE_HEAD, and git-commit
   reduces only HEAD, unless it is in MERGE_HEAD.  This means that
   git-commit uses the following pseudo-code

     if (resolve_ref(HEAD) == MERGE_HEAD[0]) {
        /* non fast-forward case */
        merge HEAD + MERGE_HEAD
     } else {
        reduce_HEAD_maybe()
        merge [HEAD] + MERGE_HEAD
     }

   This has the advantage that it doesn't change MERGE_HEAD semantic
   for simple merge which did not began as octopus

3. Remove reduce_heads() from git-commit entirely, and record in
   MERGE_HEAD (or rather now MERGE_HEADS) _all_ _reduced_ heads.
   _All_ means that HEAD is included in MERGE_HEAD if it is not
   reduced, _reduced_ means that only non-dependent heads are in
   MERGE_HEAD.  This for example means that for simple non-octopus
   merge case MERGE_HEAD/MERGE_HEADS now contain _all_ parents,
   and not only other side of merge.

   This solution has the advantage of being clear solution, clarifying
   semantic of MERGE_HEAD (currently HEAD is used both as target, i.e.
   where merge is to be recorded, and as one of heads to merge/to
   consider), and making it possible to separate layers: git-merge
   is about merging, git-commit doesn't need to know anything about
   merging.

   The disadvantage is that it changes format (well, semantic) of
   MERGE_HEAD, possibly breaking users' scripts; perhaps some of
   git commands like "git log --merge" or "git diff --merge" should
   be updated on such change.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
