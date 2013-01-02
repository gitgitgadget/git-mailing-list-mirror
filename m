From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Test failures with python versions when building git 1.8.1
Date: Wed, 02 Jan 2013 08:34:42 -0800
Message-ID: <7vip7f4k7x.fsf@alter.siamese.dyndns.org>
References: <CAEik5nOqge8ix4WGf-h+0Dmz1CanH_XtQdB-CxvPsggSu1-LzQ@mail.gmail.com>
 <7va9ss5fhq.fsf@alter.siamese.dyndns.org>
 <20130102065345.GA8685@sigill.intra.peff.net>
 <7v1ue459yh.fsf@alter.siamese.dyndns.org>
 <20130102085935.GB9328@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan McGee <dan@archlinux.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	David Michael Barr <b@rr-dav.id.au>,
	"Eric S. Raymond" <esr@thyrsus.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 02 17:35:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqRHV-0003Wb-Hy
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 17:35:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966Ab3ABQeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 11:34:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34538 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752937Ab3ABQep (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 11:34:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73AA7B483;
	Wed,  2 Jan 2013 11:34:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TuDCxL72SpjinP3qO7lQqmxwR38=; b=vYCrtB
	uqTJSgjeqNhFGLo/2Ksyofe7sUOyLtpqj1mt/C0EQleUSruvM7KvOSEZfJTQVtop
	vk4CFjSK4MWNpNdN8x3stp0x1lmHxI6zftSZ/1nmTgu6I1++tCquZUEUvmrbJFqZ
	eH/58g6ETvXieA7a7KlYrkVxCqR41ZmU5xQTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BuUIrvb+KDy/8+/GR8rCIc8H+1Hx/4PV
	1TBsdLQLE0vgIiYaY2ONSnWpXmOBY/ivNxI8XZsGPSxknnN1nZbjAKcq9PE1lfGv
	7mZ85+EmPMZ5cVIWYsOtNyvDrrV506GRHi4cwCOKeN+k3dTwiYtZNxt+oULI0I7i
	3vdDaMo2uLA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6410CB482;
	Wed,  2 Jan 2013 11:34:44 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C9342B481; Wed,  2 Jan 2013
 11:34:43 -0500 (EST)
In-Reply-To: <20130102085935.GB9328@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 2 Jan 2013 03:59:35 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 50334428-54FA-11E2-913A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212519>

Jeff King <peff@peff.net> writes:

> Whether we end up doing something with contrib and tests or not, the
> patch below gives a minimal fix in the meantime.

Replacing the symbolic link with write_script that uses exported
variables looks like a familiar pattern.  I like it.

Oh, wait.  That pattern is of course familiar, because 5a02966
(t9020: use configured Python to run the test helper, 2012-12-18)
has been in 'next', and is planned for the first batch.



> -- >8 --
> Subject: [PATCH] t9020: don't run python from $PATH
>
> In t9020, we symlink in a python script from contrib to help
> with the testing. However, we don't munge its #!-line, which
> means we may run the wrong python (we want the one in
> PYTHON_PATH). On top of this, we use a symlink without
> checking the SYMLINKS prereq, and we fail to properly quote
> GIT_BUILD_DIR, which may have spaces.
>
> Instead of symlinking, let's just write a small script which
> will feed the contrib script to PYTHON_PATH. To avoid
> quoting issues, we just export the variables the script
> needs to run.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t9020-remote-svn.sh | 5 ++++-
>  t/test-lib.sh         | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/t/t9020-remote-svn.sh b/t/t9020-remote-svn.sh
> index 4f2dfe0..416623b 100755
> --- a/t/t9020-remote-svn.sh
> +++ b/t/t9020-remote-svn.sh
> @@ -14,7 +14,10 @@ export PATH="$HOME:$PATH"
>  
>  # We override svnrdump by placing a symlink to the svnrdump-emulator in .
>  export PATH="$HOME:$PATH"
> -ln -sf $GIT_BUILD_DIR/contrib/svn-fe/svnrdump_sim.py "$HOME/svnrdump"
> +export GIT_BUILD_DIR
> +write_script svnrdump <<\EOF
> +exec "$PYTHON_PATH" "$GIT_BUILD_DIR"/contrib/svn-fe/svnrdump_sim.py "$@"
> +EOF
>  
>  init_git () {
>  	rm -fr .git &&
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index f50f834..c17db19 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -45,7 +45,7 @@ fi
>  fi
>  
>  . "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
> -export PERL_PATH SHELL_PATH
> +export PERL_PATH SHELL_PATH PYTHON_PATH
>  
>  # if --tee was passed, write the output not only to the terminal, but
>  # additionally to the file test-results/$BASENAME.out, too.
