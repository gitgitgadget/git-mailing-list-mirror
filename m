From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] fixup! config: arbitrary number of matches for --unset and --replace-all
Date: Fri,  6 Dec 2013 10:46:42 -0800
Message-ID: <1386355602-21818-1-git-send-email-gitster@pobox.com>
References: <06ba1524cbe4fa31b6e1a8d644882521aeaff4f4.1384337608.git.tr@thomasrast.ch>
Cc: Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 06 19:47:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vp0QN-0006Mk-Rd
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 19:46:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758572Ab3LFSqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 13:46:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38701 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758262Ab3LFSqp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 13:46:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5F3C56D37;
	Fri,  6 Dec 2013 13:46:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=hGqg
	OE47mZ2xUGlB5OSu/12tDtY=; b=wCs9KQrmer6s0ujJdFMsJecaldNBDQFiUqMo
	1rZRCpA1bjM7hkKbI4pLcCGuQUKRkMr4xD7+lSCsk/IZ1k8fDSc6ItS52M92fcUO
	IVdkCatTxUShm+fpcyTc6valUujriadewRE+3vG3/ZSUkXNOyXtYngtzUz58U45k
	wG+ZW+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	DVPIzew+5KuPHAEZMLAxh1AqfQ/fLHDOpOv4GodH6sovSPGyM3G94oKlr6oHrVF3
	jk4cJjwcNRmAz0hLzcjGyAryi0RXDLJb+NmdeiE2luPJrw+7eLq2OicocacnXmTW
	MrSr16KW5ZYRLxLWfn6jFdevH4b0U1ZOuK0PJr+5PJk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B44AB56D36;
	Fri,  6 Dec 2013 13:46:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 01DA356D35;
	Fri,  6 Dec 2013 13:46:43 -0500 (EST)
X-Mailer: git-send-email 1.8.5.1-402-gdd8f092
In-Reply-To: <06ba1524cbe4fa31b6e1a8d644882521aeaff4f4.1384337608.git.tr@thomasrast.ch>
X-Pobox-Relay-ID: C09A7248-5EA6-11E3-B5D5-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238943>

---
 * I'll squash this to tr/config-multivalue-lift-max in preparation
   for merging it to 'master',which should happen by the end of
   this week.

   Thanks.

 config.c                |  8 ++++----
 t/t1303-wacky-config.sh | 14 +++++++-------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/config.c b/config.c
index 431dcb7..a1e80da 100644
--- a/config.c
+++ b/config.c
@@ -1192,7 +1192,7 @@ static int store_aux(const char *key, const char *value, void *cb)
 				warning("%s has multiple values", key);
 			}
 
-			ALLOC_GROW(store.offset, store.seen+1,
+			ALLOC_GROW(store.offset, store.seen + 1,
 				   store.offset_alloc);
 
 			store.offset[store.seen] = cf->do_ftell(cf);
@@ -1222,14 +1222,14 @@ static int store_aux(const char *key, const char *value, void *cb)
 		 * Do not increment matches: this is no match, but we
 		 * just made sure we are in the desired section.
 		 */
-		ALLOC_GROW(store.offset, store.seen+1,
+		ALLOC_GROW(store.offset, store.seen + 1,
 			   store.offset_alloc);
 		store.offset[store.seen] = cf->do_ftell(cf);
 		/* fallthru */
 	case SECTION_END_SEEN:
 	case START:
 		if (matches(key, value)) {
-			ALLOC_GROW(store.offset, store.seen+1,
+			ALLOC_GROW(store.offset, store.seen + 1,
 				   store.offset_alloc);
 			store.offset[store.seen] = cf->do_ftell(cf);
 			store.state = KEY_SEEN;
@@ -1239,7 +1239,7 @@ static int store_aux(const char *key, const char *value, void *cb)
 			      !strncmp(key, store.key, store.baselen)) {
 					store.state = SECTION_SEEN;
 					ALLOC_GROW(store.offset,
-						   store.seen+1,
+						   store.seen + 1,
 						   store.offset_alloc);
 					store.offset[store.seen] = cf->do_ftell(cf);
 			}
diff --git a/t/t1303-wacky-config.sh b/t/t1303-wacky-config.sh
index 7d55730..3a2c819 100755
--- a/t/t1303-wacky-config.sh
+++ b/t/t1303-wacky-config.sh
@@ -66,13 +66,13 @@ setup_many() {
 	# Semi-efficient way of concatenating 5^5 = 3125 lines. Note
 	# that because 'setup' already put one line, this means 3126
 	# entries for section.key in the config file.
-	cat >5to1 <<EOF
-  key = foo
-  key = foo
-  key = foo
-  key = foo
-  key = foo
-EOF
+	cat >5to1 <<-\EOF &&
+	  key = foo
+	  key = foo
+	  key = foo
+	  key = foo
+	  key = foo
+	EOF
 	cat 5to1 5to1 5to1 5to1 5to1 >5to2 &&	   # 25
 	cat 5to2 5to2 5to2 5to2 5to2 >5to3 &&	   # 125
 	cat 5to3 5to3 5to3 5to3 5to3 >5to4 &&	   # 635
-- 
1.8.5.1-402-gdd8f092
