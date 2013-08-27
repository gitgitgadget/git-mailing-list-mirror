From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 11/11] "git prune" is safe
Date: Tue, 27 Aug 2013 20:05:50 +0200 (CEST)
Message-ID: <860155028.34610.1377626750550.JavaMail.ngmail@webmail19.arcor-online.net>
References: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: martinvonz@gmail.com, jrnieder@gmail.com, th.acker@arcor.de,
	gitster@pobox.com, wking@tremily.us, philipoakley@iee.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 20:05:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VENeN-0002Ts-TE
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 20:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446Ab3H0SFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 14:05:52 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:58523 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752919Ab3H0SFv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Aug 2013 14:05:51 -0400
Received: from mail-in-18-z2.arcor-online.net (mail-in-18-z2.arcor-online.net [151.189.8.35])
	by mx.arcor.de (Postfix) with ESMTP id 96A74E3C0E;
	Tue, 27 Aug 2013 20:05:50 +0200 (CEST)
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net [151.189.21.48])
	by mail-in-18-z2.arcor-online.net (Postfix) with ESMTP id 9590B3481BC;
	Tue, 27 Aug 2013 20:05:50 +0200 (CEST)
Received: from webmail19.arcor-online.net (webmail19.arcor-online.net [151.189.8.77])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id 8ABC03AE43B;
	Tue, 27 Aug 2013 20:05:50 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-08.arcor-online.net 8ABC03AE43B
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1377626750; bh=VEOXImU61e8oS8wE4c+BVfni/V1l4lBpLFQXGAUldbY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=nCWyIqVWYWS1gaTupH+A0gI5A6lWyJijrH/CRNHS5GJv4yUgl+xbsbavzejXSoEeP
	 JuWeBvGHl/lghrsXHG1uDTc8bbKhYwkzPaHutwmbI+Z76TriLV2xX3iqGS9JfhJ3LA
	 W+0Y+U1AYdsYP9AST0FLVcO+eCoUgQDcY58jvbpI=
Received: from [178.7.16.225] by webmail19.arcor-online.net (151.189.8.77) with HTTP (Arcor Webmail); Tue, 27 Aug 2013 20:05:50 +0200 (CEST)
In-Reply-To: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.16.225
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233131>


"git prune" is safe in case of concurrent accesses to a repository
but using it in such a case is not recommended.

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/user-manual.txt | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 9149846..ea843e6 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3299,17 +3299,11 @@ state, you can just prune all unreachable objects:
 $ git prune
 ------------------------------------------------
 
-and they'll be gone. But you should only run `git prune` on a quiescent
+and they'll be gone. (You should only run `git prune` on a quiescent
 repository--it's kind of like doing a filesystem fsck recovery: you
 don't want to do that while the filesystem is mounted.
-
-(The same is true of `git fsck` itself, btw, but since
-`git fsck` never actually *changes* the repository, it just reports
-on what it found, `git fsck` itself is never 'dangerous' to run.
-Running it while somebody is actually changing the repository can cause
-confusing and scary messages, but it won't actually do anything bad. In
-contrast, running `git prune` while somebody is actively changing the
-repository is a *BAD* idea).
+`git prune` is designed not to cause any harm in such cases of concurrent
+accesses to a repository but you might receive confusing or scary messages.)
 
 [[recovering-from-repository-corruption]]
 Recovering from repository corruption
-- 
1.8.3.msysgit.0


---
Thomas
