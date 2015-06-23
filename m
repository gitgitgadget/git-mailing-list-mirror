From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH v6 05/10] send-email: Allow use of aliases in the From field of --compose mode
Date: Tue, 23 Jun 2015 22:30:11 +0200
Message-ID: <1435091416-9394-5-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
References: <1434550720-24130-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
 <1435091416-9394-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 23 22:30:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7UqF-0000mo-5u
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 22:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933299AbbFWUak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 16:30:40 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:52674 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933236AbbFWUad (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jun 2015 16:30:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 65C012948;
	Tue, 23 Jun 2015 22:30:32 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Atf-NKb6fq2A; Tue, 23 Jun 2015 22:30:32 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 494142941;
	Tue, 23 Jun 2015 22:30:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 44B2920DC;
	Tue, 23 Jun 2015 22:30:32 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6fEv6Sa4srzT; Tue, 23 Jun 2015 22:30:32 +0200 (CEST)
Received: from localhost.localdomain (cor91-7-83-156-199-91.fbx.proxad.net [83.156.199.91])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id CFB2F20DA;
	Tue, 23 Jun 2015 22:30:31 +0200 (CEST)
X-Mailer: git-send-email 2.4.4.418.ga60dbe1
In-Reply-To: <1435091416-9394-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272504>

Aliases were expanded before considering the From field of the
--compose option. This is inconsistent with other fields
(To, Cc, ...) which already support aliases.

Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
---
 git-send-email.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 2d5c530..f61449d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -555,8 +555,6 @@ if (@alias_files and $aliasfiletype and defined $parse_alias{$aliasfiletype}) {
 	}
 }
 
-($sender) = expand_aliases($sender) if defined $sender;
-
 # is_format_patch_arg($f) returns 0 if $f names a patch, or 1 if
 # $f is a revision list specification to be passed to format-patch.
 sub is_format_patch_arg {
@@ -801,6 +799,8 @@ if (!$force) {
 	}
 }
 
+($sender) = expand_aliases($sender) if defined $sender;
+
 if (!defined $sender) {
 	$sender = $repoauthor || $repocommitter || '';
 }
-- 
1.9.1
