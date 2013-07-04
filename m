From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v9 4/5] t6006: add two more tests for the case i18n.commitEncoding is not set
Date: Thu,  4 Jul 2013 16:45:49 +0400
Message-ID: <d1e6681bea4a69d4774b09e4cb776f4cd6e6dcc9.1372939482.git.Alex.Crezoff@gmail.com>
References: <cover.1372939482.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 04 14:46:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uuivf-0001SI-6c
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 14:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944Ab3GDMqW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Jul 2013 08:46:22 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:33211 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964922Ab3GDMqD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 08:46:03 -0400
Received: by mail-lb0-f174.google.com with SMTP id x10so1181639lbi.5
        for <git@vger.kernel.org>; Thu, 04 Jul 2013 05:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=4CQC81JOouWE9pBr2BJU/FZ5Z7QYK0eQaV9WharKT/8=;
        b=RqoD76yDuZMq+Ee1homvFbvoKf/JwtC7QAU4HbQAdzBSpYtIaSMuviT/ziJfxKLau+
         E/7RhNdN7dOQHre+lWoQE64L/KyMEeumfuiI1Xj7YzZnzmitFps5WC0Om8aNU3YXC4Fk
         ec57XNhGrMevYzX+pPR5bNbRoXLz5wwtuC37HpsDqegnF22ePpm7cNHandBlzRyUPuFU
         cfTO+vhMzwY0Z4L0W0zzO1Mg3wNvPadLM0k8YWPkf7Hxc0q7ne/Uo3dTOLcGS/eVHn0L
         nc7t2VNGWCNyqJ5WYgUpA6JOfAAMv8byE11jOSfOfF/ncTxW3XUF6Oh0YmMwSENq2QNR
         T2UQ==
X-Received: by 10.112.157.137 with SMTP id wm9mr3494509lbb.14.1372941961786;
        Thu, 04 Jul 2013 05:46:01 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id k10sm1207026lbl.10.2013.07.04.05.46.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Jul 2013 05:46:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.15.g5c23c1e
In-Reply-To: <cover.1372939482.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1372939482.git.Alex.Crezoff@gmail.com>
References: <cover.1372719264.git.Alex.Crezoff@gmail.com> <cover.1372939482.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229580>

In de6029a2d7734a93a9e27b9c4471862a47dd8123 'complex-subject' test was
changed. Revert it back, and add two more tests to test encoding
conversions with no i18n.commitEncoding set.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
Reviewed-by: Johannes Sixt <j.sixt@viscovery.net>
---
 t/t6006-rev-list-format.sh | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index e069263..843134f 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -217,12 +217,7 @@ test_expect_success 'setup complex body' '
 	git config i18n.commitencoding iso8859-1 &&
 	echo change2 >foo && git commit -a -F commit-msg &&
 	head3=3D$(git rev-parse --verify HEAD) &&
-	head3_short=3D$(git rev-parse --short $head3) &&
-	# unset commit encoding config
-	# otherwise %e does not print encoding value
-	# and following test fails
-	git config --unset i18n.commitEncoding
-
+	head3_short=3D$(git rev-parse --short $head3)
 '
=20
 test_format complex-encoding %e <<EOF
@@ -238,12 +233,35 @@ test_format complex-subject %s <<EOF
 commit $head3
 Test printing of complex bodies
 commit $head2
+$changed_iso88591
+commit $head1
+$added_iso88591
+EOF
+
+test_format complex-body %b <<EOF
+commit $head3
+This commit message is much longer than the others,
+and it will be encoded in iso8859-1. We should therefore
+include an iso8859 character: =A1bueno!
+
+commit $head2
+commit $head1
+EOF
+
+# Git uses i18n.commitEncoding if no i18n.logOutputEncoding set
+# so unset i18n.commitEncoding to test encoding conversion
+git config --unset i18n.commitEncoding
+
+test_format complex-subject-commitencoding-unset %s <<EOF
+commit $head3
+Test printing of complex bodies
+commit $head2
 $changed
 commit $head1
 $added
 EOF
=20
-test_format complex-body %b <<EOF
+test_format complex-body-commitencoding-unset %b <<EOF
 commit $head3
 This commit message is much longer than the others,
 and it will be encoded in iso8859-1. We should therefore
--=20
1.8.3.1.15.g5c23c1e
