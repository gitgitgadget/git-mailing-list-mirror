From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC]  test-lib.sh: preprocess to use PERL_PATH
Date: Fri, 22 Jun 2012 23:18:54 -0700
Message-ID: <7vipeilfe9.fsf@alter.siamese.dyndns.org>
References: <201206230704.38648.tboegi@web.de>
 <7vsjdmli06.fsf@alter.siamese.dyndns.org> <4FE55372.3080008@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Jun 23 08:19:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiJgW-0003Eg-8w
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jun 2012 08:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754656Ab2FWGS6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Jun 2012 02:18:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50500 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753373Ab2FWGS5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jun 2012 02:18:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 206CC57ED;
	Sat, 23 Jun 2012 02:18:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=gB5ediwfw7sY
	3EN2SXHIUvndYXI=; b=kwi9DA0/baSfufKeOZxeUgHqlCXf1iW/R5Nz63mHGnWo
	I580k0rpeOQeu7Cbmp3I/1fYS0ELxcGZFlT7CnOhpLcWHEFhFwu47nfL8i+qZTwb
	LYQLpNMS/FmZrqgfuckUB2qXWGnErzllDYYhMY0fp/sSC96YEs04vjWi80km6c8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XOnTj3
	cr8yxijNb3zJwCtT/+g02cNgpHSMgOpAqtz9WK36IqPSM/aiargnN8KM9yjBEUOO
	fEUoH+3rCWEToIHUO6gbrYTLnMf0v9+FqhKUm4cDa0t7IovjKMHpVunLRPeS8itw
	JFtyWNpIicCpoROcwU3F2ava0D79eGi8H3Thk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 173D757EC;
	Sat, 23 Jun 2012 02:18:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E78057EA; Sat, 23 Jun 2012
 02:18:56 -0400 (EDT)
In-Reply-To: <4FE55372.3080008@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Sat, 23 Jun 2012 07:26:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 501B9F72-BCFB-11E1-A437-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200493>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 23.06.12 07:22, Junio C Hamano wrote:
>> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>>
>>> All test cases found in t/*.sh must include test-lib instead of tes=
t-lib.sh
>> Please don't.  That is too much churning for too little gain, I am a=
fraid.
> Ok, would it be better to rename
>
> t/test-lib.sh -> t/test-lib.sh.sh
>
> and let the Makefile generate t/test-lib.sh?

It isn't as bad as the patch posted, but not very much.

There are number of a lot lower impact options before you
contemplate such a large change, given that there is only one
invocation of bare "perl" before GIT-BUILD-OPTIONS is dot-sourced.

 (1) Perhaps that use does not have any portability issues, and we
     can leave it as-is, with a comment to forbid people from
     turning into "$PERL_PATH" and be done with it?

 (2) Perhaps that use can be rewritten in such a way that it does
     not have to be done with perl in the first place?

 (3) Perhaps what that use of perl does can be delayed until we
     dot-source GIT-BUILD-OPTIONS and have $PERL_PATH defined, in
     which case we can move that use to a later position (and we can
     turn that sole use of perl into "$PERL_PATH")?

 (3) Perhaps what test-lib.sh does before it dot-sources
     GIT-BUILD-OPTIONS does not be affected if we dot-sourced
     GIT-BUILD-OPTIONS a lot earlier (and we can turn that sole use
     of perl into "$PERL_PATH")?


=46or example (this is not tested at all, nor I did not think it
through), a patch that moves the definition of TEST_DIRECTORY which
GIT_BUILD_DIR depends on higher, so that we can dot-source the file
a lot earlier, may look like this.


 t/test-lib.sh | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9e2b711..f3e7cf9 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -34,6 +34,26 @@ esac
 # Keep the original TERM for say_color
 ORIGINAL_TERM=3D$TERM
=20
+# Test the binaries we have just built.  The tests are kept in
+# t/ subdirectory and are run in 'trash directory' subdirectory.
+if test -z "$TEST_DIRECTORY"
+then
+	# We allow tests to override this, in case they want to run tests
+	# outside of t/, e.g. for running tests on the test library
+	# itself.
+	TEST_DIRECTORY=3D$(pwd)
+fi
+if test -z "$TEST_OUTPUT_DIRECTORY"
+then
+	# Similarly, override this to store the test-results subdir
+	# elsewhere
+	TEST_OUTPUT_DIRECTORY=3D$TEST_DIRECTORY
+fi
+GIT_BUILD_DIR=3D"$TEST_DIRECTORY"/..
+
+. "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
+export PERL_PATH SHELL_PATH
+
 # For repeatability, reset the environment to known value.
 LANG=3DC
 LC_ALL=3DC
@@ -46,7 +66,7 @@ EDITOR=3D:
 # /usr/xpg4/bin/sh and /bin/ksh to bail out.  So keep the unsets
 # deriving from the command substitution clustered with the other
 # ones.
-unset VISUAL EMAIL LANGUAGE COLUMNS $(perl -e '
+unset VISUAL EMAIL LANGUAGE COLUMNS $("$PERL_PATH" -e '
 	my @env =3D keys %ENV;
 	my $ok =3D join("|", qw(
 		TRACE
@@ -229,7 +249,7 @@ trap 'die' EXIT
=20
 # The user-facing functions are loaded from a separate file so that
 # test_perf subshells can have them too
-. "${TEST_DIRECTORY:-.}"/test-lib-functions.sh
+. "$TEST_DIRECTORY/test-lib-functions.sh"
=20
 # You are not expected to call test_ok_ and test_failure_ directly, us=
e
 # the text_expect_* functions instead.
@@ -380,23 +400,6 @@ test_done () {
 	esac
 }
=20
-# Test the binaries we have just built.  The tests are kept in
-# t/ subdirectory and are run in 'trash directory' subdirectory.
-if test -z "$TEST_DIRECTORY"
-then
-	# We allow tests to override this, in case they want to run tests
-	# outside of t/, e.g. for running tests on the test library
-	# itself.
-	TEST_DIRECTORY=3D$(pwd)
-fi
-if test -z "$TEST_OUTPUT_DIRECTORY"
-then
-	# Similarly, override this to store the test-results subdir
-	# elsewhere
-	TEST_OUTPUT_DIRECTORY=3D$TEST_DIRECTORY
-fi
-GIT_BUILD_DIR=3D"$TEST_DIRECTORY"/..
-
 if test -n "$valgrind"
 then
 	make_symlink () {
@@ -492,8 +495,6 @@ GIT_CONFIG_NOSYSTEM=3D1
 GIT_ATTR_NOSYSTEM=3D1
 export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_ATT=
R_NOSYSTEM
=20
-. "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
-
 if test -z "$GIT_TEST_CMP"
 then
 	if test -n "$GIT_TEST_CMP_USE_COPIED_CONTEXT"
