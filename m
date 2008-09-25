From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] git-submodule: remove unnecessary exits when calling resolve_relative_url
Date: Thu, 25 Sep 2008 04:21:49 -0700
Message-ID: <17c3c33dd7aa6803d7ac046f3e4dc0d5bb4c7234.1222341013.git.davvid@gmail.com>
References: <200809221808.31730.johan@herland.net>
Cc: git@vger.kernel.org, johan@herland.net, spearce@spearce.org,
	mlevedahl@gmail.com, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 25 13:29:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kip1u-0005jn-G8
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 13:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254AbYIYL16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 07:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753233AbYIYL15
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 07:27:57 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:52966 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223AbYIYL15 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 07:27:57 -0400
Received: by rv-out-0506.google.com with SMTP id k40so405566rvb.1
        for <git@vger.kernel.org>; Thu, 25 Sep 2008 04:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=aka9JvtbKuF5gY/fc8wa7BKGNMftWZAsdFnJbr4fbVQ=;
        b=RSo1in2+2mzWWYUaBHhGMx2rgaeXFSxXwybPaSywoSfM70FmOn8xYqej16hPblqAQk
         MdFyzZMG/NLMbOj84BI7naZLPwEWlu+9k0jzoB72PPWbjoECtJ0ewwrdWnYgevorZIig
         uWPV2z5Fe74n0nOywWwQISCMxDAK9Yj7OZybo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=btIiEEVSL/qgVAPFaRlPl5zYuvyLGqH+X2ZDqBvdJjqqxYxeIQLsiyrFfCFflSVR/E
         59XplV/QQqBh5SIdRLMtUS6lwWQh4T3fIl0iMeyFx54eBxpB8va/gQbk7KJ6ApO22BQR
         EeXesP3MDs3DKxou9pnKMU3igVgt7/w5dr+oE=
Received: by 10.140.178.17 with SMTP id a17mr4047651rvf.156.1222342076107;
        Thu, 25 Sep 2008 04:27:56 -0700 (PDT)
Received: from localhost ( [208.106.56.2])
        by mx.google.com with ESMTPS id k2sm578176rvb.1.2008.09.25.04.27.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Sep 2008 04:27:55 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.2.307.gc4275
In-Reply-To: <200809221808.31730.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96748>

resolve_relative_url calls die() when no remote url exists so these calls to
exit can be removed.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

This applies on top of the first
"Fix submodule sync with relative submodule URLs" patch by Johan Herland.
Shawn's comments made me realize that the resolve_relative_url callers
could be cleaned up.

 git-submodule.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 92be0fe..533d1cc 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -155,7 +155,7 @@ cmd_add()
 	case "$repo" in
 	./*|../*)
 		# dereference source url relative to parent's url
-		realrepo=$(resolve_relative_url "$repo") || exit
+		realrepo=$(resolve_relative_url "$repo")
 		;;
 	*:*|/*)
 		# absolute url
@@ -184,7 +184,7 @@ cmd_add()
 
 		case "$repo" in
 		./*|../*)
-			url=$(resolve_relative_url "$repo") || exit
+			url=$(resolve_relative_url "$repo")
 		    ;;
 		*)
 			url="$repo"
@@ -270,7 +270,7 @@ cmd_init()
 		# Possibly a url relative to parent
 		case "$url" in
 		./*|../*)
-			url=$(resolve_relative_url "$url") || exit
+			url=$(resolve_relative_url "$url")
 			;;
 		esac
 
@@ -638,7 +638,7 @@ cmd_sync()
 		# Possibly a url relative to parent
 		case "$url" in
 		./*|../*)
-			url=$(resolve_relative_url "$url") || exit
+			url=$(resolve_relative_url "$url")
 			;;
 		esac
 
-- 
1.6.0.2.307.gc4275
