From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-submodule.sh - Remove trailing / from URL if found
Date: Tue, 19 Aug 2008 22:18:23 -0400
Message-ID: <1219198703-2388-1-git-send-email-mlevedahl@gmail.com>
Cc: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 04:19:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVdIU-0001rT-Gl
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 04:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbYHTCSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 22:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbYHTCSf
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 22:18:35 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:58556 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594AbYHTCSf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 22:18:35 -0400
Received: by wr-out-0506.google.com with SMTP id 69so231715wri.5
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 19:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Gcg92fHaOuIv/QHZfPfv/5xYKP8df14mu8bu76fHMxw=;
        b=sL2VCQheIHz2QuskfG1nS4k1rOSRJAG3howDqlmXTO7F6LcwBBPMElEJSca1BsmHhj
         Ah/QAwBel8ESaro3e9CHZX7/y9iJHqGlPHQTQl6iQ04v1E7J/fYOZbXx8cuuWWKUAfA7
         XdFUpoplXkH6DeWJvcU4Hph1OIauaLlSifhvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=TxchVBrjU6hbggavOlapFioQ5djfoWvxClXmbu0nftTF3hIVmNCt8Ab20sr8kZUkAI
         Id/xPZqYiS5Ofl4cw/6aisBRtuXTTLHAzW22Y2ycgWTWsidxl+H6BHbxzLmLvbwhYW63
         sIpuu1GJgVGTN7RXXnQnn390X7EsXjQHly1NA=
Received: by 10.90.106.1 with SMTP id e1mr7182203agc.78.1219198714230;
        Tue, 19 Aug 2008 19:18:34 -0700 (PDT)
Received: from localhost.localdomain ( [71.163.41.46])
        by mx.google.com with ESMTPS id l31sm88059hsa.6.2008.08.19.19.18.26
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 19 Aug 2008 19:18:33 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.22.g2957
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92949>

git clone does not complain if a trailing '/' is included in the origin
URL, but doing so causes resolution of a submodule's URL relative to the
superproject to fail. Regardless of whether git is changed to remove the
trailing / before recording the URL, we should avoid this issue in
submodule as existing repositories can have this problem.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index ea6357b..fa9dd3a 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -34,7 +34,7 @@ resolve_relative_url ()
 	remote=$(get_default_remote)
 	remoteurl=$(git config "remote.$remote.url") ||
 		die "remote ($remote) does not have a url in .git/config"
-	url="$1"
+	url="${1%/}"
 	while test -n "$url"
 	do
 		case "$url" in
-- 
1.6.0.22.g2957
