From: David Turner <dturner@twopensource.com>
Subject: [PATCH 24/43] refs.h: document make refname_is_safe and add it to header
Date: Wed,  2 Sep 2015 21:54:54 -0400
Message-ID: <1441245313-11907-25-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	David Turner <dturner@twitter.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:56:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJl7-0006Q5-4x
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbbICB4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:56:09 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34982 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932194AbbICBz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:55:59 -0400
Received: by qkcj187 with SMTP id j187so15700989qkc.2
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A1LsMRn9YSwXUlHeyFsZwnN/XADm1KMVJ6jtNQga980=;
        b=a9MFT4mv4ihTfjDXqVxEL67L/JkIg9FX1rYCHlRK8xXJGzyXr4vgOtSE14PUu8fiGM
         KSF2DqW+5Z65vvVStr1t2Z8a+XGr0UXsbmZjLVMkLuvqq/KSoYKj2YZo4barl7lJjHjC
         neavhBumYOvZmXq45Trf/igVUUW/eSn3mgB9sZdyerUunsdmSg2d1udkvwVF+COOnsld
         Zx4E7vrrqy1Kh8IAqNwnEPnyr5Bsy9qXAfe5TPtZPoWFxrpDk6bQzkN90zE1B2EjOGRP
         vzks6cbZYKChwGN5HRiUJJXILZ3dLhYx87Xxkk9R+KAC/SzlfRPOlNxDCoy2xQHqkJHL
         U50A==
X-Gm-Message-State: ALoCoQkiZWIYgYoj8jYclwUGYWHRlA6B1Fel0kUQIBEwNhSZR9eEGG2qR9hZzwgcfaNN5+9kkZb6
X-Received: by 10.55.33.74 with SMTP id h71mr34526503qkh.71.1441245359326;
        Wed, 02 Sep 2015 18:55:59 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.55.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:55:58 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277149>

This function might be used by other refs backends

Signed-off-by: David Turner <dturner@twitter.com>
---
 refs.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/refs.h b/refs.h
index 5542587..359e166 100644
--- a/refs.h
+++ b/refs.h
@@ -259,6 +259,17 @@ int verify_refname_available(const char *newname, struct string_list *extra,
 			     struct string_list *skip, struct strbuf *err);
 
 /*
+ * Check if a refname is safe.
+ * For refs that start with "refs/" we consider it safe as long they do
+ * not try to resolve to outside of refs/.
+ *
+ * For all other refs we only consider them safe iff they only contain
+ * upper case characters and '_' (like "HEAD" AND "MERGE_HEAD", and not like
+ * "config").
+ */
+int refname_is_safe(const char *refname);
+
+/*
  * Flags controlling ref_transaction_update(), ref_transaction_create(), etc.
  * REF_NODEREF: act on the ref directly, instead of dereferencing
  *              symbolic references.
-- 
2.0.4.315.gad8727a-twtrsrc
