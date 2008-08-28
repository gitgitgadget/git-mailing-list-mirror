From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 2/3] Handle NoRemoteRepositoryException in PushOperation especially
Date: Thu, 28 Aug 2008 03:36:09 +0200
Message-ID: <1219887370-17265-2-git-send-email-marek.zawirski@gmail.com>
References: <1219887370-17265-1-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Aug 28 03:37:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYWS3-0003SQ-KI
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 03:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186AbYH1BgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 21:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753278AbYH1BgW
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 21:36:22 -0400
Received: from mu-out-0910.google.com ([209.85.134.189]:61921 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042AbYH1BgV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 21:36:21 -0400
Received: by mu-out-0910.google.com with SMTP id g7so110025muf.1
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 18:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Er2krxeKna1F3/YmOVgxfVaRUIJmafvcYIpZ1Alh4MI=;
        b=hl6YDtglBOykKenFmvmUC2Bv5Pa05YJjJO+p09ccdG/HgRTTR5Qfi88P4q5m/RL0MS
         NZ4drR6aSvvCpx5nP7vlc666SihxSNOPSBnY9hluCR7QEM05B75txzm4G78joxSeVwEI
         HVSFatqniQ3AC9KHzq6ZALIjLYHNl8nqsI62A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LVH4yswLSRpjT/kHA5iBIsVYsr1AVK0rLft3EL5IuxbxH3iT8QUA6owHypJ+HjwLz5
         wd99g4mfrC7J66zWzBsPAAetSQrz1EIWm8d1nSgLQ70aT6DbOV++HANZNMj1ZYSjiKSM
         bFu01oTcE74PbVCLlDAbcZPO9O98IcN1g4UwA=
Received: by 10.103.170.6 with SMTP id x6mr446073muo.42.1219887378929;
        Wed, 27 Aug 2008 18:36:18 -0700 (PDT)
Received: from localhost ( [62.21.4.140])
        by mx.google.com with ESMTPS id i5sm1578616mue.11.2008.08.27.18.36.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Aug 2008 18:36:18 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219887370-17265-1-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94012>

We can give user better feedback for this special case, as it
is common and not directly related to protocol error.

Reported-by: Robert <robert_no.spam_m@yahoo.fr>
Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---

Beside of this change, we may consider removing URI part of
TransportException from message, moving it to the field and providing
API for getting this URI. That may allow us showing user cleaner
messages.

 .../src/org/spearce/egit/core/CoreText.java        |    3 +++
 .../src/org/spearce/egit/core/coretext.properties  |    1 +
 .../org/spearce/egit/core/op/PushOperation.java    |    5 +++++
 3 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/CoreText.java b/org.spearce.egit.core/src/org/spearce/egit/core/CoreText.java
index 35e17b9..a750117 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/CoreText.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/CoreText.java
@@ -108,6 +108,9 @@
 	public static String PushOperation_resultTransportError;
 
 	/** */
+	public static String PushOperation_resultNoServiceError;
+
+	/** */
 	public static String PushOperation_taskNameDryRun;
 
 	/** */
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/coretext.properties b/org.spearce.egit.core/src/org/spearce/egit/core/coretext.properties
index 94cf4aa..04ca28f 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/coretext.properties
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/coretext.properties
@@ -61,5 +61,6 @@ ListRemoteOperation_title=Getting remote branches information
 PushOperation_resultCancelled=Operation was cancelled.
 PushOperation_resultNotSupported=Can't push to {0}
 PushOperation_resultTransportError=Transport error occured during push operation: {0}
+PushOperation_resultNoServiceError=Push service is not available: {0}
 PushOperation_taskNameDryRun=Trying pushing to remote repositories
 PushOperation_taskNameNormalRun=Pushing to remote repositories
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperation.java
index 8811800..a0f2e5c 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperation.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperation.java
@@ -16,6 +16,7 @@
 import org.eclipse.osgi.util.NLS;
 import org.spearce.egit.core.CoreText;
 import org.spearce.egit.core.EclipseGitProgressTransformer;
+import org.spearce.jgit.errors.NoRemoteRepositoryException;
 import org.spearce.jgit.errors.NotSupportedException;
 import org.spearce.jgit.errors.TransportException;
 import org.spearce.jgit.lib.Repository;
@@ -125,6 +126,10 @@ public void run(IProgressMonitor monitor) throws InvocationTargetException {
 				final PushResult pr = transport.push(gitSubMonitor,
 						specification.getRefUpdates(uri));
 				operationResult.addOperationResult(uri, pr);
+			} catch (final NoRemoteRepositoryException e) {
+				operationResult.addOperationResult(uri, NLS.bind(
+						CoreText.PushOperation_resultNoServiceError, e
+								.getMessage()));
 			} catch (final TransportException e) {
 				operationResult.addOperationResult(uri, NLS.bind(
 						CoreText.PushOperation_resultTransportError, e
-- 
1.5.6.3
