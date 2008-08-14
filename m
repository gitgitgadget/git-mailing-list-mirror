From: Charles O'Farrell <charleso@charleso.org>
Subject: [PATCH 0/7] jgit: Branch command now supports deletion
Date: Thu, 14 Aug 2008 20:13:42 +1000
Message-ID: <1218708829-8175-1-git-send-email-charleso@charleso.org>
Cc: Charles O'Farrell <charleso@charleso.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 14 12:15:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTZrM-000331-M2
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 12:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306AbYHNKOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 06:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753235AbYHNKOJ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 06:14:09 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:50988 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749AbYHNKOH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 06:14:07 -0400
Received: by wa-out-1112.google.com with SMTP id j37so199004waf.23
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 03:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:sender;
        bh=BAYUXAVXOjg6KGH0GfTYc+Rtp6R39FVjaO6KkNmH978=;
        b=luNWLiU98Rbp6gCXsbfGSZP+SpgQAIQUF+6xuSvcpXfT4pPp79KBgoMSA8+1peXndq
         6dkxVmUp/4EmXxvocYfczpM36vaDWJQ9k7337yjneGEQUlvjHKR7ifVt1uuC7ojTYmro
         0npjCpb+zjgjn2NLnr8EpsXZY6fskVur9oMF8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:sender;
        b=F91Jht39WcESebhrjikrYpqAOiJr+R4nlmp0euAxxzfS7nMQlnRFTnEpEkEvKQTOL8
         yKQW/P9torISKIGALIhvwz8jyx6AbKnN83nvGIvM5iyvdg3ycxhj1uZ9DCu3kBlj7rwB
         qeG9zo7+fvf6b4+ZFMKb8dreNq5vKNsi8QYos=
Received: by 10.114.158.1 with SMTP id g1mr939840wae.203.1218708847246;
        Thu, 14 Aug 2008 03:14:07 -0700 (PDT)
Received: from localhost.localdomain ( [123.200.240.102])
        by mx.google.com with ESMTPS id a8sm2909044poa.12.2008.08.14.03.14.03
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Aug 2008 03:14:06 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc2.35.g04c6e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92343>

Implement branch deletion for jgit, reusing previous packed-refs writing

Charles O'Farrell (7):
  Refactor of WalkRemoteObjectDatabase ref writing into common class
  Refactor of RefUpdate force to call common updateImpl instead of
    duplication
  Minor refactor of constants, including log and ROOT_DIR
  Extract lockAndWriteFile method in RefDatabase for reuse
  Added removePackedRef method to RefDatabase for packed branch
    deletion
  Added ref deletion to RefUpdate
  jgit: Added branch deletion to jgit command

 .../src/org/spearce/jgit/pgm/Branch.java           |   57 ++++++-
 .../src/org/spearce/jgit/lib/Constants.java        |    9 +
 .../src/org/spearce/jgit/lib/RefDatabase.java      |   41 ++++--
 .../src/org/spearce/jgit/lib/RefLogWriter.java     |    2 +-
 .../src/org/spearce/jgit/lib/RefUpdate.java        |  106 ++++++++----
 .../src/org/spearce/jgit/lib/RefWriter.java        |  175 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/Repository.java       |    2 +-
 .../spearce/jgit/transport/TransportAmazonS3.java  |   10 +-
 .../org/spearce/jgit/transport/TransportSftp.java  |    6 +-
 .../spearce/jgit/transport/WalkPushConnection.java |   18 ++-
 .../jgit/transport/WalkRemoteObjectDatabase.java   |  110 +-----------
 11 files changed, 374 insertions(+), 162 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/RefWriter.java
