From: David Fang <fang@csl.cornell.edu>
Subject: sparse-checkout test failures [powerpc-darwin8]
Date: Wed, 4 Apr 2012 16:20:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.1204041616001.16407@hal-00.csl.cornell.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 22:28:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFWoX-0001OQ-NU
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 22:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184Ab2DDU2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 16:28:17 -0400
Received: from csl.cornell.edu ([128.84.224.10]:2761 "EHLO csl.cornell.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753724Ab2DDU2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 16:28:16 -0400
X-Greylist: delayed 483 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Apr 2012 16:28:16 EDT
Received: from hal-00.csl.cornell.edu (hal-00.csl.cornell.edu [128.84.224.105])
	by csl.cornell.edu (8.13.4/8.13.4) with ESMTP id q34KK8Qq068187
	for <git@vger.kernel.org>; Wed, 4 Apr 2012 16:20:13 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194738>

Hi,
 	With git 1.7.9.4, I'm seeing test failures with
t1011-read-tree-sparse-checkout.sh.

not ok - 16 read-tree adds to worktree, dirty case
#
#               echo init.t >.git/info/sparse-checkout &&
#               git checkout -f removed &&
#               mkdir sub &&
#               echo dirty >sub/added &&
#               read_tree_u_must_succeed -u -m HEAD^ &&
#               grep -q dirty sub/added
#
not ok - 17 index removal and worktree narrowing at the same time
#
#               >empty &&
#               echo init.t >.git/info/sparse-checkout &&
#               echo sub/added >>.git/info/sparse-checkout &&
#               git checkout -f top &&
#               echo init.t >.git/info/sparse-checkout &&
#               git checkout removed &&
#               git ls-files sub/added >result &&
#               test ! -f sub/added &&
#               test_cmp empty result
#
not ok - 18 read-tree --reset removes outside worktree
#
#               >empty &&
#               echo init.t >.git/info/sparse-checkout &&
#               git checkout -f top &&
#               git reset --hard removed &&
#               git ls-files sub/added >result &&
#               test_cmp empty result
#
not ok - 19 print errors when failed to update worktree
#
#               echo sub >.git/info/sparse-checkout &&
#               git checkout -f init &&
#               mkdir sub &&
#               touch sub/added sub/addedtoo &&
#               test_must_fail git checkout top 2>actual &&
#               cat >expected <<\EOF &&
#       error: The following untracked working tree files would be 
overwritten b
y checkout:
#               sub/added
#               sub/addedtoo
#       Please move or remove them before you can switch branches.
#       Aborting
#       EOF
#               test_cmp expected actual
#
# failed 5 among 19 test(s)
1..19
make[2]: *** [t1011-read-tree-sparse-checkout.sh] Error 1


not ok - 16 not just commits
#
#               echo replaced >file &&
#               git add file &&
#               REPLACED=$(git rev-parse :file) &&
#               mv file file.replaced &&
#
#               echo original >file &&
#               git add file &&
#               ORIGINAL=$(git rev-parse :file) &&
#               git update-ref refs/replace/$ORIGINAL $REPLACED &&
#               mv file file.original &&
#
#               git checkout file &&
#               test_cmp file.replaced file
#
# failed 1 among 16 test(s)
1..16
make[2]: *** [t6050-replace.sh] Error 1


Everything else that's "not ok" is a known breakage.

[from http://paste.lisp.org/display/128628]

Any idea what's going wrong?
Anyone else seeing these failures?

Fang


-- 
David Fang
http://www.csl.cornell.edu/~fang/
