From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 2/6] compat/regex/regex_internal.c: reduce scope of variables
Date: Wed, 16 Apr 2014 02:33:27 -0700
Message-ID: <1397640811-17719-2-git-send-email-gitter.spiros@gmail.com>
References: <1397640811-17719-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 11:33:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaME4-00053C-94
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 11:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755023AbaDPJdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 05:33:46 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33032 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbaDPJdn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 05:33:43 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so10574634pab.8
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 02:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B+fsMZ73LhHwWF/qhqTlE3GvNYH9jJkRJ9t2g6/ZSRk=;
        b=PqIRnAFhO7rNPAevSa45oTk1YTcR8nKhg54qxhI9epfQ/lI0qJqwhjAbZrzwtd/A0y
         S55TONGFjZtsnfL8G2OJR5BW17XgEJIO9RakkEx2n9NL88dnXLbDB93cM9IOUEoXrAnP
         ir38APlmZflIJ6eUbmqpOdZpfj8JeqyZmS8tz45rzdQS+kpsnhUG/FATZUc9l+R2GU3B
         v2lViF4LWpOO8FLjX44Gnhwnd4nZn73Y80fcSb2NwxJKQ0IdBnKXcJBPkZX1tQmThVwm
         F4RnJy5Sn1evhdNTgjW1pwNFk/ie3pyrimJ0gPpMXhAonrHXmgA+zet26NtH0pMFa3/L
         2IVQ==
X-Received: by 10.66.146.105 with SMTP id tb9mr947953pab.157.1397640823138;
        Wed, 16 Apr 2014 02:33:43 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id de5sm45687493pbc.66.2014.04.16.02.33.42
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Apr 2014 02:33:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1397640811-17719-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246319>

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 compat/regex/regex_internal.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/compat/regex/regex_internal.c b/compat/regex/regex_internal.c
index d4121f2..a7a71ec 100644
--- a/compat/regex/regex_internal.c
+++ b/compat/regex/regex_internal.c
@@ -707,7 +707,6 @@ re_string_reconstruct (re_string_t *pstr, int idx, int eflags)
 #ifdef RE_ENABLE_I18N
 	  if (pstr->mb_cur_max > 1)
 	    {
-	      int wcs_idx;
 	      wint_t wc = WEOF;
 
 	      if (pstr->is_utf8)
@@ -738,11 +737,11 @@ re_string_reconstruct (re_string_t *pstr, int idx, int eflags)
 			  mbstate_t cur_state;
 			  wchar_t wc2;
 			  int mlen = raw + pstr->len - p;
-			  unsigned char buf[6];
 			  size_t mbclen;
 
 			  if (BE (pstr->trans != NULL, 0))
 			    {
+                              unsigned char buf[6];
 			      int i = mlen < 6 ? mlen : 6;
 			      while (--i >= 0)
 				buf[i] = pstr->trans[p[i]];
@@ -778,6 +777,7 @@ re_string_reconstruct (re_string_t *pstr, int idx, int eflags)
 					? CONTEXT_NEWLINE : 0));
 	      if (BE (pstr->valid_len, 0))
 		{
+                  int wcs_idx;
 		  for (wcs_idx = 0; wcs_idx < pstr->valid_len; ++wcs_idx)
 		    pstr->wcs[wcs_idx] = WEOF;
 		  if (pstr->mbs_allocated)
@@ -925,7 +925,6 @@ static unsigned int
 internal_function
 re_string_context_at (const re_string_t *input, int idx, int eflags)
 {
-  int c;
   if (BE (idx < 0, 0))
     /* In this case, we use the value stored in input->tip_context,
        since we can't know the character in input->mbs[-1] here.  */
@@ -957,6 +956,7 @@ re_string_context_at (const re_string_t *input, int idx, int eflags)
   else
 #endif
     {
+      int c;
       c = re_string_byte_at (input, idx);
       if (bitset_contain (input->word_char, c))
 	return CONTEXT_WORD;
-- 
1.7.10.4
