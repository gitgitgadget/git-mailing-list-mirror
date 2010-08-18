From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 3/4] test-lib: Allow overriding of TEST_DIRECTORY
Date: Wed, 18 Aug 2010 13:34:32 +0000
Message-ID: <1282138473-15613-4-git-send-email-avarab@gmail.com>
References: <7vpqxhaw92.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 18 15:35:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlinS-0005kI-DF
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 15:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188Ab0HRNfF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 09:35:05 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60840 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093Ab0HRNfC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 09:35:02 -0400
Received: by mail-ww0-f44.google.com with SMTP id 17so841571wwi.1
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 06:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=WcTmBd6VuVwBicvySApmUjaG8upNVNPeL7zFqYJC9I8=;
        b=tnCPX5QVftVhFSGq3UB7Kgzxc1q1nHWuA6sugYDCkAqVbcyOxgC5kToNJht/FoR7h8
         cv+Jo4Llqpsq25lTZur6pNence82TX3GP/tFRSAoXrCl6e5tWuzctHjARkC4dSJixtsf
         GVVNmJLqAqGQJjMmQ3k5SUpMQI8iSQx/j7k/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=FUe+e96SAZnxzye5sO63qEE4wNFYQVQYqnGP6BnA7fCLWzffXcqxdxYVAClnngrOgN
         12eYew9jop74eAyeCGx1N1diOAO6hSPlSTn85LkeSiAuW0X5GT3NXNf5ZUO3Q5XZBc7Y
         Wpj4nSFCUa0g6oy7rJQwiGgnHIN8R/ilERnYk=
Received: by 10.227.157.70 with SMTP id a6mr6930411wbx.163.1282138501216;
        Wed, 18 Aug 2010 06:35:01 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id r10sm230012wbe.18.2010.08.18.06.34.58
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 06:34:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.414.g9bf49
In-Reply-To: <7vpqxhaw92.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153845>

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
