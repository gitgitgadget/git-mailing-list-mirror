From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 1/3] completion: complete config variables for --get/getall/unset/unset-all
Date: Wed,  6 May 2009 23:15:04 -0700
Message-ID: <1241676906-29783-1-git-send-email-bebarino@gmail.com>
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 07 08:15:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1wtL-00065U-Sk
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 08:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752528AbZEGGP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 02:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751994AbZEGGPZ
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 02:15:25 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:12138 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbZEGGPY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 02:15:24 -0400
Received: by rv-out-0506.google.com with SMTP id f9so452637rvb.1
        for <git@vger.kernel.org>; Wed, 06 May 2009 23:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=/b+ipl0TNR5c51SyRjbRLCMSY1w2oY4+j8Cf+8Uy7wg=;
        b=tarEpWr1CfECo3UANgZ4OSeh/7aXQE0mZQourdX2hPDzObLJXgTYs+WujaEe1NqeOT
         yLDLxYoHgpppTEp/n/1wkRr13Ku+Cdz7qaZbRVBNQanvnf1ewEfVP+kJ2ETLiXw2ixgc
         IkAs5FzdR6n06ipHTHDxC36XbGCG48LrxyDxU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Qq8VaahpNXBUTIMbUliRMxdMNqKEWXUuBHUY5kUXpkcFEvqmNTO1wq5oqB3+NG5asJ
         BlUA3zFym9/dOzA7PVfMZhaays/LZqR3NK0zE4/OkloFnc3ETTclxwW6TvbIOLr3gxNL
         yVeWpTBdom/XaOZ2j2yQ1Zdnux8LdE3xlNFqk=
Received: by 10.115.32.8 with SMTP id k8mr2052514waj.54.1241676924525;
        Wed, 06 May 2009 23:15:24 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id m28sm14313514waf.2.2009.05.06.23.15.08
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 May 2009 23:15:12 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Wed, 06 May 2009 23:15:06 -0700
X-Mailer: git-send-email 1.6.3.rc4.29.g8146
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118428>

This should make it easier for users to get and unset their
configuration variables without having to open documentation or dig
through their configuration file.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 contrib/completion/git-completion.bash |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1683e6d..72a16a1 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1322,6 +1322,17 @@ _git_send_email ()
 	COMPREPLY=()
 }
 
+__git_config_get_set_variables ()
+{
+	for i in $(git --git-dir="$(__gitdir)" config --list); do
+		case "$i" in
+		*.*)
+			echo "${i/=*/}"
+			;;
+		esac
+	done
+}
+
 _git_config ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
@@ -1388,6 +1399,10 @@ _git_config ()
 		__gitcomp "$__git_send_email_suppresscc_options"
 		return
 		;;
+	--get|--get-all|--unset|--unset-all)
+		__gitcomp "$(__git_config_get_set_variables)"
+		return
+		;;
 	*.*)
 		COMPREPLY=()
 		return
-- 
1.6.3.rc4.29.g8146
