From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 28/32] read-tree: force split-index mode off on --index-output
Date: Fri, 13 Jun 2014 19:19:47 +0700
Message-ID: <1402661991-14977-29-git-send-email-pclouds@gmail.com>
References: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 14:22:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvQVO-0004nV-MW
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 14:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595AbaFMMWq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 08:22:46 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:40067 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581AbaFMMWp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 08:22:45 -0400
Received: by mail-pd0-f180.google.com with SMTP id ft15so2088906pdb.11
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 05:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=T1LNg8MCFmUbsbQuanY03EtR2tEi2ElYYzP2/K8WlGQ=;
        b=xjSXZG47JBgh4S13On2sRrK1rYlz+Ej9K21uVbfG+x/z1c8s8YlbCqWE3wGUX10RHg
         Dqz4u7d/+N3ugNlWk5vrRDBOuLUhLxLYR6EvZjI2Q4sx7Zbr8D49ni0v8RebQuGXdzje
         HhYTRD4smNhIV4V+OOsyggC6jF+aeG4brwL6sG8lwsxSMCGt/q4so1ou1+k+rKcadnlQ
         OtNlnb1kBfK+jiIc0373EuQ4sayyCbE83P0AceVciKd0yv4jLdrLb1N3DsrH9ZxUDSfR
         LdlmtVYH/JXoVP8KT0yWWp4SAqW+0mJqSMoWbD02yh9+Xv1lqB4rfAVBw8pvotmdeqJY
         WPeg==
X-Received: by 10.68.197.8 with SMTP id iq8mr2951921pbc.124.1402662165167;
        Fri, 13 Jun 2014 05:22:45 -0700 (PDT)
Received: from lanh ([115.73.228.145])
        by mx.google.com with ESMTPSA id xy2sm20779594pab.16.2014.06.13.05.22.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jun 2014 05:22:44 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 13 Jun 2014 19:22:45 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251585>

Just a (paranoid?) safety measure..

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 read-cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index aa848e1..b1027f7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2070,7 +2070,8 @@ int write_locked_index(struct index_state *istate=
, struct lock_file *lock,
 {
 	struct split_index *si =3D istate->split_index;
=20
-	if (!si || (istate->cache_changed & ~EXTMASK)) {
+	if (!si || alternate_index_output ||
+	    (istate->cache_changed & ~EXTMASK)) {
 		if (si)
 			hashclr(si->base_sha1);
 		return do_write_locked_index(istate, lock, flags);
--=20
1.9.1.346.ga2b5940
