From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 3/4] string-list: add for_each_string_list()
Date: Thu, 19 Feb 2009 00:14:30 -0500
Message-ID: <1235020471-59982-4-git-send-email-jaysoffian@gmail.com>
References: <1235020471-59982-1-git-send-email-jaysoffian@gmail.com>
 <1235020471-59982-2-git-send-email-jaysoffian@gmail.com>
 <1235020471-59982-3-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 06:16:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La1Gl-0005K5-Bz
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 06:16:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbZBSFOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 00:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbZBSFOo
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 00:14:44 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:33483 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbZBSFOl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 00:14:41 -0500
Received: by yw-out-2324.google.com with SMTP id 5so102398ywh.1
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 21:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=dnqUjZJDUNW/jljunTIBXp52itSxapCRA81TJvvOCAo=;
        b=FFQ/lsdAfgF/I/ZxoeYP+W69xgro5LZRWgRDnPIKjFr79VVMyqMPBalXFoVZ9iak/A
         jb5AEeYIqzBpQZNClF7CSv+eK+ibiP3txW4KQ8YdTCzqv5jUQrl9PnqbjmPaR76GATrc
         3JN/7lnfOsNIs3MQ0buuMwA6o2INjufBaGTAI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=j6BiEIHWtwJaQJqDyQtl1GWoM7ps5RDf1hXi2gMWSU4Ld+3OQSdQvJT/xg9ISmmUhb
         5C+2xYjLq7CTbH9K0bqXDHDbuY6Ke0UoLB5JZ1zEiYJucWHsfRR7ptNXsnMHyK2DbH7R
         RcXNJYE8aPnmKwA9XGHLpFOhtcBxxEtf2VdKs=
Received: by 10.150.143.5 with SMTP id q5mr619960ybd.41.1235020481084;
        Wed, 18 Feb 2009 21:14:41 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id e27sm1979223elf.7.2009.02.18.21.14.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Feb 2009 21:14:40 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.218.g1b4fab
In-Reply-To: <1235020471-59982-3-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110624>

Give string-list a convenience function for iterating over each of the
items in a string_list.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 string-list.c |   10 ++++++++++
 string-list.h |    5 +++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/string-list.c b/string-list.c
index 15e14cf..1ac536e 100644
--- a/string-list.c
+++ b/string-list.c
@@ -92,6 +92,16 @@ struct string_list_item *string_list_lookup(const char *string, struct string_li
 	return list->items + i;
 }
 
+int for_each_string_list(string_list_each_func_t fn,
+			 struct string_list *list, void *cb_data)
+{
+	int i, ret = 0;
+	for (i = 0; i < list->nr; i++)
+		if ((ret = fn(&list->items[i], cb_data)))
+			break;
+	return ret;
+}
+
 void string_list_clear(struct string_list *list, int free_util)
 {
 	if (list->items) {
diff --git a/string-list.h b/string-list.h
index d32ba05..14bbc47 100644
--- a/string-list.h
+++ b/string-list.h
@@ -20,6 +20,11 @@ void string_list_clear(struct string_list *list, int free_util);
 typedef void (*string_list_clear_func_t)(void *p, const char *str);
 void string_list_clear_func(struct string_list *list, string_list_clear_func_t clearfunc);
 
+/* Use this function to iterate over each item */
+typedef int (*string_list_each_func_t)(struct string_list_item *, void *);
+int for_each_string_list(string_list_each_func_t,
+			 struct string_list *list, void *cb_data);
+
 /* Use these functions only on sorted lists: */
 int string_list_has_string(const struct string_list *list, const char *string);
 int string_list_find_insert_index(const struct string_list *list, const char *string,
-- 
1.6.2.rc1.218.g1b4fab
