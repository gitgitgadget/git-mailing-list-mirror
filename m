From: Junio C Hamano <junkio@cox.net>
Subject: Yet another set of merge test cases from the kernel tree.
Date: Wed, 14 Sep 2005 17:47:53 -0700
Message-ID: <7vvf13b1hi.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050907164734.GA20198@c165.ib.student.liu.se>
	<20050907165012.GA20392@c165.ib.student.liu.se>
	<7vzmqk2u1w.fsf_-_@assigned-by-dhcp.cox.net>
	<7vpsrcqjj6.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 02:48:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFhv7-0005Om-Dh
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 02:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbVIOAsA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 20:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVIOAsA
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 20:48:00 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:29670 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932495AbVIOAr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2005 20:47:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050915004754.SDTY7185.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Sep 2005 20:47:54 -0400
To: Fredrik Kuivinen <freku045@student.liu.se>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vpsrcqjj6.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 13 Sep 2005 22:56:45 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8576>

I've tried to reproduce 400+ merges I picked up from various
kernel trees that have more than one merge base.

number of commits looked at      : 83292
number of merge commits          : 11089
commits with more than one base  :   426

Interestingly enough, some of them have timestamps in 2002 or
2003, and comparing what our merge strategies do with what
actually got recorded is interesting.  I hope comparing what was
recorded by the SCM used back then and what we would produce
today given the same input does not violate any license
agreements somebody might have ;-).

I've taken a look at only handful of results, but I can already
see some patterns:

 - Overall we seem to do reasonably well -- IOW many merges are
   trivial even to 'stupid' strategy;

 - In some cases, all strategies do quite poorly.  For example:

   091cced38d83732ee3212806ef5ea07abbef01fe
   44583d380d189095fa959ec8ba87f0cb6deb15f5

 - There are quite a few case #16 (45 out of 426).  While
   'stupid' strategy fails to merge many of them, there are
   plenty of cases that it trivially resolves to what the SCM
   used back then did.  'resolve' being too cautious _might_
   irritate some users in these cases, but personally I feel
   that being safer is better than letting ambiguities go
   unnoticed.  It _might_ indicate that the SCM used back then
   made the same mistake as our 'stupid' strategy does today
   ;-).  A couple of examples:

   39284791a2ca8cb32b5597bf9ccf8e5c548e7aa7
   662756c753b13231d437e4bc78032b5891c9d4ea

 - 'recursive' strategy seems to most often produce results that
   match what the SCM used back then did, but it still gets some
   cases different.  E.g.

   10f44c023ef22c8c125d5ef15bed560d46c66af9
   2e7bdf93a8c4d7ecd54f1ceb19881faf0f6b14f3
   46f58b7869ffd1f2009065ffa626db3b0498925a
   5f4fbfe6d1986a99cb62f433346c92e57e7b9814
   651a8cf62546f2425df09b1b4451fe317f84431d

I have not really counted to make stats out of those 426 merge
results, and the above is just my first impressions after
looking at about two dozens or so.


------------
commit 091cced38d83732ee3212806ef5ea07abbef01fe
Merge: 80964be0914c821546d3673fcb552d5b87a44867 cb70bcabcfb745c7dee78792bd17fb5fd50b0950
Author: Len Brown <len.brown@intel.com>
Date:   Wed Nov 10 07:57:44 2004 -0500

    Merge intel.com:/home/lenb/src/26-stable-dev
    into intel.com:/home/lenb/src/26-latest-dev

differences in paths: 4057

Try resolving the old way.
Method 'traditional' automerged (1).
Method 'traditional' did not resolve cleanly.
	unmerged paths: 1
	conflict paths: 2
Difference from the actual commit: 4
Difference from the actual commit (cached): 2

Strategy recursive.
Method 'recursive' automerged (0).
Method 'recursive' resolved cleanly.
Difference from the actual commit: 1
Difference from the actual commit (cached): 1

Strategy resolve.
Method 'resolve' automerged (1).
Method 'resolve' did not resolve cleanly.
	unmerged paths: 46
	conflict paths: 24
Difference from the actual commit: 28
Difference from the actual commit (cached): 27

Strategy stupid.
Method 'stupid' automerged (1).
Method 'stupid' did not resolve cleanly.
	unmerged paths: 1
	conflict paths: 2
Difference from the actual commit: 4
Difference from the actual commit (cached): 2
 ------------------------------------------------ 
