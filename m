From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 17/19] mingw: fix git-svn tests that expect chmod to work
Date: Sun, 24 Jan 2016 18:14:27 -0800
Message-ID: <xmqq1t96be2k.fsf@gitster.mtv.corp.google.com>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
	<9045a31ec16da672a74d9b1e0b65807d21ef277e.1453650173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 25 03:14:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNWfq-00025I-FI
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 03:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754303AbcAYCOb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jan 2016 21:14:31 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53744 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753826AbcAYCO3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jan 2016 21:14:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3967D3F4B8;
	Sun, 24 Jan 2016 21:14:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=i8NWS/t7fBi9
	E5bhyhqnBL1fj9k=; b=VZvRn14ea3ob4DCdAb5SDWOGkBLXTqdJUjzO1zr0HDyO
	WhF8dJYKj5esqRuf2uItnbc6n4XIBcY4zT1lcnCXrLZtFRtiOArPjcFbFROC/598
	t22ud6dvCeUGXcMtMOoGJZgIvYZWqSu+bR1Ni7l7IZe66RDNvxOz1zA6PSQvP4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=iR4r2r
	8M4CkWpaJojB9zcCDCVOvLvx7q+MV1nS3fxc2UO5YMfvqeyXF/jGvM2ItI/79+cY
	NIDqKanLrcyORgDo0r4O8s99jqiO+BRGdHXszOWbTALu69ud/rxOy2ALlSonq22e
	KEYV6LEKRpjL+6gi36wLFiMZmXUSaaNu59zeA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2F08C3F4B7;
	Sun, 24 Jan 2016 21:14:29 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 903E33F4B6;
	Sun, 24 Jan 2016 21:14:28 -0500 (EST)
In-Reply-To: <9045a31ec16da672a74d9b1e0b65807d21ef277e.1453650173.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Sun, 24 Jan 2016 16:45:47 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5CF024F8-C309-11E5-8AE9-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284712>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> From: =EB=A7=88=EB=88=84=EC=97=98 <nalla@users.noreply.github.com>
>
> Some git-svn tests expect that the executable bit of files can be
> toggled. On Windows, this is not possible because Windows' Access
> Control Lists are much more fine-grained than the POSIX permission
> concept. Let's just not try to flip the executable bit.

Most of the changes are protected by !POSIXPERM but one of them
seems to use MINGW, which looks inconsistent and I suspect was not a
distinction made on purpose.  The above description sounds to me
that the !POSIXPERM prerequisite is the right thing to use.

I am not sure if it is a good idea to sprinkle test-have-prereq and
make the test script test different things on different platforms,
though.



