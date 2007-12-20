From: Bernt Hansen <bernt@alumni.uwaterloo.ca>
Subject: git rebase -i / git-gui bug
Date: Wed, 19 Dec 2007 19:35:28 -0500
Message-ID: <87ve6ub3u7.fsf@gollum.intra.norang.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 01:36:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J59OK-0001uI-0I
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 01:36:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755005AbXLTAfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 19:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753663AbXLTAfg
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 19:35:36 -0500
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:50264 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753489AbXLTAff (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 19:35:35 -0500
Received: from cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com ([99.239.148.180] helo=mail.norang.ca)
	by mho-02-bos.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <bernt@norang.ca>)
	id 1J59Nu-000LSZ-5e; Thu, 20 Dec 2007 00:35:34 +0000
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 99.239.148.180
X-Report-Abuse-To: abuse@dyndns.com (see http://www.mailhop.org/outbound/abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+i1pYphU9uI8XfpS4tPE/a
Received-SPF: none (mail.norang.ca: bernt@gollum.intra.norang.ca does not designate permitted sender hosts) receiver=mail.norang.ca; client-ip=192.168.1.5; helo=gollum.intra.norang.ca; envelope-from=bernt@gollum.intra.norang.ca; x-software=spfmilter 0.97 http://www.acme.com/software/spfmilter/ with libspf-unknown;
Received: from gollum.intra.norang.ca (gollum.intra.norang.ca [192.168.1.5])
	by mail.norang.ca (8.13.8/8.13.8/Debian-3) with ESMTP id lBK0ZVvN005455
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 19 Dec 2007 19:35:32 -0500
Received: from gollum.intra.norang.ca (localhost [127.0.0.1])
	by gollum.intra.norang.ca (8.14.2/8.14.2/Debian-1) with ESMTP id lBK0ZVWc006029;
	Wed, 19 Dec 2007 19:35:31 -0500
Received: (from bernt@localhost)
	by gollum.intra.norang.ca (8.14.2/8.14.2/Submit) id lBK0ZSoQ006025;
	Wed, 19 Dec 2007 19:35:28 -0500
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68963>

Thanks for a great tool I use everyday!

I'm using the tip of master for my regular day job with git-gui to write
the commit messages.  I've run into a little glitch with git rebase -i
and git-gui.

$ git --version
git version 1.5.4.rc0.73.gce85b

I haven't been able to automate the process of reproducing this but the
steps are fairly simple.

To show the problem you can create a test repository using the following
script:

--- t1.sh ---
#!/bin/sh
cd /tmp
mkdir t1
cd t1
git init

for F in f1 f2 f3 f4 f5 f6 f7 f8 f9 f10; do
  echo $F >$F
  git add $F
  echo -n -e "Commit for $F\n\nThis is line one\nThis is line two" >/tmp/commitmsg.txt 
  git commit -F /tmp/commitmsg.txt
done
-------------

Now cd /tmp/t1 and do the following:

$ git rebase -i HEAD~9

Change all lines with 'pick' to 'edit'

For each of the 10 commits use git-gui to select 'Amend Last Commit' and
just hit the [Commit] button (you can change the text if you want but
it's not necessary to show the problem)

$ git rebase --continue
after each commit and repeat until the rebase is complete.

Now if you try to squash these commits the edit buffer commit text is a
little mangled.

$ git rebase -i HEAD~9

Change all but the first pick line to 'squash' and I get the following
text in the commit message edit window:

----[ /tmp/t1/.git/COMMIT_EDITMSG ]----
# This is a combination of 3 commits.
# The first commit's message is:

Commit for f2

This is line one
This is line two
# This is the 2nd commit message:

Commit for f3

This is line one
This is line two# This is the 3rd commit message:

Commit for f4

This is line one
This is line two# This is the 3rd commit message:

Commit for f5

This is line one
This is line two# This is the 3rd commit message:

Commit for f6

This is line one
This is line two# This is the 3rd commit message:

Commit for f7

This is line one
This is line two# This is the 3rd commit message:

Commit for f8

This is line one
This is line two# This is the 3rd commit message:

Commit for f9

This is line one
This is line two# This is the 3rd commit message:

Commit for f10

This is line one
This is line two

# Please enter the commit message for your changes.
# (Comment lines starting with '#' will not be included)
# Not currently on any branch.
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	new file:   f10
#	new file:   f2
#	new file:   f3
#	new file:   f4
#	new file:   f5
#	new file:   f6
#	new file:   f7
#	new file:   f8
#	new file:   f9
#
---------------------------------------

Notice after the 3rd commit the '# This is the 3rd commit message:' is
appended to the last line of the previous commit message and the counter
seems to be stuck on 3.

---

When I run into this during work I fix up the commit text by adding
newlines before the '# This is the 3rd commit message' and it works
fine.

This might be the lack of a newline after the last line in the commit
edit message when git-gui creates the commit -- maybe.

If I use git --amend instead of git-gui to update the commits on the
above test repository it works correctly.

I'm posting this because someone else can probably fix this faster than
me (I've never looked at the git source code).  I'll post a patch when I
figure it out if nobody else beats me to it.

Regards,
Bernt