commit 10f44c023ef22c8c125d5ef15bed560d46c66af9
Merge: 5ad6b7ada85fa414a7e94c309ef9c73862c08f69 961c380cef0f1af06c254488d1a672324ec2b34a
Author: Greg Kroah-Hartman <greg@kroah.com>
Date:   Tue Mar 2 03:27:45 2004 -0800

    Merge kroah.com:/home/linux/BK/bleed-2.6
    into kroah.com:/home/linux/BK/pci-2.6

differences in paths: 273

Try resolving the old way.
Method 'traditional' automerged (1).
Method 'traditional' did not resolve cleanly.
	unmerged paths: 1
	conflict paths: 1
Difference from the actual commit: 1
Difference from the actual commit (cached): 0

Strategy recursive.
Method 'recursive' automerged (0).
Method 'recursive' resolved cleanly.
Difference from the actual commit: 0
Difference from the actual commit (cached): 0

Strategy resolve.
Method 'resolve' automerged (1).
Method 'resolve' did not resolve cleanly.
	unmerged paths: 16
	conflict paths: 8
Difference from the actual commit: 8
Difference from the actual commit (cached): 8

Strategy stupid.
Method 'stupid' automerged (1).
Method 'stupid' did not resolve cleanly.
	unmerged paths: 1
	conflict paths: 1
Difference from the actual commit: 1
Difference from the actual commit (cached): 0
 ------------------------------------------------ 
commit 2e7bdf93a8c4d7ecd54f1ceb19881faf0f6b14f3
Merge: ad50ff186e3544ce316bc24e8b37e82b840b42e1 b1c237f8c2f529713c11839db9d49ed8cec1c607
Author: Patrick Mochel <mochel@osdl.org>
Date:   Mon Sep 8 21:22:38 2003 -0700

    Merge kernel.bkbits.net:linux-2.5-power
    into osdl.org:/home/mochel/src/kernel/linux-2.5-power

differences in paths: 70

Try resolving the old way.
Method 'traditional' automerged (1).
Method 'traditional' did not resolve cleanly.
	unmerged paths: 4
	conflict paths: 3
Difference from the actual commit: 4
Difference from the actual commit (cached): 3

Strategy recursive.
Method 'recursive' automerged (0).
Method 'recursive' resolved cleanly.
Difference from the actual commit: 0
Difference from the actual commit (cached): 0

Strategy resolve.
Method 'resolve' automerged (1).
Method 'resolve' did not resolve cleanly.
	unmerged paths: 2
	conflict paths: 1
Difference from the actual commit: 1
Difference from the actual commit (cached): 1

Strategy stupid.
Method 'stupid' automerged (1).
Method 'stupid' did not resolve cleanly.
	unmerged paths: 4
	conflict paths: 3
Difference from the actual commit: 4
Difference from the actual commit (cached): 3
 ------------------------------------------------ 
commit 39284791a2ca8cb32b5597bf9ccf8e5c548e7aa7
Merge: f96645e41c946431b988e061fbc9dd4c7176e621 b335ff4d92816a6722fcf323c67b86af58eb5b9d
Author: Keith M. Wesolowski <wesolows@foobazco.org>
Date:   Sun Jul 11 10:20:23 2004 -0700

    Merge ssh://kernel.bkbits.net/sparc32-2.6
    into foobazco.org:/sources/2.5-sparc-todave

differences in paths: 2316

Try resolving the old way.
Method 'traditional' automerged (0).
Method 'traditional' resolved cleanly.
Difference from the actual commit: 0
Difference from the actual commit (cached): 0

Strategy recursive.
Method 'recursive' automerged (0).
Method 'recursive' resolved cleanly.
Difference from the actual commit: 0
Difference from the actual commit (cached): 0

Strategy resolve.
Method 'resolve' automerged (1).
Method 'resolve' did not resolve cleanly.
	unmerged paths: 4
	conflict paths: 2
Difference from the actual commit: 4
Difference from the actual commit (cached): 4

Strategy stupid.
Method 'stupid' automerged (0).
Method 'stupid' resolved cleanly.
Difference from the actual commit: 0
Difference from the actual commit (cached): 0
 ------------------------------------------------ 
commit 44583d380d189095fa959ec8ba87f0cb6deb15f5
Merge: 645dbacc0c65228151b7cbcb8a977c83328cef76 8bf1412a4bbfc9da0224e73203172f98f987b41a
Author: Jeff Dike <jdike@uml.karaya.com>
Date:   Sun Dec 29 11:40:13 2002 -0500

    Merge uml.karaya.com:/home/jdike/linux/2.5/skas-2.5
    into uml.karaya.com:/home/jdike/linux/2.5/skas-2.5-linus

