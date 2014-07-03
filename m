From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 1/2] t/Makefile: check helper scripts for non-portable shell
 commands too
Date: Fri, 04 Jul 2014 00:20:38 +0200
Message-ID: <53B5D736.6090809@web.de>
References: <53B5D6FE.2090700@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	=?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 04 00:20:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2pNC-0005ND-Jn
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jul 2014 00:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754152AbaGCWUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2014 18:20:55 -0400
Received: from mout.web.de ([212.227.17.11]:52312 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752957AbaGCWUy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2014 18:20:54 -0400
Received: from [192.168.178.41] ([84.132.191.233]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MfqEy-1XEpwB1shQ-00N7Kb; Fri, 04 Jul 2014 00:20:39
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53B5D6FE.2090700@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:95QrHJlt295yzQ/CWMmKF2JU3JnNe5t3afYoQuJxpbgq3uoHuv/
 YOB5aZzE2FsVVwAp2oW80JRsJ/fjwPNMJTVjZvxd5eMdhzKKdVHUwLjXJ2uOa6F8m3acBah
 MV3qLtZx5HLsrF4v885jkvEtoJLnQny6LfODevYmP3SqHnumwSxdrprIO7dOlWB8wQdurbK
 U1ORKUjVEV6FX93+5RUwg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252885>

Currently only the "t[0-9][0-9][0-9][0-9]-*.sh" scripts are tested for
shell incompatibilities using the check-non-portable-shell.pl script. This
makes it easy to miss non-POSIX constructs added to one of the t/*lib*.sh
helper scripts, as they aren't automatically detected.

Fix that by adding a THELPERS variable containing all shell scripts that
aren't tests and add these to the "test-lint-shell-syntax" target too.
---
 t/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/Makefile b/t/Makefile
index 8fd1a72..7fa6692 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -29,6 +29,7 @@ TEST_RESULTS_DIRECTORY_SQ = $(subst ','\'',$(TEST_RESULTS_DIRECTORY))
 T = $(sort $(wildcard t[0-9][0-9][0-9][0-9]-*.sh))
 TSVN = $(sort $(wildcard t91[0-9][0-9]-*.sh))
 TGITWEB = $(sort $(wildcard t95[0-9][0-9]-*.sh))
+THELPERS = $(sort $(filter-out $(T),$(wildcard *.sh)))

 all: $(DEFAULT_TEST_TARGET)

@@ -65,7 +66,7 @@ test-lint-executable:
 		echo >&2 "non-executable tests:" $$bad; exit 1; }

 test-lint-shell-syntax:
-	@'$(PERL_PATH_SQ)' check-non-portable-shell.pl $(T)
+	@'$(PERL_PATH_SQ)' check-non-portable-shell.pl $(T) $(THELPERS)

 aggregate-results-and-cleanup: $(T)
 	$(MAKE) aggregate-results
-- 
2.0.1.474.g5b85b58
