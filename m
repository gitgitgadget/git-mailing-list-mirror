From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 41/44] refs: add register_refs_backend
Date: Mon, 12 Oct 2015 17:52:02 -0400
Message-ID: <1444686725-27660-43-git-send-email-dturner@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:53:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll1k-0004vO-QL
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:53:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645AbbJLVxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:53:00 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:35706 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628AbbJLVw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:52:59 -0400
Received: by qgt47 with SMTP id 47so129538353qgt.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hh7cHP4wYf714otdeTJiwtgCrXkYEIyVmUOJqZ/1vv8=;
        b=fmLIOyr4mCgfNs4Bx2T4bnVkSo7bFcTbgcmsWA9ZvNrTxLJnTP+cfdG+Otlorr4NYa
         +gulUaIDtwIHMs6t+M3V8x0AXAFPWpG0rL6acH9qpfOroieqtSY8vQhTk5DaNCGaLaSt
         H6yXuSlkAmYMjA9iVBHbYuFO9+TjopHdX6gr2tkTsSBk1KIPWy2Ynx6sqCv4HSSO66qb
         sLYEveGniAYx5QTwjdbi5JMeomKos5PTHY+1wl4c3lIPUXEpsxLx6OWVGFbRCZ3V6auX
         k7fVeph2Vutdv0s5DrCqn0I0H7iaPhWmmLB/0eYnuTb8tKWKzQ/QkrHX7RITJLjC6MW9
         iMtw==
X-Gm-Message-State: ALoCoQmVw1BGTR1Va+5uc1TyHipksEaHulb2ouWuwGvauFWMrB2nrtOCBxu0bR26hbOEnFwi1i6C
X-Received: by 10.140.102.53 with SMTP id v50mr34925766qge.33.1444686778394;
        Mon, 12 Oct 2015 14:52:58 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:57 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279437>

Add register_refs_backend, to allow refs backends to be registered.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c | 6 ++++++
 refs.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/refs.c b/refs.c
index 901558d..534d12e 100644
--- a/refs.c
+++ b/refs.c
@@ -23,6 +23,12 @@ struct ref_be *refs_backends = &refs_be_files;
 
 const char *refs_backend_type;
 
+void register_refs_backend(struct ref_be *be)
+{
+	be->next = refs_backends;
+	refs_backends = be;
+}
+
 /*
  * This function is used to switch to an alternate backend.
  */
diff --git a/refs.h b/refs.h
index a9fdbf0..45615e8 100644
--- a/refs.h
+++ b/refs.h
@@ -790,5 +790,6 @@ struct ref_be {
 
 extern struct ref_be refs_be_files;
 int set_refs_backend(const char *name, void *init_data);
+void register_refs_backend(struct ref_be *be);
 
 #endif /* REFS_H */
-- 
2.4.2.644.g97b850b-twtrsrc
