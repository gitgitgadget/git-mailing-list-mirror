From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/7] grep.c: mark private file-scope symbols as static
Date: Sat, 15 Sep 2012 14:10:50 -0700
Message-ID: <1347743452-2487-5-git-send-email-gitster@pobox.com>
References: <5054AA62.2040603@ramsay1.demon.co.uk>
 <1347743452-2487-1-git-send-email-gitster@pobox.com>
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 15 23:11:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCze3-0004wn-3I
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 23:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193Ab2IOVLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2012 17:11:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61845 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752682Ab2IOVLD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 17:11:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FB84856A;
	Sat, 15 Sep 2012 17:11:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=84bQ
	MNC6P8rAYiXxdYIPSV9KLE0=; b=tKC8YGBqBCQ8vz8cjaTs78zQY7I47T4iJN5x
	FIRhbpt0kkIoNPCfZF5cA21yk3LStSet27hmMxsqWrPJhgOVlfTGuDpMd6axc4KP
	9AGp7gK0zCJCzFZPwSlnIAK7MjAcfO20BFDHUAoaw8UKiamiFvmSg4CKSTHbGZsP
	agLglwk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	vaX6a77SgOYQD0AKgCKNF70TcFScWsQFX3Pcrz2c1ZPdWKqhqAmY5oCr82O98kWJ
	NK1KGUp1Qu5TZV8WBpD22GVNItLkSud7XynLsSC1WEyUykjwkXwE25sXGSIB4kLB
	y1AIs0GELvlKg+30mbl/TNmEJiMLJi0NJ2h/JJAFqbw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7645A8569;
	Sat, 15 Sep 2012 17:11:02 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C4FF18565; Sat, 15 Sep 2012
 17:11:01 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.508.g4d78187
In-Reply-To: <1347743452-2487-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: DA6710D8-FF79-11E1-8307-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205578>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 grep.c | 6 +++++-
 grep.h | 3 +--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/grep.c b/grep.c
index 925aa92..c7f8a47 100644
--- a/grep.c
+++ b/grep.c
@@ -3,6 +3,10 @@
 #include "userdiff.h"
 #include "xdiff-interface.h"
 
+static int grep_source_load(struct grep_source *gs);
+static int grep_source_is_binary(struct grep_source *gs);
+
+
 static struct grep_pat *create_grep_pat(const char *pat, size_t patlen,
 					const char *origin, int no,
 					enum grep_pat_token t,
@@ -403,7 +407,7 @@ static void dump_grep_expression_1(struct grep_expr *x, int in)
 	}
 }
 
-void dump_grep_expression(struct grep_opt *opt)
+static void dump_grep_expression(struct grep_opt *opt)
 {
 	struct grep_expr *x = opt->pattern_expression;
 
diff --git a/grep.h b/grep.h
index 00d71f7..8a28a67 100644
--- a/grep.h
+++ b/grep.h
@@ -159,11 +159,10 @@ struct grep_source {
 
 void grep_source_init(struct grep_source *gs, enum grep_source_type type,
 		      const char *name, const void *identifier);
-int grep_source_load(struct grep_source *gs);
 void grep_source_clear_data(struct grep_source *gs);
 void grep_source_clear(struct grep_source *gs);
 void grep_source_load_driver(struct grep_source *gs);
-int grep_source_is_binary(struct grep_source *gs);
+
 
 int grep_source(struct grep_opt *opt, struct grep_source *gs);
 
-- 
1.7.12.508.g4d78187
