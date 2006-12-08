X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Documentation/git-commit.txt
Date: Fri, 08 Dec 2006 11:31:14 -0800
Message-ID: <7vfybqi3r1.fsf@assigned-by-dhcp.cox.net>
References: <7vy7pik51b.fsf@assigned-by-dhcp.cox.net>
	<4579529F.9030401@Intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 8 Dec 2006 19:31:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33725>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GslRV-0000hD-DA for gcvg-git@gmane.org; Fri, 08 Dec
 2006 20:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1426153AbWLHTbQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 14:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1426155AbWLHTbQ
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 14:31:16 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:44686 "EHLO
 fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1426153AbWLHTbP (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 14:31:15 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061208193114.LGN2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>; Fri, 8
 Dec 2006 14:31:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id wKWe1V0031kojtg0000000; Fri, 08 Dec 2006
 14:30:38 -0500
To: Salikh Zakirov <Salikh.Zakirov@Intel.com>
Sender: git-owner@vger.kernel.org

Salikh Zakirov <Salikh.Zakirov@Intel.com> writes:

> Junio Hamano wrote:
>> +Instead of staging files after each individual change, you can
>> +tell `git commit` to notice the changes to the tracked files in
>> +your working tree and do corresponding `git add` and `git rm`
>> +for you.  
>
> This part is confusing as hell to anyone having any experience
> with either CVS, SVN, Hg or Monotone, as doing "corresponding `git add`
> and `git rm`" commands automatically will be interpreted as adding
> untracked files automatically, which is not the case here.

Well, that's why the description says 'the changes to the
tracked files' above to make it clear.  An obvious alternative
is not to talk about staging in terms of `git add` and `git rm`
but instead mention `git update-index` in that part of the
documentation, but I think that is going backwards.  I think the
conclusion of recent discussions is not to paper over the
differences from new people (nor making git closer to other
systems by castrating git), but make things easier to learn for
them.  My attempt to update git-commit documentation is a part
of this effort.

Better rewording is very much appreciated.

But you are right.  Prior experiences with other systems would
make it harder to learn git here, because 'git add', especially
with Nico's enhancement in 'next', is different from 'cvs add'.

The problem is that these systems do not have the concept of
tracking 'contents' (they instead track paths), and 'add' to
them mean 'add the named paths to the set of tracked paths'.

On the other hand, git fundamentally tracks contents.  We do
have the concept of 'the set of tracked paths', but that is a
side effect of tracking contents.  In other words, you do not
'add' a path without 'add'ing its contents.

By the way, I have been wondering if the --only variant of the
command should also add untracked files to the index.  That is:

	$ git commit foo.c '*.h'

currently barfs if foo.c is not tracked, and/or there is no
tracked header files.  We could instead run git-update-index
--add on them.

Incidentally, this would make this sequence possible:

	$ tar xf /var/tmp/foo.tar ;# extract tarball here.
        $ git init-db
        $ git commit -m 'initial import' .
