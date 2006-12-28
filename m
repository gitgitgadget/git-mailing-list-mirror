From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFH] An early draft of v1.5.0 release notes
Date: Thu, 28 Dec 2006 01:32:54 +0100
Organization: At home
Message-ID: <emv367$sua$1@sea.gmane.org>
References: <7vvejx948y.fsf@assigned-by-dhcp.cox.net> <emtgps$f1q$1@sea.gmane.org> <7v1wml8wmw.fsf@assigned-by-dhcp.cox.net> <200612271312.15877.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart3133541.2NIeRqVztD"
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Dec 28 01:30:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzjA7-0004qp-J0
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 01:30:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932689AbWL1AaN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 19:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbWL1AaN
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 19:30:13 -0500
Received: from main.gmane.org ([80.91.229.2]:52961 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932689AbWL1AaL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 19:30:11 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Gzj9r-00055O-H6
	for git@vger.kernel.org; Thu, 28 Dec 2006 01:30:07 +0100
Received: from host-81-190-19-121.torun.mm.pl ([81.190.19.121])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Dec 2006 01:30:07 +0100
Received: from jnareb by host-81-190-19-121.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Dec 2006 01:30:07 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-19-121.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35494>

--nextPart3133541.2NIeRqVztD
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8Bit

Jakub Narebski wrote:
> Junio C Hamano wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>>> Junio C Hamano wrote:
>>>>
>>>>  - The commits referred to by reflog entries are now protected
>>>>    against pruning.  The new command "git reflog expire" can be
>>>>    used to truncate older reflog entries and entries that refer
>>>>    to commits that have been pruned away previously.
>>>>
>>>>    Existing repositories that have been using reflog may get
>>>>    complaints from fsck-objects; please run "git reflog expire
>>>>    --all" first to remove reflog entries that refer to commits
>>>>    that are no longer in the repository before attempting to
>>>>    repack it.
[...]

> I'd rather use "git reflog expire --pruned" to remove reflog entries
> which refer to commits which are no longer in the repository; I don't
> know, perhaps "git reflog expire --all" does that: but there is no
> Documentation/git-reflog.txt (and I'm not running 'next' nor 'master'
> but 1.4.4.3). So most probably it is just the case of adding an alias
> to reflog expire option.

Thanks for adding Documentation/git-reflog.txt. Nevertheless it didn't
add the information that "git reflog expire" removes reflog entries that
refer to commits that are no longer in the repository (see attached patch).

I'm not sure if such technical information should be in git-reflog(1),
but does only second, current sha1 in reflog line matters for prune?
And does expiring rewrite reflog (previous sha1, making always previous
sha1 (first sha1 in reflog line) always to refer some commit in earlier
reflog line, or before first reflog line), or only delete lines?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

--nextPart3133541.2NIeRqVztD
Content-Type: text/plain; name="0001-Add-information-in-git-reflog-1-that-expire-removes-pruned-entries.txt"
Content-Transfer-Encoding: 8Bit
Content-Description: [PATCH] Add information in git-reflog(1) that "expire" removes pruned entries
Content-Disposition: attachment; filename="0001-Add-information-in-git-reflog-1-that-expire-removes-pruned-entries.txt"

>From c39e864dec5fc5542e9dd14235a48fa2bb77ed6a Mon Sep 17 00:00:00 2001
From: Jakub Narebski <jnareb@gmail.com>
Date: Thu, 28 Dec 2006 01:30:05 +0100
Subject: [PATCH] Add information in git-reflog(1) that "expire" removes pruned entries

Add information to Documentation/git-reflog.txt that "expire" subcommand
also removes entries which refer to commits that are no longer in
repository.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 Documentation/git-reflog.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 55a24d3..04ea51a 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -22,11 +22,12 @@ updated.  This command is to manage the information recorded in it.
 The subcommand "expire" is used to prune older reflog entries.
 Entries older than `expire` time, or entries older than
 `expire-unreachable` time and are not reachable from the current
-tip, are removed from the reflog.  This is typically not used
+tip, are removed from the reflog.  Entries which refer to
+commits that are no longer in the repository are pruned
+regardless of their age.  This command is typically not used
 directly by the end users -- instead, see gitlink:git-gc[1].
 
 
-
 OPTIONS
 -------
 
-- 
1.4.4.3


--nextPart3133541.2NIeRqVztD--
