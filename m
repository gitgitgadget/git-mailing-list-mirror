From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 3/7] t/t7005-editor: change from skip_all=* to prereq skip
Date: Wed, 11 Aug 2010 19:04:06 +0000
Message-ID: <1281553450-26467-4-git-send-email-avarab@gmail.com>
References: <7vd3tpxao1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 11 21:04:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjGbV-00034v-C1
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 21:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758439Ab0HKTEb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 15:04:31 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38416 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758406Ab0HKTE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 15:04:29 -0400
Received: by mail-wy0-f174.google.com with SMTP id 32so462329wyb.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 12:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=V/eeDTN8ZgWAHMQi3FDKMgNeZY55gLq8I+cnzgoFEpg=;
        b=mVZcxqPKgNHiEknVqa3K9VitKfq+2IQZRiEBz5PwG7y0nltPJBd+KWLK3VacFAuZVi
         EgoTNSXbg9uXVd4ce02NOOg9XWaYsb2VH70/BZNbKC2tCPSRUr+RHagDrUGT0KyH1YxK
         1+WTmmw/Ql45f03c4eysdqOU7eg91WX0OO5sc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=j3+jmfEowDaiKT3NhCcrh60qS/7HzR1KOpiUAgzkCwzPMvua3Eo+WsWtU4zPf8oDtK
         y3Ert6zD1BUiFvvu+2/+A+a2BhW6wvFrHGc89tuCBKAnRRaTZ8wPt062ZfFHUgO9ZCq5
         /vIicLNpRJWknMT0/mMCtSuP8mHproi7NOC7s=
Received: by 10.227.145.203 with SMTP id e11mr16945578wbv.134.1281553469220;
        Wed, 11 Aug 2010 12:04:29 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id b18sm369379wbb.19.2010.08.11.12.04.28
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 12:04:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.295.gdf931
In-Reply-To: <7vd3tpxao1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153287>

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
1.7.2.1.295.gdf931
