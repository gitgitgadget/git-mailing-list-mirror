From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH v3 1/2] Add new function die_with_status
Date: Thu,  9 Jun 2011 09:47:02 +0200
Message-ID: <1307605623-2831-2-git-send-email-iveqy@iveqy.com>
References: <1307605623-2831-1-git-send-email-iveqy@iveqy.com>
Cc: hvoigt@hvoigt.net, jens.lehmann@web.de, git@vger.kernel.org
To: iveqy@iveqy.com
X-From: git-owner@vger.kernel.org Thu Jun 09 09:47:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUZxY-0003Oi-Ur
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 09:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972Ab1FIHrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 03:47:08 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44826 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419Ab1FIHrG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 03:47:06 -0400
Received: by eyx24 with SMTP id 24so444485eyx.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 00:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:cc:subject:date:message-id
         :x-mailer:in-reply-to:references;
        bh=4Y9c5KJVzPO8GTcXJZI6mXuHXI7TU7GSZjKXXOpUEd4=;
        b=bMM3612kzo3cAGtCJyclYaRY25ftuRwsIUur7HCo5uKoMSmFhzCrcoCUXC/gKEq4Iq
         AIbLffsxGyB+ZHGHq5Z0FNPCH0yTOPaqyOY8pBICINwFd00p+RGpDB8Q1yQu2n/ZnEmC
         ZN3JgS09MTuLomcdom/38w/8dp0WKN5zERG6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=LEm/cw+cAnAVu08LtxI0ZuZufRtHyC305fWyzs2H6bfsbYKRCiWUu+ZSW2TXhcYShk
         siRRAvJPYJkWhSJ7pi/rtuHh1hi9ykLHWFRIGV4TiKxmAibpL7C0nAZj7p5vgscjYloB
         SQrg7xYXdNZGYHQxce7h3htuuZd42DJ0GWvGM=
Received: by 10.213.20.79 with SMTP id e15mr2580310ebb.1.1307605624711;
        Thu, 09 Jun 2011 00:47:04 -0700 (PDT)
Received: from kolya (1-1-3-35a.mfb.mlm.bostream.se [82.182.194.253])
        by mx.google.com with ESMTPS id x3sm1200500eef.17.2011.06.09.00.47.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Jun 2011 00:47:04 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1QUZxZ-0000lm-Ip; Thu, 09 Jun 2011 09:47:21 +0200
X-Mailer: git-send-email 1.7.6.rc0.14.g4fc55
In-Reply-To: <1307605623-2831-1-git-send-email-iveqy@iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175499>

This function takes the exit code as a parameter.

This allows scripts to control the exit code when they need to die.

Make the old die-function to use die_with_status for simpler
maintenance.

die no longer prints empty die messages, this is a changed behavior.

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
Mentored-by: Jens Lehmann <Jens.Lehmann@web.de>
Mentored-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 git-sh-setup.sh |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 94e26ed..1a91f6e 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -40,8 +40,16 @@ git_broken_path_fix () {
 # @@BROKEN_PATH_FIX@@
 
 die() {
-	echo >&2 "$@"
-	exit 1
+	die_with_status 1 $@
+}
+die_with_status() {
+	stat=$1
+	shift
+	if test ${#@} -gt 0
+	then
+		echo >&2 "$@"
+	fi
+	exit $stat
 }
 
 GIT_QUIET=
-- 
1.7.6.rc0.14.g4fc55
