From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1402-check-ref-format: skip tests of refs beginning
 with slash on Windows
Date: Thu, 13 Oct 2011 16:07:09 -0700
Message-ID: <7vbotk32zm.fsf@alter.siamese.dyndns.org>
References: <1318492715-5931-1-git-send-email-mhagger@alum.mit.edu>
 <4E969BFC.50706@viscovery.net> <7vfwiw33bf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mhagger@alum.mit.edu, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 01:07:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REUMy-0002Zv-4A
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 01:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755687Ab1JMXHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 19:07:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62410 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754654Ab1JMXHM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 19:07:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D37EB648C;
	Thu, 13 Oct 2011 19:07:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h9tLgyeBxyj6ybci8VfA0ruGvUY=; b=D7WB49
	8UAoB566Xz6T3+bmqd1UcrwnUxQdN4EsUGFSXUE/U/zpdLz45dBoV1rU4B/bRCpU
	Z/GjT1Ebs0MCBF75fH0NNMU6RjBjjiSuzXwKbBDlaAJ+wPw9o8fh0JELjwrBC7tt
	hnJpfJPyUvGJudm17QhQORADTA836dnW7Ekvk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hac+n12n/g3SaqU3k6QOsS6AoqUR+YwF
	8BoXRasfoXAG15JwHIyHi4o5dM+7fpXbh1TLNYP5RDT6f+KG7yqMt6WJBJLhgm+G
	QQTVUYH8fjrsq3R5aGRVbUaFhrY2z5pasepJqGhMAdAFU5dlNrGzA9bzFUTn3Vzg
	hL3YjX7izHg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA501648B;
	Thu, 13 Oct 2011 19:07:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 11A8F643E; Thu, 13 Oct 2011
 19:07:11 -0400 (EDT)
In-Reply-To: <7vfwiw33bf.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 13 Oct 2011 16:00:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 14CDBF7C-F5F0-11E0-BEA0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183529>

Bash on Windows converts program arguments that look like absolute POSIX
paths to their Windows form, i.e., drive-letter-colon format. For this
reason, those tests in t1402 that check refs that begin with a slash do not
work as expected on Windows: valid_ref tests are doomed to fail, and
invalid_ref tests fail for the wrong reason (that there is a colon rather
than that they begin with a slash).

Skip these tests.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

Junio C Hamano <gitster@pobox.com> writes:

>> +invalid_ref NOT_MINGW '/'
>> ...
>> +valid_ref_normalized '/heads/foo' 'heads/foo' NOT_MINGW
>
> The inconsistencies strikes me a bit.

Here is what I tentatively will queue.

The interdiff from yours looks like this:

    diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
    index dba5e97..1ae4d87 100755
    --- a/t/t1402-check-ref-format.sh
    +++ b/t/t1402-check-ref-format.sh
    @@ -11,8 +11,9 @@ valid_ref() {
                    prereq=$1
                    shift
            esac
    -	test_expect_success $prereq "ref name '$1' is valid${2:+ with options $2}" \
    -			"git check-ref-format $2 '$1'"
    +	test_expect_success $prereq "ref name '$1' is valid${2:+ with options $2}" "
    +		git check-ref-format $2 '$1'
    +	"
     }
     invalid_ref() {
            prereq=
    @@ -21,8 +22,9 @@ invalid_ref() {
                    prereq=$1
                    shift
            esac
    -	test_expect_success $prereq "ref name '$1' is invalid${2:+ with options $2}" \
    -			"test_must_fail git check-ref-format $2 '$1'"
    +	test_expect_success $prereq "ref name '$1' is invalid${2:+ with options $2}" "
    +		test_must_fail git check-ref-format $2 '$1'
    +	"
     }

     invalid_ref ''
    @@ -155,21 +157,35 @@ test_expect_success 'check-ref-format --branch from subdir' '
     '

     valid_ref_normalized() {
    -	test_expect_success $3 "ref name '$1' simplifies to '$2'" "
    +	prereq=
    +	case $1 in
    +	[A-Z]*)
    +		prereq=$1
    +		shift
    +	esac
    +	test_expect_success $prereq "ref name '$1' simplifies to '$2'" "
                    refname=\$(git check-ref-format --normalize '$1') &&
    -		test \"\$refname\" = '$2'"
    +		test \"\$refname\" = '$2'
    +	"
     }
     invalid_ref_normalized() {
    -	test_expect_success $2 "check-ref-format --normalize rejects '$1'" "
    -		test_must_fail git check-ref-format --normalize '$1'"
    +	prereq=
    +	case $1 in
    +	[A-Z]*)
    +		prereq=$1
    +		shift
    +	esac
    +	test_expect_success $prereq "check-ref-format --normalize rejects '$1'" "
    +		test_must_fail git check-ref-format --normalize '$1'
    +	"
     }

     valid_ref_normalized 'heads/foo' 'heads/foo'
     valid_ref_normalized 'refs///heads/foo' 'refs/heads/foo'
    -valid_ref_normalized '/heads/foo' 'heads/foo' NOT_MINGW
    +valid_ref_normalized NOT_MINGW '/heads/foo' 'heads/foo'
     valid_ref_normalized '///heads/foo' 'heads/foo'
     invalid_ref_normalized 'foo'
    -invalid_ref_normalized '/foo' NOT_MINGW
    +invalid_ref_normalized NOT_MINGW '/foo'
     invalid_ref_normalized 'heads/foo/../bar'
     invalid_ref_normalized 'heads/./foo'
     invalid_ref_normalized 'heads\foo'

