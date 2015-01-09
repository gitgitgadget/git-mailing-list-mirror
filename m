From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] gettext.h: add parentheses around N_ expansion if supported
Date: Fri, 09 Jan 2015 14:22:46 -0800
Message-ID: <xmqqwq4vbnm1.fsf@gitster.dls.corp.google.com>
References: <aea96640a01b65776eb0474aaceded5@74d39fa044aa309eaea14b9f57fe79c>
	<xmqqa91tf5ql.fsf@gitster.dls.corp.google.com>
	<61CC69D2-A0F2-4BE2-B37A-F1D8FE19C45A@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git mailing list <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 23:22:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9hxG-0001ig-FV
	for gcvg-git-2@plane.gmane.org; Fri, 09 Jan 2015 23:22:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbbAIWWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2015 17:22:50 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64508 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752313AbbAIWWt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2015 17:22:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 51AFA2CF8E;
	Fri,  9 Jan 2015 17:22:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hXN1VWUcTw5wd2iOz0E14CVsC1s=; b=BGHYzP
	acM54+bm/ymlvdtR+wK+qQ0rszFTk5RxuwUNOLEqXJPmVWEZCA0zXH1Ay5WWzSz/
	bIhPKR5yj2t0I6nFPq0cEHh8mj4RIyFV7nfvdZOX6Zn4c03zdG+jXasOrPsDhg0t
	BNN2ucF4wU8TdYKP243vxgc5/6SSIkz7RcTvA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cLvZnP5N+A8bEtPYqJfjqzZAZB8IlUOf
	MFQJCb664yWJIcii1QC83htlJudQm3hPKXdRZG7eAR3SFYY9ytOW5rRvdHrg2SXO
	rqE0Sa8vwN1L0SXHfdwBiqlRqRPXptj9FSh9fXKI+sI7VLoreR1PQh9zS4d7XSs9
	xJZiia04syY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 47A9A2CF8D;
	Fri,  9 Jan 2015 17:22:48 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9A4A82CF8C;
	Fri,  9 Jan 2015 17:22:47 -0500 (EST)
In-Reply-To: <61CC69D2-A0F2-4BE2-B37A-F1D8FE19C45A@gmail.com> (Kyle J. McKay's
	message of "Thu, 8 Jan 2015 20:55:11 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0A58C6C8-984E-11E4-B662-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262245>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> I'm not super attached to this change, it's just that it seems to me
> that translation support for Git is a scarce resource.  I'm guessing
> that when considering the 7 complete translations (bg, ca, de, fr, sv,
> vi and zh_CN) the average number of translators per language is in the
> low single digits.  So I hate to see unnecessary translation churn,
> not when it can be so easily prevented.

Yes, I share the same feeling and I agree that it is a worthy goal.

I just did not want an unconditional "#ifdef __GNUC__" that nobody
can override without editing the source, when __GNUC__ is a rough
approximation whether a specific language extension exists and is
enabled (we do not know which -W<option> or options like --pedantic
that will be added in the future would interfere with us).

What I had in mind instead was something along this line (but with a
better make variable name).  In an unconfigured build, it decides
between ("msg") and "msg" using the same __GNUC__ heuristic, but
that can be overridden from the $(MAKE) command line in a pinch.

I do not do autoconf, but it would be trivial to set CAN_USE_* by
try-compiling a small program.

 Makefile          | 17 ++++++++++++++++-
 gettext.h         | 24 ++++++++++++++++++++++++
 git-compat-util.h |  7 +++++++
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 06e5d24..48f4ce2 100644
--- a/Makefile
+++ b/Makefile
@@ -343,6 +343,12 @@ all::
 # return NULL when it receives a bogus time_t.
 #
 # Define HAVE_CLOCK_GETTIME if your platform has clock_gettime in librt.
+#
+# Define CAN_USE_CONSTANT_STRING_IN_PARENTHESES to Yes if your compiler
+# happily compiles the following initialization:
+#     static const char s[] = ("FOO");
+# and define it to No if you need to remove the parentheses () around the
+# constant.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -950,6 +956,16 @@ ifneq (,$(SOCKLEN_T))
 	BASIC_CFLAGS += -Dsocklen_t=$(SOCKLEN_T)
 endif
 
+ifeq (Yes,$(CAN_USE_CONSTANT_STRING_IN_PARENTHESES))
+	BASIC_CFLAGS += -DUSE_PARENS_AROUND_N=1
+else
+ifneq (,$(CAN_USE_CONSTANT_STRING_IN_PARENTHESES))
+	BASIC_CFLAGS += -DUSE_PARENS_AROUND_N=0
+else
+	BASIC_CFLAGS += -DUSE_PARENS_AROUND_N=-1
+endif
+endif
+
 ifeq ($(uname_S),Darwin)
 	ifndef NO_FINK
 		ifeq ($(shell test -d /sw/lib && echo y),y)
@@ -2486,4 +2502,3 @@ cover_db: coverage-report
 
 cover_db_html: cover_db
 	cover -report html -outputdir cover_db_html cover_db
-
diff --git a/gettext.h b/gettext.h
index 7671d09..9b54ded 100644
--- a/gettext.h
+++ b/gettext.h
@@ -63,6 +63,30 @@ const char *Q_(const char *msgid, const char *plu, unsigned long n)
 }
 
 /* Mark msgid for translation but do not translate it. */
+#if !USE_PARENS_AROUND_N
 #define N_(msgid) msgid
+#else
+/*
+ * Strictly speaking, this will lead to invalid C when
+ * used this way:
+ *     static const char s[] = N_("FOO");
+ * which will expand to
+ *     static const char s[] = ("FOO");
+ * and in valid C, the initializer on the right hand side must
+ * be without the parentheses.  But many compilers do accept it
+ * as a language extension and it will allow us to catch mistakes
+ * like:
+ *     static const char **msgs = {
+ *                N_("one")
+ *                N_("two"),
+ *                N_("three"),
+ *                NULL
+ *     }
+ * (notice the missing comma on one of the lines) by forcing
+ * an compilation error, because parenthesised ("one") ("two")
+ * will not get silently turned into ("onetwo").
+ */
+#define N_(msgid) (msgid)
+#endif
 
 #endif
diff --git a/git-compat-util.h b/git-compat-util.h
index dcecd85..8640163 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -867,4 +867,11 @@ struct tm *git_gmtime_r(const time_t *, struct tm *);
 #define gmtime_r git_gmtime_r
 #endif
 
+#if USE_PARENS_AROUND_N == -1
+#  ifdef __GNUC__
+#    undef USE_PARENS_AROUND_N
+#    define USE_PARENS_AROUND_N 1
+#  endif
+#endif
+
 #endif
