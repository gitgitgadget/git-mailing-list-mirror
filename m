From: Greg Price <price@ksplice.com>
Subject: [PATCH RFC 0/4] rebase -i: Add --refs option to rewrite heads
	within branch
Date: Tue, 22 Dec 2009 17:20:33 -0500
Message-ID: <20091222222032.GU30538@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 22 23:20:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NND62-0002d8-6A
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 23:20:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755057AbZLVWUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 17:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752764AbZLVWUl
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 17:20:41 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:41456 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752709AbZLVWUk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Dec 2009 17:20:40 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id nBMMK05n006317;
	Tue, 22 Dec 2009 17:20:00 -0500 (EST)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id nBMMKjtN028403;
	Tue, 22 Dec 2009 17:20:46 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135601>

This RFC series adds a "ref" command to rebase -i, and an option
--refs to generate "ref" commands in the original TODO file.  This
makes it easy to rebase a branch together with intermediate markers,
or a series of branches.

For example, in this situation:

      part1 part2 topic
        |     |     |
        v     v     v
  A--*--*--*--*--*--*
   \
    B <--master

we may want to rebase 'topic' onto the new master, rewriting the
intermediate branches 'part1', 'part2' to the corresponding new
commits.  This can be done with a sequence of "git rebase --onto"
commands, but it's tricky to get right.

With this series, the command
  $ git rebase -i --refs master topic
suffices to produce this result:

        part1 part2 topic
  A       |     |     |
   \      v     v     v
    B--*--*--*--*--*--*
    ^
    |
    master


These patches work for me.  Before I recommend the last two patches
for merge, they'll need the following additional work:
 - interoperate with rebase --abort
 - add documentation
 - probably add tests


The series begins with two patches that are independently useful, and
that I believe are ready for merge:
  pretty: Add %D for script-friendly decoration
  log --decorate=full: drop the "tag: " prefix
They make the functionality of 'git log --decorate' available in an
output format optimized for machine parsing.  I expect other people
will find this useful for other scripts.

Greg
