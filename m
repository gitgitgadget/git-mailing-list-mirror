From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 37/51] i18n: git-stash die + eval_gettext $* messages
Date: Sun,  3 Apr 2011 16:46:01 +0000
Message-ID: <1301849175-1697-38-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:48:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QTK-0005RJ-Kz
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126Ab1DCQrM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:47:12 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57591 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753023Ab1DCQrI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:47:08 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1502912eyx.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=ndrlc3tzep+QWGygoRjNVW3LwlKRYRZufj6zc7t5FoM=;
        b=jmu+DnXeigsS8XJWIS07ZAOe+nWPxUPyYwxgXdC+8eF74Q6lHbgZtzskNy88Dic2sY
         kioNr5rZW4Q8fGRc/ZMLYLqpALVbB1fkku40WpDH2l3dCunEP9QgNK/8UPzsN0x9E95i
         tIPMofLrQOYiOmiTIzeTc6TtvrLJMUJAepsxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=bxfe8IiF/EjqCMr+awBrgcGv9LZ0fBuj66hEuM3/NWGm/a/86CU8vx0ne3WkSDQisS
         454R6l9jYKN2kDNp+kn8hmVYL3hivwMJ0HCT5pzBlYpkQ8KPlTFqI0crkNGlTgZVAb/O
         n2vwalAfwGKRWX88Aw4JS6G7vg9dhK8Hbinz8=
Received: by 10.213.29.211 with SMTP id r19mr1165212ebc.119.1301849228020;
        Sun, 03 Apr 2011 09:47:08 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.47.07
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:47:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170726>

Gettextize messages that used the $* variable. Since it's subroutine
local we have to provide an alias for it for eval_gettext.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 06f00ae..afe7043 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -330,7 +330,10 @@ is_stash_like()
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
@@ -338,7 +341,10 @@ is_stash_ref() {
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
1.7.4.1
