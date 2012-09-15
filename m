From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/7] commit.c: mark file-scope functions as static
Date: Sat, 15 Sep 2012 14:10:47 -0700
Message-ID: <1347743452-2487-2-git-send-email-gitster@pobox.com>
References: <5054AA62.2040603@ramsay1.demon.co.uk>
 <1347743452-2487-1-git-send-email-gitster@pobox.com>
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 15 23:11:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCzds-0004pG-6t
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 23:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508Ab2IOVK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2012 17:10:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61774 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751542Ab2IOVK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 17:10:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A6F28558;
	Sat, 15 Sep 2012 17:10:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=oJkq
	6XPLfEv6yFwYXYqUevh6YxQ=; b=ZT6E31CjLQ1q5/jaDjAZbnlGLpSeD7jLQeXX
	p/5MqKzpmKSdObIpHbE/U6Ld/Q0c93hwY/p0pnMdzO9YEDRuXDnnTHQk74yDWiFX
	DcVCTqLUklYgm1u07/pKs3PfyQqplGXUG0s/YJU81++EaPiVnq2R4QG2DLBL+P6g
	HK5SRFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	Y8/2LoQ8fi4atUA3W6CYm05vsp7yOM3x2cBsDo/sNk3jqL5bAhcYvLxy55EV8WSe
	kU8Wotreb6HHQPv/75reaSd7RVThuhCLkRLUpkUmDQPiPJEuhuBZ/k4nl9LpMGfP
	xGMjBhEGZu1sGGDqXzVtntnSR9wrBKT+z8E4BS1L1N8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66F988557;
	Sat, 15 Sep 2012 17:10:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C17778556; Sat, 15 Sep 2012
 17:10:55 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.508.g4d78187
In-Reply-To: <1347743452-2487-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D6D15348-FF79-11E1-B09F-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205575>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c | 7 +++++--
 commit.h | 1 -
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/commit.c b/commit.c
index 0ea441d..0246767 100644
--- a/commit.c
+++ b/commit.c
@@ -9,6 +9,8 @@
 #include "gpg-interface.h"
 #include "mergesort.h"
 
+static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
+
 int save_commit_buffer = 1;
 
 const char *commit_type = "commit";
@@ -1073,8 +1075,9 @@ static int excluded_header_field(const char *field, size_t len, const char **exc
 	return 0;
 }
 
-struct commit_extra_header *read_commit_extra_header_lines(const char *buffer, size_t size,
-							   const char **exclude)
+static struct commit_extra_header *read_commit_extra_header_lines(
+	const char *buffer, size_t size,
+	const char **exclude)
 {
 	struct commit_extra_header *extra = NULL, **tail = &extra, *it = NULL;
 	const char *line, *next, *eof, *eob;
diff --git a/commit.h b/commit.h
index 6edce87..9f21313 100644
--- a/commit.h
+++ b/commit.h
@@ -204,7 +204,6 @@ extern int commit_tree_extended(const struct strbuf *msg, unsigned char *tree,
 				struct commit_extra_header *);
 
 extern struct commit_extra_header *read_commit_extra_headers(struct commit *, const char **);
-extern struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
 extern void free_commit_extra_headers(struct commit_extra_header *extra);
 
-- 
1.7.12.508.g4d78187
