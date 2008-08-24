From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 2/3] git-submodule: use get_remote in resolve_relative_url
Date: Sun, 24 Aug 2008 10:21:39 -0700
Message-ID: <341166c1e31ba26c4e8e48cd7cf9ce12a9f745b9.1219598198.git.davvid@gmail.com>
References: <1219598500-8334-1-git-send-email-davvid@gmail.com>
 <e21617f50ffaae98ab73fa364e40440397bcbe33.1219598198.git.davvid@gmail.com>
Cc: mlevedahl@gmail.com, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Aug 24 19:31:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXJQe-0002mk-FZ
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 19:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307AbYHXR3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 13:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752591AbYHXR3n
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 13:29:43 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:26592 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752307AbYHXR3l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 13:29:41 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1296212rvb.1
        for <git@vger.kernel.org>; Sun, 24 Aug 2008 10:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=31k8Fl6HTbMph4GtP98xNl7mel+a4X1zUxj/QkhC7cw=;
        b=UK81kyWOA+vTQrCwpGcy062Axh+fwS89DbpPjDWUSsYlu00WZasY1jV94edQSzavdg
         Hd8CitFxvMDwfjJh9k1zEVI7SbKDN9IePQSC2nLUOMLENKwz8p7HGufNkRdUmi/u3JbA
         oAkTU81UmXl/1WLkqpPepIPRvaxrqKIeElUCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=armV5VgFbz8w4eS16l2UIek10gz92W7sQIFhjF9BqlWa8kkrFue1Lva/8UGwhp2nLC
         GXPr/3CKNrX+D9wmV3AkJuhaqEBZc/qyWUV6iOVnRaqKS0i+Wsub6xEbmqUyRsUDV2wT
         EgHmynp0oxjd05vWhSV2U0dj+HHryv9PS0qNw=
Received: by 10.140.132.8 with SMTP id f8mr1678876rvd.122.1219598981271;
        Sun, 24 Aug 2008 10:29:41 -0700 (PDT)
Received: from localhost ( [208.106.56.2])
        by mx.google.com with ESMTPS id k2sm5859974rvb.1.2008.08.24.10.29.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Aug 2008 10:29:40 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.90.g436ed
In-Reply-To: <e21617f50ffaae98ab73fa364e40440397bcbe33.1219598198.git.davvid@gmail.com>
In-Reply-To: <e21617f50ffaae98ab73fa364e40440397bcbe33.1219598198.git.davvid@gmail.com>
References: <e21617f50ffaae98ab73fa364e40440397bcbe33.1219598198.git.davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93536>

This change removes replaces the remote finding logic in
resolve_relative_url with the new get_remote function.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-submodule.sh |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 9d2bddb..d2ae835 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -39,9 +39,7 @@ get_remote()
 # Resolve relative url by appending to parent's url
 resolve_relative_url ()
 {
-	branch="$(git symbolic-ref HEAD 2>/dev/null)"
-	remote="$(git config branch.${branch#refs/heads/}.remote)"
-	remote="${remote:-origin}"
+	remote=$(get_remote)
 	remoteurl=$(git config "remote.$remote.url") ||
 		die "remote ($remote) does not have a url defined in .git/config"
 	url="$1"
-- 
1.6.0.90.g436ed
