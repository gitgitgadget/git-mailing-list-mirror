From: paulfred <paul.fredrickson@gmail.com>
Subject: Re: git-svn confused by "empty" (svn prop change) commit
Date: Thu, 20 Nov 2008 17:30:17 -0800
Message-ID: <m23ahlj26u.fsf@gmail.com>
References: <m28wrfhz17.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 21 02:33:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3KtN-0002Iz-9J
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 02:33:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbYKUBbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 20:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752132AbYKUBbo
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 20:31:44 -0500
Received: from main.gmane.org ([80.91.229.2]:58780 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752027AbYKUBbo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 20:31:44 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1L3Krz-00036k-G8
	for git@vger.kernel.org; Fri, 21 Nov 2008 01:31:39 +0000
Received: from dhcp39016.vcd.hp.com ([15.252.39.16])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 21 Nov 2008 01:31:39 +0000
Received: from paul.fredrickson by dhcp39016.vcd.hp.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 21 Nov 2008 01:31:39 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dhcp39016.vcd.hp.com
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.91 (darwin)
Cancel-Lock: sha1:Nw7Lank+x1Tn5e8HT7wpdImeq38=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101492>

paulfred <paul.fredrickson@gmail.com> writes:
>
> Other (perhaps important) details: I created the repository several months
> ago,and only recently put "[svn] noMetadata = true" in my config file because
> I'm the only person on the team using git, and nobody else wanted to see the
> git-svn-id messages.
>

Okay, I see that I missed in the documentation where it says setting noMetadata
"must be done *before* any history is imported and these settings should never
be changed once they are set.  User error.

>
> I suppose I could nuke everything and clone another shallow copy of the code
> from some point after the bad commit, but I'd be happy with any kind of
> work around that gets me dcommitting again.
>

So, that is what I tried to do today, only it doesn't appear to work either!
Here's what I tried in more detail:

$ git svn init -T http://project.com/svn/trunk project --no-metadata

Then I edited my config to look like this:

[svn-remote "svn"]
            noMetadata = 1
            url = http://project.com/svn
            fetch = trunk/dev:refs/remotes/trunk

only changing the fetch line (I don't want to track web pages, etc. which
are also under trunk).  Followed by:

$ git svn fetch --revision 1156
$ git svn fetch
  (now it actually pulls everything since 1156 and checks out master)
  [hack, hack, hack]
$ git svn rebase
Unable to determine upstream SVN information from working tree history

at which point I realize I am probably screwed.  But I try it anyway,
since svn tells me no one else has checked anything in yet:

$ git svn dcommit
Unable to determine upstream SVN information from HEAD history.
Perhaps the repository is empty. at /usr/local/libexec/git-core/git-svn line 435.

So apparently my problem is NOT the empty commit at all, but trying to use
noMetadata.  I am surprised that it fails on a fresh download though. Is there
something I might have done while hacking that would cause git-svn to lose
track of trunk again?  Is my only option to convince everyone to ignore
the "noise" in my comments?

Thanks,

--Paul

 
