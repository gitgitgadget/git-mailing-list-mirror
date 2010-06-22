From: Pascal Obry <pascal@obry.net>
Subject: [PATCH] Do not decode url protocol.
Date: Tue, 22 Jun 2010 11:22:47 +0200
Message-ID: <AANLkTin2WIBHAt3dK9NoYwSXR9ZVO_3mWdt-dsSIygvf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 22 11:22:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQzh0-0001id-Nh
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 11:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759102Ab0FVJWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jun 2010 05:22:50 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49092 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759092Ab0FVJWt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jun 2010 05:22:49 -0400
Received: by gye5 with SMTP id 5so2770129gye.19
        for <git@vger.kernel.org>; Tue, 22 Jun 2010 02:22:48 -0700 (PDT)
Received: by 10.101.106.10 with SMTP id i10mr4929500anm.99.1277198567264; Tue, 
	22 Jun 2010 02:22:47 -0700 (PDT)
Received: by 10.100.171.12 with HTTP; Tue, 22 Jun 2010 02:22:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149467>

When using the protocol git+ssh:// for example we do not want to
decode the '+' as a space.

This fixes a regression introduced in 9d2e942.
---
 url.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/url.c b/url.c
index cd32b92..ba0c1ac 100644
--- a/url.c
+++ b/url.c
@@ -70,9 +70,18 @@ static int url_decode_char(const char *q)
 static char *url_decode_internal(const char **query, const char *stop_at)
 {
 	const char *q = *query;
+	const char *first_slash;
 	struct strbuf out;

 	strbuf_init(&out, 16);
+
+	/* Skip protocol */
+	first_slash = strchr(*query, '/');
+
+	while (q < first_slash) {
+	  strbuf_addch(&out, *q++);
+	}
+
 	do {
 		unsigned char c = *q;

-- 
1.7.1.524.g6df2f


-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