Thanks.

 t/t1402-check-ref-format.sh |   88 +++++++++++++++++++++++++-----------------
 1 files changed, 52 insertions(+), 36 deletions(-)

diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 710fcca..1ae4d87 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -5,38 +5,40 @@ test_description='Test git check-ref-format'
 . ./test-lib.sh
 
 valid_ref() {
-	if test "$#" = 1
-	then
-		test_expect_success "ref name '$1' is valid" \
-			"git check-ref-format '$1'"
-	else
-		test_expect_success "ref name '$1' is valid with options $2" \
-			"git check-ref-format $2 '$1'"
-	fi
+	prereq=
+	case $1 in
+	[A-Z]*)
+		prereq=$1
+		shift
+	esac
+	test_expect_success $prereq "ref name '$1' is valid${2:+ with options $2}" "
+		git check-ref-format $2 '$1'
+	"
 }
 invalid_ref() {
-	if test "$#" = 1
-	then
-		test_expect_success "ref name '$1' is invalid" \
-			"test_must_fail git check-ref-format '$1'"
-	else
-		test_expect_success "ref name '$1' is invalid with options $2" \
-			"test_must_fail git check-ref-format $2 '$1'"
-	fi
+	prereq=
+	case $1 in
+	[A-Z]*)
+		prereq=$1
+		shift
+	esac
+	test_expect_success $prereq "ref name '$1' is invalid${2:+ with options $2}" "
+		test_must_fail git check-ref-format $2 '$1'
+	"
 }
 
 invalid_ref ''
-invalid_ref '/'
-invalid_ref '/' --allow-onelevel
-invalid_ref '/' --normalize
-invalid_ref '/' '--allow-onelevel --normalize'
+invalid_ref NOT_MINGW '/'
+invalid_ref NOT_MINGW '/' --allow-onelevel
+invalid_ref NOT_MINGW '/' --normalize
+invalid_ref NOT_MINGW '/' '--allow-onelevel --normalize'
 valid_ref 'foo/bar/baz'
 valid_ref 'foo/bar/baz' --normalize
 invalid_ref 'refs///heads/foo'
 valid_ref 'refs///heads/foo' --normalize
 invalid_ref 'heads/foo/'
-invalid_ref '/heads/foo'
-valid_ref '/heads/foo' --normalize
+invalid_ref NOT_MINGW '/heads/foo'
+valid_ref NOT_MINGW '/heads/foo' --normalize
 invalid_ref '///heads/foo'
 valid_ref '///heads/foo' --normalize
 invalid_ref './foo'
@@ -115,14 +117,14 @@ invalid_ref "$ref" --refspec-pattern
 invalid_ref "$ref" '--refspec-pattern --allow-onelevel'
 
 ref='/foo'
-invalid_ref "$ref"
-invalid_ref "$ref" --allow-onelevel
-invalid_ref "$ref" --refspec-pattern
-invalid_ref "$ref" '--refspec-pattern --allow-onelevel'
-invalid_ref "$ref" --normalize
-valid_ref "$ref" '--allow-onelevel --normalize'
-invalid_ref "$ref" '--refspec-pattern --normalize'
-valid_ref "$ref" '--refspec-pattern --allow-onelevel --normalize'
+invalid_ref NOT_MINGW "$ref"
+invalid_ref NOT_MINGW "$ref" --allow-onelevel
+invalid_ref NOT_MINGW "$ref" --refspec-pattern
+invalid_ref NOT_MINGW "$ref" '--refspec-pattern --allow-onelevel'
+invalid_ref NOT_MINGW "$ref" --normalize
+valid_ref NOT_MINGW "$ref" '--allow-onelevel --normalize'
+invalid_ref NOT_MINGW "$ref" '--refspec-pattern --normalize'
+valid_ref NOT_MINGW "$ref" '--refspec-pattern --allow-onelevel --normalize'
 
 test_expect_success "check-ref-format --branch @{-1}" '
 	T=$(git write-tree) &&
@@ -155,21 +157,35 @@ test_expect_success 'check-ref-format --branch from subdir' '
 '
 
 valid_ref_normalized() {
-	test_expect_success "ref name '$1' simplifies to '$2'" "
+	prereq=
+	case $1 in
+	[A-Z]*)
+		prereq=$1
+		shift
+	esac
+	test_expect_success $prereq "ref name '$1' simplifies to '$2'" "
 		refname=\$(git check-ref-format --normalize '$1') &&
-		test \"\$refname\" = '$2'"
+		test \"\$refname\" = '$2'
+	"
 }
 invalid_ref_normalized() {
-	test_expect_success "check-ref-format --normalize rejects '$1'" "
-		test_must_fail git check-ref-format --normalize '$1'"
+	prereq=
+	case $1 in
+	[A-Z]*)
+		prereq=$1
+		shift
+	esac
+	test_expect_success $prereq "check-ref-format --normalize rejects '$1'" "
+		test_must_fail git check-ref-format --normalize '$1'
+	"
 }
 
 valid_ref_normalized 'heads/foo' 'heads/foo'
 valid_ref_normalized 'refs///heads/foo' 'refs/heads/foo'
-valid_ref_normalized '/heads/foo' 'heads/foo'
+valid_ref_normalized NOT_MINGW '/heads/foo' 'heads/foo'
 valid_ref_normalized '///heads/foo' 'heads/foo'
 invalid_ref_normalized 'foo'
-invalid_ref_normalized '/foo'
+invalid_ref_normalized NOT_MINGW '/foo'
 invalid_ref_normalized 'heads/foo/../bar'
 invalid_ref_normalized 'heads/./foo'
 invalid_ref_normalized 'heads\foo'
-- 
1.7.7.289.gd0d4bb
