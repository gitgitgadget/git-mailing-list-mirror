From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 10/10] BROKEN TEST: ObjectLoader stays valid across repacks
Date: Wed, 22 Apr 2009 01:16:50 +0200
Message-ID: <200904220116.51076.robin.rosenberg.lists@dewire.com>
References: <1240276872-17893-1-git-send-email-spearce@spearce.org> <1240276872-17893-10-git-send-email-spearce@spearce.org> <1240276872-17893-11-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Apr 22 01:19:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwPF1-0003PN-Bc
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 01:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517AbZDUXRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 19:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbZDUXRC
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 19:17:02 -0400
Received: from mail.dewire.com ([83.140.172.130]:17235 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644AbZDUXRA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 19:17:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E2A13149165C;
	Wed, 22 Apr 2009 01:16:53 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vL6fiH24fKWH; Wed, 22 Apr 2009 01:16:52 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 756CE14915D9;
	Wed, 22 Apr 2009 01:16:52 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.27-14-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1240276872-17893-11-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117162>

tisdag 21 april 2009 03:21:12 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> This doesn't doesn't work.
> 
> What we are trying to verify is that an ObjectLoader remains valid
> if the underlying storage for the object has moved, such as when a
> repository is repacked, the old pack was deleted, and the object is
> now in the new pack.

So, I had an idea and started hacking and suddenly the supposedly ok cases
started crashing like this.

org.spearce.jgit.errors.MissingObjectException: Missing unknown 4a75554761c96be80602c05145d1ef41c77e1b72
	at org.spearce.jgit.revwalk.RevWalk.parseAny(RevWalk.java:704)
	at org.spearce.jgit.lib.ConcurrentRepackTest.parse(ConcurrentRepackTest.java:189)
	at org.spearce.jgit.lib.ConcurrentRepackTest.testObjectMovedWithinPack(ConcurrentRepackTest.java:129)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:39)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:25)
	at java.lang.reflect.Method.invoke(Method.java:597)
	at junit.framework.TestCase.runTest(TestCase.java:164)
	at junit.framework.TestCase.runBare(TestCase.java:130)
	at junit.framework.TestResult$1.protect(TestResult.java:106)
	at junit.framework.TestResult.runProtected(TestResult.java:124)
	at junit.framework.TestResult.run(TestResult.java:109)
	at junit.framework.TestCase.run(TestCase.java:120)
	at org.eclipse.jdt.internal.junit.runner.junit3.JUnit3TestReference.run(JUnit3TestReference.java:130)
	at org.eclipse.jdt.internal.junit.runner.TestExecution.run(TestExecution.java:38)
	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.runTests(RemoteTestRunner.java:460)
	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.runTests(RemoteTestRunner.java:673)
	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.run(RemoteTestRunner.java:386)
	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.main(RemoteTestRunner.java:196)

After pruning the other changes, it still crashes , even with mvn clean test

HashCode /home/me/SW/EGIT.contrib/org.spearce.jgit.test/trash/trash1240354367548.0/.git/objects/pack/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.pack = 327983069
HashCode /home/me/SW/EGIT.contrib/org.spearce.jgit.test/trash/trash1240354367548.0/.git/objects/pack/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.pack = 458811222
HashCode /home/me/SW/EGIT.contrib/org.spearce.jgit.test/trash/trash1240354367548.0/.git/objects/pack/pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.pack = 331392325
HashCode /home/me/SW/EGIT.contrib/org.spearce.jgit.test/trash/trash1240354367548.0/.git/objects/pack/pack-546ff360fe3488adb20860ce3436a2d6373d2796.pack = 547821429
HashCode /home/me/SW/EGIT.contrib/org.spearce.jgit.test/trash/trash1240354367548.0/.git/objects/pack/pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.pack = 536578194
HashCode /home/me/SW/EGIT.contrib/org.spearce.jgit.test/trash/trash1240354367548.0/.git/objects/pack/pack-3280af9c07ee18a87705ef50b0cc4cd20266cf12.pack = 885722359
HashCode /home/me/SW/EGIT.contrib/org.spearce.jgit.test/trash/trash1240354367548.0/.git/objects/pack/pack-146aac1f6a11aed8e06af7d9f5cc1b4b8beedb36.pack = 830203467

The hash codes printed are the same everytime it crashes, removing the invalid flags will create these codes and the test succeeds.

HashCode /home/me/SW/EGIT.contrib/org.spearce.jgit.test/trash/trash1240354568171.0/.git/objects/pack/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.pack = 327983069
HashCode /home/me/SW/EGIT.contrib/org.spearce.jgit.test/trash/trash1240354568171.0/.git/objects/pack/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.pack = 458811222
HashCode /home/me/SW/EGIT.contrib/org.spearce.jgit.test/trash/trash1240354568171.0/.git/objects/pack/pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.pack = 331392325
HashCode /home/me/SW/EGIT.contrib/org.spearce.jgit.test/trash/trash1240354568171.0/.git/objects/pack/pack-546ff360fe3488adb20860ce3436a2d6373d2796.pack = 547821429
HashCode /home/me/SW/EGIT.contrib/org.spearce.jgit.test/trash/trash1240354568171.0/.git/objects/pack/pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.pack = 536578194
HashCode /home/me/SW/EGIT.contrib/org.spearce.jgit.test/trash/trash1240354568171.0/.git/objects/pack/pack-3280af9c07ee18a87705ef50b0cc4cd20266cf12.pack = 885722359
HashCode /home/me/SW/EGIT.contrib/org.spearce.jgit.test/trash/trash1240354568171.0/.git/objects/pack/pack-146aac1f6a11aed8e06af7d9f5cc1b4b8beedb36.pack = 830203467

One cannot obviously assume they are the same, but the numbers might be a lead to why it crashes here. Looks
like as hash collision and a failure of the "equals" part to distinguish different WindowedFile's.

-- robin

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
index 9293eb9..f9e1991 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
@@ -80,6 +80,8 @@
 	/** Total number of windows actively in the associated cache. */
 	int openCount;
 
+	boolean invalid;
+
 	/**
 	 * Open a file for reading through window caching.
 	 * 
@@ -93,6 +95,10 @@ public WindowedFile(final File file) {
 		// value in WindowCache.hash(), without doing the multiply there.
 		//
 		hash = System.identityHashCode(this) * 31;
+		System.out.print("HashCode ");
+		System.out.print(file.getPath());
+		System.out.print(" = ");
+		System.out.println(hash);
 		length = Long.MAX_VALUE;
 	}
 
