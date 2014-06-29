From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH v2 2/2] sha1_file: use strncmp for string comparison
Date: Sun, 29 Jun 2014 07:56:25 +0200
Message-ID: <53AFAA89.6050200@web.de>
References: <53AED59B.1020209@web.de> <CACsJy8B_DAjLRcMe4ys2LGkLOcKuW-PL_WNHyFB8Ry3Uv38LCw@mail.gmail.com> <53AFA775.1090900@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 07:57:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X187I-0008DR-Oy
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jun 2014 07:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbaF2F52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2014 01:57:28 -0400
Received: from mout.web.de ([212.227.17.11]:55607 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926AbaF2F51 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2014 01:57:27 -0400
Received: from [192.168.178.27] ([79.250.179.75]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MNcIg-1X2mnl1Tdy-007GVX; Sun, 29 Jun 2014 07:57:11
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53AFA775.1090900@web.de>
X-Provags-ID: V03:K0:ebP51DJ8rVp3EOvSPjEgCWYyrLxXJwLwHAU2I7/9lfKqG0qu0p7
 sDdT1zAXlhCzjeqgluYsdsrPTMEfqo1f10ZaLuQsqm8S8SLuocyFX0yDavJgfp6lKVwD/CR
 UHCaYlED9ad+mQQt7o5y+dvFBBVIRFDA+STDe7duGsO/WVLBpfWQt6RMI7q3HYunpYsTfux
 wF639Ig6gpSZyAONMp3Pg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252629>

Avoid overrunning the existing pack name (p->pack_name, a C string) in
the case that the new path is longer by using strncmp instead of memcmp
for comparing.  While at it, replace the magic constant 4 with a
strlen call to document its meaning.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
No changes from intial round.

 sha1_file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index 394fa45..8adab14 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1207,7 +1207,8 @@ static void prepare_packed_git_one(char *objdir, int local)
 		if (has_extension(de->d_name, ".idx")) {
 			/* Don't reopen a pack we already have. */
 			for (p = packed_git; p; p = p->next) {
-				if (!memcmp(path.buf, p->pack_name, path.len - 4))
+				if (!strncmp(path.buf, p->pack_name,
+					     path.len - strlen(".idx")))
 					break;
 			}
 			if (p == NULL &&
-- 
2.0.0