differences in paths: 406

Try resolving the old way.
Method 'traditional' automerged (0).
Method 'traditional' resolved cleanly.
Difference from the actual commit: 1
Difference from the actual commit (cached): 1

Strategy recursive.
Method 'recursive' automerged (1).
Method 'recursive' did not resolve cleanly.
	unmerged paths: 1
	conflict paths: 1
Difference from the actual commit: 1
Difference from the actual commit (cached): 1

Strategy resolve.
Method 'resolve' automerged (1).
Method 'resolve' did not resolve cleanly.
	unmerged paths: 1
	conflict paths: 1
Difference from the actual commit: 2
Difference from the actual commit (cached): 2

Strategy stupid.
Method 'stupid' automerged (0).
Method 'stupid' resolved cleanly.
Difference from the actual commit: 1
Difference from the actual commit (cached): 1
 ------------------------------------------------ 
commit 46f58b7869ffd1f2009065ffa626db3b0498925a
Merge: d98612ae0eac1053fe585c0b283a9d385ed80572 9dd6f379b26f49c5819e302156dabb2171721f78
Author: James Simmons <jsimmons@maxwell.earthlink.net>
Date:   Sat Nov 16 01:36:03 2002 -0800

    Merge

differences in paths: 74

Try resolving the old way.
Method 'traditional' automerged (1).
Method 'traditional' did not resolve cleanly.
	unmerged paths: 1
	conflict paths: 5
Difference from the actual commit: 6
Difference from the actual commit (cached): 5

Strategy recursive.
Method 'recursive' automerged (1).
Method 'recursive' did not resolve cleanly.
	unmerged paths: 1
	conflict paths: 1
Difference from the actual commit: 1
Difference from the actual commit (cached): 0

Strategy resolve.
Method 'resolve' automerged (1).
Method 'resolve' did not resolve cleanly.
	unmerged paths: 4
	conflict paths: 3
Difference from the actual commit: 3
Difference from the actual commit (cached): 2

Strategy stupid.
Method 'stupid' automerged (1).
Method 'stupid' did not resolve cleanly.
	unmerged paths: 1
	conflict paths: 5
Difference from the actual commit: 6
Difference from the actual commit (cached): 5
 ------------------------------------------------ 
commit 5f4fbfe6d1986a99cb62f433346c92e57e7b9814
Merge: 03fab1f6c2a2ac316da184d687276655b53d3290 e772cc0eea175593d25669e11433b9647f4051e5
Author: James Simmons <jsimmons@kozmo.(none)>
Date:   Fri Feb 14 17:37:00 2003 -0800

    Merge bk://fbdev.bkbits.net/fbdev-2.5
    into kozmo.(none):/usr/src/fbdev-2.5

differences in paths: 154

Try resolving the old way.
Method 'traditional' automerged (1).
Method 'traditional' did not resolve cleanly.
	unmerged paths: 1
	conflict paths: 2
Difference from the actual commit: 4
Difference from the actual commit (cached): 2

Strategy recursive.
Method 'recursive' automerged (0).
Method 'recursive' resolved cleanly.
Difference from the actual commit: 0
Difference from the actual commit (cached): 0

Strategy resolve.
Method 'resolve' automerged (1).
Method 'resolve' did not resolve cleanly.
	unmerged paths: 2
	conflict paths: 1
Difference from the actual commit: 2
Difference from the actual commit (cached): 2

Strategy stupid.
Method 'stupid' automerged (1).
Method 'stupid' did not resolve cleanly.
	unmerged paths: 1
	conflict paths: 2
Difference from the actual commit: 4
Difference from the actual commit (cached): 2
 ------------------------------------------------ 
commit 651a8cf62546f2425df09b1b4451fe317f84431d
Merge: cbe9bae1575761d8dfa7dd4b07c94878ef95bab8 abb86e39e38666d8b0af1821cb7c036902bbf459
Author: James Simmons <jsimmons@kozmo.(none)>
Date:   Thu Dec 5 17:48:25 2002 -0800

    Merge bk://fbdev.bkbits.net/fbdev-2.5
    into kozmo.(none):/usr/src/fbdev-2.5

differences in paths: 312

Try resolving the old way.
Method 'traditional' automerged (1).
Method 'traditional' did not resolve cleanly.
	unmerged paths: 1
	conflict paths: 1
