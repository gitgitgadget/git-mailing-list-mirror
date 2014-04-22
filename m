From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 1/3] fetch.c: clear errno before calling functions that might set it
Date: Tue, 22 Apr 2014 11:45:25 -0700
Message-ID: <1398192327-21302-2-git-send-email-sahlberg@google.com>
References: <1398192327-21302-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 20:46:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcfhe-0000Un-Um
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 20:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755860AbaDVSpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 14:45:44 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:60032 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755091AbaDVSpd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 14:45:33 -0400
Received: by mail-qa0-f73.google.com with SMTP id hw13so992775qab.4
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 11:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ox2He1jPzEpPz3xwhF6a96myiyYw+0x63wakog8f2dE=;
        b=gZCm+rSbcKIdjOFvUhpc/HzQc5XkJnT4KEATcx9q8tIcaXlrqAsTDldZhRGLIsBv10
         /sCPvEul8hF5AHsxjpcYIJiq02B1IBd3yEAi47uiiG2JU8591d2I9hSYyiK1Nn5x75lO
         kuYuaLyjHkbKpmFTnAxwb6ldmNKRuw1cNWLE+vpSuQqBn/W892gGumFuggbK5iUGqwjv
         KAM81PKs0r61UP0/3y5EbYx65LjU3m0YzoNyzxlzEFTTRYUDPOvlNXxaYYsk9xci22ie
         2HHAWiSYwlgvp+8N1tB7D8WG7K2t14MGY/lZhPVnjUm7xY2ZmCw4+CtSgDj/H7rTRxF+
         8IEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ox2He1jPzEpPz3xwhF6a96myiyYw+0x63wakog8f2dE=;
        b=jcVXaZahWk56Qp+DDOX7DhqXvBLhQ3CISzr0hiP494n/DQX7Cftun1v0RWF/a798KR
         tvkwmnXYsENUrl1CzqLc7wKPAdihZmI4jqgmY4u+zatBuBPpKTEA6kmIk0J7ZHp1/xUK
         SwcuN7Oh8tarv9iFZUAXGKlSEVym+cZOgheKs+thconJ/Zf+OTAAIrllzNHOvFxRqewF
         ScdNLB+YUy437ci0X/L1ZoxOKZUP/UkhmcO+HuDyGKGVAFspenTznfLFn8jSCy4POEGM
         OC79KmxqaQ7LTBjLhUf7ZLeFoc9JVQtQ1t47y+KnZQ8iNA5PiaLda0ks5YvGw+9KQ7ax
         AhIA==
X-Gm-Message-State: ALoCoQmPeNAHBub1RPGx4lxmjKavOM7TOD7Je3VQ5DICcMekq77D6cl9kvYgqWIHxuHVtQSFsDvXEnrWiRuxYlfXCc3Ek6pJZDgGrmjOMfelP/LMmzhGgRWj4nCelu1ISYwszBhs0BsW4rGxjPYcWPbP4gR9YsgL2SJGjsDu3bEN9/VEuV0oj6/PefPb3rvROx09gwSqN82z
X-Received: by 10.236.87.73 with SMTP id x49mr18812517yhe.30.1398192332375;
        Tue, 22 Apr 2014 11:45:32 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r61si5708599yhf.1.2014.04.22.11.45.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Apr 2014 11:45:32 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 382B031C15E;
	Tue, 22 Apr 2014 11:45:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D81D9E0BB8; Tue, 22 Apr 2014 11:45:31 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.518.g16976cb.dirty
In-Reply-To: <1398192327-21302-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246764>

In s_update_ref there are two calls that when they fail we return an error
based on the errno value. In particular we want to return a specific error
if ENOTDIR happened. Both these functions do have failure modes where they
may return an error without updating errno, in which case a previous and
unrelated ENOTDIT may cause us to return the wrong error. Clear errno before
calling any functions if we check errno afterwards.

Also skip initializing a static variable to 0. Sstatics live in .bss and
are all automatically initialized to 0.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/fetch.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 55f457c..a93c893 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -44,7 +44,7 @@ static struct transport *gtransport;
 static struct transport *gsecondary;
 static const char *submodule_prefix = "";
 static const char *recurse_submodules_default;
-static int shown_url = 0;
+static int shown_url;
 
 static int option_parse_recurse_submodules(const struct option *opt,
 				   const char *arg, int unset)
@@ -382,6 +382,8 @@ static int s_update_ref(const char *action,
 	if (!rla)
 		rla = default_rla.buf;
 	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
+
+	errno = 0;
 	lock = lock_any_ref_for_update(ref->name,
 				       check_old ? ref->old_sha1 : NULL,
 				       0, NULL);
-- 
1.9.1.518.g16976cb.dirty
