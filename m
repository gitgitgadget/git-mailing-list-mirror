From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: turn on network daemon tests by default
Date: Thu, 13 Feb 2014 11:35:13 -0800
Message-ID: <xmqqfvnmlsb2.fsf@gitster.dls.corp.google.com>
References: <20140210191521.GA3112@sigill.intra.peff.net>
	<20140210212931.GA16154@sigill.intra.peff.net>
	<xmqqa9dxpgw9.fsf@gitster.dls.corp.google.com>
	<20140211200445.GA27946@sigill.intra.peff.net>
	<xmqqzjlxnqvw.fsf@gitster.dls.corp.google.com>
	<20140212214753.GA6799@sigill.intra.peff.net>
	<xmqq38jom037.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 13 20:35:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WE24e-0000vD-32
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 20:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbaBMTfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Feb 2014 14:35:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43568 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008AbaBMTfq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Feb 2014 14:35:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28A656C05A;
	Thu, 13 Feb 2014 14:35:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rFJcG2NSJOH0FXrEQPURkzRX7+g=; b=oshswP
	Y4WKakT1XQodttMyn5r7gxpCjcPWymMZ96/tUTdZQhOEWIc4rc9TKz0F33x+ZgD3
	nkTp5WCnO/plM7u8MqSywLl8aNt5RuI0dQmpjjIKu8WjHxixlZO0WNjOjYL9li1Q
	KKenqYnr4fz3K+AyVKGpcIADeRt8IxqBP5oyU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wg1XG+1tjx9H3OLdHmf6mpkn2hMB9Z6A
	eJTMI0nI0zPBnhkVbZzncGoHI2Mdzmn8XEfxDEQB5ClWGnN4SOSQ1zi47snuqW04
	RHflJjeMNTpitYgh4gAnngGQDRVog3QxscQWzKdje8Zh4TuJNMf4jkE7L7WG/Y39
	rOlSdNzGWe8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8F736C058;
	Thu, 13 Feb 2014 14:35:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6992D6C042;
	Thu, 13 Feb 2014 14:35:32 -0500 (EST)
In-Reply-To: <xmqq38jom037.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 12 Feb 2014 14:34:52 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 00953926-94E6-11E3-B574-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242074>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>>   test_normalize_tristate GIT_TEST_DAEMON
>
> Heh, great minds think alike.  This is what I am playing with,
> without committing (because I do like your "ask config if this is a
> kind of various boolean 'false' representations, which I haven't
> managed to add to it).

And this is with the "ask config" helper.

Two tangents.

 - We may want to do something similar in cvsserver and git-gui to
   make them more robust.

   $ git grep -e true --and -e 1 --and -e yes

 - Do we want to do something similar to GIT_TEST_CREDENTIAL_HELPER?

-- >8 --
From: Jeff King <peff@peff.net>
Date: Mon, 10 Feb 2014 16:29:37 -0500
Subject: [PATCH] tests: turn on network daemon tests by default

We do not run the httpd nor git-daemon tests by default, as
they are rather heavyweight and require network access
(albeit over localhost). However, it would be nice if more
pepole ran them, for two reasons:

  1. We would get more test coverage on more systems.

  2. The point of the test suite is to find regressions. It
     is very easy to change some of the underlying code and
     break the httpd code without realizing you are even
     affecting it. Running the httpd tests helps find these
     problems sooner (ideally before the patches even hit
     the list).

We still want to leave an "out", though, for people who really do
not want to run them. For that reason, the GIT_TEST_HTTPD and
GIT_TEST_GIT_DAEMON variables are now tri-state booleans
(true/false/auto), so you can say GIT_TEST_HTTPD=false to turn the
tests back off.  To support those who want a stable single way to
disable these tests across versions of Git before and after this
change, an empty string explicitly set to these variables is also
taken as "false", so the behaviour changes only for those who:

  a. did not express any preference by leaving these variables
     unset.  They did not test these features before, but now they
     do; or

  b. did express that they want to test these features by setting
     GIT_TEST_FEATURE=false (or any equivalent other ways to tell
     "false" to Git, e.g. "0"), which has been a valid but funny way
     to say that they do want to test the feature only because we
     used to interpret any non-empty string to mean "yes please
     test".  They no longer test that feature.

In addition, we are forgiving of common setup failures (e.g., you do
not have apache installed, or have an old version) when the
tri-state is "auto" (or empty), but report an error when it is
"true". This makes "auto" a sane default, as we should not cause
failures on setups where the tests cannot run. But it allows people
who use "true" to catch regressions in their system (e.g., they
uninstalled apache, but were expecting their automated test runs to
test git-httpd, and would want to be notified).

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/lib-git-daemon.sh     |  8 ++++---
 t/lib-httpd.sh          | 22 +++++++++----------
 t/test-lib-functions.sh | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+), 14 deletions(-)

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index 394b06b..615bf5d 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -16,9 +16,10 @@
 #	stop_git_daemon
 #	test_done
 
-if test -z "$GIT_TEST_GIT_DAEMON"
+test_tristate GIT_TEST_GIT_DAEMON
+if test "$GIT_TEST_GIT_DAEMON" = false
 then
