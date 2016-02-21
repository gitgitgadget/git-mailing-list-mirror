From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH 1/5] merge-recursive: find-renames resets threshold
Date: Sun, 21 Feb 2016 12:09:14 -0300
Message-ID: <1456067358-19781-2-git-send-email-felipegassis@gmail.com>
References: <1456067358-19781-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	sunshine@sunshineco.com,
	=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= 
	<felipegassis@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 21 19:07:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXYQ1-0005Xl-K9
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 19:07:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbcBUSHT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Feb 2016 13:07:19 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:33076 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbcBUSHS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 13:07:18 -0500
Received: by mail-qg0-f47.google.com with SMTP id b35so96902286qge.0
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 10:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tWmwcksilVuW5o7IPS+YBCrdfRLsgGOJxwGaCNx92YQ=;
        b=RJtI1JCPrAjBjKaS2SgkomLzUaWv9+7x7UduhkXSVxkzfwt8ijE6q8CuNnBirhWVTN
         rbDrDjHfcPPqo2q46HTy/w2qzhYYQBYxkzubU0xpOGIwdCZg2dJCn9NZx8m6xzQHwbIx
         TKBlPv/005cHF0z9c8213SyL030BsCgOxq5XpNiC0+EYwzdwxI3eavG4ssjsr534qKvK
         BVJgfj8bowyVdP9Hyn7YAD6wxkY92nSK4OF+jJg2iWZEJRQT/qbQ1eTe4+JvJ8Wmcijt
         uzZiTzzcU6/63VYN41nOAB8TJ0AVQOOOZuUq4e4sRk6VcPpYjwmClObEFYHKFbTS7/dM
         INWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=tWmwcksilVuW5o7IPS+YBCrdfRLsgGOJxwGaCNx92YQ=;
        b=DKXC0J1u46pC1koZoi2JL358+z2xPNeqYq75HEcXUxiLvUWYsVNtl9NdLo61/qxKv1
         was2VzlEjeSM9z2pyt8CE55SDu7DhaGXJ6mrvDUNlF0AMXKZXXpHCPxaQ+5KmFByJAR7
         jbispFS/dgSOuoWghZxeZGMzzDUMYT19b5HE7R7ZazMLZeydURWNWhIxgsx05iNbc41W
         pLVcAbcZGOZm8X3dZi4upiAXrINg9ctG8H14NqGiBlHrj2+TopEBAiipwuXzO7f+WSpa
         MkTOEAspWwLL1pltEL+8CpQQgCZxv94qbUlTvy0DEC/yAM1rrN9UIKa2iVG51fUvAVb4
         emVw==
X-Gm-Message-State: AG10YOQWI1Hdec3xdN6b2nQrv24wFHpJjDCY67iIndhHNllUke+g+St4h1QM3V1p/bvMDQ==
X-Received: by 10.140.27.174 with SMTP id 43mr28425893qgx.67.1456067468025;
        Sun, 21 Feb 2016 07:11:08 -0800 (PST)
Received: from traveller.moon ([177.94.146.172])
        by smtp.gmail.com with ESMTPSA id o203sm8467389qho.15.2016.02.21.07.11.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Feb 2016 07:11:07 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.492.gc9722f8
In-Reply-To: <1456067358-19781-1-git-send-email-felipegassis@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286819>

Make the find-renames option follow the behaviour in git-diff, where it
resets the threshold when none is given. So, for instance,
"--find-renames=3D25 --find-renames" should result in the default
threshold (50%) instead of 25%.

Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
---
 merge-recursive.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 7bff5be..b880ae5 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2094,8 +2094,10 @@ int parse_merge_opt(struct merge_options *o, con=
st char *s)
 		o->renormalize =3D 0;
 	else if (!strcmp(s, "no-renames"))
 		o->detect_rename =3D 0;
-	else if (!strcmp(s, "find-renames"))
+	else if (!strcmp(s, "find-renames")) {
 		o->detect_rename =3D 1;
+		o->rename_score =3D 0;
+	}
 	else if (skip_prefix(s, "find-renames=3D", &arg) ||
 		 skip_prefix(s, "rename-threshold=3D", &arg)) {
 		if ((o->rename_score =3D parse_rename_score(&arg)) =3D=3D -1 || *arg=
 !=3D 0)
--=20
2.7.1.492.gc9722f8
