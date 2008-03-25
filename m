From: Junio C Hamano <junio@pobox.com>
Subject: [PATCH 1/5] parse-options.c: introduce OPT_DATE
Date: Mon, 24 Mar 2008 23:59:02 -0700
Message-ID: <7vhcevnvbd.fsf@gitster.siamese.dyndns.org>
References: <200803232150.29971.barra_cuda@katamail.com>
 <200803241502.21465.barra_cuda@katamail.com>
 <7vwsnrubmd.fsf@gitster.siamese.dyndns.org>
 <200803242218.44026.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 08:00:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je38c-0002nz-Dm
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 08:00:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696AbYCYG7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 02:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752369AbYCYG7T
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 02:59:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57869 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499AbYCYG7R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 02:59:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 83C1E2F7F;
	Tue, 25 Mar 2008 02:59:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B34F92F7D; Tue, 25 Mar 2008 02:59:11 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78154>

From: Michele Ballabio <barra_cuda@katamail.com>
Date: Mon, 24 Mar 2008 15:02:21 +0100

There are quite a few places that will need to call approxidate(),
when they'll adopt the parse-options system, so this patch adds the
function parse_opt_approxidate_cb(), used by OPT_DATE.

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 parse-options.c |    7 +++++++
 parse-options.h |    4 ++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 8e64316..e87cafb 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -409,3 +409,10 @@ int parse_opt_abbrev_cb(const struct option *opt, const char *arg, int unset)
 	*(int *)(opt->value) = v;
 	return 0;
 }
+
+int parse_opt_approxidate_cb(const struct option *opt, const char *arg,
+			     int unset)
+{
+	*(unsigned long *)(opt->value) = approxidate(arg);
+	return 0;
+}
diff --git a/parse-options.h b/parse-options.h
index 1af62b0..4ee443d 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -94,6 +94,9 @@ struct option {
 #define OPT_SET_PTR(s, l, v, h, p)  { OPTION_SET_PTR, (s), (l), (v), NULL, (h), 0, NULL, (p) }
 #define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), NULL, (h) }
 #define OPT_STRING(s, l, v, a, h)   { OPTION_STRING,  (s), (l), (v), (a), (h) }
+#define OPT_DATE(s, l, v, h) \
+	{ OPTION_CALLBACK, (s), (l), (v), "time",(h), 0, \
+	  parse_opt_approxidate_cb }
 #define OPT_CALLBACK(s, l, v, a, h, f) \
 	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), 0, (f) }
 
@@ -110,6 +113,7 @@ extern NORETURN void usage_with_options(const char * const *usagestr,
 
 /*----- some often used options -----*/
 extern int parse_opt_abbrev_cb(const struct option *, const char *, int);
+extern int parse_opt_approxidate_cb(const struct option *, const char *, int);
 
 #define OPT__VERBOSE(var)  OPT_BOOLEAN('v', "verbose", (var), "be verbose")
 #define OPT__QUIET(var)    OPT_BOOLEAN('q', "quiet",   (var), "be quiet")
-- 
1.5.5.rc1.121.g1594
