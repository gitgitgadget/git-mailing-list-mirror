From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 35/48] i18n: git-stash die + eval_gettext $1 messages
Date: Sun,  8 May 2011 12:21:07 +0000
Message-ID: <1304857280-14773-36-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:23:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ30r-0004Hv-7u
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754034Ab1EHMWZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:22:25 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48739 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753909Ab1EHMWG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:22:06 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1325631eyx.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=gA+1WJn5YMHFymXpgNIR+xgcoloqSKECn5JJdirmAKc=;
        b=MvtVdocqym9D9QEshwHTYQ4x4cVANr8q31Kmfca07oMGg9G170ww4MV95k7aVnROY7
         r2DtdD46YrquohzkEJsyI4Eca7703hk1fqC7QX0u8KXl6iBKqCajBso79M1ku+rbMFzv
         EpF5JcJ664MUpNsluqq0/4HMLZQ3u2z9WXHVM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=M+C/VgSMX/jgkX5u9H78W8GsctK4Cvp9Czykj1SSwfA1I/F8oP+Z1sPc3xtW0j7ehn
         3xIzDzw/W2wNTYgrj7+MuVy94PwM6WZDtfZE5EggX69YdEqHE/qCUYv/e7rshU79Pp3C
         bH3f7GnfNRZKBEsrRrswfTnQJR2onTNsUC/BQ=
Received: by 10.14.52.80 with SMTP id d56mr2759853eec.161.1304857325869;
        Sun, 08 May 2011 05:22:05 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.22.04
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:22:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173129>

Gettextize a messages that used the $1 variable. Since it's subroutine
local we have to provide an alias for it for eval_gettext.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index e5e9590..bf4868a 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -299,7 +299,10 @@ parse_flags_and_rev()
 		;;
 	esac
=20
-	REV=3D$(git rev-parse --quiet --symbolic --verify $1 2>/dev/null) || =
die "$1 is not valid reference"
+	REV=3D$(git rev-parse --quiet --symbolic --verify $1 2>/dev/null) || =
{
+		reference=3D"$1"
+		die "$(eval_gettext "\$reference is not valid reference")"
+	}
=20
 	i_commit=3D$(git rev-parse --quiet --verify $REV^2 2>/dev/null) &&
 	set -- $(git rev-parse $REV $REV^1 $REV: $REV^1: $REV^2: 2>/dev/null)=
 &&
--=20
1.7.4.4
