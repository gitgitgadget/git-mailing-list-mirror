From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/7] tests: drop GIT_*_TIMING_TESTS environment variable support
Date: Mon,  9 Jun 2014 16:22:55 -0700
Message-ID: <1402356175-7249-8-git-send-email-gitster@pobox.com>
References: <1402356175-7249-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 01:23:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu8uu-0004br-4W
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 01:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934434AbaFIXXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 19:23:41 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54690 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932414AbaFIXXj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 19:23:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1CC191D429;
	Mon,  9 Jun 2014 19:23:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=RTaI
	wrChiKDGatEQFPJl+roVLOM=; b=Kou6sy7rpKbBboJUrg9MgG2y6yiBHLWleUmB
	0plmGbKsoeTKEAuhcff9evMAEWDCLgq+Ez+Bog0mevuDAt6K77R7LJy0hBWpvdxo
	hjyU/9zFFV9zRmLivON/LvciJRtlDtDJmNsjIaXJPvj5Ov1l3gDAF3DIvJ/cNTVd
	8vqcias=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=C3lOWH
	jTAQUMV53FY/9aVDBPu3qaqvDGg6PITGIMKvja1jeo9aWhVw5jrFSH/9fsWGPkdu
	ORk4D3rzPeyc+tcpQyfsCn9XbjFommhz5e8u9rEfWr3aJf2ulv0lehGRt9JvMizW
	kWHNEkPG97IQVpCrbG3Rv7+B8/VOkW7ww1f4Y=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 13BF31D428;
	Mon,  9 Jun 2014 19:23:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2F2E41D41E;
	Mon,  9 Jun 2014 19:23:35 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-483-g1a584c4
In-Reply-To: <1402356175-7249-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 140FC3DE-F02D-11E3-B121-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251140>

Two tests (t3302 and t3419) used to have their own environment
variable to trigger expensive tests without enabling expensive
tests in other scripts; a user could set GIT_NOTES_TIMING_TESTS
but not GIT_TEST_LONG and run the whole test suite and trigger
expensive tests only in t3302 but not other tests.  The same for
GIT_PATCHID_TIMING_TESTS in t3419.

While this may have seemed a good flexibility, in reality if you are
concentrating on a single test (e.g. t3302), you can just run that
single test with the GIT_TEST_LONG to trigger expensive tests.  It
does not seem worth forcing other people who may want to come up
with their own expesive tests to invent new environment variables by
keeping this convention.

Drop them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3302-notes-index-expensive.sh | 2 --
 t/t3419-rebase-patch-id.sh       | 2 --
 2 files changed, 4 deletions(-)

diff --git a/t/t3302-notes-index-expensive.sh b/t/t3302-notes-index-expensive.sh
index 8d44e04..7217c5e 100755
--- a/t/t3302-notes-index-expensive.sh
+++ b/t/t3302-notes-index-expensive.sh
@@ -7,8 +7,6 @@ test_description='Test commit notes index (expensive!)'
 
 . ./test-lib.sh
 
-test -n "$GIT_NOTES_TIMING_TESTS" && test_set_prereq EXPENSIVE
-
 create_repo () {
 	number_of_commits=$1
 	nr=0
diff --git a/t/t3419-rebase-patch-id.sh b/t/t3419-rebase-patch-id.sh
index 9292b49..217dd79 100755
--- a/t/t3419-rebase-patch-id.sh
+++ b/t/t3419-rebase-patch-id.sh
@@ -4,8 +4,6 @@ test_description='git rebase - test patch id computation'
 
 . ./test-lib.sh
 
-test -n "$GIT_PATCHID_TIMING_TESTS" && test_set_prereq EXPENSIVE
-
 count () {
 	i=0
 	while test $i -lt $1
-- 
2.0.0-435-g307a092
