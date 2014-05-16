From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 22/44] fetch.c: clear errno before calling functions that might set it
Date: Fri, 16 May 2014 10:37:10 -0700
Message-ID: <1400261852-31303-23-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:39:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM6T-00027x-49
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756588AbaEPRjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:39:21 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:61543 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757947AbaEPRhj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:39 -0400
Received: by mail-pa0-f74.google.com with SMTP id rd3so521441pab.3
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nAhzYOuVfqcXLPO33MPiHm1IvP+zE9BPOLKnzT9REMk=;
        b=SytchRtAC5F896iWX0k9UoYkHsNMBD3VzRmpy5MUEwkihgdP5Lno7kTEw4RivGBG4X
         4rIUFqKqHJYeoVHpkv6lUfQwzqzep/79auxmhSLEB9tQQwdDTa/MYz0FFO+cJUs2808s
         xvXcJxpHwt1wcz2M5fkHhI+JGTZp6t032gbKWNIW3umvQdvvjIcehzbMTLu3NZAKxp2o
         0E4NANA0b4scpgqb02i5eklVpL2OiDny2OUZTYmo9tA9KQjiq7LAeoWUfapDJCszV8UR
         JbuG8Ju4kyI+Gd2/m+LtjF9HcRjxguPwpr9occuxHLwzEgP8WHU4WmiQDTNCPKqod7WZ
         2Baw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nAhzYOuVfqcXLPO33MPiHm1IvP+zE9BPOLKnzT9REMk=;
        b=kHCerPh80OKWCmaWuer6c2JflBuENZYQizR0jMDhsPmU6As/zBVGJRk2Z8h+Udewg8
         N8/E316Heu76/4VITfBTXC7IwjqEppy4OCQwisIyw17GMYcxFCCqUyFf/0/dsBiuDv3d
         zqiA26MhFUvnvwOKKZrNMg5WjGvvTX1BrpLLIUcDKckD0mFcOerPoegVwAwyRy/4H9vP
         dtMGPzp5F54YzPPcVrDa7WtrmOo5cbXQwOqeLLjlH+9VmJDTYqKqS6vHRf02aFAye/sv
         8VdU/y2hnwxQg7ivfsDiab8u2RP8Jx1e13YhkYxpz4I4OfjoVzFwuuSt5kglIIAJ541L
         JnYw==
X-Gm-Message-State: ALoCoQkrLc1aK1CnxeuIT43R8LY1kk0Q7Y9fkFDpqlwILFwl9hOk1YJWyL+9sCoHho8QLw7br1JJ
X-Received: by 10.66.163.33 with SMTP id yf1mr6594975pab.19.1400261857805;
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a44si441756yhb.6.2014.05.16.10.37.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 9D0C631C255;
	Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 790F5E0D39; Fri, 16 May 2014 10:37:37 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249384>

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
2.0.0.rc3.510.g20c254b
