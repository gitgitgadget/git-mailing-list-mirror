From: "Fyn Fynn" <fynfynn@gmail.com>
Subject: Re: Fwd: git status options feature suggestion
Date: Fri, 17 Oct 2008 17:19:47 -0700
Message-ID: <1a04eebf0810171719r6b604a88n781bf43f0f047aae@mail.gmail.com>
References: <ee2a733e0810120309o1fbfa4dxe6f2292a28bd6db3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 18 02:21:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqzZ3-0000FU-2W
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 02:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754446AbYJRATw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 20:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754736AbYJRATw
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 20:19:52 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:53944 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbYJRATv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 20:19:51 -0400
Received: by fk-out-0910.google.com with SMTP id 18so791911fkq.5
        for <git@vger.kernel.org>; Fri, 17 Oct 2008 17:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=WbI6DyWRr5pTj3MLhzU9utRa0Hf01p40M21m/JOU6jE=;
        b=O3BNRpW52NzJ7j5M4aI8DHirEZZIMhErM8EvQHasF4GTczK3l2YTs5scNi6wYMbsVx
         TocDYudaNkPioRCx9irt3nEC7aev+vld9L8n+t/GNxO0fzWU3YwVziwAZ88/HQaMO42H
         Tr01s0UzlSmxb4iVg7PZ/c9JCDIWqZVOipGXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=g59xdT0W5l/Uj94B6X0rNJcXIQ08i4jsQCxuiHT5w29RVooQ+2OwYOgkqf+8j5S76X
         IMmedtZbapasea6pvoAOTr67Z5SCLmsgSYmb3mKc2v2IUsWV0F57q1phvSF6uknRyxo0
         Vmc9IQb+YeoQ7cMPaVwezPes0M2itGUtzIeog=
Received: by 10.187.182.10 with SMTP id j10mr735021fap.39.1224289188172;
        Fri, 17 Oct 2008 17:19:48 -0700 (PDT)
Received: by 10.187.211.5 with HTTP; Fri, 17 Oct 2008 17:19:47 -0700 (PDT)
In-Reply-To: <ee2a733e0810120309o1fbfa4dxe6f2292a28bd6db3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98509>

Just wanted to chime in about a feature existing in Bazaar's and
Subversion's and  "status" command: getting the status of tracked
files _only_.

Here's how the status -V switch works in Bazaar:

~/foo$ bzr init
~/foo$ echo "content" > bar.txt
~/foo$ bzr add bar.txt
added bar.txt
~/foo$ echo "content" > baz.txt
~/foo$ bzr status
added:
  bar.txt
unknown:
  baz.txt
~/foo$ bzr status -V
added:
  bar.txt

As you can see, the -V switch makes `bzr status` only display the
status of files that are tracked.

This is very useful when you're tracking a "skeleton" of essential
files in a directory tree that contains a large number of additional
files and subdirectories, particularly if those are changing often and
/ or are large/binary so it's impractical to control/ignore them.

A common case of that: tracking a subset of configuration files under
one's home directory.

Right now, there are two ways of getting around the lack of "status
-V" (Subversion: "status -q") in git (credit for both goes to doener
on #git@FreeNode, who showed them to me):

git config --global alias.st 'diff --name-status HEAD'

Which makes `git st` output practically the same thing as  -V/-q in
Bazaar/Subversion. However, the output doesn't distinguish between
Staged (indexed) and Unstaged (non-indexed) changes (a distinction
that the 2 other SCMs above don't support).


git config --global alias.st '!echo Staged:; git diff --cached
--name-status; echo Unstaged:; git diff --name-status'

Which does distinguish between Staged and Unstaged, but is definitely
something that can work only as an alias for frequent usage.

Incidentally, a minor quibble with both solutions is that they require
HEAD to exist; so you need to make at least one commit before you can
use them. For most users, this wouldn't frequently be a huge loss, but
if you're commonly initializing branches, you might miss it. For
example, note how the above Bazaar example would fail with:

fatal: ambiguous argument 'HEAD': unknown revision or path not in the
working tree.

- Fyn
