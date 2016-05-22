From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] fetch: reduce ref column size when there are enough short ref names
Date: Sun, 22 May 2016 18:20:19 +0700
Message-ID: <20160522112019.26516-3-pclouds@gmail.com>
References: <20160522112019.26516-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 13:20:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4RR4-0003ru-9t
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 13:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbcEVLUg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2016 07:20:36 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35751 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366AbcEVLUe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 07:20:34 -0400
Received: by mail-pa0-f65.google.com with SMTP id rw9so15199958pab.2
        for <git@vger.kernel.org>; Sun, 22 May 2016 04:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LcjgQVltbnKZ+FRcV17otzmP3QswvwCj/aI1WB/BnzI=;
        b=KEogc33rsLYO/NReDUtTPmPBeH8nRrYbcjPUs9VmdUILEdI8PnXrECQM/REZsyB2jM
         xeHz9WTWuWWN8ygusbAt/64aizi0LGh1OSJYdPQPY2mR3fgw9Y1WE6sifVH9EFJ394Qc
         ZqI2R0Gb1uZ3PSSp3ANuqvZTJuh4h1G4LY1KLqf6YgIpKAdqUF5FWeHBoxy3ps6D2Blb
         bFkjqq8eJAMYUUn9Ytr6z+RpXhMYhaM27aZO+vu0uze9Eb9ZMuA358fCJDL+PD+qF/Cl
         6taSORrZqNE8Vf85ZwiqwXEzpc+1kYleEXOBttMM+rkZeLF6vDEsebaEJk2ppD9JXKT2
         AZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LcjgQVltbnKZ+FRcV17otzmP3QswvwCj/aI1WB/BnzI=;
        b=d1Osy2zKjvJcmxRD93IL67X5ZuptXL6db7hpSsxHeIiCdF0a2GvEgW+CAHqB7rR1fg
         OXnDJGKE9rw0Bb3WuuvZ/Xk8f5Er+A4ZXSITagSxLUBYxvkizQulXiiqloPTXkoBUZD9
         7r2Kbp8928iCv/BkXDpZPD6FqDduV4kyxvH07TDqNyrUFb8+ozkfPtzW/xP983g0GGvQ
         slemsupHTXud7dngmLWrK/YaObcgRLXyyt7MZS/kANnSTOejmXGwuseeB+31UaphVaxB
         h7RwVpw6vRxlbtSl2MWMp1dAvpqVQVhCDsjjLMQLRP4pt9Vlb0l4LUeVTJBymaONE0vV
         vlWQ==
X-Gm-Message-State: AOPr4FVcgG//AAwerkSiXK1+FLsNEpm75SlWyBE+cAQ98ngx2hZodjdIfRA9R6tPnMeNWA==
X-Received: by 10.66.119.177 with SMTP id kv17mr19142724pab.57.1463916034065;
        Sun, 22 May 2016 04:20:34 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id v75sm39119373pfa.94.2016.05.22.04.20.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 May 2016 04:20:33 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 22 May 2016 18:20:30 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160522112019.26516-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295283>

A flaw with the previous patch is, if there is a single long ref name,
the rest of the ref list will be aligned with the big column, wasting
lots of space (and potentially be wrapped around by the terminal, makin=
g
it even harder to read).

This patch tries to mitigate that. If there are five consecutive refs
whose name is at least ten chars shorter than column width, the width i=
s
reduced by ten. Five and ten are picked out of thin air. But the short
width reduction (instead of "REFCOL_WIDTH =3D len") is to avoid the col=
umn
width being reduced then grown back too much and too fast (imagine the
next ref is really short then the ref after that is super long).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 223e09b..ae2ff0c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -469,8 +469,20 @@ static int REFCOL_WIDTH =3D 10;
=20
 static void adjust_refcol_width(int len)
 {
+	static int reduce_width_count;
+
+	if (REFCOL_WIDTH > 10 && len < REFCOL_WIDTH - 10) {
+		reduce_width_count++;
+		if (reduce_width_count =3D=3D 5) {
+			REFCOL_WIDTH -=3D 10;
+			reduce_width_count =3D 0;
+		}
+	} else
+		reduce_width_count =3D 0;
+
 	if (REFCOL_WIDTH < len) {
 		REFCOL_WIDTH =3D len;
+		reduce_width_count =3D 0;
 	}
 }
=20
--=20
2.8.2.524.g6ff3d78
