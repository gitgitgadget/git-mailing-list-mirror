From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/7] test: turn USR_BIN_TIME into a lazy prerequisite
Date: Mon,  9 Jun 2014 16:22:50 -0700
Message-ID: <1402356175-7249-3-git-send-email-gitster@pobox.com>
References: <1402356175-7249-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 01:23:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu8uZ-0004KM-Bb
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 01:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934278AbaFIXXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 19:23:15 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58746 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932414AbaFIXXM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 19:23:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B45E01D3FB;
	Mon,  9 Jun 2014 19:23:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=m2gW
	NuoUfhJKNE9vHC+jgVWL2aQ=; b=yV5BWm3erfGnaovFZ6jJ/HEY51ZUm5TDYa0S
	Nh0oZvyLRHRFnobJzEh8SdWyNaCjhQ8uPadsSV8DC5RlXcNXm+UqyA6zh8TRS4QX
	JRCkSZYwu3G4mkk6xy3flFnOEEuVwU+7//Snfnc4M61ElIhb5iim5/pnT2QbNgjp
	w+2BVBI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=h2IsLH
	ZSVhraBWCRr346PAGJIuzOUvAzTOr/D3BsBAqGljdGa8bP0tN9TArE+bh7hw2EyF
	Gf4CLcbj6BzoWbywE/llKtRZAdIisr17bnTH7DRdqd/IUVtISP6UWUR3uwW2mDcz
	UrjjvfeuD20/XmXYbHJuFh8cxV874w+/SYPFM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AA8421D3FA;
	Mon,  9 Jun 2014 19:23:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BB7321D3F8;
	Mon,  9 Jun 2014 19:23:07 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-483-g1a584c4
In-Reply-To: <1402356175-7249-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 03B7487C-F02D-11E3-8787-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251133>

Two test scripts (t3302 and t3419) had copy & paste code to set
USR_BIN_TIME prerequisite.  Use the test_lazy_prereq helper to define
them in the common t/test-lib.sh.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3302-notes-index-expensive.sh | 1 -
 t/t3419-rebase-patch-id.sh       | 1 -
 t/test-lib.sh                    | 4 ++++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t3302-notes-index-expensive.sh b/t/t3302-notes-index-expensive.sh
index e35d781..dc706ab 100755
--- a/t/t3302-notes-index-expensive.sh
+++ b/t/t3302-notes-index-expensive.sh
@@ -9,7 +9,6 @@ test_description='Test commit notes index (expensive!)'
 
 test_set_prereq NOT_EXPENSIVE
 test -n "$GIT_NOTES_TIMING_TESTS" && test_set_prereq EXPENSIVE
-test -x /usr/bin/time && test_set_prereq USR_BIN_TIME
 
 create_repo () {
 	number_of_commits=$1
diff --git a/t/t3419-rebase-patch-id.sh b/t/t3419-rebase-patch-id.sh
index e70ac10..08e30b3 100755
--- a/t/t3419-rebase-patch-id.sh
+++ b/t/t3419-rebase-patch-id.sh
@@ -6,7 +6,6 @@ test_description='git rebase - test patch id computation'
 
 test_set_prereq NOT_EXPENSIVE
 test -n "$GIT_PATCHID_TIMING_TESTS" && test_set_prereq EXPENSIVE
-test -x /usr/bin/time && test_set_prereq USR_BIN_TIME
 
 count()
 {
diff --git a/t/test-lib.sh b/t/test-lib.sh
index d70d05e..884c57c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -859,6 +859,10 @@ test_lazy_prereq EXPENSIVE '
 	test -n "$GIT_TEST_LONG"
 '
 
+test_lazy_prereq USR_BIN_TIME '
+	test -x /usr/bin/time
+'
+
 # When the tests are run as root, permission tests will report that
 # things are writable when they shouldn't be.
 test -w / || test_set_prereq SANITY
-- 
2.0.0-435-g307a092
