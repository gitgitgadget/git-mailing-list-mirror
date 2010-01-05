From: Hakim Cassimally <hakim.cassimally@gmail.com>
Subject: git-cherry-pick problem - directory not touched by commit is marked 
	"added by us"
Date: Tue, 5 Jan 2010 12:33:26 +0000
Message-ID: <82cfa8031001050433r6d705222qf905c929ad6395c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 05 13:33:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NS8bO-0000WD-Rs
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 13:33:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450Ab0AEMd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 07:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967Ab0AEMd3
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 07:33:29 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:63803 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738Ab0AEMd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 07:33:28 -0500
Received: by ewy19 with SMTP id 19so8372838ewy.21
        for <git@vger.kernel.org>; Tue, 05 Jan 2010 04:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=V942MVnxEBOwcBSOpi+1Dxzuhj3lAVm33USWYXJKUng=;
        b=MuM0/nWmcXa1S7vLbfOKrqBc/ycdonZ+qIRtXNfojUFfPqbf5hollAumOLE4a1kpB8
         cIAVD2MUbxuXl8uViWMqUP+HbUF406bRmJVZcK6bmA4H3IsmX4IPAi3d5V77d45oqjO9
         OfDF7o2qCtQrlEMYqg5K7tPH/MSir9Wqe9NDE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=bTl0UHD4b79OvhPLTfQCvaqRVz8C6M7/GGiJUGVEzmEJ+UHJhPlEVIJJgkMGlbaeky
         aN5Vz9OGHgD2b5/yr2MLJROqU57SP6tKC4VFndnf7Eo0tL/c6t5cKd14HR/P4jw7tSrG
         MbuywJpWn803eDtq2IvjJ0c2H0zU9SHaKwW0Q=
Received: by 10.216.89.135 with SMTP id c7mr4233948wef.62.1262694806463; Tue, 
	05 Jan 2010 04:33:26 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136187>

I got into a bit of trouble with a git-cherry-pick last night, and
though mugwump
and others on #git helped me as far as a workaround, I'm still very confused,
and would like to make sure it doesn't happen again

I'm fairly sure the problem is due to my ignorance, so I'll firstly describe
the mess I've made of my repo :-)

BACKGROUND
==========

 * I had a (trunk) branch that contained most of the code
 * I started to experiment with porting our .cgi code to a framework and later,
after the fact, created (experimental) off (trunk)
 * As experimental has of course taken longer than expected, I've since forked
(stable) again from (trunk), but from a commit before the experimental stages
started.

 * I've developed Feature "X", which took advantage of some of the experimental
refactoring... so of course I developed it in (experimental)...

 * I now want to port it back to (stable) so I can release it...

 * I was recommended to use 'git rebase -i' but didn't understand how

 * ... so I was also recommended to use 'git cherry-pick'.  As there were
only 6 relevant commits, I chose to do that

WHAT HAPPENS
============

When I'm in (stable), and try to cherry-pick the change from (experimental),
git thinks that I'm making a massive number of changes in a directory that
wasn't touched by the relevant commit.

Here's a sample transcript which hopefully makes sense: I've included output
of 'git show' and 'git whatchanged' which seem to suggest that the commit
I'm cherry-picking shouldn't be changing these files.

    (stable) $ git --version
    git version 1.6.6
    # I tried previously on 1.6.0.4 but upgraded in case it helped

    (stable) $ git status
    # On branch stable
    # nothing to commit (working directory clean)

    (stable) $ git show --stat 301afce1
    commit 301afce1c78380276d208077ef4ec76b469c1024
    Author: osfameron <...>
    Date:   Wed Dec 23 23:45:20 2009 +0000

        Proof of concept for import module (parse Excel)

     bin/upload_module.pl |  142
++++++++++++++++++++++++++++++++++++++++++++++++++
     1 files changed, 142 insertions(+), 0 deletions(-)

    (stable) $ git whatchanged -1 301afce1
    commit 301afce1c78380276d208077ef4ec76b469c1024
    Author: osfameron <...>
    Date:   Wed Dec 23 23:45:20 2009 +0000

        Proof of concept for import module (parse Excel)

    :000000 100644 0000000... c90e261... A  bin/upload_module.pl

    (stable) $ git cherry-pick 301afce1
    Finished one cherry-pick.
    www/client/css/admin-clean.css: needs merge
    www/client/css/admin.css: needs merge
    www/client/css/error.css: needs merge
    www/client/css/public.css: needs merge
    www/client/css/user-clean.css: needs merge
        <...snip>
    www/client/css/admin-clean.css: unmerged
(832c41e99d19f2dd39c9cf3709f14619ffab24b8)
    www/client/css/admin.css: unmerged
(8e7cd850bf40d1a921b1f62ce0945abd374fa55d)
    www/client/css/error.css: unmerged
(88945d05640c0820c9cf68922392573d4ac07b2c)
        <...snip>
    ...
    error: Error building trees

    (stable) $ git status
    # On branch stable
    # Changes to be committed:
    #   (use "git reset HEAD <file>..." to unstage)
    #
    #       new file:   bin/upload_module.pl
    #
    # Unmerged paths:
    #   (use "git reset HEAD <file>..." to unstage)
    #   (use "git add <file>..." to mark resolution)
    #
    #       added by us:        www/client/css/admin-clean.css
    #       added by us:        www/client/css/admin.css
    #       added by us:        www/client/css/error.css
    #       added by us:        www/client/css/public.css
        <...snip>

As mugwump suggested, I can resolve by doing

(stable) $ git checkout HEAD www/

And then proceed by commiting that cherry-pick.  This is how I've fixed it.
(Slightly annoying to repeat/lather/rinse for 6 separate commits, but works).

Oddly, though I've done some messing about in the www/ tree, these files exist
in both, for example "www/client/css/admin.css" exists in both (experimental)
and in (stable).

Please let me know if I should be submitting different or more detailed
information to describe the problem better!
Any help in working out what I'm doing wrong would be really appreciated,

osfameron
