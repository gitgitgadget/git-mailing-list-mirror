From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 16/20] gettextize: git-bisect bisect_run + $@ messages
Date: Tue, 14 Sep 2010 13:52:16 +0000
Message-ID: <1284472340-7049-17-git-send-email-avarab@gmail.com>
References: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 16:02:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvW5N-0002SH-PJ
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 16:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800Ab0INOCE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 10:02:04 -0400
Received: from mail-wy0-f180.google.com ([74.125.82.180]:48304 "EHLO
	mail-wy0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356Ab0INOCD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 10:02:03 -0400
Received: by wyb40 with SMTP id 40so9228774wyb.11
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 07:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=zK97+411YC8VUAEc9xZazlp++6pALrBcfUsyKvJ8cFA=;
        b=KAJ5EoMK//YJvLafAMF//+B274apY1X8Fqsq4mJA8eFA3uNE4ApM7ZD0Omrb/9PGlp
         06I2pOJgWVz0S4AIxPZYZhnPJod8FdbuGHycY0Svc3ocMYqkO6s0G8K0SRf0oaGYgAs5
         lXsSjV6q0E/dZFyJoH8018he/5buapjkQim4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=GhjUTFQy/tEQzGFfdKLp568SDNxNdSIbfv/KjTa8cSYSCcqqJJ/fq3nWFJj3mWSRKL
         gh8q6K9iMjbbh2p8BmOpuObqJjn8r4Ma9cRmBQkA1TOIgs3TuOaErLM0uLdARIZnh2Ef
         VQ7T6w2A6wqmxbDbKodbQo+TGCHyg26zH/LqI=
Received: by 10.216.5.21 with SMTP id 21mr3994570wek.20.1284472425723;
        Tue, 14 Sep 2010 06:53:45 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm158854weq.16.2010.09.14.06.53.39
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 14 Sep 2010 06:53:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.234.g8dc15
In-Reply-To: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156192>

Gettextize bisect_run messages that use the $@ variable. Since it's
subroutine local we have to provide an alias for it for eval_gettext.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index f715e84..3b10ce6 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -366,14 +366,15 @@ bisect_run () {
=20
     while true
     do
-      echo "running $@"
+      command=3D"$@"
+      eval_gettext "running \$command"; echo
       "$@"
       res=3D$?
=20
       # Check for really bad run error.
       if [ $res -lt 0 -o $res -ge 128 ]; then
-	  echo >&2 "bisect run failed:"
-	  echo >&2 "exit code $res from '$@' is < 0 or >=3D 128"
+	  echo >&2 "$(eval_gettext "bisect run failed:
+exit code \$res from '\$command' is < 0 or >=3D 128")"
 	  exit $res
       fi
=20
--=20
1.7.3.rc1.234.g8dc15
