From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/10] t4018: an infrastructure to test hunk headers
Date: Fri, 21 Mar 2014 15:00:45 -0700
Message-ID: <xmqqk3bnrz3m.fsf@gitster.dls.corp.google.com>
References: <53282741.5010609@web.de> <cover.1395433874.git.j6t@kdbg.org>
	<52505977c20a480941ae1f85f50ffb7a0bbffedb.1395433874.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Brandon Casey <drafnel@gmail.com>,
	git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>, l.s.r@web.de,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Mar 21 23:01:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR7V3-0000Fc-1k
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 23:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbaCUWAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 18:00:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64102 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759AbaCUWAt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 18:00:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE4707643C;
	Fri, 21 Mar 2014 18:00:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XgVl5CM2Mwb9czx+bT89WHMN5wc=; b=k7E+fY
	H2u7SH2vSXQutYMl+YP/KFuAxPDK8Jx9x5Kv5x7gyVy1V9XcBRP1xgBPp+7Pu3QI
	uWK7dqsuFOgD58OELGJy7iRFMZ2lMXSCJ7V5yGkl9tXqEdF3H8O0PIa0qk+wGbMV
	OVMc+P6zko6tMfGzrRUk/owt0E3rjzeYxO3y8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wj2Jm5Tbr/9G+lUeuoEVL1m16TIdr04Y
	9wI2eKJFd4SL72/NkH2aO9rBPZKCWwz2Aa+DtYFy+n7ePRSc07f25SiyQltZj2ZW
	GxJ1LRi7tXkNrkN+oaSDZjH02MXrThdLH9citaWTl1MqZNz8j48gsRVCBiTcwfIf
	kho6sZE7Gfg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 966777643B;
	Fri, 21 Mar 2014 18:00:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA2BF76439;
	Fri, 21 Mar 2014 18:00:47 -0400 (EDT)
In-Reply-To: <52505977c20a480941ae1f85f50ffb7a0bbffedb.1395433874.git.j6t@kdbg.org>
	(Johannes Sixt's message of "Fri, 21 Mar 2014 22:07:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 423D447A-B144-11E3-88E3-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244757>

Johannes Sixt <j6t@kdbg.org> writes:

> Add an infrastructure that simplifies adding new tests of the hunk
> header regular expressions.
>
> To add new tests, a file with the syntax to test can be dropped in the
> directory t4018. The README file explains how a test file must contain;

s/how/what/, or "how a test file must be written" you mean?

> the README itself tests the default behavior.

Thanks.  Looks like a reasonable way to mark what must be found.

> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  t/t4018-diff-funcname.sh | 60 +++++++++++++++++++++++++++++++++++++++++++-----
>  t/t4018/README           | 18 +++++++++++++++
>  2 files changed, 72 insertions(+), 6 deletions(-)
>  create mode 100644 t/t4018/README
>
> diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
> index 38a092a..b467d9e 100755
> --- a/t/t4018-diff-funcname.sh
> +++ b/t/t4018-diff-funcname.sh
> @@ -100,7 +100,25 @@ test_expect_funcname () {
>  	grep "^@@.*@@ $1" diff
>  }
>  
> -for p in ada bibtex cpp csharp fortran html java matlab objc pascal perl php python ruby tex
> +diffpatterns="
> +	ada
> +	bibtex
> +	cpp
> +	csharp
> +	fortran
> +	html
> +	java
> +	matlab
> +	objc
> +	pascal
> +	perl
> +	php
> +	python
> +	ruby
> +	tex
> +"
> +
> +for p in $diffpatterns
>  do
>  	test_expect_success "builtin $p pattern compiles" '
>  		echo "*.java diff=$p" >.gitattributes &&

I always found this "Let's apply rules for language $p to these
*.java files" strange.  I have wonder if it makes sense to further
change the framework to read the name of the rule to be applied from
the file in t/t4018/ directory, instead of using filename that is
the same as the name of the rule?  That way, you can list the files
in t/t4018/ directory to come up with the above list, without having
to maintain the list of rules separately like the above.

> @@ -118,11 +136,6 @@ do
>  	'
>  done
>  
> -test_expect_success 'default behaviour' '
> -	rm -f .gitattributes &&
> -	test_expect_funcname "public class Beer\$"
> -'
> -
>  test_expect_success 'set up .gitattributes declaring drivers to test' '
>  	cat >.gitattributes <<-\EOF
>  	*.java diff=java
> @@ -182,4 +195,39 @@ test_expect_success 'alternation in pattern' '
>  	test_expect_funcname "public static void main("
>  '
>  
> +test_expect_success 'setup hunk header tests' '
> +	for i in $diffpatterns
> +	do
> +		echo "$i-* diff=$i"
> +	done > .gitattributes &&

I like that you can have more than one test for each language/rule
this way, allowing you to test one kind of breakage without getting
affected by lines prepared for other tests in the same file.

> +	# add all test files to the index
> +	(
> +		cd "$TEST_DIRECTORY"/t4018 &&
> +		git --git-dir="$TRASH_DIRECTORY/.git" add .
> +	) &&
> +
> +	# place modified files in the worktree
> +	for i in $(git ls-files)
> +	do
> +		sed -e "s/ChangeMe/IWasChanged/" <"$TEST_DIRECTORY/t4018/$i" >"$i" || return 1
> +	done
> +'
> +
> +# check each individual file
> +for i in $(git ls-files)
> +do
> +	if grep broken "$i" >/dev/null 2>&1
> +	then
> +		result=failure
> +	else
> +		result=success
> +	fi
> +	test_expect_$result "hunk header: $i" "
> +		test_when_finished 'cat actual' &&	# for debugging only
> +		git diff -U1 $i >actual &&
> +		grep '@@ .* @@.*RIGHT' actual
> +	"
> +done
> +
>  test_done
> diff --git a/t/t4018/README b/t/t4018/README
> new file mode 100644
> index 0000000..283e01cc
> --- /dev/null
> +++ b/t/t4018/README
> @@ -0,0 +1,18 @@
> +How to write RIGHT test cases
> +=============================
> +
> +Insert the word "ChangeMe" (exactly this form) at a distance of
> +at least two lines from the line that must appear in the hunk header.
> +
> +The text that must appear in the hunk header must contain the word
> +"right", but in all upper-case, like in the title above.
> +
> +To mark a test case that highlights a malfunction, insert the word
> +BROKEN in all lower-case somewhere in the file.
> +
> +This text is a bit twisted and out of order, but it is itself a
> +test case for the default hunk header pattern. Know what you are doing
> +if you change it.
> +
> +BTW, this tests that the head line goes to the hunk header, not the line
> +of equal signs.
