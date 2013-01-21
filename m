From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] grep: avoid accepting ambiguous revision
Date: Mon, 21 Jan 2013 20:00:49 +0700
Message-ID: <1358773249-24384-2-git-send-email-pclouds@gmail.com>
References: <1358773249-24384-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 21 14:01:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxGzj-0004N8-Dd
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 14:00:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371Ab3AUNAi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2013 08:00:38 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:55638 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037Ab3AUNAh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 08:00:37 -0500
Received: by mail-pb0-f51.google.com with SMTP id ro12so3330383pbb.10
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 05:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=yNLKG+UuCw4J2FsVAZPRWN3zOqeEejn4U6Co9drKlTA=;
        b=jZ4rMq0e0ejNv3VaAz9bFOt7pVOgg6lj9g/ZkJz0tLFxV7VkamdQYAPYgxUEBG+Gp8
         6dsBJplCmFO4MEdk2AOlyajQ4KVVkah4eytG6DLRNzcHnGe1L+LULSyJ02LtCrJQGaKg
         00h+ws+5/msLx0dOJOmulM4tBoA6TERKka0KY0AsJkSMk6VqITR9p+EPHPHjMJ6kJXL+
         w5DVW4GWicyHYLr7GfJWTwHBJzWiE2L1AIWE6Bi8l4/WuQWDS2ct1kFwpgMDnBhS4+so
         sa3fMOO/R06c0hLxCWl9EZuI6cgFyCmKs8uyYXZOXVNdI++YCxMWDpHjgcvQuNzuznU7
         zsjA==
X-Received: by 10.66.88.133 with SMTP id bg5mr47044431pab.21.1358773237291;
        Mon, 21 Jan 2013 05:00:37 -0800 (PST)
Received: from lanh ([115.74.55.178])
        by mx.google.com with ESMTPS id o6sm9248150paw.37.2013.01.21.05.00.34
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Jan 2013 05:00:36 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 21 Jan 2013 20:01:00 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358773249-24384-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214116>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/grep.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index 0e1b6c8..8025964 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -823,6 +823,8 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 			struct object *object =3D parse_object(sha1);
 			if (!object)
 				die(_("bad object %s"), arg);
+			if (!seen_dashdash)
+				verify_non_filename(prefix, arg);
 			add_object_array(object, arg, &list);
 			continue;
 		}
--=20
1.8.0.rc2.23.g1fb49df
