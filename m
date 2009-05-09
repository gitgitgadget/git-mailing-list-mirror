From: Mark Struberg <struberg@yahoo.de>
Subject: [JGIT] exception while pushing if no objects/pack directory exists in origin repo
Date: Sat, 9 May 2009 22:40:50 +0200 (CEST)
Message-ID: <693615.98383.qm@web27802.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 09 22:41:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2tLv-00077S-KC
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 22:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754615AbZEIUkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 16:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754550AbZEIUkv
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 16:40:51 -0400
Received: from web27802.mail.ukl.yahoo.com ([217.146.182.7]:45228 "HELO
	web27802.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754462AbZEIUkv (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 May 2009 16:40:51 -0400
Received: (qmail 98559 invoked by uid 60001); 9 May 2009 20:40:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1241901650; bh=lH0TJ4svKoPOMqPZhlwZUOeeteRhZzvuAKoraR8uEm4=; h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=E5W0HhWmH0JVjkrrLUnaICMI+Ukd4Z6/qnrq18INLR4xYLzahoyac7o97HQyjhpBVzevqVyCcv3xtorRZrZLKPox4eyKsdwY2sNbVln1uPhsWnx75ZggkMGyOEaqspcoRKBXVfzfe/Lla3G5tB/pLm+SvUgxItb0IMSYFfnhzrI=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=jMOF1A2HHkSCjru1mCOK0iFws9td991s4qrJ6YNbTf24PbCtZjMMXldwtHUQW6pljmtT2Wu65lXqq+gs6DXe8DP/JzAx5zKd1v56Dtsif/sJAkHjpblh/jWy7uL1wPI0/mRf9d+yQC5FMQoKrglt4iQs/0Af4fdsRSGZ+osTBXE=;
Received: from [62.47.151.130] by web27802.mail.ukl.yahoo.com via HTTP; Sat, 09 May 2009 22:40:50 CEST
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118682>


Hi!

I have problems with JGit pushing to an old origin repo in my TCK tests of
maven-scm-providers-git.

This 'old' bare repository does not have an object/pack folder, it only has unpacked objects lying
around. I created it in 2007-11 with git-1.5.3 so this is actually not so old, so I'm not sure why
there is no pack folder. Maybe that's caused by some 'prune empty directories' and stuff, I really
don't know.

If I use jgit to push to this repo it crashes because it cannot write to the pack folder. If I
mkdir the object/pack folder in my origin repo, everything runs smooth.

The test git repo checked-in in my git repo ;)

http://github.com/struberg/maven-scm-providers-git/tree/82e3021576e18a09fc04e1a5ac58368f598167b2/maven-scm-provider-jgit/src/test/resources/repository


The Exception I get when running my TCK test:

org.apache.maven.scm.ScmException: JGit checkin failure!
	at
org.apache.maven.scm.provider.git.jgit.command.checkin.JGitCheckInCommand.executeCheckInCommand(JGitCheckInCommand.java:98)
	at
org.apache.maven.scm.command.checkin.AbstractCheckInCommand.executeCommand(AbstractCheckInCommand.java:53)
	at org.apache.maven.scm.command.AbstractCommand.execute(AbstractCommand.java:59)
	at
org.apache.maven.scm.provider.git.AbstractGitScmProvider.executeCommand(AbstractGitScmProvider.java:339)
	at
org.apache.maven.scm.provider.git.AbstractGitScmProvider.checkin(AbstractGitScmProvider.java:265)
	at org.apache.maven.scm.provider.AbstractScmProvider.checkIn(AbstractScmProvider.java:342)
	at org.apache.maven.scm.provider.AbstractScmProvider.checkIn(AbstractScmProvider.java:326)
	at org.apache.maven.scm.manager.AbstractScmManager.checkIn(AbstractScmManager.java:374)
	at
org.apache.maven.scm.tck.command.checkin.CheckInCommandTckTest.testCheckInCommandTest(CheckInCommandTckTest.java:74)
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
	at junit.framework.TestSuite.runTest(TestSuite.java:230)
	at junit.framework.TestSuite.run(TestSuite.java:225)
	at
org.eclipse.jdt.internal.junit.runner.junit3.JUnit3TestReference.run(JUnit3TestReference.java:130)
	at org.eclipse.jdt.internal.junit.runner.TestExecution.run(TestExecution.java:38)
	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.runTests(RemoteTestRunner.java:460)
	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.runTests(RemoteTestRunner.java:673)
	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.run(RemoteTestRunner.java:386)
	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.main(RemoteTestRunner.java:196)
Caused by: org.spearce.jgit.errors.TransportException:
file:///home/msx/develop/java/maven2/maven-scm/maven-scm-providers/maven-scm-providers-git/maven-scm-provider-jgit/target/scm-test/repository:
error occurred during unpacking on the remote end: error Cannot move pack to
/home/msx/develop/java/maven2/maven-scm/maven-scm-providers/maven-scm-providers-git/maven-scm-provider-jgit/target/scm-test/repository/objects/pack/pack-737c284d140709e1182fa00fa1a20d4e370cf2d5.pack
	at
org.spearce.jgit.transport.BasePackPushConnection.readStatusReport(BasePackPushConnection.java:217)
	at org.spearce.jgit.transport.BasePackPushConnection.doPush(BasePackPushConnection.java:134)
	at org.spearce.jgit.transport.BasePackPushConnection.push(BasePackPushConnection.java:100)
	at org.spearce.jgit.transport.PushProcess.execute(PushProcess.java:127)
	at org.spearce.jgit.transport.Transport.push(Transport.java:713)
	at org.spearce.jgit.simple.SimpleRepository.push(SimpleRepository.java:504)
	at org.spearce.jgit.simple.SimpleRepository.push(SimpleRepository.java:436)
	at
org.apache.maven.scm.provider.git.jgit.command.checkin.JGitCheckInCommand.executeCheckInCommand(JGitCheckInCommand.java:66)
	... 26 more


Not sure if I only have a 'broken' repo (everything runs smooth on the shell) or if this is a
thing which should get fixed in JGit... 


txs and LieGrue,
strub


      
