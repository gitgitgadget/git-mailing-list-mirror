From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 5/5] completion: complete values for send-email
Date: Sun,  3 May 2009 23:25:35 -0700
Message-ID: <1241418335-18474-5-git-send-email-bebarino@gmail.com>
References: <1241418335-18474-1-git-send-email-bebarino@gmail.com>
 <1241418335-18474-2-git-send-email-bebarino@gmail.com>
 <1241418335-18474-3-git-send-email-bebarino@gmail.com>
 <1241418335-18474-4-git-send-email-bebarino@gmail.com>
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 04 08:26:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0rdB-0004vC-At
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 08:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719AbZEDG0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 02:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752710AbZEDG0K
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 02:26:10 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:48721 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbZEDG0J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 02:26:09 -0400
Received: by wf-out-1314.google.com with SMTP id 26so2971167wfd.4
        for <git@vger.kernel.org>; Sun, 03 May 2009 23:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=mw3gvL0deabog8NhmVBPCFLnTNMXT8/ROwRhjBlXPag=;
        b=Kl/5klu1v6Zl11y4nFoBFh7FwFSMlxfjX/OxM/71NlepeD7K85pe4rR9SlSv0hgQ0Y
         d/MIz1RrvVdwDXrKHEsu05mDTdtc6r9fv1lMxNApMYo2CIgC6vMVfujKMpqMMD1CvDhG
         aXMXhd+VzrVAbyklKLXt1Vez1mod/GpRYSxiw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=btiIAG0eCXJsShgd6SKqD9h3vAs6Kx2WmhQTyma8aTFX4yQxe3zhBBCSRjg3t8AsJ+
         k6UxmjTZNoz0SBQfw4sLodsxt3jDiFN7pjVW7IBkPLM3U+Gj7DrlIn40PkF0lddY+leX
         zXDMfkytOB86drYtnC6Gimqa5N2whNgIT1NwA=
Received: by 10.142.231.7 with SMTP id d7mr1995736wfh.318.1241418370239;
        Sun, 03 May 2009 23:26:10 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id 31sm463490wff.24.2009.05.03.23.26.04
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 May 2009 23:26:07 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sun, 03 May 2009 23:26:03 -0700
X-Mailer: git-send-email 1.6.2.3
In-Reply-To: <1241418335-18474-4-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118208>

Add completion for --confirm, --suppress-cc, and --smtp-encryption
command line arguments. Add completion for aliasfiletype and confirm
configuration variables.

Since --smtp-ssl is deprecated, replace it with --smtp-encryption and
the two options ssl and tls.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 contrib/completion/git-completion.bash |   39 +++++++++++++++++++++++++++++--
 1 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d67ffd9..1683e6d 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1282,18 +1282,39 @@ _git_rebase ()
 	__gitcomp "$(__git_refs)"
 }
 
+__git_send_email_confirm_options="always never auto cc compose"
+__git_send_email_suppresscc_options="author self cc ccbody sob cccmd body all"
+
 _git_send_email ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
+	--confirm=*)
+		__gitcomp "
+			$__git_send_email_confirm_options
+			" "" "${cur##--confirm=}"
+		return
+		;;
+	--suppress-cc=*)
+		__gitcomp "
+			$__git_send_email_suppresscc_options
+			" "" "${cur##--suppress-cc=}"
+
+		return
+		;;
+	--smtp-encryption=*)
+		__gitcomp "ssl tls" "" "${cur##--smtp-encryption=}"
+		return
+		;;
 	--*)
 		__gitcomp "--annotate --bcc --cc --cc-cmd --chain-reply-to
-			--compose --dry-run --envelope-sender --from --identity
+			--compose --confirm= --dry-run --envelope-sender
+			--from --identity
 			--in-reply-to --no-chain-reply-to --no-signed-off-by-cc
 			--no-suppress-from --no-thread --quiet
 			--signed-off-by-cc --smtp-pass --smtp-server
-			--smtp-server-port --smtp-ssl --smtp-user --subject
-			--suppress-cc --suppress-from --thread --to
+			--smtp-server-port --smtp-encryption= --smtp-user
+			--subject --suppress-cc= --suppress-from --thread --to
 			--validate --no-validate"
 		return
 		;;
@@ -1355,6 +1376,18 @@ _git_config ()
 		__gitcomp "$__git_log_date_formats"
 		return
 		;;
+	sendemail.aliasesfiletype)
+		__gitcomp "mutt mailrc pine elm gnus"
+		return
+		;;
+	sendemail.confirm)
+		__gitcomp "$__git_send_email_confirm_options"
+		return
+		;;
+	sendemail.suppresscc)
+		__gitcomp "$__git_send_email_suppresscc_options"
+		return
+		;;
 	*.*)
 		COMPREPLY=()
 		return
-- 
1.6.2.3
