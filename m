From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 18/20] gettextize: git-bisect bisect_replay + $1 messages
Date: Tue, 14 Sep 2010 13:52:18 +0000
Message-ID: <1284472340-7049-19-git-send-email-avarab@gmail.com>
References: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 15:54:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvVxW-0004ig-Up
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 15:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545Ab0INNyA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 09:54:00 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48443 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327Ab0INNx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 09:53:59 -0400
Received: by mail-ww0-f44.google.com with SMTP id 20so136386wwd.1
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 06:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=4Kt/br7mrh4P3nXH2CFJT8ELR5ttPGhPMa8d5JYe2hk=;
        b=RJdA5l46OiXFlEX2ktM+cF+xHnmuVQNSaaOy17kYAYsfr6GDxqYzte5R4rJVELBxN1
         naxMpBsXMFxLk3CTXKjmqHkvdZLJgmA4oNo+2bT2KXDd/Z+q7ry1dWk9iiq5pyuqATPp
         NS2RcDNg2ya9yNdRDsM41AtCTjmhnUZbZoK1w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=P9NweXbPhxng7+D41AZdNyXhHib1mkIrFbhyZrl2PcUzMEQkhDjJveWHyoXZpJs8m2
         FP7sjOTxSfHhQBmWuWWib4dmbrjnbBrf4n526/QWpjiQHd0AcnFjayztxfZh00i19vF5
         Zne7CQkGlhwF56+IZ1CFKXprzHHnunx2Ht2cg=
Received: by 10.227.135.141 with SMTP id n13mr248289wbt.97.1284472439213;
        Tue, 14 Sep 2010 06:53:59 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm158854weq.16.2010.09.14.06.53.51
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 14 Sep 2010 06:53:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.234.g8dc15
In-Reply-To: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156185>

Gettextize bisect_replay messages that use the $1 variable. Since it's
subroutine local we have to provide an alias for it for eval_gettext.

Since I was doing that anyway I've changed all other uses of $1
variable to use the alias variable for clarity.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 64c6b81..f3162d6 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -341,7 +341,8 @@ bisect_clean_state() {
 }
=20
 bisect_replay () {
-	test -r "$1" || die "cannot read $1 for replaying"
+	file=3D"$1"
+	test -r "$file" || die "$(eval_gettext "cannot read \$file for replay=
ing")"
 	bisect_reset
 	while read git bisect command rev
 	do
@@ -359,7 +360,7 @@ bisect_replay () {
 		*)
 			die "$(gettext "?? what are you talking about?")" ;;
 		esac
-	done <"$1"
+	done <"$file"
 	bisect_auto_next
 }
=20
--=20
1.7.3.rc1.234.g8dc15