-	skip_all="git-daemon testing disabled (define GIT_TEST_GIT_DAEMON to enable)"
+	skip_all="git-daemon testing disabled (unset GIT_TEST_GIT_DAEMON to enable)"
 	test_done
 fi
 
@@ -58,7 +59,8 @@ start_git_daemon() {
 		kill "$GIT_DAEMON_PID"
 		wait "$GIT_DAEMON_PID"
 		trap 'die' EXIT
-		error "git daemon failed to start"
+		test_skip_or_die $GIT_TEST_GIT_DAEMON \
+			"git daemon failed to start"
 	fi
 }
 
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index bfdff2a..f9c2e22 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -30,9 +30,10 @@
 # Copyright (c) 2008 Clemens Buchacher <drizzd@aon.at>
 #
 
-if test -z "$GIT_TEST_HTTPD"
+test_tristate GIT_TEST_HTTPD
+if test "$GIT_TEST_HTTPD" = false
 then
-	skip_all="Network testing disabled (define GIT_TEST_HTTPD to enable)"
+	skip_all="Network testing disabled (unset GIT_TEST_HTTPD to enable)"
 	test_done
 fi
 
@@ -76,8 +77,7 @@ GIT_VALGRIND_OPTIONS=$GIT_VALGRIND_OPTIONS; export GIT_VALGRIND_OPTIONS
 
 if ! test -x "$LIB_HTTPD_PATH"
 then
-	skip_all="skipping test, no web server found at '$LIB_HTTPD_PATH'"
-	test_done
+	test_skip_or_die $GIT_TEST_HTTPD "no web server found at '$LIB_HTTPD_PATH'"
 fi
 
 HTTPD_VERSION=`$LIB_HTTPD_PATH -v | \
@@ -89,19 +89,20 @@ then
 	then
 		if ! test $HTTPD_VERSION -ge 2
 		then
-			skip_all="skipping test, at least Apache version 2 is required"
-			test_done
+			test_skip_or_die $GIT_TEST_HTTPD \
+				"at least Apache version 2 is required"
 		fi
 		if ! test -d "$DEFAULT_HTTPD_MODULE_PATH"
 		then
-			skip_all="Apache module directory not found.  Skipping tests."
-			test_done
+			test_skip_or_die $GIT_TEST_HTTPD \
+				"Apache module directory not found"
 		fi
 
 		LIB_HTTPD_MODULE_PATH="$DEFAULT_HTTPD_MODULE_PATH"
 	fi
 else
-	error "Could not identify web server at '$LIB_HTTPD_PATH'"
+	test_skip_or_die $GIT_TEST_HTTPD \
+		"Could not identify web server at '$LIB_HTTPD_PATH'"
 fi
 
 prepare_httpd() {
@@ -155,9 +156,8 @@ start_httpd() {
 		>&3 2>&4
 	if test $? -ne 0
 	then
-		skip_all="skipping test, web server setup failed"
 		trap 'die' EXIT
-		test_done
+		test_skip_or_die $GIT_TEST_HTTPD "web server setup failed"
 	fi
 }
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index aeae3ca..b333e3f 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -716,6 +716,64 @@ perl () {
 	command "$PERL_PATH" "$@"
 }
 
+# Is the value one of the various ways to spell a boolean true/false?
+test_normalize_bool () {
+	git -c magic.variable="$1" config --bool magic.variable 2>/dev/null
+}
+
+# Given a variable $1, normalize the value of it to one of "true",
+# "false", or "auto" and store the result to it.
+#
+#     test_tristate GIT_TEST_HTTPD
+#
+# A variable set to an empty string is set to 'false'.
+# A variable set to 'false' or 'auto' keeps its value.
+# Anything else is set to 'true'.
+# An unset variable defaults to 'auto'.
+#
+# The last rule is to allow people to set the variable to an empty
+# string and export it to decline testing the particular feature
+# for versions both before and after this change.  We used to treat
+# both unset and empty variable as a signal for "do not test" and
+# took any non-empty string as "please test".
+
+test_tristate () {
+	if eval "test x\"\${$1+isset}\" = xisset"
+	then
+		# explicitly set
+		eval "
+			case \"\$$1\" in
+			'')	$1=false ;;
+			auto)	;;
+			*)	$1=\$(test_normalize_bool \$$1 || echo true) ;;
+			esac
+		"
+	else
+		eval "$1=auto"
+	fi
+}
+
+# Exit the test suite, either by skipping all remaining tests or by
+# exiting with an error. If "$1" is "auto", we then we assume we were
+# opportunistically trying to set up some tests and we skip. If it is
+# "true", then we report a failure.
+#
+# The error/skip message should be given by $2.
+#
+test_skip_or_die () {
+	case "$1" in
+	auto)
+		skip_all=$2
+		test_done
+		;;
+	true)
+		error "$2"
+		;;
+	*)
+		error "BUG: test tristate is '$1' (real error: $2)"
+	esac
+}
+
 # The following mingw_* functions obey POSIX shell syntax, but are actually
 # bash scripts, and are meant to be used only with bash on Windows.
 
-- 
1.9.0-rc3-260-g4cf525c
