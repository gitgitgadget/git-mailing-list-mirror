From: Alec Berryman <alec@thened.net>
Subject: [PATCH] git-svn: Always create a new RA when calling do_switch for svn://
Date: Sun, 14 Sep 2008 17:14:14 -0400
Message-ID: <1221426856-2652-1-git-send-email-alec@thened.net>
To: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Sep 14 23:26:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kez77-0008WG-8P
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 23:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754326AbYINVZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2008 17:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753705AbYINVZU
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 17:25:20 -0400
Received: from 129.210.68.208.dnsptr.net ([208.68.210.129]:59868 "EHLO
	ives.vdov.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753669AbYINVZS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 17:25:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by ives.vdov.net (Postfix) with ESMTP id BDA1F24EDE3;
	Sun, 14 Sep 2008 16:15:02 -0500 (CDT)
Received: from ives.vdov.net ([127.0.0.1])
	by localhost (ives.vdov.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ph1Fi7KRDx+R; Sun, 14 Sep 2008 16:15:01 -0500 (CDT)
Received: from localhost (pool-96-237-12-178.bstnma.east.verizon.net [96.237.12.178])
	by ives.vdov.net (Postfix) with ESMTPSA id EACFF24EDBD;
	Sun, 14 Sep 2008 16:15:00 -0500 (CDT)
X-Mailer: git-send-email 1.6.0.2.231.gfc858
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95868>


This was reported as Debian bug #464713.  An example repository can be
found at svn://svn.debian.org/chinese/packages/lunar-applet.  When I try
to clone it with 1.6.0.2.229.g1293c or 1.5.6.5, both using 1.5.1
libraries, I see the following:

r158 = 1107cff6309c979751e0841d40b9e2e471694b26 (git-svn@159)
    M   debian/changelog
    M   debian/rules
r159 = 010d0b481753bd32ce0255ce433d63e14114d3b6 (git-svn@159)
Found branch parent: (git-svn) 010d0b481753bd32ce0255ce433d63e14114d3b6
Following parent with do_switch
Malformed network data: Malformed network data at /home/alec/local/git/libexec/git-core//git-svn line 2360

It looks like the user made several commits and decided to undo them by
removing the directory and copying an older version in its place.

This appears to only affect access via svn:// and svn+ssh://; I tried
with file:// but not with http://.

The first patch is a minor refactoring of some test code, and the second
one actually fixes the issue for me.
