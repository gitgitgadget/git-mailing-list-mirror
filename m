From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 12/24] refs.c: make write_ref_sha1 static
Date: Wed, 1 Oct 2014 19:08:51 -0700
Message-ID: <20141002020851.GE1175@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
 <20141002014817.GS1175@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 04:08:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZVpD-000147-Fc
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 04:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527AbaJBCI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 22:08:56 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:41662 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625AbaJBCIz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 22:08:55 -0400
Received: by mail-pd0-f176.google.com with SMTP id fp1so1198842pdb.21
        for <git@vger.kernel.org>; Wed, 01 Oct 2014 19:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Oy1VL9R0n4RvIl4gPxfy1zOflUgkPm3F3VmypRu1GAQ=;
        b=vNsLDCYX3orLaOo2ndoa+Ab3FecJcj4G3fDkTGFKZGo4IXNX9jmCGFyh/YacSZFvKx
         Q5DFnsZs/vIbcZ9mUTbj3TgfrAh6tnBcnYijls097qVhB17drT+bumJ5MPV3K49L0+YW
         MoCnG7b4ahuQ2x6m8EzMK+nOu1idJnOip6SfeqlmbYE6IyhtI9rtbXZubEzO9TXScqy1
         j5IkuwGwhUB2bRWrnZdYF/zztWnhqx7Eqec2pPnAW6JWW4MCxgXX0gWVMkiv77u5KxhE
         dvhuuPzMnqEvfTt6LW3OpvaqajtIpKbcxSw28J5sX81+LFx3ZrSq7tyy+EnYbJds3nG9
         5uIA==
X-Received: by 10.68.129.102 with SMTP id nv6mr68771080pbb.134.1412215734794;
        Wed, 01 Oct 2014 19:08:54 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id f12sm2133372pat.36.2014.10.01.19.08.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Oct 2014 19:08:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141002014817.GS1175@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257783>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Mon, 28 Apr 2014 15:36:58 -0700

No external users call write_ref_sha1 any more so let's declare it static.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Since v21:
- punctuation fix in commit message
- grammar tweak in doc comment

 refs.c | 10 ++++++++--
 refs.h |  3 ---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 623a1ae..f596a9f 100644
--- a/refs.c
+++ b/refs.c
@@ -2645,6 +2645,9 @@ static int rename_tmp_log(const char *newrefname)
 	return 0;
 }
 
+static int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1,
+			  const char *logmsg);
+
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
 	unsigned char sha1[20], orig_sha1[20];
@@ -2900,8 +2903,11 @@ static int is_branch(const char *refname)
 	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
 }
 
-/* This function must return a meaningful errno */
-int write_ref_sha1(struct ref_lock *lock,
+/*
+ * Write sha1 into the ref specified by the lock. Make sure that errno
+ * is sane on error.
+ */
+static int write_ref_sha1(struct ref_lock *lock,
 	const unsigned char *sha1, const char *logmsg)
 {
 	static char term = '\n';
diff --git a/refs.h b/refs.h
index fd63b47..3bb16db 100644
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
