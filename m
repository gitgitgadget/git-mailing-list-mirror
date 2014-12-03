From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 13/14] lockfile: remove unused function 'unable_to_lock_die'
Date: Tue, 2 Dec 2014 21:26:54 -0800
Message-ID: <20141203052654.GW6527@google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 06:27:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xw2Sr-0001te-Ft
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 06:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbaLCF06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 00:26:58 -0500
Received: from mail-ig0-f169.google.com ([209.85.213.169]:54143 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbaLCF05 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 00:26:57 -0500
Received: by mail-ig0-f169.google.com with SMTP id hl2so17521599igb.2
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 21:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=X0VNV74Q4AI0wp4zuf9+EzTmXeCvy2scqYdmNQrHrbY=;
        b=fCcB1WwykWXI2XQQ69VdF6SOOoez0s7Aps+zlkgJ57DNdybVeSYENt2liBiVMa7BZ4
         f1ZEnUhzluc//5UIyNZ+LfJzt1/iib4yZiwow168VBkOXYGPpUC8LJUJqERpfcJvTx78
         onI3tdEhTKa9ApCpHE9iSV9Y2IYPLzHmrYizpvVX160RWn+fAZe8TdJKrqYXLTbY1k7N
         NZ9x6YtycvsV3/LVdLDL/EQgABAicCCz3B8X28faVP9NhQNJ14DSDW8BcPOpmvVBNXiv
         5g3TWmRBxUqTDX3kAxVwFi5ZAQQ0jrizy2ziUXZoYpvCf4SohUJqjXfSGWiwBFZbo/yv
         n3Kg==
X-Received: by 10.42.253.195 with SMTP id nb3mr5832857icb.34.1417584416751;
        Tue, 02 Dec 2014 21:26:56 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id w8sm13024091igb.7.2014.12.02.21.26.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Dec 2014 21:26:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141203050217.GJ6527@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260637>

The old callers now use the message passed back by
hold_lock_file_for_update / hold_lock_file_for_append instead of
trying to interpret errno.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 lockfile.c | 8 --------
 lockfile.h | 1 -
 2 files changed, 9 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index a79679b..8d8d5ed 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -170,14 +170,6 @@ void unable_to_lock_message(const char *path, int flags, int err,
 	}
 }
 
-NORETURN void unable_to_lock_die(const char *path, int flags, int err)
-{
-	struct strbuf buf = STRBUF_INIT;
-
-	unable_to_lock_message(path, flags, err, &buf);
-	die("%s", buf.buf);
-}
-
 int hold_lock_file_for_update(struct lock_file *lk, const char *path,
 			      int flags, struct strbuf *err)
 {
diff --git a/lockfile.h b/lockfile.h
index 6d0a9bb..b4d29a3 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -73,7 +73,6 @@ struct lock_file {
 
 extern void unable_to_lock_message(const char *path, int, int err,
 				   struct strbuf *buf);
-extern NORETURN void unable_to_lock_die(const char *path, int, int err);
 extern int hold_lock_file_for_update(struct lock_file *, const char *path,
 				     int, struct strbuf *err);
 extern int hold_lock_file_for_append(struct lock_file *, const char *path,
