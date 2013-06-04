From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/11] tests: use test_ln_s_add to remove SYMLINKS prerequisite (trivial cases)
Date: Tue, 04 Jun 2013 14:06:48 -0700
Message-ID: <7vwqq960wn.fsf@alter.siamese.dyndns.org>
References: <cover.1370076477.git.j6t@kdbg.org>
	<3c8aaaa4ad606d2afb7c110a28c119792caa8aba.1370076477.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jun 04 23:06:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjyRV-0006cg-9z
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 23:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862Ab3FDVGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 17:06:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36586 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763Ab3FDVGv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 17:06:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4FE72538D;
	Tue,  4 Jun 2013 21:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rwOio/CazH1Wvt3mQ/57BH4aTqA=; b=S0zpVo
	5ZqZHGa9MWRpT+6MpMv3lreaR4V8zDkDxmWuuh7K2tx7CGM6MzmlWlqAxD760CtF
	gqS89vWuPO7vuUySuO/wP4suPijgghZmglMYBt+K97z3n14NJbA8rkW6+nCWYUzo
	P1a6XyMy+kLqQ5HXWwivlGn6OzZrtLB5NamOE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ikQJtSQ5sK4c1m59i5i6Ke2kcrse76pb
	wnHjpxMsvh+t9OtBdgdzfeZph58HPZsrUcu0LlxBs2bEqnMiDC2QuVk/6zX2DO6H
	u8wim/QHWzKfaUvQnEJ5dttuRqFTg15ww7jFB2MT4zTUf7irtL+5XTCPmtyuZ73Y
	ocMU4Z7XV9U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A96B72538C;
	Tue,  4 Jun 2013 21:06:50 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C533825389;
	Tue,  4 Jun 2013 21:06:49 +0000 (UTC)
In-Reply-To: <3c8aaaa4ad606d2afb7c110a28c119792caa8aba.1370076477.git.j6t@kdbg.org>
	(Johannes Sixt's message of "Sat, 1 Jun 2013 11:34:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC74DC28-CD5A-11E2-A800-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226403>

Johannes Sixt <j6t@kdbg.org> writes:

> There are many instances where the treatment of symbolic links in the
> object model and the algorithms are tested, but where it is not
> necessary to actually have a symbolic link in the worktree. Make
> adjustments to the tests and remove the SYMLINKS prerequisite when
> appropriate in trivial cases, where "trivial" means:
>
> - merely a replacement of 'ln -s a b' to test_ln_s or of
>   'ln -s a b && git add b' to test_ln_s_add is needed;
>
> - a test for symbolic link on the file system can be split off (and
>   remains protected by SYMLINKS);
>
> - existing code is equivalent to test_ln_s[_add].

This is too big to review in one go, so I may have separate messages
later on this same patch.

> diff --git a/t/t2003-checkout-cache-mkdir.sh b/t/t2003-checkout-cache-mkdir.sh
> index ff163cf..bd17ba2 100755
> --- a/t/t2003-checkout-cache-mkdir.sh
> +++ b/t/t2003-checkout-cache-mkdir.sh
> @@ -19,10 +19,10 @@ test_expect_success 'setup' '
>  	git update-index --add path0 path1/file1
>  '
>  
> -test_expect_success SYMLINKS 'have symlink in place where dir is expected.' '
> +test_expect_success 'have symlink in place where dir is expected.' '
>  	rm -fr path0 path1 &&
>  	mkdir path2 &&
> -	ln -s path2 path1 &&
> +	test_ln_s path2 path1 &&
>  	git checkout-index -f -a &&
>  	test ! -h path1 && test -d path1 &&
>  	test -f path1/file1 && test ! -f path2/file1

I do not think this hunk is correct.

We have two regular files in the index: path0, path1/file1, and we
add a symbolic link path1 that happens to point at directory path2/
in the working tree.

The test is about making sure that checkout-index is not confused by
the symbolic link in the working tree, by attempting to checkout
path1/file1.

Under the precondition checkout-index runs in this test, a casual

	echo rezrov >path1/file1

would leave path1 as a symlink without turning it into a real
directory, and we will end up creating path2/file1.  We are making
sure that checkout-index does not behave that way, and it is
essential to have symlink support in the working tree for the "bug"
to trigger.

On a filesystem without symbolic links, the patched test would pass
just fine, but there can be no aliasing between path1 and path2 in
the first place.

> @@ -79,10 +79,10 @@ test_expect_success SYMLINKS 'use --prefix=tmp/orary- where tmp is a symlink' '
>  	test -h tmp
>  '
>  
> -test_expect_success SYMLINKS 'use --prefix=tmp- where tmp-path1 is a symlink' '
> +test_expect_success 'use --prefix=tmp- where tmp-path1 is a symlink' '
>  	rm -fr path0 path1 path2 tmp* &&
>  	mkdir tmp1 &&
> -	ln -s tmp1 tmp-path1 &&
> +	test_ln_s tmp1 tmp-path1 &&
>  	git checkout-index --prefix=tmp- -f -a &&
>  	test -f tmp-path0 &&
>  	test ! -h tmp-path1 &&

This change has the same issue, I think.  We prepare tmp-path1
symbolic link to trap a casual "echo rezrov >tmp-path1/file1" to be
redirected to tmp1/file1 while leaving tmp-path1 as a symlink,
making sure we do the equivalent of "rm tmp-path1; mkdir tmp-path1"
before "echo rezrov >tmp-path1/file1".
