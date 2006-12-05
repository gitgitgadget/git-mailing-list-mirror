X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: using xdl_merge(), was Re: Resolving conflicts
Date: Tue, 05 Dec 2006 11:50:56 -0800
Message-ID: <7vac22glzz.fsf@assigned-by-dhcp.cox.net>
References: <456FD461.4080002@saville.com>
	<Pine.LNX.4.64.0611302330000.3695@woody.osdl.org>
	<456FDF24.1070001@saville.com>
	<Pine.LNX.4.64.0612012018490.3476@woody.osdl.org>
	<7vejri20mf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612021131140.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<4575B32F.5060108@ramsay1.demon.co.uk>
	<Pine.LNX.4.64.0612051023460.3542@woody.osdl.org>
	<Pine.LNX.4.63.0612051949290.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 19:51:28 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612051949290.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 5 Dec 2006 19:53:09 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33369>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrgJz-0008GW-8Q for gcvg-git@gmane.org; Tue, 05 Dec
 2006 20:51:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030681AbWLETvB (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 14:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030709AbWLETvA
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 14:51:00 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:62179 "EHLO
 fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1030681AbWLETu7 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006
 14:50:59 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061205195057.QTXO4817.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>; Tue, 5
 Dec 2006 14:50:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id v7r61V00W1kojtg0000000; Tue, 05 Dec 2006
 14:51:07 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 5 Dec 2006, Linus Torvalds wrote:
>
>>  - take every single merge in git (or the kernel, if you want even more)

The attached is the script I am using.  The test checks the
output from 'master' (merge from RCS) and 'next' (with xdl-merge)
and also tries to see how different the conflicts look like.

In the git.git archive, there is no "clean" merge on which
'master' and 'next' did not agree.  It is not a proof of
correctness at all but it gives a sense of assurance.

However, the conflict 'next' leaves seems a bit suspicious.
Trying to reproduce

	56f9686c4d1e1d586b731b815bd98d70f84ecda4

gives an interesting illustration.

Here is one conflicted hunk from that merge (RCS merge)

-- 8< -- RCS merge conflict hunk, diff from the 1st parent -- 8< --
 
--- a/Makefile
+++ b/Makefile
@@ -232,8 +232,13 @@ LIB_FILE=libgit.a
 XDIFF_LIB=xdiff/lib.a
 
 LIB_H = \
+<<<<<<< HEAD/Makefile
 	archive.h blob.h cache.h commit.h csum-file.h delta.h \
 	diff.h object.h pack.h pkt-line.h quote.h refs.h \
+=======
+	blob.h cache.h commit.h csum-file.h delta.h \
+	diff.h object.h pack.h pkt-line.h quote.h refs.h sideband.h \
+>>>>>>> d47f3db75c58139cdcbca5cc63b17bf5db293b6a/Makefile
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h
 
-- >8 -- RCS merge conflict hunk, diff from the 1st parent -- >8 --

-- 8< -- JS merge conflict hunk, diff from the 1st parent -- 8< --

--- a/Makefile
+++ b/Makefile
@@ -232,8 +232,14 @@ LIB_FILE=libgit.a
 XDIFF_LIB=xdiff/lib.a
 
 LIB_H = \
+<<<<<<< HEAD/Makefile
 	archive.h blob.h cache.h commit.h csum-file.h delta.h \
 	diff.h object.h pack.h pkt-line.h quote.h refs.h \
+=======
+	blob.h cache.h commit.h csum-file.h delta.h \
+	diff.h object.h pack.h pkt-line.h quote.h refs.h sideband.h \
+>>>>>>> d47f3db75c58139cdcbca5cc63b17bf5db293b6a/Makefile
+	diff.h object.h pack.h pkt-line.h quote.h refs.h sideband.h \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h
 
-- >8 -- JS merge conflict hunk, diff from the 1st parent -- >8 --

Notice that there is one duplicated line after the closing
conflict marker?


-- 8< -- remerge.sh test script -- 8< --
#!/bin/sh
# Leaves things to be examined in /var/tmp/remerge-$$/

ogit=$HOME/git-master/bin/git
ngit=$HOME/git-next/bin/git
tmp=/var/tmp/remerge-$$-tmp

trap 'rm -f $tmp-*' 0

# Revlist
if ! test -f ./+RL
then
	git rev-list --parents HEAD |
	perl -n -e 'if (/^[0-9a-f]{40} [0-9a-f]{40} [0-9a-f]{40}$/) {
		print;
	}' >./+RL
fi

try_one () {
	# should be on a discardable branch.

	git=$1 parent1=$2 parent2=$3
	$git reset --hard "$parent1"
	
	if $git merge "$parent2"
	then
		echo clean merge
		$git diff-tree -r --raw "$parent1" HEAD 
	else
		echo conflicted merge
		$git ls-files -u
		$git diff --binary -p "$parent1"
	fi
}

# Make sure we do not trash anything important
current=`git symbolic-ref HEAD`
if test "z$current" != zrefs/heads/remerge-test
then
	git checkout -b remerge-test ||
        git checkout remerge-test

        current=`git symbolic-ref HEAD`
        test "z$current" = zrefs/heads/remerge-test || exit
fi

while read result parent1 parent2
do
	try_one $ogit $parent1 $parent2 >$tmp-1 2>/dev/null
	try_one $ngit $parent1 $parent2 >$tmp-2 2>/dev/null
	if diff $tmp-1 $tmp-2
	then
		echo "Ok"
	else
		echo "Bad $result"
		mkdir -p $tmp/$result
		mv $tmp-1 $tmp/$result/ogit
		mv $tmp-2 $tmp/$result/ngit
	fi
	$git reset --hard
done < ./+RL

