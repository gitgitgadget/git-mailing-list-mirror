From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-sh-i18n: detect and avoid broken gettext(1)
 implementation
Date: Fri, 20 Jan 2012 12:00:07 -0800
Message-ID: <7vobtydu0o.fsf@alter.siamese.dyndns.org>
References: <CALxABCZWBtgX736Acoy-CCAz8RJb0EKnHf+7g72dOdVS+BOhSw@mail.gmail.com>
 <1327063775-28420-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 21:00:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoKdJ-0004OX-L1
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 21:00:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196Ab2ATUAN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Jan 2012 15:00:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59344 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706Ab2ATUAL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jan 2012 15:00:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B35637EFF;
	Fri, 20 Jan 2012 15:00:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=VfXL4oXqXSoh
	KIYMwvU1lFq4LFc=; b=IbR9oBBkojem9IQT6YAUfp99yOB7eJKd2ORC7nPTCx7O
	rjQLSgLzRRS3ChhMh+mNKSV9e4x9rt3sib8kyHxAJ+UMQLDnD9ipeCCjlIKyawZH
	+vtB5J74446RfMJBL+xENhqmuy4TRHygWAmPgCBHgfDlKa6+X/k4ekyiBmLINtE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QDOJRz
	Uwe4P6x3TXjLGbz3kbwDQYusR25j9Mv1DhEi+MuilWpvvrXBtTTecra+3tnHBGb3
	sNT3hd6eZkOHkCmmiDLjYLO0+/HBCdF6uHmEsHfvomtYw78b3FvxsEJIEb7MO7V/
	5tOtxnJHZAx+LpRqeimUt/AajObqhKRKpsF6Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB3017EFE;
	Fri, 20 Jan 2012 15:00:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6AC627EF4; Fri, 20 Jan 2012
 15:00:08 -0500 (EST)
In-Reply-To: <1327063775-28420-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 20 Jan
 2012 12:49:35 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B119932-43A1-11E1-A20A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188898>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Here's a minimal patch to git-sh-i18n that should make things work on
> Cygwin and any other platforms with broken gettext functions while
> also using the OS-provided functions if they work.

> I've added a new t0201-gettext-fallbacks-broken-gettext.sh test that
> tests this. This required a small change in lib-gettext.sh so I
> wouldn't load test-lib.sh twice.
>
> Note that there's already a t0201* test in the repo. Maybe we want to
> increment all the gettext test numbers by one to make room for it?
>
> As an aside I'm really not a big fan of having hardcoded numbers in
> the test files like this. We don't care about the order of execution
> here.

We do not care the order but we do care about the uniqueness in paralle=
l
test execution.

It does appear that we need a bit better preprocessing of git-sh-i18n a=
t
the compile time now. How about applying the restructuring shown in the
patch by Alex (without the @@NO_GETTEXT@@ bit) first without changing a=
ny
logic, then try making the "First decide what scheme to use" part light=
er
weight by replacing the runtime "type gettext.sh" and such checks with
some preprocessing?

IOW, the first step would look like the attached patch, and then we can
replace the entire "First decide" part if/elif/fi chain with just this:

	# The scheme to use
        : ${GIT_INTERNAL_GETTEXT_SH_SCHEME:=3D@@GETTEXT_SH_SCHEME@@}

so that t/lib-gettext.sh can define and export GIT_INTERNAL_GETTEXT_SH =
to
always get what it wants to test (fallthrough?). At build time, instead
of, or in addition to, the $(cmd_munge_script), we could replace the
single @@GETTEXT_SH_SCHEME@@ token above with whatever scheme we want t=
o
use to hardcode the decision we make at the compile time.

Hmm?

 git-sh-i18n.sh |  103 +++++++++++++++++++++++++++---------------------=
--------
 1 files changed, 50 insertions(+), 53 deletions(-)

diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index 26a57b0..6648bd3 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -16,61 +16,45 @@ else
 fi
 export TEXTDOMAINDIR
