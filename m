From: "Vallon, Justin" <Justin.Vallon@deshaw.com>
Subject: git svn dcommit fails with empty commits
Date: Fri, 10 Dec 2010 11:25:11 -0500
Message-ID: <982E526FA742C94E9AC26DA766FD07090A3373@NYCMBX3.winmail.deshaw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "'git@vger.kernel.org'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 10 17:42:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR63Z-0007cX-4c
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 17:42:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756621Ab0LJQmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 11:42:47 -0500
Received: from master.dr.deshaw.com ([149.77.227.1]:48427 "EHLO
	master.dr.deshaw.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573Ab0LJQmq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Dec 2010 11:42:46 -0500
X-Greylist: delayed 931 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Dec 2010 11:42:46 EST
Received: from winmail.deshaw.com ([149.77.72.51])
 by master.dr.deshaw.com (8.13.8+Sun/8.13.7/2.0.kim.desco.357) with ESMTP id oBAGRD9S024145
 for <git@vger.kernel.org>; Fri, 10 Dec 2010 11:27:13 -0500 (EST)
Received: from NYCMBX3.winmail.deshaw.com ([149.77.72.43]) by
 mailnychts1.winmail.deshaw.com ([149.77.72.51]) with mapi; Fri, 10 Dec 2010
 11:27:12 -0500
Thread-Topic: git svn dcommit fails with empty commits
Thread-Index: AcuYhtBVsFBxpW4ORyeuCNYoZvrGqw==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163421>

I am trying to get git-svn to cooperate with the master branch by doing some merges after the rebase in dcommit.  This ends up creating an empty merge commit (since the trees are identical).  Then, later git commits appear on top of that merge.

However dcommit has a problem with the empty merge (or an empty commit, to be more accurate).  The problem seems to be around the "No changes" case in git-svn.perl/cmd_dcommit.  If there were no changes (apply_diff returns false), then the editor_cb is not called, and $cmt_rev is not updated.  Then $last_rev is set to $cmt_rev, which is now empty.

It seems either:

1) In editor_cb, just assign to $last_rev directly, and remove the $last_rev setting.
2) Use: $last_rev = $cmt_rev if defined $cmt_rev

-- 
-Justin
