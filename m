From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 06/20] gettextize: git-stash die + eval_gettext $* messages
Date: Tue, 14 Sep 2010 13:52:06 +0000
Message-ID: <1284472340-7049-7-git-send-email-avarab@gmail.com>
References: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 15:53:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvVwn-0004Ln-Dq
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 15:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947Ab0INNw6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 09:52:58 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48443 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816Ab0INNw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 09:52:57 -0400
Received: by mail-ww0-f44.google.com with SMTP id 20so136386wwd.1
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 06:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=cmRxs1dFzO/HM9ShGFx7augWM5OKRXLFlYoBTWkFpGM=;
        b=RImIMupBShTIgaxTH0wjxk65cc5EEgO5HeD8dFzJuavoLkNlBgRbO58tdLcMRh65YB
         PEg6Xks3CsapsLcDhnhFD0VcJ6ComijLYVOA4l3iAAY792JhvgMXQngZGpbHjrMUUDCK
         Hhw3B4X5H8e/RBijmwz/ZMja+hienZgDCmejc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=QrLKYufHSvEvjAyS5xggZ8V7NbaKXI/UYpRyxzkzYBZ2unfcH6nqtLsYm6fNp8cBoU
         Qi9aa2acnoRrEOKFB2BlYtSq7eA2ogfT/Jp7wUUp43d/qS7NBEW+FKWouahqQYVxBqvS
         zvTZ0UkbpMzNwDCyjHapEhJjjjv5ONUroi41U=
Received: by 10.227.141.132 with SMTP id m4mr795979wbu.65.1284472376440;
        Tue, 14 Sep 2010 06:52:56 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm158854weq.16.2010.09.14.06.52.54
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 14 Sep 2010 06:52:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.234.g8dc15
In-Reply-To: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156177>

Gettextize messages that used the $* variable. Since it's subroutine
local we have to provide an alias for it for eval_gettext.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 38720b8..f3ea9e8 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -337,7 +337,10 @@ is_stash_like()
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
@@ -345,7 +348,10 @@ is_stash_ref() {
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
1.7.3.rc1.234.g8dc15
