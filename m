From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] OPT__VERBOSE(): clarify its expected use by using OPT_COUNTUP
Date: Tue,  6 Aug 2013 16:31:27 -0700
Message-ID: <1375831889-9610-3-git-send-email-gitster@pobox.com>
References: <7viozihh26.fsf@alter.siamese.dyndns.org>
 <1375831889-9610-1-git-send-email-gitster@pobox.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 07 01:31:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6qjG-0003DW-Gs
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 01:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756243Ab3HFXbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 19:31:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46370 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756073Ab3HFXbg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 19:31:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4E3236D2A;
	Tue,  6 Aug 2013 23:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=18vr
	h8vIJonPu6IpYadsHmgluWM=; b=oakbdippGS6W740kC231EyOVJuETiKf/owES
	ioR3zHIozndwY/zc+KijCYK1BIGL9sYpyrMIUDujEe7bsB3SzpwTfQxpdMO4E9SJ
	N5MJVazGEF4OtGWk6wfSA7ZKD0ZnwLFBPJIQBKwfJh4rSarkbjO1HvZqN+WHD+mY
	ApA2fCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	jBokqu97+/ZeRWP+oUZQ/4HUkX423BPLYZ1xGJzfMik/G391g9K8o0AW25kpCYnB
	jyKG2BlPmoYW4iL5ROlrOvXRSYHxK+HQV5ODW99rz6dcf8mYCTiY/1S5wYWf5qrP
	U/QW0yoQNmG2sCvHvEVF3DAk4frgTTbnLhmTI6IUIBM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8D9036D29;
	Tue,  6 Aug 2013 23:31:35 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2773836D26;
	Tue,  6 Aug 2013 23:31:35 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-rc1-210-gf6d87e2
In-Reply-To: <1375831889-9610-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5553B4D8-FEF0-11E2-A1F1-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231797>

The parseopt parsing for OPT__VERBOSE() is implemented in terms of
OPT_BOOLEAN() and users of it do take advantage of the "counting up"
behaviour to implement increasing levels of verbosity by
differentiating "git cmd -v" and "git cmd -v -v".

Clarify this by explicitly using OPT_COUNTUP() instead.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 parse-options.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options.h b/parse-options.h
index f2b01ee..582dd4b 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -230,7 +230,7 @@ extern int parse_opt_tertiary(const struct option *, const char *, int);
 extern int parse_opt_string_list(const struct option *, const char *, int);
 extern int parse_opt_noop_cb(const struct option *, const char *, int);
 
-#define OPT__VERBOSE(var, h)  OPT_BOOLEAN('v', "verbose", (var), (h))
+#define OPT__VERBOSE(var, h)  OPT_COUNTUP('v', "verbose", (var), (h))
 #define OPT__QUIET(var, h)    OPT_BOOL('q', "quiet",   (var), (h))
 #define OPT__VERBOSITY(var) \
 	{ OPTION_CALLBACK, 'v', "verbose", (var), NULL, N_("be more verbose"), \
-- 
1.8.4-rc1-210-gf6d87e2
