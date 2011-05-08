From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 34/48] i18n: git-stash die + eval_gettext $* messages
Date: Sun,  8 May 2011 12:21:06 +0000
Message-ID: <1304857280-14773-35-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:23:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ31N-0004a3-Fe
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116Ab1EHMXT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:23:19 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37472 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894Ab1EHMWF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:22:05 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1325598eyx.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=w4xon0xOMz0BzrE+UoUgt6KBwvObUiwRvsyqzrRHffE=;
        b=R/TKVy5fyON5sz82tfKMDnBghmdYalnq4Ht0PcD1xuFjtP5QvF1uDu/WUGUGuDCRTr
         W10vH5C0xs9ZxO9PMMwbRz6MXFSaKJ8oZMn6LBo6Z28DDN8y708hzWbx7ffW6XxZJtY+
         3PEfvl5rEkXi0PadR9pQnstSkk1wORRhFGj0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=lGi9LAx1qqa3H/AsKWg8kGxqZ46Gch+nZdoCMvWFq8fAyP4uANELxmzJZadiGyCDPt
         h8eqsLkaAVwfHEoK2MeTZeI0W1gS75bVJTVXnTHfku/FIdMTzvOEI8O2i05mFGSkSFWM
         +5f+mFAgfgMqd6x4rtH2+aH5TerDUXCDYlsVc=
Received: by 10.14.51.4 with SMTP id a4mr2872717eec.82.1304857324801;
        Sun, 08 May 2011 05:22:04 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.22.04
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:22:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173141>

Gettextize messages that used the $* variable. Since it's subroutine
local we have to provide an alias for it for eval_gettext.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 8388f78..e5e9590 100755
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
1.7.4.4
