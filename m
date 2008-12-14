From: Nix <nix@esperi.org.uk>
Subject: Possibly-spurious 'not uptodate. Cannot merge'
Date: Sun, 14 Dec 2008 16:47:09 +0000
Message-ID: <874p16puuq.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 14 17:48:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBu8v-00064R-Cp
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 17:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442AbYLNQrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 11:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753126AbYLNQrP
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 11:47:15 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:35969 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677AbYLNQrP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 11:47:15 -0500
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18])
	by mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id mBEGlAUH013861
	for <git@vger.kernel.org>; Sun, 14 Dec 2008 16:47:11 GMT
Received: (from nix@localhost)
	by esperi.org.uk (8.12.11.20060614/8.12.11/Submit) id mBEGl94s028640;
	Sun, 14 Dec 2008 16:47:09 GMT
Emacs: the prosecution rests its case.
User-Agent: Gnus/5.1008 (Gnus v5.10.8) XEmacs/21.5-b28 (linux)
X-DCC-INFN-TO-Metrics: hades 1233; Body=1 Fuz1=1 Fuz2=1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103092>

Recently (as of perhaps git 1.5.4?), whenever I update my l-k tree I get
this:

loki 504 /usr/packages/linux/linux% git pull
remote: Counting objects: 638, done.
remote: Compressing objects: 100% (86/86), done.
remote: Total 517 (delta 430), reused 516 (delta 430)
Receiving objects: 100% (517/517), 74.91 KiB, done.
Resolving deltas: 100% (430/430), completed with 120 local objects.
From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.27.y
   078bb16..5defaf8  master     -> 2.6.27-stable/master
 * [new tag]         v2.6.27.9  -> v2.6.27.9
error: Entry 'Makefile' not uptodate. Cannot merge.
fatal: merging of trees 34f70ec1fadcaad7de6979491e2dea9da735e6f9 and ded3f44559ce050e0ef014ebce093c5d9295ede8 failed
Merge with strategy recursive failed.

In this situation, 'git diff' reports no changes at all, but 'git reset
--hard' gets the tree back into a state where merging succeeds, as does
'git update-index --refresh'.

I suspect the 'problem' is that I've hardlinked a bunch of build trees
to this tree in the interim via 'cp -al', then applied patches to each
of those trees with quilt, then deleted all those trees prior to the git
pull. This doesn't change the original files at all, but *does* update
their link count: is git getting annoyed by the corresponding change in
ctime? (If so, why did it start happening only fairly recently?)
