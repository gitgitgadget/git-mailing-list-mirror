From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 23/24] lockfile: remove unable_to_lock_error
Date: Wed, 1 Oct 2014 19:34:04 -0700
Message-ID: <20141002023404.GP1175@google.com>
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
X-From: git-owner@vger.kernel.org Thu Oct 02 04:34:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZWDi-0002tj-OS
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 04:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbaJBCeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 22:34:11 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:52369 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbaJBCeH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 22:34:07 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so1368136pab.16
        for <git@vger.kernel.org>; Wed, 01 Oct 2014 19:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Dg3HvutLePXmvRRkiXXhaWzEcn9wqFPNapEf3kqoQXk=;
        b=geDow0VBoNJ5RPO/UVv7FZnc+DsqhxguSrPlZGKa8PFnKeXMmY7TyQXei8fI9uiYYZ
         R6iPMCEDS7+0w4nFbCJFPeAaPrRe/e3onLjzUjXb/XcL1fodb+ezbReNhx25ItvhVGHw
         5VjBye3d7QpDAlqKDi4uW6lHiiyf02MfrBj6REz0/enoyCPlWpvDTEluciuJ5ZaCbU3d
         hPSFLhkzyWrysvjgONa3+U5FoUALNWC5MZote87XOKBtofn19tk+IibNe18YtjzsYXE4
         AQtM+hzkZfk/R+kCSozh71yPyIn1ml5eChh2i5L/SV15n48QM1c0wxHGXxYj1NBVpzBp
         fzGw==
X-Received: by 10.66.124.136 with SMTP id mi8mr21004724pab.89.1412217247097;
        Wed, 01 Oct 2014 19:34:07 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id td4sm2191654pab.19.2014.10.01.19.34.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Oct 2014 19:34:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141002014817.GS1175@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257794>

Date: Thu, 28 Aug 2014 16:41:34 -0700

The former caller uses unable_to_lock_message now.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Ronnie Sahlberg <sahlberg@google.com>
---
As before.

 cache.h    |  1 -
 lockfile.c | 10 ----------
 2 files changed, 11 deletions(-)

diff --git a/cache.h b/cache.h
index 0c0ac60..f582b6c 100644
--- a/cache.h
+++ b/cache.h
@@ -558,7 +558,6 @@ struct lock_file {
 };
 #define LOCK_DIE_ON_ERROR 1
 #define LOCK_NODEREF 2
-extern int unable_to_lock_error(const char *path, int err);
 extern void unable_to_lock_message(const char *path, int err,
 				   struct strbuf *buf);
 extern NORETURN void unable_to_lock_index_die(const char *path, int err);
diff --git a/lockfile.c b/lockfile.c
index a921d77..dbd4101 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -176,16 +176,6 @@ void unable_to_lock_message(const char *path, int err, struct strbuf *buf)
 			    absolute_path(path), strerror(err));
 }
 
-int unable_to_lock_error(const char *path, int err)
-{
-	struct strbuf buf = STRBUF_INIT;
-
-	unable_to_lock_message(path, err, &buf);
-	error("%s", buf.buf);
-	strbuf_release(&buf);
-	return -1;
-}
-
 NORETURN void unable_to_lock_index_die(const char *path, int err)
 {
 	struct strbuf buf = STRBUF_INIT;
-- 
2.1.0.rc2.206.gedb03e5
