From: Andrew Pimlott <andrew@pimlott.net>
Subject: git patch-id fails on long lines
Date: Tue, 20 Sep 2011 11:07:42 -0700
Message-ID: <1316541771-sup-9996@pimlott.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 20 20:48:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R65N1-0007Lb-8i
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 20:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844Ab1ITSsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 14:48:36 -0400
Received: from pimlott.net ([72.249.23.100]:47654 "EHLO fugue.pimlott.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295Ab1ITSse (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 14:48:34 -0400
X-Greylist: delayed 2450 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Sep 2011 14:48:34 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pimlott.net; s=default;
	h=Content-Transfer-Encoding:Message-Id:Date:To:From:Subject:Content-Type; bh=IXltuSPfynfEwqsgevgOiFntzTQutM4WEae7frEZqaE=;
	b=Es9xdG4HTTwBjumhKPBO8a4M7FIpn4qouLGM9oFC3UKeSdCoYvbuFnvrFHTCKi3hj2AAgr1GLN1n+KkcALs3i2hy0yQ618XX0dRUhfTVI07xaEjBj6jJof37Mlp1nteWXcH0FOgrLBU5ZTexTEbgkc1ZKJwXD2dfg7XcKBskeYc=;
Received: from andrew by fugue.pimlott.net with local (Exim 4.72)
	(envelope-from <andrew@pimlott.net>)
	id 1R64jO-0005jp-Hd
	for git@vger.kernel.org; Tue, 20 Sep 2011 11:07:42 -0700
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181776>

In patch-id.c, get_one_patchid uses a fixed 1000-char buffer to read a line.[1]
This causes incorrect results on longer lines.  Pasted below is a git commit
(from git show) that demonstrates the problem.  The result of running git
patch-id on this commit is:

9220f380851be9cab1a760430e3be096dcbee8c6 9b96b6fde8f7df791a1490ae18e1fa75fbab3262
74b8ede07628a574fd586624e0c77a4b6c9967e0 aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa

The commit:

commit 9b96b6fde8f7df791a1490ae18e1fa75fbab3262
Author: Andrew Pimlott <andrew@pimlott.net>
Date:   Tue Sep 20 10:53:25 2011 -0700

    2

diff --git a/a b/a
index e69de29..2e6adac 100644
--- a/a
+++ b/a
@@ -0,0 +1 @@
+aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
 aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
diff --git a/b b/b
index e69de29..1425fcc 100644
--- a/b
+++ b/b
@@ -0,0 +1 @@
+b

Andrew

[1] https://github.com/git/git/blob/master/builtin/patch-id.c
