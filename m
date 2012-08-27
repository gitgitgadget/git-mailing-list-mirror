From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] test: set the realpath of CWD as TRASH_DIRECTORY
Date: Mon, 27 Aug 2012 09:15:06 -0700
Message-ID: <7vk3wktiph.fsf@alter.siamese.dyndns.org>
References: <5030F0BF.2090500@alum.mit.edu>
 <f58965733e604a9fe6ed72384d0307062403b478.1346043214.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 18:15:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T61yA-00074o-Te
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 18:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299Ab2H0QPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 12:15:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56534 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753093Ab2H0QPL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 12:15:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35EBC7AE9;
	Mon, 27 Aug 2012 12:15:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PZesIsSr/cvWGzZgUO7RyPSfDJo=; b=wPZ4Ol
	iBV7YibR5H+SCHzD1OQePEYunoBRk8fYAXLiCNkxzU8FzYuf4m4wpO8Y1zymFRqg
	sCwA4r4y5dxZ/Q+d0OcG78R1oiC2D7QvquEDpNoDZNQWGgAyGcTIrUhPfW+inFOH
	zwEGwbw7MSK1rXanFkuPeEMJi5jaZNgHw3qYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s3h6zpXvDglzl0cXE+LsAtgwYTAoJOCS
	e5qMWXXg+4bS/0Oyk/u4OKP4FHsX+gCljmzO6uxWKESWLVRqfSk7BdK16zUvSMBg
	IR4ggrC6TTEizfhV/JXYhkvXIu+9nI3WpMk3q+FpbxdfWXA5hkzBEmFIjVi0rkUG
	bT5B0Uk0XfU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FEF47AE8;
	Mon, 27 Aug 2012 12:15:10 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 85D467AE6; Mon, 27 Aug 2012
 12:15:08 -0400 (EDT)
In-Reply-To: <f58965733e604a9fe6ed72384d0307062403b478.1346043214.git.worldhello.net@gmail.com> (Jiang Xin's message of "Mon, 27 Aug 2012 13:13:36 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5EC9A8B2-F062-11E1-9B37-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204351>

Jiang Xin <worldhello.net@gmail.com> writes:

> Some testcases will fail if current work directory is on a symlink.
>
>     symlink$ sh ./t4035-diff-quiet.sh
>     $ sh ./t4035-diff-quiet.sh --root=/symlink
>     $ TEST_OUTPUT_DIRECTORY=/symlink sh ./t4035-diff-quiet.sh
>
> This is because the realpath of ".git" directory will be returned when
> running the command 'git rev-parse --git-dir' in a subdir of the work
> tree, and the realpath may not equal to "$TRASH_DIRECTORY".
>
> In this fix, "$TRASH_DIRECTORY" is determined right after the realpath
> of CWD is resolved.
>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> Reported-by: Michael Haggerty <mhagger@alum.mit.edu>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---

I think this is in line with what was discussed in the other thread
Michael brought this up.  Thanks for following it through.

Michael, this looks good to me; anything I missed?

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 78c42..9a59ca8 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -531,17 +531,17 @@ fi
>  test="trash directory.$(basename "$0" .sh)"
>  test -n "$root" && test="$root/$test"
>  case "$test" in
> -/*) TRASH_DIRECTORY="$test" ;;
> - *) TRASH_DIRECTORY="$TEST_OUTPUT_DIRECTORY/$test" ;;
> +/*) ;;
> + *) test="$TEST_OUTPUT_DIRECTORY/$test" ;;
>  esac
> -test ! -z "$debug" || remove_trash=$TRASH_DIRECTORY
> +test ! -z "$debug" || remove_trash=$test
>  rm -fr "$test" || {
>  	GIT_EXIT_OK=t
>  	echo >&5 "FATAL: Cannot prepare test area"
>  	exit 1
>  }
>  
> -HOME="$TRASH_DIRECTORY"
> +HOME="$test"
>  export HOME
>  
>  if test -z "$TEST_NO_CREATE_REPO"; then
> @@ -552,6 +552,7 @@ fi
>  # Use -P to resolve symlinks in our working directory so that the cwd
>  # in subprocesses like git equals our $PWD (for pathname comparisons).
>  cd -P "$test" || exit 1
> +TRASH_DIRECTORY="$(pwd)"
>  
>  this_test=${0##*/}
>  this_test=${this_test%%-*}
