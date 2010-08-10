From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 3/7] t/t7005-editor: change from skip_all=* to prereq skip
Date: Tue, 10 Aug 2010 19:52:44 +0000
Message-ID: <1281469968-25670-4-git-send-email-avarab@gmail.com>
References: <1281469968-25670-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 10 21:53:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oiut0-0008HM-HG
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 21:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754968Ab0HJTxR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 15:53:17 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58890 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754530Ab0HJTxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 15:53:16 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so13310538wwj.1
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 12:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=R24R5+rhQrbL5sq7if1LmpFV2IvOXqieE72F5ain3sk=;
        b=O7T4Q+mn0JJLt/5wsi5hLb7+bytAzrM2f2/Jk8gBHyP7TJC5VPOXQNLSA4EGcHktdn
         7owy0BtcovrSiVi85pc9SKjJw67rEOhGaOrPLQrk73bMRLocyOqTJKRZvFX3KDwtqsTs
         Su7vM4xZ2xeyhyosKJINKlYZrSWg/B+VcZ72k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Gl4YQItowizhLx+clzijP2yTHLluum7bAgIwrHCXPrc0cl+6A/MmZnn0ZUUSUKDD/P
         0NgSsLQK5hXVPdB+fPyHZAWGc165Il4mb9DPL+HqXH5WAksHBkArniT8O6l2T6dKP0RF
         8kZI3OMvPmdFr3G5brLVzu7pP+/s1OEVAR/5A=
Received: by 10.216.164.141 with SMTP id c13mr15611206wel.83.1281469996171;
        Tue, 10 Aug 2010 12:53:16 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id p45sm3602981weq.21.2010.08.10.12.53.14
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Aug 2010 12:53:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.295.gd03d
In-Reply-To: <1281469968-25670-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153145>

Change this test to skip test with test prerequisites, and to do setup
work in tests. This improves the skipped statistics on platforms where
the test isn't run.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t7005-editor.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index 26ddf9d..1b530b5 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -111,13 +111,13 @@ do
 	'
 done
=20
-if ! echo 'echo space > "$1"' > "e space.sh"
+if echo 'echo space > "$1"' > "e space.sh"
 then
-	skip_all=3D"Skipping; FS does not support spaces in filenames"
-	test_done
+	# FS supports spaces in filenames
+	test_set_prereq SPACES_IN_FILENAMES
 fi
=20
-test_expect_success 'editor with a space' '
+test_expect_success SPACES_IN_FILENAMES 'editor with a space' '
=20
 	chmod a+x "e space.sh" &&
 	GIT_EDITOR=3D"./e\ space.sh" git commit --amend &&
@@ -126,7 +126,7 @@ test_expect_success 'editor with a space' '
 '
=20
 unset GIT_EDITOR
-test_expect_success 'core.editor with a space' '
+test_expect_success SPACES_IN_FILENAMES 'core.editor with a space' '
=20
 	git config core.editor \"./e\ space.sh\" &&
 	git commit --amend &&
--=20
1.7.2.1.295.gd03d
