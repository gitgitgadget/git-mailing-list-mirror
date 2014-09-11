From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 12/19] refs.c: make write_ref_sha1 static
Date: Wed, 10 Sep 2014 20:08:58 -0700
Message-ID: <20140911030858.GP18279@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 05:09:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRukt-0002Cg-9q
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 05:09:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991AbaIKDJD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 23:09:03 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:59082 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758AbaIKDJC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 23:09:02 -0400
Received: by mail-pa0-f51.google.com with SMTP id kx10so8937739pab.38
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 20:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GHLiG7A/m/vY/Pzz/w+cRFuRuUHEt5ZBXiaEPlk+lYk=;
        b=Jw31QHGllxNAzlWSe79O944mbFN0+KPs42bxJWmxEm3cXg7E33tdO9pKP1Uy/rj0Op
         iugtQkyHS6/yGwPq56I2nktv4QuCfXaYsC3SacaG2op3kKkbwgs2tU+xL4wf/nG5sqzm
         h/szkgPuanoeWbDziA5+RTFxjYSUXOONmXNxYRK+TOP4CrkZylW9cLL+VoJv1mF7pG79
         eFfA3HgtwZvaXu0h/OUAAYofl4rT0MBsGJh772TAjAI/WOKDFTleBvJdJMnhCWy5Avsp
         cN6VZENWT4pwrmfFgh3qhs5oJ4kdvkDQ1y9dv7zFXXFFEaCwex/gNk/87FjrdGk1AneB
         c+LA==
X-Received: by 10.66.145.133 with SMTP id su5mr33039849pab.11.1410404941480;
        Wed, 10 Sep 2014 20:09:01 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id i1sm15920194pdf.46.2014.09.10.20.09.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Sep 2014 20:09:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140911030318.GD18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256824>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Mon, 28 Apr 2014 15:36:58 -0700

No external users call write_ref_sha1 any more so lets declare it static.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 10 ++++++++--
 refs.h |  3 ---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 86c708a..c2dab4a 100644
--- a/refs.c
+++ b/refs.c
@@ -2646,6 +2646,9 @@ static int rename_tmp_log(const char *newrefname)
 	return 0;
 }
 
+static int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1,
+			  const char *logmsg);
+
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
 	unsigned char sha1[20], orig_sha1[20];
@@ -2901,8 +2904,11 @@ static int is_branch(const char *refname)
 	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
 }
 
-/* This function must return a meaningful errno */
-int write_ref_sha1(struct ref_lock *lock,
+/*
+ * Writes sha1 into the ref specified by the lock. Makes sure that errno
+ * is sane on error.
+ */
+static int write_ref_sha1(struct ref_lock *lock,
 	const unsigned char *sha1, const char *logmsg)
 {
 	static char term = '\n';
diff --git a/refs.h b/refs.h
index e14aa31..fafa493 100644
--- a/refs.h
+++ b/refs.h
@@ -195,9 +195,6 @@ extern int commit_ref(struct ref_lock *lock);
 /** Release any lock taken but not written. **/
 extern void unlock_ref(struct ref_lock *lock);
 
-/** Writes sha1 into the ref specified by the lock. **/
-extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
-
 /*
  * Setup reflog before using. Set errno to something meaningful on failure.
  */
-- 
2.1.0.rc2.206.gedb03e5
