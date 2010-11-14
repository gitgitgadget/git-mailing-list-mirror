From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 2/4] t7004-tag.sh: re-arrange git tag comment for clarity
Date: Sun, 14 Nov 2010 14:44:15 +0000
Message-ID: <1289745857-16704-3-git-send-email-avarab@gmail.com>
References: <1289745857-16704-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 14 15:45:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHdq3-0003gO-67
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 15:45:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755925Ab0KNOp1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 09:45:27 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:53253 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755877Ab0KNOpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 09:45:25 -0500
Received: by wwb29 with SMTP id 29so432741wwb.1
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 06:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=F5aFrblH2Vw3SvQFJtpLSFYcO1ZH7RQkk+m6qMeQIzw=;
        b=Y5TJz1tb1rS1Z8F8aAo0PNQydyuKpe57TwXRXtmIHSC47lwFy4EeVmsLBgSmYq6dii
         SucW9PEKjvCHz7rd1en3CykbmFwS6hV5gFtaNX1NHfR+dmHwDnMGbk11/cuTS1Ga9p+T
         PLyEgnK5rxvFkF6hNl7AU/tvrfcSBaGYp7Tk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xBuQqMrWIUHpp6ApidzK8WeGQsHBhjSNskpFbKjcbSZZPiCy8XgdWXCbyrS/JRB9Ga
         Xa6aBFWyszF0Qqq8B3PMdF1oL5jVZkebFVZ2E/+wHhyA5pWAhWVayRACDIv56OUDrbiY
         utJZryyKW86NG62hfZiGTyJG/XNowwMI0mkxM=
Received: by 10.227.156.68 with SMTP id v4mr4900030wbw.224.1289745923551;
        Sun, 14 Nov 2010 06:45:23 -0800 (PST)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id y15sm3208613weq.6.2010.11.14.06.45.22
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 06:45:23 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.326.g36065a
In-Reply-To: <1289745857-16704-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161412>

Split the "message in editor has initial comment" test into three
tests. The motivation is to be able to only skip the middle part under
NO_GETTEXT_POISON.

In addition the return value of 'git tag' was being returned. We now
check that it's non-zero. I used ! instead of test_must_fail so that
the GIT_EDITOR variable was only used in this command invocation, and
because the surrounding tests use this style.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t7004-tag.sh |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index ac943f5..700b556 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1051,13 +1051,23 @@ test_expect_success \
=20
 test_expect_success \
 	'message in editor has initial comment' '
-	GIT_EDITOR=3Dcat git tag -a initial-comment > actual
+	! (GIT_EDITOR=3Dcat git tag -a initial-comment > actual)
+'
+
+test_expect_success \
+	'message in editor has initial comment: first line' '
 	# check the first line --- should be empty
-	first=3D$(sed -e 1q <actual) &&
-	test -z "$first" &&
+	echo >first.expect &&
+	sed -e 1q <actual >first.actual &&
+	test_cmp first.expect first.actual
+'
+
+test_expect_success \
+	'message in editor has initial comment: remainder' '
 	# remove commented lines from the remainder -- should be empty
-	rest=3D$(sed -e 1d -e '/^#/d' <actual) &&
-	test -z "$rest"
+	>rest.expect
+	sed -e 1d -e '/^#/d' <actual >rest.actual &&
+	test_cmp rest.expect rest.actual
 '
=20
 get_tag_header reuse $commit commit $time >expect
--=20
1.7.2.3
