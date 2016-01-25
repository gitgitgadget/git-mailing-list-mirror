From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 18/19] mingw: skip a couple of git-svn tests that cannot pass on Windows
Date: Sun, 24 Jan 2016 18:16:46 -0800
Message-ID: <xmqqwpqy9ze9.fsf@gitster.mtv.corp.google.com>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
	<ff13c4125f268905baaa10a097ffdafe07eafb25.1453650173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 25 03:16:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNWi5-0003CT-KC
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 03:16:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755195AbcAYCQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 21:16:50 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60890 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754804AbcAYCQs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 21:16:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 23F4C3F529;
	Sun, 24 Jan 2016 21:16:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qlRkWORHacNZgfd6eBxzma8EfRg=; b=YbajCS
	HIGVhFPsoKO15jD8Ki5X4zw1JHJhj+xfxFS8EwMgstHBOLjyY1RZ5StUsm7HkSLj
	ybFHWWfdie7po9/vzy/OM+2tdU7nF/OfR9wgX3AF7GBq8AuFBw6pim20cz8jScGH
	mfR2u+xtADcL1hRwbl+7Wygh4y+ciNaJRYwiA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RnTV/oZSb4G+Fq/ujS1v6/GD916vvVBB
	/Ty78f+/NLn80eo8coWGaaioajebXVoT1qsEV7jKMLFLCjF/MSeS2o2SuCb/f4Kx
	GPz3rQrTT+0Jat/u1I1Gr46nxE/P4sfwgWJOdRBz06ciUHNNfRxlrOhrS7Qc3M//
	xsZnI36XrsE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1BC3A3F528;
	Sun, 24 Jan 2016 21:16:48 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 96AB83F527;
	Sun, 24 Jan 2016 21:16:47 -0500 (EST)
In-Reply-To: <ff13c4125f268905baaa10a097ffdafe07eafb25.1453650173.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Sun, 24 Jan 2016 16:45:52 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AFCDBF96-C309-11E5-BED9-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284713>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Some of the tests expect that executable bits can be toggled, others
> expect that paths are POSIX paths (but when they come through git.exe,
> they are converted into Windows paths and necessarily differ), yet
> others expect symbolic links to be available.

These skip the tests that cannot possibly pass in their entirety by
protecting them with prerequisites, which feels the right thing to
do.  The "executable bits" ones would need to become !POSIXPERM, and
symlink ones !SYMLINKS, though.

Thanks.

> This lets t9100-git-svn-basic.sh and t9130-git-svn-authors-file.sh pass
> in Git for Windows' SDK.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t9100-git-svn-basic.sh        | 15 +++++++--------
>  t/t9130-git-svn-authors-file.sh |  2 +-
>  2 files changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
> index bca7ec8..8c74ffa 100755
> --- a/t/t9100-git-svn-basic.sh
> +++ b/t/t9100-git-svn-basic.sh
> @@ -127,7 +127,7 @@ test_expect_success "$name" '
>  
>  
>  name='remove executable bit from a file'
> -test_expect_success "$name" '
> +test_expect_success !MINGW "$name" '
>  	rm -f "$GIT_DIR"/index &&
>  	git checkout -f -b mybranch5 ${remotes_git_svn} &&
>  	chmod -x exec.sh &&
> @@ -140,7 +140,7 @@ test_expect_success "$name" '
>  
>  
>  name='add executable bit back file'
> -test_expect_success "$name" '
> +test_expect_success !MINGW "$name" '
>  	chmod +x exec.sh &&
>  	git update-index exec.sh &&
>  	git commit -m "$name" &&
> @@ -151,7 +151,7 @@ test_expect_success "$name" '
>  
>  
>  name='executable file becomes a symlink to file'
> -test_expect_success "$name" '
> +test_expect_success !MINGW "$name" '
>  	rm exec.sh &&
>  	ln -s file exec.sh &&
>  	git update-index exec.sh &&
> @@ -163,8 +163,7 @@ test_expect_success "$name" '
>  
>  name='new symlink is added to a file that was also just made executable'
>  
> -test_expect_success "$name" '
> -	chmod +x file &&
> +test_expect_success !MINGW "$name" '
>  	ln -s file exec-2.sh &&
>  	git update-index --add file exec-2.sh &&
>  	git commit -m "$name" &&
> @@ -175,7 +174,7 @@ test_expect_success "$name" '
>  	test -h "$SVN_TREE"/exec-2.sh'
>  
>  name='modify a symlink to become a file'
> -test_expect_success "$name" '
> +test_expect_success !MINGW "$name" '
>  	echo git help >help &&
>  	rm exec-2.sh &&
>  	cp help exec-2.sh &&
> @@ -191,7 +190,7 @@ test_expect_success "$name" '
>  name="commit with UTF-8 message: locale: $GIT_SVN_LC_ALL"
>  LC_ALL="$GIT_SVN_LC_ALL"
>  export LC_ALL
> -test_expect_success UTF8 "$name" "
> +test_expect_success !MINGW,UTF8 "$name" "
>  	echo '# hello' >> exec-2.sh &&
>  	git update-index exec-2.sh &&
>  	git commit -m '???????' &&
> @@ -224,7 +223,7 @@ tree d667270a1f7b109f5eb3aaea21ede14b56bfdd6e
>  tree 8f51f74cf0163afc9ad68a4b1537288c4558b5a4
>  EOF
>  
> -test_expect_success "$name" "test_cmp a expected"
> +test_expect_success !MINGW "$name" "test_cmp a expected"
>  
>  test_expect_success 'exit if remote refs are ambigious' "
>          git config --add svn-remote.svn.fetch \
> diff --git a/t/t9130-git-svn-authors-file.sh b/t/t9130-git-svn-authors-file.sh
> index d306b77..4126481 100755
> --- a/t/t9130-git-svn-authors-file.sh
> +++ b/t/t9130-git-svn-authors-file.sh
> @@ -91,7 +91,7 @@ test_expect_success 'fetch continues after authors-file is fixed' '
>  	)
>  	'
>  
> -test_expect_success 'fresh clone with svn.authors-file in config' '
> +test_expect_success !MINGW 'fresh clone with svn.authors-file in config' '
>  	(
>  		rm -r "$GIT_DIR" &&
>  		test x = x"$(git config svn.authorsfile)" &&