=20
-if test -z "$GIT_GETTEXT_POISON"
+# First decide what scheme to use...
+GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dfallthrough
+if test -n "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS"
+then
+	: no probing necessary
+elif test -n "$GIT_GETTEXT_POISON"
 then
-	if test -z "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS" && type gettext.sh =
>/dev/null 2>&1 && test "$(gettext test 2>&1)" =3D "test"
-	then
-		# This is GNU libintl's gettext.sh, we don't need to do anything
-		# else than setting up the environment and loading gettext.sh
-		GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dgnu
-		export GIT_INTERNAL_GETTEXT_SH_SCHEME
-
-		# Try to use libintl's gettext.sh, or fall back to English if we
-		# can't.
-		. gettext.sh
-
-	elif test -z "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS" && test "$(gettex=
t -h 2>&1)" =3D "-h"
-	then
-		# We don't have gettext.sh, but there's a gettext binary in our
-		# path. This is probably Solaris or something like it which has a
-		# gettext implementation that isn't GNU libintl.
-		GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dsolaris
-		export GIT_INTERNAL_GETTEXT_SH_SCHEME
-
-		# Solaris has a gettext(1) but no eval_gettext(1)
-		eval_gettext () {
-			gettext "$1" | (
-				export PATH $(git sh-i18n--envsubst --variables "$1");
-				git sh-i18n--envsubst "$1"
-			)
-		}
-
-	else
-		# Since gettext.sh isn't available we'll have to define our own
-		# dummy pass-through functions.
-
-		# Tell our tests that we don't have the real gettext.sh
-		GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dfallthrough
-		export GIT_INTERNAL_GETTEXT_SH_SCHEME
-
-		gettext () {
-			printf "%s" "$1"
-		}
-
-		eval_gettext () {
-			printf "%s" "$1" | (
-				export PATH $(git sh-i18n--envsubst --variables "$1");
-				git sh-i18n--envsubst "$1"
-			)
-		}
-	fi
-else
-	# Emit garbage under GETTEXT_POISON=3DYesPlease. Unlike the C tests
-	# this relies on an environment variable
-
 	GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dpoison
-	export GIT_INTERNAL_GETTEXT_SH_SCHEME
+elif type gettext.sh >/dev/null 2>&1
+then
+	# GNU libintl's gettext.sh
+	GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dgnu
+elif test "$(gettext -h 2>&1)" =3D "-h"
+then
+	# gettext binary exists but no gettext.sh. likely to be a gettext
+	# binary on a Solaris or something that is not GNU libintl and
+	# lack eval_gettext.
+	GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dgettext_without_eval_gettext
+fi
+export GIT_INTERNAL_GETTEXT_SH_SCHEME
=20
+# ... and then follow that decision.
+case "$GIT_INTERNAL_GETTEXT_SH_SCHEME" in
+gnu)
+	# Use libintl's gettext.sh, or fall back to English if we can't.
+	. gettext.sh
+	;;
+gettext_without_eval_gettext)
+	# Solaris has a gettext(1) but no eval_gettext(1)
+	eval_gettext () {
+		gettext "$1" | (
+			export PATH $(git sh-i18n--envsubst --variables "$1");
+			git sh-i18n--envsubst "$1"
+		)
+	}
+	;;
+poison)
+	# Emit garbage so that tests that incorrectly rely on translatable
+	# strings will fail.
 	gettext () {
 		printf "%s" "# GETTEXT POISON #"
 	}
@@ -78,7 +62,20 @@ else
 	eval_gettext () {
 		printf "%s" "# GETTEXT POISON #"
 	}
-fi
+	;;
+*)
+	gettext () {
+		printf "%s" "$1"
+	}
+
+	eval_gettext () {
+		printf "%s" "$1" | (
+			export PATH $(git sh-i18n--envsubst --variables "$1");
+			git sh-i18n--envsubst "$1"
+		)
+	}
+	;;
+esac
=20
 # Git-specific wrapper functions
 gettextln () {
