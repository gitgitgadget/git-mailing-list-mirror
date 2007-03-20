From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH 1/4] update-hook: abort early if the project description is unset
Date: Tue, 20 Mar 2007 10:58:32 +0000
Message-ID: <200703201058.33046.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 11:58:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTc3A-0002Nc-F1
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 11:58:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753648AbXCTK6k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 06:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753653AbXCTK6j
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 06:58:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:59638 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753648AbXCTK6i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 06:58:38 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1597056uga
        for <git@vger.kernel.org>; Tue, 20 Mar 2007 03:58:37 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=Hck74UTpNBJ6xD0YYnkSVAGnY/Xabk/oSlyBb0nsluztDNBHMLTaw6DrIICNCH4tS5gxs77/vIU+8E5Gy6LJZmkDSMRiy4p6X8hNQwjHYOAXcQBCilPtQZDI1z3RsHaaL3RG9YmtwPKMwA6dxOz2InlaZstQTq6zHitDJEdfZms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=SQPDQ3rwgZmRokyh8eaBG8m27B48nUpCSEsW4mHDnbwidgLl35/e6DszXio7/qeUMwovGeaoRbIYUpdk/mnVh4CAq6VXs0I0EOLKF9Krp5ybthwlEn/YMhzyIE+Dwts+l6k3RJAKv3i7ZWszikFq9Mu7TvyEe1SGDYTemE37CD8=
Received: by 10.64.114.10 with SMTP id m10mr7561147qbc.1174388316857;
        Tue, 20 Mar 2007 03:58:36 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id p20sm1550828nfc.2007.03.20.03.58.35;
        Tue, 20 Mar 2007 03:58:36 -0700 (PDT)
X-TUID: 2f8600270cded8d8
X-UID: 292
X-Length: 1421
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42734>

It was annoying to always have the first email from a project be from
the "Unnamed repository; edit this file to name it for gitweb project";
just because it's so easy to forget to set it.

This patch checks to see if the description file is still default (or
empty) and aborts if so - allowing you to fix the problem before sending
out silly looking emails to every developer.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 templates/hooks--update |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/templates/hooks--update b/templates/hooks--update
index 8f6c4fe..1a60773 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -56,6 +56,12 @@ recipients=$(git-repo-config hooks.mailinglist)
 announcerecipients=$(git-repo-config hooks.announcelist)
 allowunannotated=$(git-repo-config --bool hooks.allowunannotated)
 
+# check for no description
+if [ -z "$projectdesc" -o "$projectdesc" = "Unnamed repository; edit this file to name it for gitweb" ]; then
+	echo "*** Project description file hasn't been set" >&2
+	exit 1
+fi
+
 # --- Check types
 newrev_type=$(git-cat-file -t $newrev)
 
-- 
1.5.0.3.402.g0c48
