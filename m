From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 22/44] fetch.c: clear errno before calling functions that might set it
Date: Thu, 15 May 2014 10:29:37 -0700
Message-ID: <1400174999-26786-23-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:31:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzUg-00086L-Cy
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755728AbaEORaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:30:24 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:36465 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755672AbaEORaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:09 -0400
Received: by mail-vc0-f201.google.com with SMTP id ij19so637287vcb.0
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n9SVyEXa/7GolGFHMqKHgUxewDVAiE5jFQ3tTAuFS8A=;
        b=f4YBV+aRJ5EADtfNrmKeANP7g0mbR+AWOocUoGo4ZfQ99HGWfhJFeFf9nB3OzGf4UD
         +0Qa2UErROZEWviGRuKMI/A5CsdpopZ5eIoCHaNyQzxe1HMXUu8IIk1LXtfoAmk8nxcn
         91lhX9hvYdtpUPRJB/MJglcEeSa00pH6oYa9EGV9SFsIWjLhopMGZS38/IJNW4t5TMhj
         RlRmUfXsLbCEM3JNPm3Xa97WUg/OvWkqTNfKp/tWOllvm1Hc2WCzMfbFhqwLCKiUNFIC
         G/ZqFeP0U6w8kj6pYK1RGT212KcvpEJgL+Q+qKwhjCPlP22TVU8MDqLr3Zx0yu9rjOi/
         wIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n9SVyEXa/7GolGFHMqKHgUxewDVAiE5jFQ3tTAuFS8A=;
        b=FO9AOPksuLbGJZ2vNG0zwLW9Ok1ErjoLJzTNxA/Lm3GPev6aF7pd/0lGe0bVx4GhyH
         kLwFiZbm3dstvVOq8ZxrVN04bqyR3/XJtCYartudxqbv86uND+CPWpMw/A7p7BfZO1ax
         pD8sBJcXnzu3VftIpcrPE03Xfk5v6yp96lzGZEqEgLUZ+wKDIUwGsLtKq4y2aLO7AQN7
         nWL9ZwuU4pYDT7oRiGYUoosugIW6vL5ukxnExpz3WexQFRfd+BJOmLKTrj6WDvKy+sRF
         BVr1q0hV9Adc8Q2GXe8M4kh2zf9y7c5lyvlwX6jidDufY0w7Z5hGHFeoApIyGV7wxXrH
         kc9w==
X-Gm-Message-State: ALoCoQnizTTkrs+Dr8iGB8cFXXvdAUmemZp9gnkfK2ciD6pwhd+DkfdDAEoxeooXByR0wxEYejQV
X-Received: by 10.58.236.5 with SMTP id uq5mr5485662vec.35.1400175006745;
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si273165yhk.4.2014.05.15.10.30.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 96EC031C239;
	Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 70840E1129; Thu, 15 May 2014 10:30:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249133>

In s_update_ref there are two calls that when they fail we return an error
based on the errno value. In particular we want to return a specific error
if ENOTDIR happened. Both these functions do have failure modes where they
may return an error without updating errno, in which case a previous and
unrelated ENOTDIR may cause us to return the wrong error. Clear errno before
calling any functions if we check errno afterwards.

Also skip initializing a static variable to 0. Statics live in .bss and
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
2.0.0.rc3.477.g0f8edf7
