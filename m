From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH 0/4] RepositoryTestCase cleanups
Date: Thu, 27 Nov 2008 22:13:26 +0100
Message-ID: <1227820410-9621-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, fonseca@diku.dk,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Nov 27 22:14:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5oCH-0005Vz-Ro
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 22:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbYK0VNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 16:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752777AbYK0VNe
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 16:13:34 -0500
Received: from mail.dewire.com ([83.140.172.130]:6535 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752723AbYK0VNd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 16:13:33 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 49101147D538;
	Thu, 27 Nov 2008 22:13:31 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cZyBPBAkF23t; Thu, 27 Nov 2008 22:13:30 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id B8DF5147D535;
	Thu, 27 Nov 2008 22:13:30 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.640.g6331a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101830>

Ok, so here is an attempt to improve the ability of the JGit's unit
tests to delete temporary repositories. This has probably been seen
by many, but Jonas Fonseca raised the issue.

The background is that on Windows you cannot delete files that are
open and mmapped files are open until they get unmapped, which in
Java is beyond explicit programmer control. You can only free the
resources and pray that the GC does the work. Fortunately it usually
does. It turned out our testcases weren't even trying to clean up
properly. 

-- robin

Robin Rosenberg (4):
  Make the cleanup less verbose when it fails to delete temporary
    stuff.
  Add shutdown hooks to try to clean up after unit tests anyway
  Cleanup malformed test cases
  Automatically clean up any repositories created by the test cases

 .../tst/org/spearce/jgit/lib/PackWriterTest.java   |    3 +
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |   82 +++++++++++++++++---
 2 files changed, 73 insertions(+), 12 deletions(-)
