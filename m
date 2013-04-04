From: Simon Ruderich <simon@ruderich.org>
Subject: [PATCH 2/2] diffcore-pickaxe: fill_one() doesn't modify textconv
Date: Thu, 4 Apr 2013 18:05:58 +0200
Message-ID: <20130404160557.GB25232@ruderich.org>
References: <472ae7e08eedfef5886d0ace935654876091447d.1365090893.git.simon@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 18:06:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNmgO-0007Qh-S0
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 18:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762863Ab3DDQGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 12:06:01 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:43472 "EHLO
	zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762531Ab3DDQF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 12:05:59 -0400
Received: from localhost (pD9E97AF7.dip.t-dialin.net [::ffff:217.233.122.247])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by zucker.schokokeks.org with ESMTPSA; Thu, 04 Apr 2013 18:05:58 +0200
  id 0000000000000048.00000000515DA4E6.00005E1A
Content-Disposition: inline
In-Reply-To: <472ae7e08eedfef5886d0ace935654876091447d.1365090893.git.simon@ruderich.org>
User-Agent: Mutt/1.5.21 (2013-03-19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220027>

Signed-off-by: Simon Ruderich <simon@ruderich.org>
---
 diffcore-pickaxe.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index f814a52..c378ea0 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -75,10 +75,10 @@ static void diffgrep_consume(void *priv, char *line, unsigned long len)
 }
 
 static void fill_one(struct diff_filespec *one,
-		     mmfile_t *mf, struct userdiff_driver **textconv)
+		     mmfile_t *mf, struct userdiff_driver *textconv)
 {
 	if (DIFF_FILE_VALID(one)) {
-		mf->size = fill_textconv(*textconv, one, &mf->ptr);
+		mf->size = fill_textconv(textconv, one, &mf->ptr);
 	} else {
 		memset(mf, 0, sizeof(*mf));
 	}
@@ -101,8 +101,8 @@ static int diff_grep(struct diff_filepair *p, struct diff_options *o,
 		textconv_two = get_textconv(p->two);
 	}
 
-	fill_one(p->one, &mf1, &textconv_one);
-	fill_one(p->two, &mf2, &textconv_two);
+	fill_one(p->one, &mf1, textconv_one);
+	fill_one(p->two, &mf2, textconv_two);
 
 	if (!mf1.ptr) {
 		if (!mf2.ptr)
@@ -228,8 +228,8 @@ static int has_changes(struct diff_filepair *p, struct diff_options *o,
 	if (textconv_one == textconv_two && diff_unmodified_pair(p))
 		return 0;
 
-	fill_one(p->one, &mf1, &textconv_one);
-	fill_one(p->two, &mf2, &textconv_two);
+	fill_one(p->one, &mf1, textconv_one);
+	fill_one(p->two, &mf2, textconv_two);
 
 	if (!mf1.ptr) {
 		if (!mf2.ptr)
-- 
1.8.2

-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
