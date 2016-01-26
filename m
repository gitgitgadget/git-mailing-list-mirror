From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 18/19] mingw: handle the missing POSIXPERM prereq in t9124
Date: Tue, 26 Jan 2016 14:05:58 -0800
Message-ID: <xmqqfuxkatdl.fsf@gitster.mtv.corp.google.com>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
	<cover.1453818789.git.johannes.schindelin@gmx.de>
	<4c38596ae3fdcc5906dba49521084fe2b1a6888d.1453818790.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 26 23:06:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOBkW-0004mp-4u
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 23:06:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbcAZWGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 17:06:04 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50967 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750756AbcAZWGC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 17:06:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B43813F833;
	Tue, 26 Jan 2016 17:06:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/G/gZMeaRY6SBG9eK6Zli7uwHrE=; b=l0ZPVU
	W6HNS0zswIaIuGNxmnMsz8qd+Dlk19CLBTcNXiSUF3PDh116+klh2mwpiY4PcFAQ
	KF3qVchI9dE9uBl8/9HNwt7W5jL9jduBJXF0dPcJuyFRjDde3+AP6gAjycGrpJmX
	ycEl13Eu9aZBsQcnQh8RPJjd49XIZmCP0lBIM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lMynrtVcz5QYposTrxSZHVbHvIyVsqR/
	IWw76qffSVzmoBzCde3Hyo6s84cpQgpDv5QU6qSP8WLNTcRUC41OC9OnFvpYfFmI
	76onIRddJjudFpgnmE4iKWvjvDH0G4liY6l660+VmFTWAkeGRAu6XF7DjWX8613w
	pnQW0Hr5iBs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A28A93F832;
	Tue, 26 Jan 2016 17:06:00 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 017083F831;
	Tue, 26 Jan 2016 17:05:59 -0500 (EST)
In-Reply-To: <4c38596ae3fdcc5906dba49521084fe2b1a6888d.1453818790.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Tue, 26 Jan 2016 15:35:38 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FB8E7356-C478-11E5-B42A-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284861>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> On Windows, the permission system works completely differently than
> expected by some of the tests. So let's make sure that we do not test
> POSIX functionality on Windows.
>
> This lets t9124-git-svn-dcommit-auto-props.sh pass in Git for Windows'
> SDK.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t9124-git-svn-dcommit-auto-props.sh | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/t/t9124-git-svn-dcommit-auto-props.sh b/t/t9124-git-svn-dcommit-auto-props.sh
> index aa841e1..2be0805 100755
> --- a/t/t9124-git-svn-dcommit-auto-props.sh
> +++ b/t/t9124-git-svn-dcommit-auto-props.sh
> @@ -34,8 +34,7 @@ test_expect_success 'enable auto-props config' '
>  '
>  
>  test_expect_success 'add files matching auto-props' '
> -	echo "#!$SHELL_PATH" >exec1.sh &&
> -	chmod +x exec1.sh &&
> +	printf "" | write_script exec1.sh &&

That looks like a useless use of printf.  Why not

	write_script exec1.sh </dev/null &&

>  	echo "hello" >hello.txt &&
>  	echo bar >bar &&
>  	git add exec1.sh hello.txt bar &&
> @@ -48,8 +47,7 @@ test_expect_success 'disable auto-props config' '
>  '
>  
>  test_expect_success 'add files matching disabled auto-props' '
> -	echo "#$SHELL_PATH" >exec2.sh &&
> -	chmod +x exec2.sh &&
> +	printf "" | write_script exec2.sh &&
>  	echo "world" >world.txt &&
>  	echo zot >zot &&
>  	git add exec2.sh world.txt zot &&
> @@ -65,7 +63,10 @@ test_expect_success 'check resulting svn repository' '
>  	cd svnrepo &&
>  
>  	# Check properties from first commit.
> -	test "x$(svn_cmd propget svn:executable exec1.sh)" = "x*" &&
> +	if test_have_prereq POSIXPERM
> +	then
> +		test -z "$(svn_cmd propget svn:executable exec1.sh)"

Why this change?

		test "x$(svn_cmd propget svn:executable exec1.sh)" = "x*" &&

means "propget command gives a literal string that consists of a
single asterisk".

> +	fi &&
>  	test "x$(svn_cmd propget svn:mime-type exec1.sh)" = \
>  	     "xapplication/x-shellscript" &&
>  	test "x$(svn_cmd propget svn:mime-type hello.txt)" = "xtext/plain" &&
> @@ -73,7 +74,10 @@ test_expect_success 'check resulting svn repository' '
>  	test "x$(svn_cmd propget svn:mime-type bar)" = "x" &&
>  
>  	# Check properties from second commit.
> -	test "x$(svn_cmd propget svn:executable exec2.sh)" = "x*" &&
> +	if test_have_prereq POSIXPERM
> +	then
> +		test -z "$(svn_cmd propget svn:executable exec2.sh)"

Likewise.

Please do not change things without understanding what they are doing.

> +	fi &&
>  	test "x$(svn_cmd propget svn:mime-type exec2.sh)" = "x" &&
>  	test "x$(svn_cmd propget svn:mime-type world.txt)" = "x" &&
>  	test "x$(svn_cmd propget svn:eol-style world.txt)" = "x" &&
