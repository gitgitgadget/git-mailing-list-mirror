From: Greg Price <greg@quora.com>
Subject: [PATCH 0/6] rebase: command "ref" and options --rewrite-{refs,heads,tags}
Date: Sun, 26 Jun 2011 17:16:57 -0700
Message-ID: <cover.1309133817.git.greg@quora.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 27 02:42:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QazuM-0006H7-UU
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 02:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756008Ab1F0AfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jun 2011 20:35:12 -0400
Received: from DMZ-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.35]:55655 "EHLO
	dmz-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755828Ab1F0Aed (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jun 2011 20:34:33 -0400
X-AuditID: 12074423-b7ce8ae000000a29-e5-4e07d0115ffd
Received: from mailhub-auth-3.mit.edu ( [18.9.21.43])
	by dmz-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 79.69.02601.110D70E4; Sun, 26 Jun 2011 20:34:25 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id p5R0YUuC028979;
	Sun, 26 Jun 2011 20:34:30 -0400
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p5R0YTNn018988;
	Sun, 26 Jun 2011 20:34:30 -0400 (EDT)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsUixCmqrSt4gd3P4NwFYYuuK91MFg29V5gd
	mDwuXlL2+LxJLoApissmJTUnsyy1SN8ugSvjxPO7bAWN4hUfp7g2MG4Q7GLk5JAQMJF41POE
	FcIWk7hwbz1bFyMXh5DAPkaJH9cWs0A4GxglZnfuZYJwvjBKLPh3iBmkRUhAXeJm2yFGCFtH
	4s/v+1C2lcSeHfuhbEOJJ0fvsIPYvED25ZVvwHrZBBQljm79CBYXEVCTmNh2iAXEZhYQl1g3
	9zxYnEVAVeLJx29g9cICQRJXbu5jmcDIv4CRYRWjbEpulW5uYmZOcWqybnFyYl5eapGumV5u
	ZoleakrpJkZQELG7KO9g/HNQ6RCjAAejEg9vZxy7nxBrYllxZe4hRkkOJiVRXtHzQCG+pPyU
	yozE4oz4otKc1OJDjBIczEoivO/CgHK8KYmVValF+TApaQ4WJXHeXO//vkIC6YklqdmpqQWp
	RTBZGQ4OJQneIJChgkWp6akVaZk5JQhpJg5OkOE8QMNDQWp4iwsSc4sz0yHypxgVpcR5V4Mk
	BEASGaV5cL2wKH/FKA70ijBvG0gVDzBBwHW/AhrMBDS47zIbyOCSRISUVAOj9Yu0C6FSCR4p
	HRKXOHc/nnzlkCynxLa1JudCls769TOhPc1ko6ZD//nXlRsvdV9IaDn0xv38R27Fr1WfFJiu
	x+sePXoiN55ZdJOS0BO/pLvsOq4fZ3XrMyrOa1Vcnm7yf/2Rz0d5J3LXHapdyrsrbbqSZ6ze
	p4+xwaftX0eqsCQK9u56dpZfiaU4I9FQi7moOBEA7P8mEc0CAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176339>

This series adds a "ref" command to rebase -i, and options
--rewrite-{refs,heads,tags} to generate "ref" commands in the original
TODO file.  This makes it easy to rebase a branch together with
intermediate markers, or a series of branches.

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
  $ git rebase --rewrite-heads master topic
suffices to produce this result:

        part1 part2 topic
  A       |     |     |
   \      v     v     v
    B--*--*--*--*--*--*
    ^
    |
    master


I originally submitted a version of this series nearly a year and a
half ago [1].  This version has been rebased to the new release 1.7.6
(Martin von Zweigbergk's cleanups gave me quite some conflicts to
resolve, but are nevertheless much appreciated!) and the interface has
been adjusted for the comments of Junio and others [2].  The general
command is --rewrite-refs=PATTERN; --rewrite-heads and --rewrite-tags
are provided as shortcuts, the former being equivalent to the --refs
of my original proposal.

 [1]  http://www.amailbox.net/mailarchive/git/2009/12/22/18967
 [2]  http://www.amailbox.net/mailarchive/git/2009/12/22/18972

I have no excuse for the year and a half of delay in submitting the
revised version, but I believe that late is better than never. =)


The series contains two preparatory patches that are independently useful:
  pretty: Add %D for script-friendly decoration
  for-each-ref: --stdin to match specified refs against pattern
Each one exposes a bit more knowledge of the repository in a
machine-readable form convenient for scripting.  I hope other people
may find them useful in writing other scripts.

Greg


---
Greg Price (6):
  rebase -i: Add the "ref" command
  pretty: Add %D for script-friendly decoration
  for-each-ref: --stdin to match specified refs against pattern
  rebase: --rewrite-{refs,heads,tags} to pull refs along with branch
  t/lib-rebase.sh: pass through ref commands
  rebase --rewrite-refs: tests

 Documentation/git-rebase.txt     |   15 ++++++++
 Documentation/pretty-formats.txt |    1 +
 builtin/for-each-ref.c           |   22 ++++++++++-
 git-rebase--interactive.sh       |   37 ++++++++++++++++++-
 git-rebase.sh                    |   28 ++++++++++++++
 pretty.c                         |   33 +++++++++++++----
 t/lib-rebase.sh                  |    2 +-
 t/t3420-rebase-ref.sh            |   75 ++++++++++++++++++++++++++++++++++++++
 8 files changed, 201 insertions(+), 12 deletions(-)
 create mode 100644 t/t3420-rebase-ref.sh

-- 
1.7.5.4
