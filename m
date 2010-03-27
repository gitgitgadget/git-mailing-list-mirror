From: Steven Michalske <smichalske@gmail.com>
Subject: Re: native-git-svn: A Summer of Code 2010 proposal
Date: Fri, 26 Mar 2010 22:40:57 -0700
Message-ID: <3d4937ff1003262240t6159d9c5sc9253f555c3aed1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 27 06:41:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvOlr-0004wQ-Oj
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 06:41:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382Ab0C0Fk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 01:40:59 -0400
Received: from mail-yx0-f182.google.com ([209.85.210.182]:39198 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162Ab0C0Fk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 01:40:58 -0400
Received: by yxe12 with SMTP id 12so4193366yxe.33
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 22:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type;
        bh=F51bj2xlOSdPlRTue9Es6UbFYqGjtnmazM1GI/nBLpM=;
        b=lkqZoCebFUzQBrKVJN/FuNcSwx4qCaNIz+Ap5dlYC1Y3HtwTAlEkuzCR2r2WWN8Roc
         mCz1uuSWgJD2JOZZotJUOaODYojkeFoNsQ3UN3xqECt6FiB7DoJsejTPvxvTZgfpf+J2
         ynM+is5wMkdJ9fVm6OfgObM6nKbMQuiHnQfNE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=f6bI4O+ghsNFXIRL7I4oG8Dr4MMkHmjwha3gfKceFKN8Ph3hLfg17mYOZP+Z+1oN4/
         Mp34yA0CroCKuIjRTWC3HpTP8Gkn8Y8Qq3cxavwSCYEL1LTmmcfb+m0x2LWoXEtfpmxm
         Or6vUfbZC3MhZKEZu4twdKmkkN7hbwbrUD29I=
Received: by 10.90.55.8 with HTTP; Fri, 26 Mar 2010 22:40:57 -0700 (PDT)
Received: by 10.91.95.14 with SMTP id x14mr1437058agl.1.1269668457894; Fri, 26 
	Mar 2010 22:40:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143317>

Ramkumar Ramachandra <artagnon <at> gmail.com> writes:
---8<------
> The following resources are relevant to the project:
> 1. git_remote_helpers/git/git.py is a minimalistic remote helper
> written by Sverre. I plan to extend this as much as possible before
> rewriting it in C.

Would cython meet the needs of increasing the speed of the python code
without requiring a rewrite?

> 2. libsvn contains excellent documentation and clear examples to
> create the SVN client.
> 3. git-svn.perl has a lot functionality that I plan to re-implement in
> native-git-svn:
>    3.1 parse_svn_date: Given a date (in UTC) from Subversion, return a
> string in the format "<TZ Offset> <local date/time>" that Git will use
>    3.2 load_authors: <svn username> = real-name <email address>
> mapping based on git-svnimport

One feature that I would like to see is a way to call an application for a name
lookup author file maintenance.

i.e. if the SVN authors file is missing the lookup,  call the lookup tool.

I work at a company with a LDAP server that I can look up the svn username to
get real name and email address.  This way I don't have to manually maintain a
svn authors file.

This is really a remote helper component, not just SVN

>    3.3 do_git_init_db: Create and maintain svn-remotes
>    3.4 get_commit_entry: Parse commit messages, and encode them; SVN
> requires messages to be UTF-8 when entering the repo
>    3.5 cmd_branch: Handle branching/ tagging

I'm torn on how the current system handles this,  I like all tags to
be tags, and
that if a tag had a branch like behavior (bad SVN users!), that a branch exists
for it, with the tag pointing to its branches head.

>    3.6 cmd_create_ignore: Reads svn:ignore and puts the information
> into .gitignore
> 4. There are several existing third-party SVN exporters worth looking into [2].
-----8<------

A couple of side thoughts.

--
Support for SVN's blank folders.  Some of the old build systems I have used
need the blank folders, so I have to create to make the build work :-(
can't use
git-bisect easily.  Well it's that i have to make the bisect run
script make the
needed folders, not too hard, but annoying.  Could we track if in a particular
SVN revision we had a blank folder that was either created or removed.  Stuff a
hidden file '.git_svn_empty_folder' or a .gitignore with a * in it so
git can then
track the SVN's empty folder, and if the SVN folder gets contents the
.git_ignore
needs the ignore removed?

--
One of my SVN repositories using the current system fails to import that
repository is missing a revision in its SVN history.  In other words
the SVN repo
has corrupted history the current git-svn will fail to import the repository.

Example:  R31 of the SVN repo is this status, R32 fails to checkout
due to a SVN
error, but R33 will checkout and is valid.  I would like to see the
helper pause
and ask me what to do.  Either fail or skip that revision.  It's a
shame the history
is gone, but I now have to tell the current git-svn to do a shallow clone and
start at R33 and I loose all of commits R1 to R31, This leads to branches that
have no known roots......  My case is this happened roughly at
revision 1700, the
server's hard drive crashed and restore was done with a backup that was at a
revision around 1500 so there is a big gap..... of lost history, but
that history is
5-6 years old so the daily backups to reconstruct it are LONG gone.
Too bad we didn't have git back then, could have restored all the
history with a
push! ;-)

If you want me to test your work on a hairy repository with corrupt history and
thousands of branches, I'll do that for you.


--
In that same corrupt repository, each branch has a large PDF that NEVER
changes.  This makes me think that it might make exports faster if I could tell
the SVN client that a file is static, and to only track if it gets
removed or size
changes,  don't know if libsvn would let you do that....  You might
even be able
to detect that kind of condition, large unchanging binary like files,
 might make a great bandwidth/speed optimization.



Sorry if I didn't see these points brought up in other emails on your
proposal.
But working at a company with lots of history in SVN makes me passionate
about the SVN integration in git :-)


Good luck!
Steve