> This lets t9118-git-svn-funky-branch-names.sh and
> t9124-git-svn-dcommit-auto-props.sh pass in Git for Windows' SDK,
> and partially fixes t9100-git-svn-basic.sh.
>
> Signed-off-by: =EB=A7=88=EB=88=84=EC=97=98 <nalla@users.noreply.githu=
b.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t9100-git-svn-basic.sh              |  5 ++++-
>  t/t9118-git-svn-funky-branch-names.sh | 12 +++++++++---
>  t/t9124-git-svn-dcommit-auto-props.sh | 20 ++++++++++++++++----
>  3 files changed, 29 insertions(+), 8 deletions(-)
>
> diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
> index dbb440b..bca7ec8 100755
> --- a/t/t9100-git-svn-basic.sh
> +++ b/t/t9100-git-svn-basic.sh
> @@ -38,7 +38,10 @@ test_expect_success \
>  		mkdir bar &&
>  		echo "zzz" >bar/zzz &&
>  		echo "#!/bin/sh" >exec.sh &&
> -		chmod +x exec.sh &&
> +		{
> +			test_have_prereq !POSIXPERM ||
> +			chmod +x exec.sh
> +		} &&
>  		svn_cmd import -m "import for git svn" . "$svnrepo" >/dev/null
>  	) &&
>  	rm -rf import &&
> diff --git a/t/t9118-git-svn-funky-branch-names.sh b/t/t9118-git-svn-=
funky-branch-names.sh
> index a221915..49775a5 100755
> --- a/t/t9118-git-svn-funky-branch-names.sh
> +++ b/t/t9118-git-svn-funky-branch-names.sh
> @@ -23,8 +23,11 @@ test_expect_success 'setup svnrepo' '
>  	              "$svnrepo/pr ject/branches/$scary_uri" &&
>  	svn_cmd cp -m "leading dot" "$svnrepo/pr ject/trunk" \
>  			"$svnrepo/pr ject/branches/.leading_dot" &&
> -	svn_cmd cp -m "trailing dot" "$svnrepo/pr ject/trunk" \
> -			"$svnrepo/pr ject/branches/trailing_dot." &&
> +	{
> +		test_have_prereq MINGW ||
> +		svn_cmd cp -m "trailing dot" "$svnrepo/pr ject/trunk" \
> +			"$svnrepo/pr ject/branches/trailing_dot."
> +	} &&
>  	svn_cmd cp -m "trailing .lock" "$svnrepo/pr ject/trunk" \
>  			"$svnrepo/pr ject/branches/trailing_dotlock.lock" &&
>  	svn_cmd cp -m "reflog" "$svnrepo/pr ject/trunk" \
> @@ -45,7 +48,10 @@ test_expect_success 'test clone with funky branch =
names' '
>  		git rev-parse "refs/remotes/origin/more%20fun%20plugin!" &&
>  		git rev-parse "refs/remotes/origin/$scary_ref" &&
>  		git rev-parse "refs/remotes/origin/%2Eleading_dot" &&
> -		git rev-parse "refs/remotes/origin/trailing_dot%2E" &&
> +		{
> +			test_have_prereq MINGW ||
> +			git rev-parse "refs/remotes/origin/trailing_dot%2E"
> +		} &&
>  		git rev-parse "refs/remotes/origin/trailing_dotlock%2Elock" &&
>  		git rev-parse "refs/remotes/origin/$non_reflog"
>  	)
> diff --git a/t/t9124-git-svn-dcommit-auto-props.sh b/t/t9124-git-svn-=
dcommit-auto-props.sh
> index aa841e1..c851121 100755
> --- a/t/t9124-git-svn-dcommit-auto-props.sh
> +++ b/t/t9124-git-svn-dcommit-auto-props.sh
> @@ -35,7 +35,10 @@ test_expect_success 'enable auto-props config' '
> =20
>  test_expect_success 'add files matcihng auto-props' '
>  	echo "#!$SHELL_PATH" >exec1.sh &&
> -	chmod +x exec1.sh &&
> +	{
> +		test_have_prereq !POSIXPERM ||
> +		chmod +x exec1.sh
> +	} &&
>  	echo "hello" >hello.txt &&
>  	echo bar >bar &&
>  	git add exec1.sh hello.txt bar &&
> @@ -49,7 +52,10 @@ test_expect_success 'disable auto-props config' '
> =20
>  test_expect_success 'add files matching disabled auto-props' '
>  	echo "#$SHELL_PATH" >exec2.sh &&
> -	chmod +x exec2.sh &&
> +	{
> +		test_have_prereq !POSIXPERM ||
> +		chmod +x exec2.sh
> +	} &&
>  	echo "world" >world.txt &&
>  	echo zot >zot &&
>  	git add exec2.sh world.txt zot &&
> @@ -65,7 +71,10 @@ test_expect_success 'check resulting svn repositor=
y' '
>  	cd svnrepo &&
> =20
>  	# Check properties from first commit.
> -	test "x$(svn_cmd propget svn:executable exec1.sh)" =3D "x*" &&
> +	{
> +		test_have_prereq !POSIXPERM ||
> +		test "x$(svn_cmd propget svn:executable exec1.sh)" =3D "x*"
> +	} &&
>  	test "x$(svn_cmd propget svn:mime-type exec1.sh)" =3D \
>  	     "xapplication/x-shellscript" &&
>  	test "x$(svn_cmd propget svn:mime-type hello.txt)" =3D "xtext/plain=
" &&
> @@ -73,7 +82,10 @@ test_expect_success 'check resulting svn repositor=
y' '
>  	test "x$(svn_cmd propget svn:mime-type bar)" =3D "x" &&
> =20
>  	# Check properties from second commit.
> -	test "x$(svn_cmd propget svn:executable exec2.sh)" =3D "x*" &&
> +	{
> +		test_have_prereq !POSIXPERM ||
> +		test "x$(svn_cmd propget svn:executable exec2.sh)" =3D "x*"
> +	} &&
>  	test "x$(svn_cmd propget svn:mime-type exec2.sh)" =3D "x" &&
>  	test "x$(svn_cmd propget svn:mime-type world.txt)" =3D "x" &&
>  	test "x$(svn_cmd propget svn:eol-style world.txt)" =3D "x" &&
