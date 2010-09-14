From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 07/20] gettextize: git-stash die + eval_gettext $1 messages
Date: Tue, 14 Sep 2010 13:52:07 +0000
Message-ID: <1284472340-7049-8-git-send-email-avarab@gmail.com>
References: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 15:53:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvVwn-0004Ln-W5
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 15:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015Ab0INNxD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 09:53:03 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48443 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984Ab0INNxA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 09:53:00 -0400
Received: by mail-ww0-f44.google.com with SMTP id 20so136386wwd.1
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 06:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=nTjoutDVPksxA3z/3tFc9N+sKLBpFNVzyjtzb2t9YXg=;
        b=P1uycybmhNQEfh3O11hBmN0vNm+QPFoeQ/y8t1nYnBnMIp7Hhrc/5Ql9L3PkAPEZ7E
         qjPs/mvlF3c+SXaesQ7lzzWjp3fIOp2FkSi9ZvHGSbN24nK1jsH1xa3jMSVmitjR3zZf
         bb7yGqDJ+urwchOIp6GNtYPshCV2MLC2IyMrc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XgVQ0V8iWheN+Yig/RE7OTEdXgOrNv2w2O7dEtBZmhG0CMv3dc5E0yDnxcY+q/zAsz
         4vlg3YpykcoUlplCEhLuCSphSeyuI6OF9tdwdqRdnyFTDweptdG/KFcMzNrtn5TVxH3j
         nRjYCT7ZCaNSL8E2lu6evCPqHj+ff+BAf1idE=
Received: by 10.227.29.91 with SMTP id p27mr3308217wbc.67.1284472380345;
        Tue, 14 Sep 2010 06:53:00 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm158854weq.16.2010.09.14.06.52.57
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 14 Sep 2010 06:52:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.234.g8dc15
In-Reply-To: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156179>

Gettextize a messages that used the $1 variable. Since it's subroutine
local we have to provide an alias for it for eval_gettext.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index f3ea9e8..7c005d3 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -305,7 +305,10 @@ parse_flags_and_rev()
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
1.7.3.rc1.234.g8dc15
