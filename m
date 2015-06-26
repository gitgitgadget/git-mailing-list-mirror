From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v9 5/5] bisect: allow any terms set by user
Date: Fri, 26 Jun 2015 10:20:00 +0200
Message-ID: <vpqegkyyj7z.fsf@anie.imag.fr>
References: <1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435258257-29047-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435258257-29047-6-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqk2urwjmq.fsf@gitster.dls.corp.google.com>
	<xmqqfv5fwib3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 10:20:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8Os3-00079U-6J
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 10:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbbFZIUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 04:20:18 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42421 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751585AbbFZIUM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 04:20:12 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5Q8JxQc020731
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 26 Jun 2015 10:19:59 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5Q8K0es002425;
	Fri, 26 Jun 2015 10:20:00 +0200
In-Reply-To: <xmqqfv5fwib3.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 25 Jun 2015 15:10:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 26 Jun 2015 10:19:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5Q8JxQc020731
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435911600.80706@SVw/nEyp+HnOLSq9D7wZbA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272767>

Junio C Hamano <gitster@pobox.com> writes:

> The second sentence may want to be something like
>
> 	If you mistyped one of the terms, you can do another "git
> 	bisect terms <term-new> <term-old>" to correct them, but
> 	that is possible only before you start the bisection.

Applied, thanks.

I currently have this in addition to v9 in my branch. I'll resend later
(https://github.com/moy/git/tree/bisect-terms is up to date).

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index e783f87..7609cd6 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -143,19 +143,19 @@ set your own terms.
 git bisect terms <term-new> <term-old>
 ------------------------------------------------
 
-This command has to be used before a bisection has started. <term-old>
-must be associated with the latest revisions and <term-new> with the
-ancestors of <term-old>. For example, if something was buggy in the
+This command has to be used before a bisection has started. <term-new>
+must be associated with the latest revisions and <term-old> with some
+ancestors of <term-new>. For example, if something was buggy in the
 old part of the history, you know somewhere the bug was fixed, and you
 want to find the exact commit that fixed it, you may want to say `git
-bisect terms fixed broken`; this way, you would mark a commit that
+bisect terms broken fixed`; this way, you would mark a commit that
 still has the bug with `broken`, and a newer one after the fix with
 `fixed`.
 
-Only the first bisection following the `git bisect terms` will use the
+Only the bisection following the `git bisect terms` will use the
 terms. If you mistyped one of the terms you can do again `git bisect
-terms <term-old> <term-new>`.
-
+terms <term-new> <term-old>`, but that is possible only before you
+start the bisection.
 
 Bisect visualize
 ~~~~~~~~~~~~~~~~
diff --git a/git-bisect.sh b/git-bisect.sh
index 8fee712..07c64d9 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -549,6 +549,20 @@ get_terms () {
        fi
 }
 
+write_terms () {
+       NAME_BAD=$1
+       NAME_GOOD=$2
+       check_term_format "$NAME_BAD"
+       check_term_format "$NAME_GOOD"
+       printf '%s\n%s\n' "$NAME_BAD" "$NAME_GOOD" >"$GIT_DIR/BISECT_TERMS"
+}
+
+check_term_format () {
+       term=$1
+       git check-ref-format refs/bisect/"$term" ||
+       die "$(eval_gettext "'\$term' is not a valid term")"
+}
+
 check_and_set_terms () {
        cmd="$1"
        case "$cmd" in
@@ -579,8 +593,8 @@ check_and_set_terms () {
 
 bisect_voc () {
        case "$1" in
-       bad) echo "bad|old" ;;
-       good) echo "good|new" ;;
+       bad) echo "bad|new" ;;
+       good) echo "good|old" ;;
        esac
 }
 
@@ -611,20 +625,6 @@ Otherwise, to start a new bisection with new terms, please use
        esac
 }
 
-write_terms () {
-       NAME_BAD=$1
-       NAME_GOOD=$2
-       check_term_format "$NAME_BAD"
-       check_term_format "$NAME_GOOD"
-       printf '%s\n%s\n' "$NAME_BAD" "$NAME_GOOD" >"$GIT_DIR/BISECT_TERMS"
-}
-
-check_term_format () {
-       term=$1
-       git check-ref-format refs/bisect/"$term" ||
-       die "$(eval_gettext "'\$term' is not a valid term")"
-}
-
 case "$#" in
 0)
        usage ;;

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
