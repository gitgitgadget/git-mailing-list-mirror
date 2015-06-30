From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v7 05/10] send-email: allow use of aliases in the From field of --compose mode
Date: Tue, 30 Jun 2015 14:16:46 +0200
Message-ID: <1435666611-18429-6-git-send-email-Matthieu.Moy@imag.fr>
References: <1435666611-18429-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 30 14:17:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9uTT-0005Va-CE
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 14:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995AbbF3MRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 08:17:09 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39685 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752531AbbF3MRE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 08:17:04 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5UCGwEW015325
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Jun 2015 14:16:58 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5UCGxpx022748;
	Tue, 30 Jun 2015 14:16:59 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z9uTD-000512-Cq; Tue, 30 Jun 2015 14:16:59 +0200
X-Mailer: git-send-email 2.5.0.rc0.10.g7792c2a
In-Reply-To: <1435666611-18429-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 30 Jun 2015 14:16:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5UCGwEW015325
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1436271419.08974@uESyfqXFbPW3zc2VNwCOpA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273044>

From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>

Aliases were expanded before considering the From field of the
--compose option. This is inconsistent with other fields
(To, Cc, ...) which already support aliases.

Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 git-send-email.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 994697e..da1d4a4 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -561,8 +561,6 @@ if (@alias_files and $aliasfiletype and defined $parse_alias{$aliasfiletype}) {
 	}
 }
 
-($sender) = expand_aliases($sender) if defined $sender;
-
 # is_format_patch_arg($f) returns 0 if $f names a patch, or 1 if
 # $f is a revision list specification to be passed to format-patch.
 sub is_format_patch_arg {
@@ -807,6 +805,8 @@ if (!$force) {
 	}
 }
 
+($sender) = expand_aliases($sender) if defined $sender;
+
 if (!defined $sender) {
 	$sender = $repoauthor || $repocommitter || '';
 }
-- 
2.5.0.rc0.10.g7792c2a
