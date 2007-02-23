From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Fri, 23 Feb 2007 00:51:11 -0800
Message-ID: <7v8xep8dfk.fsf@assigned-by-dhcp.cox.net>
References: <7v7iudz33y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 23 09:51:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKW96-0004Mq-4I
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 09:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbXBWIvN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 03:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbXBWIvN
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 03:51:13 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:49527 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932156AbXBWIvM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 03:51:12 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070223085111.XBFR2394.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Fri, 23 Feb 2007 03:51:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SwrB1W0081kojtg0000000; Fri, 23 Feb 2007 03:51:12 -0500
X-master-at: ef1a5c2fa8bc67abea6cbacf975ea3260cd40fa3
X-next-at: 3d8a50a9604f66a56894029d273f145896b3b326
In-Reply-To: <7v7iudz33y.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 19 Feb 2007 23:42:57 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40431>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* js/bundle (Fri Feb 23 03:17:51 2007 +0100) 5 commits
 + git-bundle: record commit summary in the prerequisite data
 + git-bundle: fix 'create --all'
 + git-bundle: avoid fork() in verify_bundle()
 + git-bundle: assorted fixes
 + Add git-bundle: move objects and references by archive

Johannes muttered something about leak in "create --all" but I
do not think there is any --- they are pointing at memory
location in refs.c:cached_refs.{loose,packed}.  I haven't
checked if the prerequisite logic is done correctly yet -- I
trust that the list can verify it for me before I get around to
it myself.

* js/no-limit-boundary (Mon Feb 19 03:14:59 2007 +0100) 1 commit
 + rev-list --max-age, --max-count: support --boundary

This should graduate to 'master' soon.

* js/etc-config (Thu Feb 15 11:43:56 2007 +0100) 2 commits
 + Make tests independent of global config files
 + config: read system-wide defaults from /etc/gitconfig

I think this is Ok, I do not have a real need for this myself
but it was done in response to a specific user request, so I can
be easily persuaded to make this graduate to 'master' by a
gentle reminder with a success report.

* js/commit-format (Fri Feb 23 01:35:03 2007 +0100) 1 commit
 - pretty-formats: add 'format:<string>'

Cute, but probably can be cleaned up.

* js/diff-ni (Thu Feb 22 21:50:10 2007 +0100) 1 commit
 - Teach git-diff-files the new option `--no-index`

With a minor code restructure I think it got much nicer.

* js/apply (Thu Feb 22 20:11:21 2007 +0100) 1 commit
 + apply: make --verbose a little more useful

Nice touch.  I think this is ready and I'll merge after I have a
chance or two to exercise it myself in real-life.

* jc/status (Thu Feb 22 02:07:56 2007 -0800) 5 commits
 - git-status: use in-core --refresh in a read-only repository.
 - git-runstatus --refresh
 + run_diff_{files,index}(): update calling convention.
 + update-index: do not die too early in a read-only repository.
 + git-status: do not be totally useless in a read-only repository.

The first (meaning bottom in the list) two are true improvement
for obscure corner case, the third is a code cleanup to make
future enhancements (and the later ones in the series) easier.
I have not decided if it is worth to have the remaining two, so
they are left in 'pu'.

* js/fetch-progress (Tue Feb 20 03:01:44 2007 +0100) 1 commit
 + fetch & clone: do not output progress when not on a tty

I'll see it in action from my cron job.

* jc/fetch (Tue Feb 13 01:21:41 2007 +0000) 8 commits
 - Use stdin reflist passing in git-fetch.sh
 - Use stdin reflist passing in parse-remote
 - Allow fetch--tool to read from stdin
 - git-fetch: rewrite expand_ref_wildcard in C
 - git-fetch: rewrite another shell loop in C
 - git-fetch: move more code into C.
 - git-fetch--tool: start rewriting parts of git-fetch in C.
 - git-fetch: split fetch_main into fetch_dumb and fetch_native

Works, does not break anything, very ugly.  Probably needs
reworking if we were to have this in 'next'.

* sb/merge (Thu Feb 15 16:39:53 2007 +0100) 1 commit
 - t/t5515-fetch-merge-logic.sh: Added tests for the merge logic in
   git-fetch

* jc/merge-subtree (Thu Feb 15 16:32:45 2007 -0800) 1 commit
 - A new merge stragety 'subtree'.

I agree with Shawn that its tree-shifting logic should be based
on something similar to tree-diff rename detection before moving
it into 'next'.

* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
 - test-para: combined diff between HEAD, index and working tree.
 - para-walk: walk n trees, index and working tree in parallel

Stalled.
