From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 10/13] gettextize: git-checkout: our/their version message
Date: Wed,  1 Sep 2010 20:44:02 +0000
Message-ID: <1283373845-2022-11-git-send-email-avarab@gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 01 22:45:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OquBW-000790-B7
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 22:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755300Ab0IAUoz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 16:44:55 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:48595 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754122Ab0IAUoo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 16:44:44 -0400
Received: by mail-ew0-f46.google.com with SMTP id 23so4641990ewy.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 13:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=nD0zxmm6ROXac226wTVO2spfB7QcqAkAazQOIHLvAqU=;
        b=odDFIg9iD8suMdgojw/ZF0RS3TPIeyERtspfZVxlNjMFOOe3VpbtXEaP5gk7ZZuNI/
         eTWdGpLCtNPK0htDgemlHiWYLwFgYNBkN7hdj1pJrcb5OfT40UHjzeD7/mF1h8wnM/Ag
         Kn/91lwyJ9NC/ldqXJqo7N5W2KSprIZtcMQTI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xdGa2AwvKPlnGC0DsmziSeBHZGF7fTr1NQ5KBjAKTonJyPulMEKlnTNx+bt+Fjzul0
         qMkY1YK7RBk8sY3axEr9Jtg3fXMjBvDs2OinNMW1wnS+W9J0bZJGmYR9mQB1VU+49Suo
         QdyFPgNYDajeORbuJUIBNDfQoxVWlmFGwfioU=
Received: by 10.216.54.16 with SMTP id h16mr8410087wec.6.1283373882640;
        Wed, 01 Sep 2010 13:44:42 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm6461150weq.16.2010.09.01.13.44.41
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Sep 2010 13:44:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.579.g2183d
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155086>

Split up the "does not have our/their version" message to make it
easier to translate.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

I'm splitting this sort of thing into an if/else rather than:

    printf(foo ? _("bar") : _("blah"), ...)

because I think the alternative is harder to read.

 builtin/checkout.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 97bf2ec..a096e3d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -103,9 +103,10 @@ static int check_stage(int stage, struct cache_ent=
ry *ce, int pos)
 			return 0;
 		pos++;
 	}
-	return error("path '%s' does not have %s version",
-		     ce->name,
-		     (stage =3D=3D 2) ? "our" : "their");
+	if (stage =3D=3D 2)
+		return error(_("path '%s' does not have our version"), ce->name);
+	else
+		return error(_("path '%s' does not have their version"), ce->name);
 }
=20
 static int check_all_stages(struct cache_entry *ce, int pos)
@@ -130,9 +131,10 @@ static int checkout_stage(int stage, struct cache_=
entry *ce, int pos,
 			return checkout_entry(active_cache[pos], state, NULL);
 		pos++;
 	}
-	return error("path '%s' does not have %s version",
-		     ce->name,
-		     (stage =3D=3D 2) ? "our" : "their");
+	if (stage =3D=3D 2)
+		return error(_("path '%s' does not have our version"), ce->name);
+	else
+		return error(_("path '%s' does not have their version"), ce->name);
 }
=20
 static int checkout_merged(int pos, struct checkout *state)
--=20
1.7.2.2.579.g2183d
