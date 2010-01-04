From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] t7002: set test prerequisite "external-grep" if supported
Date: Mon,  4 Jan 2010 19:34:14 +0700
Message-ID: <1262608455-4045-1-git-send-email-pclouds@gmail.com>
References: <7v7hs09tpi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 04 13:35:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRm9f-0005kq-3L
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 13:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557Ab0ADMfP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jan 2010 07:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752218Ab0ADMfO
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 07:35:14 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:49727 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378Ab0ADMfN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 07:35:13 -0500
Received: by yxe26 with SMTP id 26so14477660yxe.4
        for <git@vger.kernel.org>; Mon, 04 Jan 2010 04:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=MlHzA8ZHij3uTW5XBU6X1LdU4mLVKSeXkV2u1mNuZm8=;
        b=t8a+m+fN3VeVMNjFEZdRrEOTdwjspkjmNn2VAWZvxFGLR4ybPHkyvtqnGQzpKZ4Zfa
         rnMOnR8efbJZjCX6CXu/hlY38Ai76ja0ke6yU03rlhcw3wa70fOtmUVDv7BhOFcqgVuS
         fH0yf+5UUHeQ9rmbiHvetaQAvOM8lMeasteGY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=DsArCDfYs5/e7fCpJwXwatChf1umNZZJkLFzP/h4hMXG7JKWX74oexBMk2bUtf0J84
         qmTJBqHiF+8CpB+VR1kzAGq/IjZOUDJng2KJGKQcv+uhevaX/+0Lj0NFuwVgW87xahH5
         Z4MSaaEHjHOnrcJ1YkwAdVGytNXvTCZdgtVxU=
Received: by 10.101.65.7 with SMTP id s7mr16717244ank.57.1262608505842;
        Mon, 04 Jan 2010 04:35:05 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.227.183])
        by mx.google.com with ESMTPS id 14sm8976214gxk.6.2010.01.04.04.35.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Jan 2010 04:35:05 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon,  4 Jan 2010 19:34:17 +0700
X-Mailer: git-send-email 1.6.6.315.g1a406
In-Reply-To: <7v7hs09tpi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136111>

Add another test to set prerequisite "external-grep" if the current
build supports external grep. This can be used to skip external grep
only tests on builds that do not support this optimization.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t7002-grep.sh |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
index abd14bf..ffda0df 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -8,6 +8,18 @@ test_description=3D'git grep various.
=20
 . ./test-lib.sh
=20
+test_expect_success 'Check for external grep support' '
+	case "$(git grep -h 2>&1|grep ext-grep)" in
+	*"(default)"*)
+		test_set_prereq external-grep
+		true;;
+	*"(ignored by this build)"*)
+		true;;
+	*)
+		false;;
+	esac
+'
+
 cat >hello.c <<EOF
 #include <stdio.h>
 int main(int argc, const char **argv)
--=20
1.6.6.315.g1a406
