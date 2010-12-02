From: David Barr <david.barr@cordelta.com>
Subject: [PATCH/RFC] fast-import: add 'ls' command
Date: Thu,  2 Dec 2010 21:40:19 +1100
Message-ID: <1291286420-13591-1-git-send-email-david.barr@cordelta.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 02 13:41:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO8T7-0001BH-86
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 13:41:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757531Ab0LBMk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 07:40:56 -0500
Received: from fallbackmx08.syd.optusnet.com.au ([211.29.132.10]:34008 "EHLO
	fallbackmx08.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757521Ab0LBMkz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Dec 2010 07:40:55 -0500
X-Greylist: delayed 6635 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Dec 2010 07:40:54 EST
Received: from mail09.syd.optusnet.com.au (mail09.syd.optusnet.com.au [211.29.132.190])
	by fallbackmx08.syd.optusnet.com.au (8.13.1/8.13.1) with ESMTP id oB2AgaHM029728
	for <git@vger.kernel.org>; Thu, 2 Dec 2010 21:42:36 +1100
Received: from localhost.localdomain (d110-33-95-167.mit3.act.optusnet.com.au [110.33.95.167])
	by mail09.syd.optusnet.com.au (8.13.1/8.13.1) with ESMTP id oB2Af6XG018562;
	Thu, 2 Dec 2010 21:41:07 +1100
X-Mailer: git-send-email 1.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162698>

This patch is by no means complete - I still need to consider the edge cases.
It does achieve the basic requirements for simplifying svn-fe.
The vcs-svn library currently maintains an in-memory index of all paths
in all revisions. Introducing an `ls` command to fast-import allows this
responsibility to be delegated.
Most importantly, it will allow access to the tree data on demand which
is needed for incremental imports.

The two features that svn-fe will need are access the the current in-flight
commit and to previous commits by mark.

 fast-import.c |  127 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 125 insertions(+), 2 deletions(-)
