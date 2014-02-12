From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: turn on network daemon tests by default
Date: Wed, 12 Feb 2014 14:34:52 -0800
Message-ID: <xmqq38jom037.fsf@gitster.dls.corp.google.com>
References: <20140210191521.GA3112@sigill.intra.peff.net>
	<20140210212931.GA16154@sigill.intra.peff.net>
	<xmqqa9dxpgw9.fsf@gitster.dls.corp.google.com>
	<20140211200445.GA27946@sigill.intra.peff.net>
	<xmqqzjlxnqvw.fsf@gitster.dls.corp.google.com>
	<20140212214753.GA6799@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 12 23:35:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDiOc-0001jx-Tk
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 23:35:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754477AbaBLWfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 17:35:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64272 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754435AbaBLWfD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 17:35:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01FA46C419;
	Wed, 12 Feb 2014 17:35:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7Fuvewj5FbHIcVrxSnXgCd6rwYI=; b=XTnpj/
	bJgo3jQLJ2l4C+g2q1D5VU+O8P8nOg12l7yTc2S6eMT+D+DKXEix68SGg1vP/JSJ
	Ktbg0vapKITe8M44hSk3joCRpJxW6WO8RyItGMw5IVX0Z0+YwUcG4GU58OonIj0y
	rZxXyK41xnCiuqdHnLQbPe6iDGJklr8q+ak5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OkcnG0O1ZIIPkZOMBSZsmCLd7XSQPYPb
	invPipxDJGwjk41LCgL5ED6x9b31Z48lbwBZjvNyu5d8bIdIaJR33bVlMgheIo41
	s5FusJIOjqUB7P447WHQ/Db9zPYJlM3yqd4Rt5nuQIU05sNR9rneKp7buV1/xjp5
	9FcTU1klj5Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39F676C416;
	Wed, 12 Feb 2014 17:35:00 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6750F6C414;
	Wed, 12 Feb 2014 17:34:56 -0500 (EST)
In-Reply-To: <20140212214753.GA6799@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 12 Feb 2014 16:47:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E6026FF8-9435-11E3-8D39-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242030>

Jeff King <peff@peff.net> writes:

>   test_normalize_tristate GIT_TEST_DAEMON

Heh, great minds think alike.  This is what I am playing with,
without committing (because I do like your "ask config if this is a
kind of various boolean 'false' representations, which I haven't
managed to add to it).


 t/lib-git-daemon.sh     |  2 +-
 t/lib-httpd.sh          |  2 +-
 t/test-lib-functions.sh | 45 +++++++++++++++++++++++++++------------------
 3 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index 36106de..615bf5d 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -16,7 +16,7 @@
 #	stop_git_daemon
 #	test_done
 
-GIT_TEST_GIT_DAEMON=$(test_tristate "$GIT_TEST_GIT_DAEMON")
+test_tristate GIT_TEST_GIT_DAEMON
 if test "$GIT_TEST_GIT_DAEMON" = false
 then
 	skip_all="git-daemon testing disabled (unset GIT_TEST_GIT_DAEMON to enable)"
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 583fb14..f9c2e22 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -30,7 +30,7 @@
 # Copyright (c) 2008 Clemens Buchacher <drizzd@aon.at>
 #
 
-GIT_TEST_HTTPD=$(test_tristate "$GIT_TEST_HTTPD")
+test_tristate GIT_TEST_HTTPD
 if test "$GIT_TEST_HTTPD" = false
 then
 	skip_all="Network testing disabled (unset GIT_TEST_HTTPD to enable)"
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 3cc09c0..21c5214 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -716,27 +716,36 @@ perl () {
 	command "$PERL_PATH" "$@"
 }
 
-# Normalize the value given in $1 to one of "true", "false", or "auto". The
-# result is written to stdout. E.g.:
+# Given a variable $1, normalize the value of it to one of "true",
+# "false", or "auto" and store the result to it.
 #
-#     GIT_TEST_HTTPD=$(test_tristate "$GIT_TEST_HTTPD")
+#     test_tristate GIT_TEST_HTTPD
 #
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
 test_tristate () {
-	case "$1" in
-	""|auto)
-		echo auto
-		;;
-	*)
-		# Rely on git-config to handle all the variants of
-		# true/1/on/etc that we allow.
-		if ! git -c magic.hack="$1" config --bool magic.hack 2>/dev/null
-		then
-			# If git-config failed, it was some non-bool value like
-			# YesPlease. Default this to "true" for historical
-			# compatibility.
-			echo true
-		fi
-	esac
+	if eval "test x\"\${$1+isset}\" = xisset"
+	then
+		# explicitly set
+		eval "
+			case \"\$$1\" in
+			'')	$1=false ;;
+			false | auto) ;;
+			*)	$1=true ;;
+			esac
+		"
+	else
+		eval "$1=auto"
+	fi
 }
 
 # Exit the test suite, either by skipping all remaining tests or by
