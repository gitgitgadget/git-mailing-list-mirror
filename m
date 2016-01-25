From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/19] mingw: do not use symlinks with SVN in t9100
Date: Sun, 24 Jan 2016 17:51:40 -0800
Message-ID: <xmqqegd6bf4j.fsf@gitster.mtv.corp.google.com>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
	<f016fde3118f5028b7e589f36bc9c916464a9de9.1453650173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karsten Blees <blees@dcon.de>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 25 02:51:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNWJn-0000Wv-Jp
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 02:51:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754628AbcAYBvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 20:51:44 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58661 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754573AbcAYBvn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 20:51:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5E9703F050;
	Sun, 24 Jan 2016 20:51:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o+RZ88u+hE4/oGqGbDQyJi8zr9E=; b=mPfZrn
	2B5+qPbJaAYGH4m6Isz2VsPmTzvP1+MAhvehlik/il6jLvrg4WaJlBYhf0WBULSI
	9nC2mFy0JOalSkpeKdBP8Yu/tuOvC4gRTvd3OwLCFa2TBZtD8fR24Slxknii2wOl
	epar4QTSr0+R/0eOm4x+bNhSB4BXt3dnp9e0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VKXesqH+t0tVbsidfFyxb+6WV2M0NS/7
	8e81YwoItNjBWQOPkJrJmGHgj/kJbGZrjyCaY9tm/PAiZZIoHWute4xn2ux38xyN
	F0Tq7sjKkf1tvi2NWu4JJd1s+aG3ouZ5nBEdwNdYewjLGsLsytWVF6+gxXntC7Q1
	PrPOAcgHynE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 553963F04F;
	Sun, 24 Jan 2016 20:51:42 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C9DAE3F04E;
	Sun, 24 Jan 2016 20:51:41 -0500 (EST)
In-Reply-To: <f016fde3118f5028b7e589f36bc9c916464a9de9.1453650173.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Sun, 24 Jan 2016 16:45:04 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2E4870FE-C306-11E5-8BD6-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284708>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> From: Karsten Blees <blees@dcon.de>
>
> The SVN library does not seem to support symlinks, even if symlinks are
> enabled in MSYS2 and Git. Use 'cp' instead of 'ln -s'.
>
> This partially fixes t/t9100-git-svn-basic.sh
>
> Signed-off-by: Karsten Blees <blees@dcon.de>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t9100-git-svn-basic.sh | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

For the purpose of SVN test, is it important that foo.link is a link
to foo?  I am wondering what would be the fallout from making this
change without "only on MINGW do this".

On the other hand, perhaps such a change may make this particular
test meaningless for whatever reason.  Perhaps this test is about
git-svn handling a symbolic link correctly, and you wouldn't be
testing anything useful if you unconditionally changed "ln -s" to
"cp" on all platforms.  But if that is the case, I suspect that it
would make more sense to mark the test to be skipped using the
prerequiste, instead of pretending that this test passes.  While the
updated test may be testing that the same "works correctly on
symbolic links" as before on all the other platforms, on MINGW, it
is testing something completely different.

I cannot quite tell if that is the case.

> diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
> index 258d9b8..dbb440b 100755
> --- a/t/t9100-git-svn-basic.sh
> +++ b/t/t9100-git-svn-basic.sh
> @@ -25,7 +25,14 @@ test_expect_success \
>  	(
>  		cd import &&
>  		echo foo >foo &&
> -		ln -s foo foo.link
> +		if test_have_prereq !MINGW
> +		then
> +			ln -s foo foo.link
> +		else
> +			# MSYS libsvn does not support symlinks, so always use cp, even if
> +			# ln -s actually works
> +			cp foo foo.link
> +		fi
>  		mkdir -p dir/a/b/c/d/e &&
>  		echo "deep dir" >dir/a/b/c/d/e/file &&
>  		mkdir bar &&
