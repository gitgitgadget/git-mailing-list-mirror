From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 34/48] i18n: git-stash die + eval_gettext $* messages
Date: Sat, 21 May 2011 18:44:15 +0000
Message-ID: <1306003469-22939-35-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:46:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrBY-0000TI-Tf
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757075Ab1EUSpx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:45:53 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:45234 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756913Ab1EUSpe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:34 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1451059ewy.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=CESzJldC+a7q/Re8nVT7uDcAusSb1axCOAC7I0AlkLA=;
        b=Ow+jJkMIEYQUWFt8f92jA4jt/zB0ZURkk5Xb2eTp7X2XEcyecb2Y3uqX8jOnsGewEl
         wNoX1QFaTS5egI7ChRRMXn6dpETCuOgp3SO5oPzWMhNYyZCcK03HSLN4wCs3QmlHagn4
         2ZUu/JZRw3UAUz898gTshWpasc+nG+9PMc7KQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=fCm+qMwEJHV8wxtOpvDA4nuvkFN1NS/ZGaUEy756JDvlpnzMUqjMqsm25P68K0CaHq
         QoxQRWkrUoHIh+gbrc0xmn6N2gtNTz54l0WHSlAdHugLcIKKVZs7t04aNm0HW+hCMBXd
         hAm6lMpRZ68xSlDhHEHUFEz8vKiAeYfcAqIPU=
Received: by 10.213.19.18 with SMTP id y18mr542319eba.60.1306003534114;
        Sat, 21 May 2011 11:45:34 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.33
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174135>

Gettextize messages that used the $* variable. Since it's subroutine
local we have to provide an alias for it for eval_gettext.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 3d89c15..509e14f 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -321,7 +321,10 @@ is_stash_like()
 }
=20
 assert_stash_like() {
-	is_stash_like "$@" || die "'$*' is not a stash-like commit"
+	is_stash_like "$@" || {
+		args=3D"$*"
+		die "$(eval_gettext "'\$args' is not a stash-like commit")"
+	}
 }
=20
 is_stash_ref() {
@@ -329,7 +332,10 @@ is_stash_ref() {
 }
=20
 assert_stash_ref() {
-	is_stash_ref "$@" || die "'$*' is not a stash reference"
+	is_stash_ref "$@" || {
+		args=3D"$*"
+		die "$(eval_gettext "'\$args' is not a stash reference")"
+	}
 }
=20
 apply_stash () {
--=20
1.7.5.1
