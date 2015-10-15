From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 02/26] refs: make repack_without_refs and is_branch public
Date: Thu, 15 Oct 2015 15:46:26 -0400
Message-ID: <1444938410-2345-3-git-send-email-dturner@twopensource.com>
References: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Oct 15 21:47:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmoUe-0006eM-O0
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 21:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315AbbJOTrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 15:47:09 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35549 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbbJOTrH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 15:47:07 -0400
Received: by qkap81 with SMTP id p81so44898262qka.2
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 12:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hMmK8B80aKgJbDVEfr7htq64QMKTgHy6AmiYBMyDNZI=;
        b=cZgbcus2uUVNlhRs7YlJXidbztuctHG1wRg+S3Xfzq5f9cJij7Ty2mny9Nmml8Flnl
         fBfnTI0kdZRttIQZ8hVBEVnD7BIsnh2OHwVxa2enufU5XlO5/c7DgaLNWpfsTIJXFsuy
         y4jIJUwFpsUJcYPpF96rSFzWuoinTyQItGGuylnjVPPGMA04iTWMGl8J1JjqSoo1+GQd
         x4SZYGWUX0L5fUdAK6Bonx1YQoIfP1Vn4FkQ0RffJsN0rHBw7nN1y4w2zGRIiE75jMmz
         ur1GHwRFxCvwuLn9zyI1pjfSceVDsONybterQhB2Oy6XNImQQZp7ceUpH8Oi1G78wbF+
         ASwQ==
X-Gm-Message-State: ALoCoQmVNS4R1e1XUL0m6uO5ksjkljLekiHVxVrnjh3qlj2N/xbnUrSVqo6a+qUcrxXUQtCuQdb3
X-Received: by 10.55.27.28 with SMTP id b28mr14224318qkb.48.1444938426738;
        Thu, 15 Oct 2015 12:47:06 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p193sm6054142qha.29.2015.10.15.12.47.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Oct 2015 12:47:05 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279683>

is_branch was already non-static, but this patch declares it in the
header.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c | 5 +++--
 refs.h | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index fe71ea0..84abc82 100644
--- a/refs.c
+++ b/refs.c
@@ -2816,8 +2816,9 @@ int pack_refs(unsigned int flags)
 
 /*
  * Rewrite the packed-refs file, omitting any refs listed in
- * 'refnames'. On error, leave packed-refs unchanged, write an error
- * message to 'err', and return a nonzero value.
+ * 'refnames'. On error, packed-refs will be unchanged, the return
+ * value is nonzero, and a message about the error is written to the
+ * 'err' strbuf.
  *
  * The refs in 'refnames' needn't be sorted. `err` must not be NULL.
  */
diff --git a/refs.h b/refs.h
index 7367a7f..8408bef 100644
--- a/refs.h
+++ b/refs.h
@@ -237,6 +237,8 @@ int pack_refs(unsigned int flags);
 int verify_refname_available(const char *newname, struct string_list *extra,
 			     struct string_list *skip, struct strbuf *err);
 
+extern int is_branch(const char *refname);
+
 /*
  * Flags controlling ref_transaction_update(), ref_transaction_create(), etc.
  * REF_NODEREF: act on the ref directly, instead of dereferencing
-- 
2.4.2.644.g97b850b-twtrsrc
