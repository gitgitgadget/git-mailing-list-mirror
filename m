From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/12] t: drop useless sane_unset GIT_* calls
Date: Fri, 21 Mar 2014 14:24:31 -0700
Message-ID: <xmqqy503s0s0.fsf@gitster.dls.corp.google.com>
References: <20140320231159.GA7774@sigill.intra.peff.net>
	<20140320231433.GC8479@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Tran <unsignedzero@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 22:24:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR6vh-00087A-9l
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 22:24:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223AbaCUVYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 17:24:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36321 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853AbaCUVYf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 17:24:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F15076E47;
	Fri, 21 Mar 2014 17:24:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QpoPA9utafa3HMYzLOPOTQbMVFg=; b=W9AA9E
	SS/HSSrcig9eif5Yv0Ko3KMBsjKyLIyPB3sd4vsSMtvWwmI6Db4aTn4roCqz30WE
	MN2P6bsR9o1CyeKnDexlAzEUoB9AEZjEvAUGX1gTTIiYbWTcjRPsDE5cVFPKrPej
	x3nMNZePIhiuqIBddEwvhawLHWzNIzJnya5r8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bkQTP8LtX0AFiqM30gBrg/AxLY7BUvs+
	4G1aQUVWLTWKpxWdnAoy6j63hXLkrx7WE5qsYkjYasfZt0AnZjImkSvLd+dv0c/M
	DDQIISeIHEcY65UmheCHyFZK1/IVTWYieoBTC7To0VHNlBp1sa08SEfZ0kxEp7yB
	xiuaY7OyxIM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2911976E46;
	Fri, 21 Mar 2014 17:24:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6865176E44;
	Fri, 21 Mar 2014 17:24:34 -0400 (EDT)
In-Reply-To: <20140320231433.GC8479@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 20 Mar 2014 19:14:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 32C97F54-B13F-11E3-9967-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244750>

Jeff King <peff@peff.net> writes:

> Several test scripts manually unset GIT_CONFIG and other
> GIT_* variables. These are generally taken care of for us by
> test-lib.sh already.
>
> Unsetting these is not only useless, but can be confusing to
> a reader, who may wonder why some tests in a script unset
> them and others do not (t0001 is particularly guilty of this
> inconsistency, probably because many of its tests predate
> the test-lib.sh environment-cleansing).

> Note that we cannot always get rid of such unsetting. For
> example, t9130 can drop the GIT_CONFIG unset, but not the
> GIT_DIR one, because lib-git-svn.sh sets the latter. And in
> t1000, we unset GIT_TEMPLATE_DIR, which is explicitly
> initialized by test-lib.sh.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I suppose one could make an argument that test-lib.sh may later change
> the set of variables it clears, and these unsets are documenting an
> explicit need of each test. I'd find that more compelling if it were
> actually applied consistently.

Hmph.  I am looking at "git show HEAD^:t/t0001-init.sh" after
applying this patch, and it does look consistently done with
GIT_CONFIG and GIT_DIR (I am not sure about GIT_WORK_TREE but from a
cursory read it is done consistently for tests on non-bare
repositories).

So I would actually agree with your alternative interpretation
"Unsetting these is useless, but it does serve documentation
purpose---without having to see what the state of the environment
when the subprocess is started, the reader can understand what is
being tested", rather than the one in the log message.

Having said that, I am perfectly OK with the change to t0001 in this
patch, if we added at the very beginning of the test sequence a
comment that says:

    Below, creation and use of repositories are tested with various
    combinations of environment settings and command line flags.
    They are done inside subshells to avoid leaking temporary
    environment settings to later tests *and* assumes that the
    initial environment does not have have GIT_DIR, GIT_CONFIG, and
    GIT_WORK_TREE defined.

or something.

