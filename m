From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] sh-setup: explicitly mark CR as a field separator
Date: Mon, 26 Oct 2015 13:07:11 -0700
Message-ID: <xmqqbnblgzrk.fsf@gitster.mtv.corp.google.com>
References: <cover.1445777347.git.johannes.schindelin@gmx.de>
	<cover.1445782122.git.johannes.schindelin@gmx.de>
	<2b089201404299257f23b3931499ea16202f0f65.1445782122.git.johannes.schindelin@gmx.de>
	<vpqlhaqas8g.fsf@grenoble-inp.fr>
	<xmqq8u6piir8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Chad Boles <chadbo@microsoft.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Philip Oakley <philipoakley@iee.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Oct 26 21:07:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zqo37-0006xK-Hz
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 21:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807AbbJZUHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 16:07:15 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57095 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751603AbbJZUHN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 16:07:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B5BD426961;
	Mon, 26 Oct 2015 16:07:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0uwpAfGsL1PwBeNfXKRVXTNy5p8=; b=HZeMxp
	3AQ1fLmbGyceNaKzzaEKEmAEtriqRnfguGtGuHW1bRXN4lPlrXSThQ/spOeUpK+1
	J8PrUO5X77osWi5xNW3PzEJnw9R0rTHSuuprN3z82eywdjPqGE31NT1GkNkwz9vb
	2rMTSjbHxTIbUOVw6gEektgFb0M9miRpEPcEE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UlUHCIadfEF07/BulOvIJ1ISPhQNpLQ5
	e8COskhwkmFflEnM0jSFJyEd3Zbc0dOtyB6WIkPRkG0CH8oYCQlh+eB813Dbn3kw
	HS2WBCkhCcbPTcK+VBNFLWME3K0fmSA9U48w6nqaYb3zL7Dl4CJsuXGwPOSEOVVN
	0TpBxcrHhdU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ABC7726960;
	Mon, 26 Oct 2015 16:07:12 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2D4282695F;
	Mon, 26 Oct 2015 16:07:12 -0400 (EDT)
In-Reply-To: <xmqq8u6piir8.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 26 Oct 2015 11:31:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 250A3E8A-7C1D-11E5-BD48-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280216>

Junio C Hamano <gitster@pobox.com> writes:

> Something along the line of the following would be tolerable, even
> though I think in the longer term, not just in Git land but in the
> larger ecosystem to use POSIXy tools on Windows, the best solution
> is to fix the shell so that it matches the expectation of the users
> of its platform.
>
> I say "something along the line of" here because I do not know how
> the problematic shell behaves on the assignment command that stuffs
> a lone CR into a variable.  It _might_ need a similar protection
> against the shell feature "the last EOL is removed from the result
> of command expansion", as I did in the above example, depending on
> how incoherent the implementation is.  The implementation seems to
> accept CRLF and LF in shell scripts proper just fine, but apparently
> its implementation of "read" does not honor such platform EOL
> convention, which caused this issue, and I don't know what it does
> in the codepath that implements command expansion.

I still have to say "something along the lines of" as I do not have
(and I do not wish to have, to be honest) an access to test this
with the problematic shell implementation, but here is an updated
patch.

-- >8 --
Subject: [PATCH] rebase-i: work around Windows CRLF line endings

Editors on Windows can and do save text files with CRLF line
endings, which is the convention on the platform.  We are seeing
reports that the "read" command in a port of bash to the environment
however does not strip the CRLF at the end, not adjusting for the
same convention on the platform.

This breaks the recently added sanity checks for the insn sheet fed
to "rebase -i"; instead of an empty line (hence nothing in $command),
the script was getting a lone CR in there.

Special case a lone CR and treat it the same way as an empty line to
work this around.

The test was stolen from Dscho.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-rebase--interactive.sh    | 13 +++++++++++++
 t/t3404-rebase-interactive.sh | 12 ++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c42ba34..3911711 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -77,6 +77,10 @@ amend="$state_dir"/amend
 rewritten_list="$state_dir"/rewritten-list
 rewritten_pending="$state_dir"/rewritten-pending
 
+# Work around a Windows port of shell that does not strip
+# the newline at the end of a line correctly.
+cr=$(printf "\015")
+
 strategy_args=
 if test -n "$do_merge"
 then
@@ -518,6 +522,11 @@ do_next () {
 	"$comment_char"*|''|noop|drop|d)
 		mark_action_done
 		;;
+	"$cr")
+		# Windows port of shell not stripping the newline
+		# at the end of an empty line correctly.
+		mark_action_done
+		;;
 	pick|p)
 		comment_for_reflog pick
 
@@ -888,6 +897,10 @@ check_bad_cmd_and_sha () {
 		"$comment_char"*|''|noop|x|exec)
 			# Doesn't expect a SHA-1
 			;;
+		"$cr")
+			# Windows port of shell not stripping the newline
+			# at the end of an empty line correctly.
+			;;
 		pick|p|drop|d|reword|r|edit|e|squash|s|fixup|f)
 			if ! check_commit_sha "${rest%%[ 	]*}" "$lineno" "$1"
 			then
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 88d7d53..2f97a3d 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1240,4 +1240,16 @@ test_expect_success 'static check of bad SHA-1' '
 	test E = $(git cat-file commit HEAD | sed -ne \$p)
 '
 
+test_expect_success 'editor saves as CR/LF' '
+	git checkout -b with-crlf &&
+	write_script add-crs.sh <<-\EOF &&
+	sed -e "s/\$/Q/" <"$1" | tr Q "\\015" >"$1".new &&
+	mv -f "$1".new "$1"
+	EOF
+	(
+		test_set_editor "$(pwd)/add-crs.sh" &&
+		git rebase -i HEAD^
+	)
+'
+
 test_done
-- 
2.6.2-405-g6877da6
