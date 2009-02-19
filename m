From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 2/4] remote: move append_ref_to_tracked_list to get rid of prototype
Date: Thu, 19 Feb 2009 00:14:29 -0500
Message-ID: <1235020471-59982-3-git-send-email-jaysoffian@gmail.com>
References: <1235020471-59982-1-git-send-email-jaysoffian@gmail.com>
 <1235020471-59982-2-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 06:16:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La1Gk-0005K5-L3
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 06:16:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbZBSFOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 00:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbZBSFOm
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 00:14:42 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:33483 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbZBSFOk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 00:14:40 -0500
Received: by yw-out-2324.google.com with SMTP id 5so102398ywh.1
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 21:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=y05YbgKRjE3vraqJrfoErksQtw6862OdTOR60TduhrA=;
        b=YOpq8P3M8WBRZab5en/6e6Sttpjxe9zXtft0hhnKl0r0cOtwbOdEr5wA55sfJf6E26
         gaP8ZgbSuCz0MNGD8RMOQwqQWGvOtN2qIv+QavtDbX5W3G4TXq/e6iDKMTWnMXJ2PJ3g
         PKUD027k0UIyuswCEE5dSVoMrK485gNsxGpzA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=FibgvGODtPcuNdgppKGWszg32XQ75nhWP6uA6nZHcwOEBOt+A8aN+0UoSKHoUD1Bv5
         UCXdG4u+UnT8RqDcZcXT88AeOyE+jTQbN3mjGw9ISM9IFA1MaFkSHRMRGvpTFrGQDqNh
         /KzcEZeglrsV0zeyUo4VBokuKU93el3AMuwmU=
Received: by 10.150.192.4 with SMTP id p4mr607768ybf.108.1235020478728;
        Wed, 18 Feb 2009 21:14:38 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id o29sm1960203elf.9.2009.02.18.21.14.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Feb 2009 21:14:38 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.218.g1b4fab
In-Reply-To: <1235020471-59982-2-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110623>

Relocate the append_ref_to_tracked_list() function above all its callers
so that we can get rid of the prototype.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
Doing this as a separate patch makes the prior patch easier to review,
but I think it could be squashed when you apply the series.

 builtin-remote.c |   37 +++++++++++++++++--------------------
 1 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index ea5e808..b61f754 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -23,9 +23,6 @@ static int verbose;
 
 static int show_all(void);
 
-static int append_ref_to_tracked_list(const char *refname,
-	const unsigned char *sha1, int flags, void *cb_data);
-
 static inline int postfixcmp(const char *string, const char *postfix)
 {
 	int len1 = strlen(string), len2 = strlen(postfix);
@@ -659,6 +656,23 @@ static void free_remote_ref_states(struct ref_states *states)
 	string_list_clear(&states->heads, 0);
 }
 
+static int append_ref_to_tracked_list(const char *refname,
+	const unsigned char *sha1, int flags, void *cb_data)
+{
+	struct ref_states *states = cb_data;
+	struct refspec refspec;
+
+	if (flags & REF_ISSYMREF)
+		return 0;
+
+	memset(&refspec, 0, sizeof(refspec));
+	refspec.dst = (char *)refname;
+	if (!remote_find_tracking(states->remote, &refspec))
+		string_list_append(abbrev_branch(refspec.src), &states->tracked);
+
+	return 0;
+}
+
 static int get_remote_ref_states(const char *name,
 				 struct ref_states *states,
 				 int query)
@@ -688,23 +702,6 @@ static int get_remote_ref_states(const char *name,
 	return 0;
 }
 
-static int append_ref_to_tracked_list(const char *refname,
-	const unsigned char *sha1, int flags, void *cb_data)
-{
-	struct ref_states *states = cb_data;
-	struct refspec refspec;
-
-	if (flags & REF_ISSYMREF)
-		return 0;
-
-	memset(&refspec, 0, sizeof(refspec));
-	refspec.dst = (char *)refname;
-	if (!remote_find_tracking(states->remote, &refspec))
-		string_list_append(abbrev_branch(refspec.src), &states->tracked);
-
-	return 0;
-}
-
 static int show(int argc, const char **argv)
 {
 	int no_query = 0, result = 0;
-- 
1.6.2.rc1.218.g1b4fab
