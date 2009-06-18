From: Peter Krefting <peter@softwolves.pp.se>
Subject: msysgit git-submodule: "Unable to fetch in submodule path ..."
Date: Thu, 18 Jun 2009 14:10:56 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0906181310400.23400@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 18 15:11:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHHOV-0003hu-Dq
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 15:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755326AbZFRNK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 09:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755168AbZFRNKz
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 09:10:55 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:43663 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754665AbZFRNKz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 09:10:55 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id n5IDAuHg031786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 18 Jun 2009 15:10:56 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id n5IDAuVn031783;
	Thu, 18 Jun 2009 15:10:56 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Thu, 18 Jun 2009 15:10:56 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121838>

Hi!

This is with msysGit 1.6.3.2.1299.gee46c

I am having some problem when checking out a large project with many 
submodules. After cloning the superproject, doing a git submodule --init 
will fail with a "Unable to fetch in submodule path '...'" for one specific 
module (does this on all machines that we have tried it on). I cannot see 
any error messages from git-fetch itself:

   [...]
   Initialized empty Git repository in c:/Users/peter/src/foo/bar/modules/foo/.git/
   remote: Counting objects: 14752, done.
   remote: Compressing objects: 100% (5036/5036), done.
   remote: Total 14752 (delta 9278), reused 14752 (delta 9278)Receiving objects:  9

   Receiving objects: 100% (14752/14752), 5.07 MiB | 3501 KiB/s, done.
   Resolving deltas: 100% (9278/9278), done.
   Unable to fetch in submodule path 'modules/foo'

If I enter the modules/foo manually and enter

   git reset --hard

or similar, everything works fine, and I do have the complete history.

Looking at the code for git-submodule, it seems to suggest that git 
submodule is calling git-fetch without parameters, and checking the return 
value from it. It does, as indicated above, not seem to return any errors.

I tried adding a "-v -v" to the git-fetch command line in git-submodule, and I 
see that it does terminate early. With the other modules, I get a list of 
all the cloned branches and tags. But for this module, it stops as above. I 
get some additional debug output, but can't quite say it helps me much:

   Initialized empty Git repository in c:/Users/peter/src/foo/baz/modules/foo/.git/
   remote: Counting objects: 14752, done.
   remote: Compressing objects: 100% (5036/5036), done.
   emote: Total 14752 (delta 9278), reused 14752 (delta 9278)
   Receiving objects: 100% (14752/14752), 5.07 MiB | 3629 KiB/s, done.
   Resolving deltas: 100% (9278/9278), done.
   Server supports multi_ack
   Server supports side-band-64k
   Server supports ofs-delta
   Marking 76b96bfecc0d47013dd1fca1a555f12074eca814 as complete
   Unable to fetch in submodule path 'modules/foo'

The string "Marking %s as complete" seems to stem from 
mark_recent_complete_commits() in builtin-fetch-pack.c. The other messages 
seems to stem from do_fetch_pack() in the same file, so it gets there and 
not further. I cannot seem to find any exit point.

Does anyone know how to continue debugging, or know what might be going wrong?

-- 
\\// Peter - http://www.softwolves.pp.se/
