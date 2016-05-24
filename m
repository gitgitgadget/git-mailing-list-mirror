From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-prompt.sh: Don't error on null ${ZSH,BASH}_VERSION
Date: Tue, 24 May 2016 10:27:59 -0700
Message-ID: <xmqqshx75psw.fsf@gitster.mtv.corp.google.com>
References: <1464078713-3220-1-git-send-email-ville.skytta@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Ville =?utf-8?Q?Skytt=C3=A4?= <ville.skytta@iki.fi>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue May 24 19:28:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5G7l-0006MH-76
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 19:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755913AbcEXR2F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 May 2016 13:28:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64703 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755324AbcEXR2E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2016 13:28:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BEAE91D194;
	Tue, 24 May 2016 13:28:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=T5tTBNUe7UpG
	FMJd4AxZDxrwGwk=; b=iCoTc/Gl5160U+YinIAsra83wopZFfTDvEZZRbYrYW5j
	S9GOW0Veni7CI4f0Cki8orprYu2ek9dVGGcxthnOWVVSXCG50sphcSYdf0ck7OWQ
	3CzjS6Q08hT6wdsG6rQOSW/P+N7lPD9GumDiflAn9MChnoyoQJC3eo6b0wuDjOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Sjrn96
	4o9FpaymMEV9RfHpJFyPiBezUNKTyiXZdY21vjWPVepD8Ihy8KshEWFPAU4GBq24
	maapbizTyH9UK/xOvwqG8zi5kvX63PNj1v2Diy7BIbzbJz0u4RpCSM1s3oyG9zfb
	MqVeN5gfODJhVFTgmISPw8LnfZItxA1fVQ2Dw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AF0451D192;
	Tue, 24 May 2016 13:28:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D35F11D191;
	Tue, 24 May 2016 13:28:01 -0400 (EDT)
In-Reply-To: <1464078713-3220-1-git-send-email-ville.skytta@iki.fi> ("Ville
	=?utf-8?Q?Skytt=C3=A4=22's?= message of "Tue, 24 May 2016 11:31:53 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DDC4D7E8-21D4-11E6-AC46-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295508>

Ville Skytt=C3=A4 <ville.skytta@iki.fi> writes:

> When the shell is in "nounset" or "set -u" mode, referencing unset or
> null variables results in an error. Protect $ZSH_VERSION and
> $BASH_VERSION against that.
>  	local ps1_expanded=3Dyes
> -	[ -z "$ZSH_VERSION" ] || [[ -o PROMPT_SUBST ]] || ps1_expanded=3Dno
> -	[ -z "$BASH_VERSION" ] || shopt -q promptvars || ps1_expanded=3Dno
> +	[ -z "${ZSH_VERSION-}" ] || [[ -o PROMPT_SUBST ]] || ps1_expanded=3D=
no
> +	[ -z "${BASH_VERSION-}" ] || shopt -q promptvars || ps1_expanded=3D=
no

I wonder if we can teach t9903 to run (at least) some parts of the
completion script under "set -u" to catch these automatically without
a report from an end user.

With the attached "just started to scratch the surface" patch to
test-lib.sh and fix by Ville to the git-prompt.sh script, we find
another one.

    ...contrib/completion/git-prompt.sh: line 481: short_sha: unbound v=
ariable

Ville, I think you want to take the "git-prompt.sh" part from the
following and replace it with your patch.

Others, I am not sure how seriously we would want to support those
who use "set -u"; the damage to test-lib.sh so far (see below) does
not look _too_ bad, but the reason why I have "set -u" after
including lib-bash.sh is because it will trigger a lot more errors
while lib-bash and test-lib do their preparation.

 contrib/completion/git-prompt.sh | 5 +++--
 t/t9903-bash-prompt.sh           | 2 ++
 t/test-lib.sh                    | 8 +++++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-=
prompt.sh
index 64219e6..ed994a9 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -355,8 +355,8 @@ __git_ps1 ()
 	# incorrect.)
 	#
 	local ps1_expanded=3Dyes
-	[ -z "$ZSH_VERSION" ] || [[ -o PROMPT_SUBST ]] || ps1_expanded=3Dno
-	[ -z "$BASH_VERSION" ] || shopt -q promptvars || ps1_expanded=3Dno
+	[ -z "${ZSH_VERSION-}" ] || [[ -o PROMPT_SUBST ]] || ps1_expanded=3Dn=
o
+	[ -z "${BASH_VERSION-}" ] || shopt -q promptvars || ps1_expanded=3Dno
=20
 	local repo_info rev_parse_exit_code
 	repo_info=3D"$(git rev-parse --git-dir --is-inside-git-dir \
@@ -369,6 +369,7 @@ __git_ps1 ()
 	fi
=20
 	local short_sha
+	short_sha=3D
 	if [ "$rev_parse_exit_code" =3D "0" ]; then
 		short_sha=3D"${repo_info##*$'\n'}"
 		repo_info=3D"${repo_info%$'\n'*}"
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 0db4469..96b5ff8 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -7,6 +7,8 @@ test_description=3D'test git-specific bash prompt funct=
ions'
=20
 . ./lib-bash.sh
=20
+set -u
+
 . "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
=20
 actual=3D"$TRASH_DIRECTORY/actual"
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0055ebb..36ca13e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -186,6 +186,9 @@ test "x$TERM" !=3D "xdumb" && (
 	) &&
 	color=3Dt
=20
+HARNESS_ACTIVE=3D quiet=3D verbose_only=3D run_list=3D trace=3D
+: ${GIT_SKIP_TESTS=3D}
+
 while test "$#" -ne 0
 do
 	case "$1" in
@@ -585,7 +588,7 @@ test_eval_ () {
=20
 test_run_ () {
 	test_cleanup=3D:
-	expecting_failure=3D$2
+	expecting_failure=3D${2-}
=20
 	if test "${GIT_TEST_CHAIN_LINT:-1}" !=3D 0; then
 		# turn off tracing for this test-eval, as it simply creates
@@ -750,6 +753,8 @@ test_done () {
 	esac
 }
=20
+GIT_VALGRIND=3D
+
 if test -n "$valgrind"
 then
 	make_symlink () {
@@ -902,6 +907,7 @@ fi
 # in subprocesses like git equals our $PWD (for pathname comparisons).
 cd -P "$TRASH_DIRECTORY" || exit 1
=20
+skip_all=3D
 this_test=3D${0##*/}
 this_test=3D${this_test%%-*}
 if match_pattern_list "$this_test" $GIT_SKIP_TESTS
