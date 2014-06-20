From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 22/48] refs.c: make ref_transaction_begin take an err argument
Date: Fri, 20 Jun 2014 07:43:03 -0700
Message-ID: <1403275409-28173-23-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:46:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy05S-000410-U7
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754236AbaFTOqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:46:21 -0400
Received: from mail-ig0-f202.google.com ([209.85.213.202]:39284 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbaFTOne (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:34 -0400
Received: by mail-ig0-f202.google.com with SMTP id c1so38697igq.3
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wYZDdbMbgGdlUoRKRAkKWo7iOAeX0Mc0D8OhmodFIx4=;
        b=EBIAGx9Yem1aHJxaufut+DNn01TLjzhuTuFSXK6SvmrKdmhlWRjTpNu3r9wMLSFHqn
         5oaGHEMXscgc4f9E8nz6bn/P1JJUIoUWVwHNIqc2I7qNArzrjtI9nstnbhJ7XYUYcwqD
         4Tha8Htfnv2yzSkqYbt47k/x3FKI4wTS1ZpbSyxSOSYcXyxsYcI3VNprsRxIgWh2gJ1i
         NEoFbeW/Yif/oMTvpMUeko0rlqPC6y2flGCoESTY8crf0DoBuVGZzlye5w/LDCCCMhaQ
         d0j0yu6VIQbeWu09FQJwbmkRhOZI3ci81dYPtht47QuAtP5FNrXxkmRFWp+9BlHa+fzn
         KbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wYZDdbMbgGdlUoRKRAkKWo7iOAeX0Mc0D8OhmodFIx4=;
        b=a9t3jLFn8ODZ1F7Uci6s+OmWTNigDQqCeV3cRkBkGezg12uYCAvkwUHCijvwnnsmuR
         tisVgAD8l6oT/oZTZ+wSWgIfreTu9HxHroZdOayXmaBRDDOi7iVwrMzVII+KiCrlZonY
         3VjTnew8nj4YzspzN4/GlAy4lp9oWejdPxHmo+RgGxZFEbjcZ2rtDzIauRwJj/SiQieH
         2r4PIzHyRi+m8FdsAqPprPLsPszNIFcYfNNEssQS0qOgn2qnsA83z2cswv9DW4udWajX
         Sb44CUZiouj7DaLglwUZ7oDab47KZ2aCZqsmon05q1QafifL9egjrWwB7Df++zX6v4xs
         ba9g==
X-Gm-Message-State: ALoCoQkbJVHwHbu1JuZIWguH8hfFTIXT22K+AnXP3GpK48TevyZqQpd8J+yHyx0ZSsSkmFyPtac4
X-Received: by 10.50.87.65 with SMTP id v1mr1517898igz.0.1403275412889;
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id j5si665233yhi.1.2014.06.20.07.43.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id B810E31C6B4;
	Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 9438EE0873; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252267>

Add an err argument to _begin so that on non-fatal failures in future ref
backends we can report a nice error back to the caller.
While _begin can currently never fail for other reasons than OOM, in which
case we die() anyway, we may add other types of backends in the future.
For example, a hypothetical MySQL backend could fail in _being with
"Can not connect to MySQL server. No route to host".

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 2 +-
 refs.c               | 2 +-
 refs.h               | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 7c9c248..c6ad0be 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -365,7 +365,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		die("Refusing to perform update with empty message.");
 
 	if (read_stdin) {
-		transaction = ref_transaction_begin();
+		transaction = ref_transaction_begin(&err);
 		if (delete || no_deref || argc > 0)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
diff --git a/refs.c b/refs.c
index 40f04f4..9cb7908 100644
--- a/refs.c
+++ b/refs.c
@@ -3397,7 +3397,7 @@ struct ref_transaction {
 	size_t nr;
 };
 
-struct ref_transaction *ref_transaction_begin(void)
+struct ref_transaction *ref_transaction_begin(struct strbuf *err)
 {
 	return xcalloc(1, sizeof(struct ref_transaction));
 }
diff --git a/refs.h b/refs.h
index eeababd..e729ea9 100644
--- a/refs.h
+++ b/refs.h
@@ -269,7 +269,7 @@ enum action_on_err {
  * Begin a reference transaction.  The reference transaction must
  * be freed by calling ref_transaction_free().
  */
-struct ref_transaction *ref_transaction_begin(void);
+struct ref_transaction *ref_transaction_begin(struct strbuf *err);
 
 /*
  * The following functions add a reference check or update to a
-- 
2.0.0.420.g181e020.dirty
