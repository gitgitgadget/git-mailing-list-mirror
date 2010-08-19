From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v3 3/4] test-lib: Allow overriding of TEST_DIRECTORY
Date: Thu, 19 Aug 2010 16:08:11 +0000
Message-ID: <1282234092-27429-4-git-send-email-avarab@gmail.com>
References: <1282138473-15613-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 19 18:08:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om7fk-0001ab-OQ
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 18:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206Ab0HSQIl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 12:08:41 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:63903 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090Ab0HSQIj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 12:08:39 -0400
Received: by ewy23 with SMTP id 23so1393173ewy.19
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 09:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=MPqKuS5GLkajX0y6yV/7M0DHVckk2HgtCEtSB5m8k2c=;
        b=DOByY0ctZ2Ds/VWUzRhKq0ZhQsmx+T/hKm7zz3xan1Qnf2zVh7rhriAb94N0yS04yM
         S9cxFMkgCjOnaTO9F300Nbm/B4kJ0JgdLCAB8OVwu0V9G1aD9ve6J1jsraQ1/B5Z0F/8
         oSM9gcg2dvfQCq/6G2D5ormWLD6B8YdWs3IPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=tTlHs1gAyNXuGmJ1yEWWl8R0eZhoICkhyU3a8QbsHQvxDurZndwHIn0aareo2VvQQ/
         +J+CKh9R/KB1ODtKvHlOMNkVyf2aOE82QGUg5ViaAIKN2P9jiMpt7AhgM8pHEywX1ctr
         8lIfY+qfchuwQooyoT6q7PJIrjXbkzSMU5tCg=
Received: by 10.216.3.19 with SMTP id 19mr837597weg.108.1282234117462;
        Thu, 19 Aug 2010 09:08:37 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e8sm1118781wej.46.2010.08.19.09.08.36
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 19 Aug 2010 09:08:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.446.g168052
In-Reply-To: <1282138473-15613-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153938>

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
1.7.2.1.446.g168052
