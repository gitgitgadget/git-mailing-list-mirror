From: Patrick Ohly <patrick.ohly@intel.com>
Subject: git rebase --whitespace
Date: Tue, 11 Nov 2008 15:12:50 +0100
Message-ID: <1226412770.17450.839.camel@ecld0pohly>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-0zil7GhaeHbTiJuOKk8G"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 11 15:14:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzu0N-0000jz-SJ
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 15:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755831AbYKKOMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 09:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755842AbYKKOMx
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 09:12:53 -0500
Received: from mga01.intel.com ([192.55.52.88]:63750 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754906AbYKKOMw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 09:12:52 -0500
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 11 Nov 2008 06:06:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.33,584,1220252400"; 
   d="scan'208";a="637886471"
Received: from ecld0pohly.ikn.intel.com (HELO [172.28.75.199]) ([172.28.75.199])
  by fmsmga001.fm.intel.com with ESMTP; 11 Nov 2008 06:13:33 -0800
X-Mailer: Evolution 2.22.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100645>


--=-0zil7GhaeHbTiJuOKk8G
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello!

I tried to use "git --rebase --whitespace=..." and noticed some
oddities. Git 1.6.0.4.

      * --whitespace is not supported when using --interactive. Should
        be mentioned in the docs.
      * Without --interactive, rebase will bail out early if the current
        branch is up-to-date. I was trying to use --whitespace=fix to
        clean up my patches and had to patch git-rebase (see attached),
        otherwise it didn't let me do that.
      * The documentation mentions --whitespace=check, but "check" is
        not a valid option.

I don't have time to fix the documentation, but I thought I should at
least mention the issues and send the patch your way in case someone
finds it useful.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.

--=-0zil7GhaeHbTiJuOKk8G
Content-Disposition: attachment; filename=git-rebase-whitespace.patch
Content-Type: text/x-patch; name=git-rebase-whitespace.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

--- git-1.6.0.4/git-rebase.sh	2008-11-09 07:53:38.000000000 +0100
+++ git-1.6.0.4/git-rebase.sh.patched	2008-11-11 15:10:27.000000000 +0100
@@ -375,6 +375,7 @@
 # but this should be done only when upstream and onto are the same.
 mb=$(git merge-base "$onto" "$branch")
 if test "$upstream" = "$onto" && test "$mb" = "$onto" &&
+        ! (echo $git_am_opt | grep -e --whitespace ) > /dev/null &&
 	# linear history?
 	! (git rev-list --parents "$onto".."$branch" | grep " .* ") > /dev/null
 then

--=-0zil7GhaeHbTiJuOKk8G--
