From: Junio C Hamano <gitster@pobox.com>
Subject: [RFH/PATCH 4/4] OPT__FORCE(): clarify its expected use by using OPT_COUNTUP
Date: Tue,  6 Aug 2013 16:31:29 -0700
Message-ID: <1375831889-9610-5-git-send-email-gitster@pobox.com>
References: <7viozihh26.fsf@alter.siamese.dyndns.org>
 <1375831889-9610-1-git-send-email-gitster@pobox.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 07 01:31:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6qjH-0003DW-2a
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 01:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756266Ab3HFXbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 19:31:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57440 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754786Ab3HFXbk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 19:31:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EF2B36D3B;
	Tue,  6 Aug 2013 23:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=DCK7
	nof87OwzQ7EdZIxaJhoSjJA=; b=XBV4gH0UjI1lWScx03QnIevPvGnhNye4hkgp
	sQNC9KwRE8TA9kgHXM7zrXfyiEOkNvEDxnhBqSXIMhhRjn32VAuKx1fmnK8XDORf
	6tOOe7iYfqKYRfkPMQ+1kMgjbFgTb0sioChTInLA29xt7Tm/GasbgbGNGVZqx56+
	Uxv7p+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	isAcLDWHnGBJmHvGVd507967H1AmVv50xXMxcy4v6uRvbKFwOP3242O3a5X2FDGc
	HIa8zBQIgMy3zDavoulRU5lKav3wjN0TaRTuJ/EVZetsG3B8/q+t3fvVeoSaAdBr
	2UNI7gg812XnKB9n3I8uTnSN0mYTfQiYgcV3LKY911Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34EF836D38;
	Tue,  6 Aug 2013 23:31:40 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7464D36D35;
	Tue,  6 Aug 2013 23:31:39 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-rc1-210-gf6d87e2
In-Reply-To: <1375831889-9610-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 57E6476A-FEF0-11E2-BA18-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231798>

The parseopt parsing for OPT__FORCE() is implemented in terms of
OPT_BOOLEAN() and users of it can take advantage of the "counting
up" behaviour to implement increasing levels of forcefulness by
differentiating "git cmd -f" and "git cmd -f -f".

Clarify this by explicitly using OPT_COUNTUP() instead.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This _should_ be done with a similar audit of existing callers,
   but I ran out of concentration.

 parse-options.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options.h b/parse-options.h
index 78f52c2..1eeb0d9 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -238,7 +238,7 @@ extern int parse_opt_noop_cb(const struct option *, const char *, int);
 	{ OPTION_CALLBACK, 'q', "quiet", (var), NULL, N_("be more quiet"), \
 	  PARSE_OPT_NOARG, &parse_opt_verbosity_cb, 0 }
 #define OPT__DRY_RUN(var, h)  OPT_BOOL('n', "dry-run", (var), (h))
-#define OPT__FORCE(var, h)    OPT_BOOLEAN('f', "force",   (var), (h))
+#define OPT__FORCE(var, h)    OPT_COUNTUP('f', "force",   (var), (h))
 #define OPT__ABBREV(var)  \
 	{ OPTION_CALLBACK, 0, "abbrev", (var), N_("n"),	\
 	  N_("use <n> digits to display SHA-1s"),	\
-- 
1.8.4-rc1-210-gf6d87e2