>  t/t0001-init.sh                 | 15 ---------------
>  t/t9130-git-svn-authors-file.sh |  1 -
>  t/t9400-git-cvsserver-server.sh |  1 -
>  3 files changed, 17 deletions(-)
>
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index 9fb582b..ddc8160 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -25,7 +25,6 @@ check_config () {
>  
>  test_expect_success 'plain' '
>  	(
> -		sane_unset GIT_DIR GIT_WORK_TREE &&
>  		mkdir plain &&
>  		cd plain &&
>  		git init
> @@ -35,7 +34,6 @@ test_expect_success 'plain' '
>  
>  test_expect_success 'plain nested in bare' '
>  	(
> -		sane_unset GIT_DIR GIT_WORK_TREE &&
>  		git init --bare bare-ancestor.git &&
>  		cd bare-ancestor.git &&
>  		mkdir plain-nested &&
> @@ -47,7 +45,6 @@ test_expect_success 'plain nested in bare' '
>  
>  test_expect_success 'plain through aliased command, outside any git repo' '
>  	(
> -		sane_unset GIT_DIR GIT_WORK_TREE &&
>  		HOME=$(pwd)/alias-config &&
>  		export HOME &&
>  		mkdir alias-config &&
> @@ -65,7 +62,6 @@ test_expect_success 'plain through aliased command, outside any git repo' '
>  
>  test_expect_failure 'plain nested through aliased command' '
>  	(
> -		sane_unset GIT_DIR GIT_WORK_TREE &&
>  		git init plain-ancestor-aliased &&
>  		cd plain-ancestor-aliased &&
>  		echo "[alias] aliasedinit = init" >>.git/config &&
> @@ -78,7 +74,6 @@ test_expect_failure 'plain nested through aliased command' '
>  
>  test_expect_failure 'plain nested in bare through aliased command' '
>  	(
> -		sane_unset GIT_DIR GIT_WORK_TREE &&
>  		git init --bare bare-ancestor-aliased.git &&
>  		cd bare-ancestor-aliased.git &&
>  		echo "[alias] aliasedinit = init" >>config &&
> @@ -91,7 +86,6 @@ test_expect_failure 'plain nested in bare through aliased command' '
>  
>  test_expect_success 'plain with GIT_WORK_TREE' '
>  	if (
> -		sane_unset GIT_DIR &&
>  		mkdir plain-wt &&
>  		cd plain-wt &&
>  		GIT_WORK_TREE=$(pwd) git init
> @@ -104,7 +98,6 @@ test_expect_success 'plain with GIT_WORK_TREE' '
>  
>  test_expect_success 'plain bare' '
>  	(
> -		sane_unset GIT_DIR GIT_WORK_TREE GIT_CONFIG &&
>  		mkdir plain-bare-1 &&
>  		cd plain-bare-1 &&
>  		git --bare init
> @@ -114,7 +107,6 @@ test_expect_success 'plain bare' '
>  
>  test_expect_success 'plain bare with GIT_WORK_TREE' '
>  	if (
> -		sane_unset GIT_DIR GIT_CONFIG &&
>  		mkdir plain-bare-2 &&
>  		cd plain-bare-2 &&
>  		GIT_WORK_TREE=$(pwd) git --bare init
> @@ -128,7 +120,6 @@ test_expect_success 'plain bare with GIT_WORK_TREE' '
>  test_expect_success 'GIT_DIR bare' '
>  
>  	(
> -		sane_unset GIT_CONFIG &&
>  		mkdir git-dir-bare.git &&
>  		GIT_DIR=git-dir-bare.git git init
>  	) &&
> @@ -138,7 +129,6 @@ test_expect_success 'GIT_DIR bare' '
>  test_expect_success 'init --bare' '
>  
>  	(
> -		sane_unset GIT_DIR GIT_WORK_TREE GIT_CONFIG &&
>  		mkdir init-bare.git &&
>  		cd init-bare.git &&
>  		git init --bare
> @@ -149,7 +139,6 @@ test_expect_success 'init --bare' '
>  test_expect_success 'GIT_DIR non-bare' '
>  
>  	(
> -		sane_unset GIT_CONFIG &&
>  		mkdir non-bare &&
>  		cd non-bare &&
>  		GIT_DIR=.git git init
> @@ -160,7 +149,6 @@ test_expect_success 'GIT_DIR non-bare' '
>  test_expect_success 'GIT_DIR & GIT_WORK_TREE (1)' '
>  
>  	(
> -		sane_unset GIT_CONFIG &&
>  		mkdir git-dir-wt-1.git &&
>  		GIT_WORK_TREE=$(pwd) GIT_DIR=git-dir-wt-1.git git init
>  	) &&
> @@ -170,7 +158,6 @@ test_expect_success 'GIT_DIR & GIT_WORK_TREE (1)' '
>  test_expect_success 'GIT_DIR & GIT_WORK_TREE (2)' '
>  
>  	if (
> -		sane_unset GIT_CONFIG &&
>  		mkdir git-dir-wt-2.git &&
>  		GIT_WORK_TREE=$(pwd) GIT_DIR=git-dir-wt-2.git git --bare init
>  	)
> @@ -183,8 +170,6 @@ test_expect_success 'GIT_DIR & GIT_WORK_TREE (2)' '
>  test_expect_success 'reinit' '
>  
>  	(
> -		sane_unset GIT_CONFIG GIT_WORK_TREE GIT_CONFIG &&
> -
>  		mkdir again &&
>  		cd again &&
>  		git init >out1 2>err1 &&
> diff --git a/t/t9130-git-svn-authors-file.sh b/t/t9130-git-svn-authors-file.sh
> index c3443ce..a812783 100755
> --- a/t/t9130-git-svn-authors-file.sh
> +++ b/t/t9130-git-svn-authors-file.sh
> @@ -97,7 +97,6 @@ test_expect_success 'fresh clone with svn.authors-file in config' '
>  		test x = x"$(git config svn.authorsfile)" &&
>  		test_config="$HOME"/.gitconfig &&
>  		sane_unset GIT_DIR &&
> -		sane_unset GIT_CONFIG &&
>  		git config --global \
>  		  svn.authorsfile "$HOME"/svn-authors &&
>  		test x"$HOME"/svn-authors = x"$(git config svn.authorsfile)" &&
> diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
> index 3edc408..ed98e64 100755
> --- a/t/t9400-git-cvsserver-server.sh
> +++ b/t/t9400-git-cvsserver-server.sh
> @@ -25,7 +25,6 @@ perl -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
>      test_done
>  }
>  
> -unset GIT_DIR GIT_CONFIG
>  WORKDIR=$(pwd)
>  SERVERDIR=$(pwd)/gitcvs.git
>  git_config="$SERVERDIR/config"
