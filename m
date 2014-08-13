From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 11/23] refs-common.c: move resolve_refdup to common
Date: Wed, 13 Aug 2014 13:14:55 -0700
Message-ID: <1407960907-18189-12-git-send-email-sahlberg@google.com>
References: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 22:16:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHext-0000CW-SK
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 22:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753862AbaHMUQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 16:16:01 -0400
Received: from mail-oi0-f73.google.com ([209.85.218.73]:62616 "EHLO
	mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539AbaHMUPL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 16:15:11 -0400
Received: by mail-oi0-f73.google.com with SMTP id u20so69975oif.4
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hRHDXqhxKO3FgPcjcnxMWmFUOS7t7C1cyT+/0gYvcYQ=;
        b=FCTirQTZdTUQimdj3/AAREQY5KCGN7UCgLAo1K+MHlVWW7Hy6GpJy2lyxXje+PHtpz
         bSPSBQpFk7FnN0+V63voGzVsm3KQ17jYVUlQQe0AGaSlh4FlgERR/qrOD10Q4fTWS7Jy
         f574d8vEZqCB03oQ/Xr1em1sOPokAs8KfP1dUPWrcprR0WRstcJafis77QI1DnL3TGDR
         vlcqPsvwl4fiDUvMIBKFpTXZiy15gsgrBzp2UzgynHJdGeTREQR+t7OxeW0nTyU8x4RY
         fpjVki5vksKrZFqabrlsYIBuYywaknGaM3rcHHilUfeACIa+D+BmDQjTaO6BujlzNC6a
         EBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hRHDXqhxKO3FgPcjcnxMWmFUOS7t7C1cyT+/0gYvcYQ=;
        b=D4g5K5ggBOKoYMpD+w/huiKxD/lcRGl4m49i6Veb6u0tlpMTbIIxvu0FAKYIeHWUvM
         1EEV9r2KnzvRAjd3rvnLcXYt6Oe7xlV3Py3VsD67xswPh9uDOIaOQt5dYY6qgZ/rKVnD
         EF3jXn6qCXtiAKL5U3B7hFHugKIrN7Ys81X1GE10NCgLyG2qYsLFrlFMVjAk0Oh50lCi
         Ibgk2pNy3+pgdEDnb5cLI4wiLKqJjo4rx+QWPrHefL9WBzYpKZ81Qz5KSMtVGXVBU16v
         hHo8ylS8J+3tcqZuAdt3b5O6dWRu8rgEehv/zMLVAfWQmLK52Jrve6N+/3/aL5/VY+t/
         us5g==
X-Gm-Message-State: ALoCoQmrofoRnAS8WZFRP/Vt7zKkh+1RWVcqAqX8zwDbCDzEo7P1uk1yolcQMCWm+ULy0Gu2FmeF
X-Received: by 10.182.230.133 with SMTP id sy5mr3665111obc.22.1407960910678;
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id h42si209644yhj.3.2014.08.13.13.15.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 85D025A4536;
	Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 60DDEE0C3A; Wed, 13 Aug 2014 13:15:09 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.gfa712f7
In-Reply-To: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255243>

This function can be shared across all refs backends so move it
to the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-common.c | 6 ++++++
 refs.c        | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs-common.c b/refs-common.c
index 37d3d14..655a1a0 100644
--- a/refs-common.c
+++ b/refs-common.c
@@ -565,3 +565,9 @@ int ref_exists(const char *refname)
 	unsigned char sha1[20];
 	return !!resolve_ref_unsafe(refname, sha1, RESOLVE_REF_READING, NULL);
 }
+
+char *resolve_refdup(const char *ref, unsigned char *sha1, int flags, int *ref_flag)
+{
+	const char *ret = resolve_ref_unsafe(ref, sha1, flags, ref_flag);
+	return ret ? xstrdup(ret) : NULL;
+}
diff --git a/refs.c b/refs.c
index a94378e..ed7bc61 100644
--- a/refs.c
+++ b/refs.c
@@ -1501,12 +1501,6 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int fla
 	}
 }
 
-char *resolve_refdup(const char *ref, unsigned char *sha1, int flags, int *ref_flag)
-{
-	const char *ret = resolve_ref_unsafe(ref, sha1, flags, ref_flag);
-	return ret ? xstrdup(ret) : NULL;
-}
-
 /* The argument to filter_refs */
 struct ref_filter {
 	const char *pattern;
-- 
2.0.1.556.g3edca4c
