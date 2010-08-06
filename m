From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 2/3] test-lib: Print missing prerequisites in test output
Date: Fri,  6 Aug 2010 21:19:24 +0000
Message-ID: <1281129565-26124-3-git-send-email-avarab@gmail.com>
References: <1281129565-26124-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 06 23:20:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhUKu-0005ak-G8
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 23:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762082Ab0HFVT4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 17:19:56 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51612 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762074Ab0HFVTx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 17:19:53 -0400
Received: by mail-wy0-f174.google.com with SMTP id 39so8201142wyb.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 14:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=+8T2uTCpGNGwl7Etbt38DwX5Gh0iu43xmVPON0PlZCM=;
        b=g17yQvbS4pTRAczq1Qlw29esOt171UweGQeYpLwp+Idw+gTloeKGZTs6kFDeaFLBDi
         5MzhYSyDunzbLUGjAHcJA7Wn5K+52zG7gzZLjBfQz1m80fXFa5xjEO5DjVXidXEbLYq3
         asorjph7pXzGJ5nlc/9j5Rm5xu0KwAptp4D1A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=enpUkruSf+Ot7mSqO916h10dnWmZ4BzEdcnY3wuqHk1R5h23mgY29wfD+N+Zk0/S1O
         1nEye5Izs3JRrIOAFwzJbOwhr5/ei/I07J/u4r+r+6Fpro8/2hUmuCsBlSrGKUpMrEuJ
         YIYnrUkDV9ygYAqEW6dwBFpq0tHJ5eBAmW25k=
Received: by 10.216.3.19 with SMTP id 19mr418468weg.108.1281129593094;
        Fri, 06 Aug 2010 14:19:53 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k7sm1167559wej.2.2010.08.06.14.19.51
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 06 Aug 2010 14:19:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1281129565-26124-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152817>

Change the test output to print needed prerequisites as part of the
TAP. This makes it easy to see at a glance why a test was
skipped. Before:

    ok 7 # skip <message>
    ok 9 # skip <message>

After:

    ok 7 # skip <message> (prereqs: DONTHAVEIT)
    ok 9 # skip <message> (prereqs: HAVEIT,DONTHAVEIT)

This'll also be useful for smoke testing output, where the developer
reading the output may not be familiar with the system where tests are
being skipped.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/test-lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8701923..4e0a1c3 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -403,7 +403,7 @@ test_skip () {
 	case "$to_skip" in
 	t)
 		say_color skip >&3 "skipping test: $@"
-		say_color skip "ok $test_count # skip $1"
+		say_color skip "ok $test_count # skip $1 (prereqs: $prereq)"
 		: true
 		;;
 	*)
--=20
1.7.1
