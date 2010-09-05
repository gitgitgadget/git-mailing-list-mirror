From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [demo/PATCH 1/3] string-list: introduce string_list_init()
Date: Sun, 5 Sep 2010 15:04:30 -0500
Message-ID: <20100905200429.GB14497@burratino>
References: <1283709077-5438-1-git-send-email-tfransosi@gmail.com>
 <20100905200323.GA14497@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 22:06:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsLU3-0004BY-MV
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 22:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301Ab0IEUGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 16:06:31 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40106 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678Ab0IEUGa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 16:06:30 -0400
Received: by iwn5 with SMTP id 5so3526696iwn.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 13:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=SkFH9aiBi3t8/eUGHwEuAP/++nq0Ej+b83i87qVPMyg=;
        b=UAPrYo2PyMQnnHQqbPOmHzzYpMRZ0J3I6DQAmYbKp8/xMcGhENZqrFnL1Kx2IvCmTq
         jIu3/gZpdOZW450f5GGr+COPQYyIs/E/BUWC0h8C+NBb5j6h+XQ6svgIIPvL0Rp7aZH0
         VBQ7M8dBUnS71xEZe7Jtpaperc1U+2H854m1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jLbwUfoGS49WixaMa3GaGzkVaUeScbR7viPR6h07qfeRUQQ8yU2HpxwrVzABkyyFwP
         eRamQX+a9zYbU0vGnFtNWxDOz8m+qnSInlOz1vdKyEpHrR+SqeNOGrGQVkOWAASRY9yY
         606FTKiUw7BcgPyA3+otjQKohRgcgthqI6o9g=
Received: by 10.231.79.77 with SMTP id o13mr5035499ibk.36.1283717190345;
        Sun, 05 Sep 2010 13:06:30 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id h8sm4928027ibk.9.2010.09.05.13.06.29
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 05 Sep 2010 13:06:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100905200323.GA14497@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155480>

Instead of asking callers to

	memset(&list, 0, sizeof(list));
	list.strdup_strings = strdup_strings;

we can take care of that ourselves, providing the flexibility
to change the details of string_list layout later if wanted.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 string-list.c |    7 +++++++
 string-list.h |    1 +
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/string-list.c b/string-list.c
index 9b023a2..8e992a7 100644
--- a/string-list.c
+++ b/string-list.c
@@ -102,6 +102,13 @@ int for_each_string_list(struct string_list *list,
 	return ret;
 }
 
+void string_list_init(struct string_list *list, int strdup_strings)
+{
+	list->items = NULL;
+	list->nr = list->alloc = 0;
+	list->strdup_strings = strdup_strings ? 1 : 0;
+}
+
 void string_list_clear(struct string_list *list, int free_util)
 {
 	if (list->items) {
diff --git a/string-list.h b/string-list.h
index 4946938..07e075c 100644
--- a/string-list.h
+++ b/string-list.h
@@ -15,6 +15,7 @@ struct string_list
 #define STRING_LIST_INIT_NODUP { NULL, 0, 0, 0 }
 #define STRING_LIST_INIT_DUP   { NULL, 0, 0, 1 }
 
+void string_list_init(struct string_list *list, int strdup_strings);
 void print_string_list(const struct string_list *p, const char *text);
 void string_list_clear(struct string_list *list, int free_util);
 
-- 
1.7.2.3
