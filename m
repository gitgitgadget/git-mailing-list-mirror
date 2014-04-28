From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v4 20/27] fetch.c: clear errno before calling functions that might set it
Date: Mon, 28 Apr 2014 15:54:35 -0700
Message-ID: <1398725682-30782-21-git-send-email-sahlberg@google.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 01:01:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeuYP-00059Z-1g
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 01:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644AbaD1XBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 19:01:36 -0400
Received: from mail-pd0-f202.google.com ([209.85.192.202]:40326 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbaD1XBf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 19:01:35 -0400
Received: by mail-pd0-f202.google.com with SMTP id y10so210pdj.5
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 16:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vNt9D3xbvjoFQ6dXK2YCGoQXXDISNPLWwnpEOYtpxkQ=;
        b=KdU+k34LoAPS5+H/cvDbNYeTBalL5GB1WkaBP5hf3KDkpj8yjqd7XKjeoRJpBx9veZ
         kseUzxKq/9WNwARVOUx/c1gphLkUYnB5UktM+1HKYhHyIbYdoHT/0PBjyXBrzOUTaDfk
         3xXdAaemfZbXeY4ypDsOyMgUUXIKzSN9cGqfbcUgW0WE8MrmTgBFUBp7HOSVT+luc6vP
         R9ulV280QiItiUjbysgAkiZE3X4PMr5k84xFX9H+QbjIGiXzEfqxPRYlwZLK3YdUxFb8
         vIU1cpytZcvBMVmrduE6CQFjMpg+vAOYHd2lmZ8x+9JEdwpNtnGC7tate6cytoUNzESU
         +L8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vNt9D3xbvjoFQ6dXK2YCGoQXXDISNPLWwnpEOYtpxkQ=;
        b=Bug1uXC2Ewa1ciUqsb5nVgGioTjbz1hmNOO2/OlCOwmh48rPUsH7H1yZVmbXCDHBC3
         W9IluXvZwJQ7o8ZHPXvT/7bzxP6ywxIBawNDb77prIMT29w9Lp9OAWufKD7ElkukL9Gh
         fXafZ8ZwsOn+8LwznPz86SwXLO2Ik2lL4inffnSJ/OnkhNMU5owEMhhamehzoqjvJgwi
         ODU9xL7O5E/TvjlxZnonw5FpKSk7+MQL9xrVZJFU28QoR5Z5K7iGB2N9lC6BIukim+0I
         V0cqlJAGHFdPSNoEeS+up43pgHonr58sVi/K1SlzLybJQTkALGvLLfcJHh9pG7BcgtP7
         fz3w==
X-Gm-Message-State: ALoCoQmQPjQzCDaKOZb6D09NOEoL110r1W0BazoZLu3ixsFHsQbK1/1m2YClRSBuNIN3hQGGE12b8rEfCaSkGqnpRqu8L+sGPCeUNaYio01VTp8umkgQhdZ+H4DPB8KZFhl0PJSVFygQ7+F8D7hashDtlJXwrvT5HmG+jr4vFINYAB+7W2KEeqMEDZ46OY+jBv8v+n1w1g0F
X-Received: by 10.67.5.165 with SMTP id cn5mr14765520pad.9.1398725694548;
        Mon, 28 Apr 2014 15:54:54 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a44si2349978yhb.6.2014.04.28.15.54.54
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Apr 2014 15:54:54 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 259F231C20B;
	Mon, 28 Apr 2014 15:54:54 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id CC144E080D; Mon, 28 Apr 2014 15:54:53 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.528.g98b8868.dirty
In-Reply-To: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247488>

In s_update_ref there are two calls that when they fail we return an error
based on the errno value. In particular we want to return a specific error
if ENOTDIR happened. Both these functions do have failure modes where they
may return an error without updating errno, in which case a previous and
unrelated ENOTDIT may cause us to return the wrong error. Clear errno before
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
1.9.1.528.g98b8868.dirty
