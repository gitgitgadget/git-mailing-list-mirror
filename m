From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2 1/2] t/Makefile: check helper scripts for non-portable
 shell commands too
Date: Wed, 09 Jul 2014 21:34:12 +0200
Message-ID: <53BD9934.9050708@web.de>
References: <53B5D6FE.2090700@web.de> <53B5D76D.1090509@web.de> <xmqq38eddolk.fsf@gitster.dls.corp.google.com> <53BC4569.3020907@web.de> <CAPc5daUXZNB=2X8zsrhs9=Z-nV1o1v7KWGydAj6UmBk23UBEEw@mail.gmail.com> <53BD9908.1060807@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 21:34:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4xdW-0000Ze-AC
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 21:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbaGITe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 15:34:27 -0400
Received: from mout.web.de ([212.227.15.4]:58363 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964778AbaGITeY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 15:34:24 -0400
Received: from [192.168.178.41] ([84.132.188.65]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MBkKF-1WvNNC2am7-00AoN5; Wed, 09 Jul 2014 21:34:13
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53BD9908.1060807@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:Tql9cwAO28HHinzVX5Uf5l6b6jefHygfFnr8ZSdhf3Zy9RzWMGQ
 MnTjz26ELot1rjVWxEX0QMOEwaDwRgmvgQIZ59naC59omr0CSeHIQIYBt2uxl4ZsPadaIe8
 MaQb92AnWKkFYGsmheWHRnCRUsS2HXy88QxH4zDZFgIrrBRDj57NzaZtx6SzWpduRpmbkxn
 PX/HNFk+qwXT1jCrv2ykQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253142>

Currently only the "t[0-9][0-9][0-9][0-9]-*.sh" scripts are tested for
shell incompatibilities using the check-non-portable-shell.pl script. This
makes it easy to miss non-POSIX constructs added to one of the t/*lib*.sh
helper scripts, as they aren't automatically detected.

Fix that by adding a THELPERS variable containing all shell scripts that
aren't tests and add these to the "test-lint-shell-syntax" target too.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
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
2.0.1.476.gf051ede
