From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 3/4] test-lib: Allow overriding of TEST_DIRECTORY
Date: Thu, 19 Aug 2010 16:06:00 +0000
Message-ID: <1282233961-27203-4-git-send-email-avarab@gmail.com>
References: <1282138473-15613-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 19 18:07:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om7dx-0000My-8C
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 18:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497Ab0HSQGj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 12:06:39 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52686 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375Ab0HSQGg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 12:06:36 -0400
Received: by mail-ww0-f44.google.com with SMTP id 17so2637367wwi.1
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 09:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=WcTmBd6VuVwBicvySApmUjaG8upNVNPeL7zFqYJC9I8=;
        b=nHVvLJpk9YrshwfOZ5WA+0goulUpWNw9LT5ymPftOcOV6qrevW1hAgUXBFJbZ3pjrY
         n7ZnGMOBjjCl52TrMg4CnE+nQ3N207p71EvD5XZgTSBmsflDv9J53IZ8NDJuY5D2YIJX
         3zJDtv0/87q8nRVbBHr705tpSNJXOMfSEVXB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=rx4CeqnDsxfqLE9GL8WaPDsACqxohR4Yw+pl3bU8VYY6ATDjbJJezBvFWpoxD+UQYk
         kfBgPl+k4aS/WjaSHI0xVJUao7IpJHkGwZlI9QDP7BPpJwVJ/eSJoVS07pF2/QloJk7V
         rISiJg6KaXPW0kQE6ipOLNU/FIyW/7mq1ojEc=
Received: by 10.227.156.199 with SMTP id y7mr64327wbw.21.1282233995363;
        Thu, 19 Aug 2010 09:06:35 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id q17sm470663wbe.12.2010.08.19.09.06.34
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 19 Aug 2010 09:06:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.446.g168052
In-Reply-To: <1282138473-15613-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153934>

Tests that test the test-lib.sh itself need to be executed in the
dynamically created trash directory, so we can't assume
$TEST_DIRECTORY is ../ for those.

As a side benefit this change also makes it easy for us to move the
t/*.sh tests into subdirectories if we ever want to do that.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/test-lib.sh |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 689aa29..01ddf3e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -747,7 +747,13 @@ test_done () {
=20
 # Test the binaries we have just built.  The tests are kept in
 # t/ subdirectory and are run in 'trash directory' subdirectory.
-TEST_DIRECTORY=3D$(pwd)
+if test -z "$TEST_DIRECTORY"
+then
+	# We allow tests to override this, in case they want to run tests
+	# outside of t/, e.g. for running tests on the test library
+	# itself.
+	TEST_DIRECTORY=3D$(pwd)
+fi
 GIT_BUILD_DIR=3D"$TEST_DIRECTORY"/..
=20
 if test -n "$valgrind"
--=20
1.7.2.1.414.g9bf49