Difference from the actual commit: 1
Difference from the actual commit (cached): 1

Strategy recursive.
Method 'recursive' automerged (0).
Method 'recursive' resolved cleanly.
Difference from the actual commit: 0
Difference from the actual commit (cached): 0

Strategy resolve.
Method 'resolve' automerged (0).
Method 'resolve' resolved cleanly.
Difference from the actual commit: 1
Difference from the actual commit (cached): 1

Strategy stupid.
Method 'stupid' automerged (1).
Method 'stupid' did not resolve cleanly.
	unmerged paths: 1
	conflict paths: 1
Difference from the actual commit: 1
Difference from the actual commit (cached): 1
 ------------------------------------------------ 
commit 662756c753b13231d437e4bc78032b5891c9d4ea
Merge: 1a89e511e152998311f49c60e55b21d48d1b8973 8d7c763253b85b5598e5975a5c88b896fefe2110
Author: Tony Luck <tony.luck@intel.com>
Date:   Thu Mar 31 00:29:06 2005 -0800

    Merge intel.com:/data/home/aegl/BK/work/1
    into intel.com:/data/home/aegl/BK/linux-ia64-release-2.6.12

differences in paths: 3303

Try resolving the old way.
Method 'traditional' automerged (0).
Method 'traditional' resolved cleanly.
Difference from the actual commit: 0
Difference from the actual commit (cached): 0

Strategy recursive.
Method 'recursive' automerged (0).
Method 'recursive' resolved cleanly.
Difference from the actual commit: 0
Difference from the actual commit (cached): 0

Strategy resolve.
Method 'resolve' automerged (0).
Method 'resolve' resolved cleanly.
Difference from the actual commit: 3
Difference from the actual commit (cached): 3

Strategy stupid.
Method 'stupid' automerged (0).
Method 'stupid' resolved cleanly.
Difference from the actual commit: 0
Difference from the actual commit (cached): 0
 ------------------------------------------------ 
#!/bin/sh

check_result () {
	# method=$1, expect=$2

	result_exit=$?
	case "$result_exit" in
	0 | 1)
		echo "Method '$1' automerged ($result_exit)."
		git-update-cache --refresh >/dev/null
		unmerged=`git-ls-files --unmerged`
		conflict=`git-diff-files --name-only`
		case "$unmerged$conflict" in
		'')
			echo "Method '$1' resolved cleanly."
			;;
		*)
			echo "Method '$1' did not resolve cleanly."
			echo "	unmerged paths: "`echo "$unmerged" | wc -l`
			echo "	conflict paths: "`echo "$conflict" | wc -l`
			;;
		esac
		echo "Difference from the actual commit: "`
			git-diff-cache --name-only "$expect" | wc -l`
		echo "Difference from the actual commit (cached): "`
			git-diff-cache --name-only --cached "$expect" | wc -l`
		;;
	*)
		echo "Method '$1' failed to automerge."
		;;
	esac
}

strategies=$(git merge -s help 2>&1 | sed -e 's/available strategies are: //')

rm -fr ./++merge-log
mkdir -p ./++merge-log

while read parents
do
	set x $parents; shift; head="$1"; shift
	remote= expect= remotes_seen=
	for x
	do
		case "$x" in
		'|')
			case "$remotes_seen" in
			yes) break ;;
			esac
			remotes_seen=yes
			continue ;;
		?*)
			case "$remotes_seen" in
			yes) expect="$x"; break ;;
			esac
			remote="$remote$x " ;;
		esac
	done

	echo "Merge $remote into $head"
	echo

    (
	
	git log --max-count=1 $expect

	echo "differences in paths: "`
		git-diff-tree -r --name-only $remote $head | wc -l`

	echo
	git reset --hard "$head"
	echo "Try resolving the old way."
	(
		PATH=$HOME/bin/Linux-0.99.6:/usr/bin:/bin
		export PATH
		git-resolve-script $head $remote 'test merge with resolve'
		exit $?
	) >./"++merge-log/$expect.traditional" 2>&1
	check_result traditional $expect

	for s in $strategies
	do
	    case "$s" in octopus) continue ;; esac
	    echo
	    git reset --hard "$head"
	    echo "Strategy $s."
	    git-merge -n -s $s "test merge $s" $head $remote \
		>./"++merge-log/$expect.$s" 2>&1
	    check_result $s $expect
	done

	echo ' ------------------------------------------------ '

    ) >./"++merge-log/$expect".log 2>&1

done <./++commit-check-out
