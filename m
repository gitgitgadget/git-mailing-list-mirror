From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 24/25] lockfile: remove unable_to_lock_error
Date: Tue, 14 Oct 2014 17:55:21 -0700
Message-ID: <20141015005521.GB32245@google.com>
References: <20141015004522.GD32245@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 15 02:55:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeCsD-0004h7-Cw
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 02:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686AbaJOAzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 20:55:25 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:48941 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932479AbaJOAzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 20:55:25 -0400
Received: by mail-pd0-f179.google.com with SMTP id r10so235875pdi.10
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 17:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=oQ7NbaTKupaP7JKMWdHleCIIqCRr43f4nTi8VPexx2A=;
        b=nGF1RJR+5MQNkNXrakNjF5oROb9hffeIft5+/YJpi/4w1TbXz++i/QoKqn6sdtF1QP
         DAPV5HrbOh7CR/3QTRdbXckDGZbDlX1PLnW2nilKcoxMnNeA6bA0q//gj6AfVOorGhPy
         LVNy0gUQmDztm4LkyUFvrk33tJsIr3ASjAjO+TRsuesksizTFyrXgPcXSUWwcZQ/hB4h
         lt6He9nYqdV2535ns5X5ncNP3eVtnh30LoahWiV8g2hweXBmNJtMV30K/2ax2GgLCKxb
         HHWFyEcoR9CbgRW5qnQE2e7iThBWhYHjaVPc1j8yJe4tw+z0wOOH/F3YA9AkpilhkdYg
         FATQ==
X-Received: by 10.67.29.177 with SMTP id jx17mr8678930pad.56.1413334524004;
        Tue, 14 Oct 2014 17:55:24 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c43b:1934:40ef:9a07])
        by mx.google.com with ESMTPSA id y9sm8569358pdq.12.2014.10.14.17.55.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Oct 2014 17:55:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141015004522.GD32245@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Date: Thu, 28 Aug 2014 16:41:34 -0700

The former caller uses unable_to_lock_message now.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Ronnie Sahlberg <sahlberg@google.com>
---
 lockfile.c | 10 ----------
 lockfile.h |  1 -
 2 files changed, 11 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index d098ade..4f16ee7 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -162,16 +162,6 @@ void unable_to_lock_message(const char *path, int err, struct strbuf *buf)
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
 NORETURN void unable_to_lock_die(const char *path, int err)
 {
 	struct strbuf buf = STRBUF_INIT;
diff --git a/lockfile.h b/lockfile.h
index dc066d1..cd2ec95 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -71,7 +71,6 @@ struct lock_file {
 #define LOCK_DIE_ON_ERROR 1
 #define LOCK_NO_DEREF 2
 
-extern int unable_to_lock_error(const char *path, int err);
 extern void unable_to_lock_message(const char *path, int err,
 				   struct strbuf *buf);
 extern NORETURN void unable_to_lock_die(const char *path, int err);
-- 
2.1.0.rc2.206.gedb03e5
