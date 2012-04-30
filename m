From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 5a/5] streaming: void pointer instead of char pointer
Date: Tue, 01 May 2012 00:11:54 +0200
Message-ID: <4F9F0E2A.1060004@lsrfire.ath.cx>
References: <1335761837-12482-1-git-send-email-pclouds@gmail.com> <1335761837-12482-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 00:12:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOyp7-0006Bt-5k
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 00:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756902Ab2D3WL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 18:11:56 -0400
Received: from india601.server4you.de ([85.25.151.105]:57793 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756873Ab2D3WL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 18:11:56 -0400
Received: from [192.168.2.105] (p4FFDA315.dip.t-dialin.net [79.253.163.21])
	by india601.server4you.de (Postfix) with ESMTPSA id AC6D92F8181;
	Tue,  1 May 2012 00:11:54 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120420 Thunderbird/12.0
In-Reply-To: <1335761837-12482-6-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196616>

Allow any kind of buffer to be fed to read_istream() without an explicit
cast by making it's buf argument a void pointer.  It's about arbitrary
data, not only characters.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 streaming.c |    2 +-
 streaming.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/streaming.c b/streaming.c
index 7e7ee2b..3a3cd12 100644
--- a/streaming.c
+++ b/streaming.c
@@ -99,7 +99,7 @@ int close_istream(struct git_istream *st)
 	return r;
 }
 
-ssize_t read_istream(struct git_istream *st, char *buf, size_t sz)
+ssize_t read_istream(struct git_istream *st, void *buf, size_t sz)
 {
 	return st->vtbl->read(st, buf, sz);
 }
diff --git a/streaming.h b/streaming.h
index 3e82770..1d05c2a 100644
--- a/streaming.h
+++ b/streaming.h
@@ -10,7 +10,7 @@ struct git_istream;
 
 extern struct git_istream *open_istream(const unsigned char *, enum object_type *, unsigned long *, struct stream_filter *);
 extern int close_istream(struct git_istream *);
-extern ssize_t read_istream(struct git_istream *, char *, size_t);
+extern ssize_t read_istream(struct git_istream *, void *, size_t);
 
 extern int stream_blob_to_fd(int fd, const unsigned char *, struct stream_filter *, int can_seek);
 
-- 
1.7.10
