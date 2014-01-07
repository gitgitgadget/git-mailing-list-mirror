From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pager: set LV=-c alongside LESS=FRSX
Date: Tue, 07 Jan 2014 09:00:02 -0800
Message-ID: <xmqqha9fg225.fsf@gitster.dls.corp.google.com>
References: <874n6zbqlh.fsf@helix.nebula.avasys.jp>
	<20140106193339.GH3881@google.com>
	<874n5ghenr.fsf@helix.nebula.avasys.jp>
	<20140107021404.GK3881@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Olaf Meeuwissen <olaf.meeuwissen@avasys.jp>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 18:00:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0a10-0008A4-GJ
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 18:00:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbaAGRA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 12:00:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46659 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752049AbaAGRAY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 12:00:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D0B360048;
	Tue,  7 Jan 2014 12:00:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FVoHns7URBBIphAgD532CO97Me4=; b=wsSbcc
	ZAdvs8oc1+P+mAbByjFU/rkwRLJySZXu9LIbPHKYZwp5lhnLKwjxwpJPHVY0bBnf
	+sT/NvJq+DAz81jXQOwkxVzxr21X9z/oyJgSF5/2B2FBasOdWHwqeAsEHNuZSe0f
	4hkdQh2kQqLalzTi/NrdcXJAtSKXg/5cNddy8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LjHk7Mp0bMZiGZ0l3gP6G9Dghtml7x4T
	xDkCkb/7DwVpHxSwFg9+ZJYU/o2KDL07v5t0z6tWW3tIYENIm8+MU4jg4Agw1mnU
	mgVnhMhXIRQmrS0a/prMNqbvVILlsqNQLe61G7FuCFX3uwn/uW1YdCws+0NR3Udv
	sV26uRMWdwY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7570C60045;
	Tue,  7 Jan 2014 12:00:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 757FE6003A;
	Tue,  7 Jan 2014 12:00:13 -0500 (EST)
In-Reply-To: <20140107021404.GK3881@google.com> (Jonathan Nieder's message of
	"Mon, 6 Jan 2014 18:14:05 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2CC54FA4-77BD-11E3-854B-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240110>

Jonathan Nieder <jrnieder@gmail.com> writes:

> On systems with lv configured as the preferred pager (i.e.,
> DEFAULT_PAGER=lv at build time, or PAGER=lv exported in the
> environment) git commands that use color show control codes instead of
> color in the pager:
>
> 	$ git diff
> 	^[[1mdiff --git a/.mailfilter b/.mailfilter^[[m
> 	^[[1mindex aa4f0b2..17e113e 100644^[[m
> 	^[[1m--- a/.mailfilter^[[m
> 	^[[1m+++ b/.mailfilter^[[m
> 	^[[36m@@ -1,11 +1,58 @@^[[m
>
> "less" avoids this problem because git uses the LESS environment
> variable to pass the -R option ('output ANSI color escapes in raw
> form') by default.  Use the LV environment variable to pass 'lv' the
> -c option ('allow ANSI escape sequences for text decoration / color')
> to fix it for lv, too.
>
> Noticed when the default value for color.ui flipped to 'auto' in
> v1.8.4-rc0~36^2~1 (2013-06-10).
>
> Reported-by: Olaf Meeuwissen <olaf.meeuwissen@avasys.jp>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Olaf Meeuwissen wrote[1]:
>
>> Yes, it's called LV and documented in the lv(1) manual page.  Simply
>> search for 'env' ;-)
>
> Ah, thanks.  How about this patch?
>
> [1] http://bugs.debian.org/730527

Looks good; though I have to wonder two (and a half) things:

 - Scripted Porcelains get LESS=-FRSX while C Porcelains get
   LESS=FRSX as the default (the leading dash being the
   difference), which looks somewhat inconsistent.  Not a new
   problem, though.

 - Can we generalize this a bit so that a builder can pass a list
   of var=val pairs and demote the existing LESS=FRSX to just a
   canned setting of such a mechanism?

 - Can such a code be reused to make this into a runtime setting,
   even?  Would it be worth the complexity?

Thanks.

>  Documentation/config.txt |  4 ++++
>  git-sh-setup.sh          |  3 ++-
>  pager.c                  | 11 +++++++++--
>  perl/Git/SVN/Log.pm      |  1 +
>  t/t7006-pager.sh         | 12 ++++++++++++
>  5 files changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index a405806..ed59853 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -567,6 +567,10 @@ be passed to the shell by Git, which will translate the final
>  command to `LESS=FRSX less -+S`. The environment tells the command
>  to set the `S` option to chop long lines but the command line
>  resets it to the default to fold long lines.
> ++
> +Likewise, when the `LV` environment variable is unset, Git sets it
> +to `-c`.  You can override this setting by exporting `LV` with
> +another value or setting `core.pager` to `lv +c`.
>  
>  core.whitespace::
>  	A comma separated list of common whitespace problems to
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index 190a539..fffa3c7 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -159,7 +159,8 @@ git_pager() {
>  		GIT_PAGER=cat
>  	fi
>  	: ${LESS=-FRSX}
> -	export LESS
> +	: ${LV=-c}
> +	export LESS LV
>  
>  	eval "$GIT_PAGER" '"$@"'
>  }
> diff --git a/pager.c b/pager.c
> index 345b0bc..0cc75a8 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -80,8 +80,15 @@ void setup_pager(void)
>  	pager_process.use_shell = 1;
>  	pager_process.argv = pager_argv;
>  	pager_process.in = -1;
> -	if (!getenv("LESS")) {
> -		static const char *env[] = { "LESS=FRSX", NULL };
> +	if (!getenv("LESS") || !getenv("LV")) {
> +		static const char *env[3];
> +		int i = 0;
> +
> +		if (!getenv("LESS"))
> +			env[i++] = "LESS=FRSX";
> +		if (!getenv("LV"))
> +			env[i++] = "LV=-c";
> +		env[i] = NULL;
>  		pager_process.env = env;
>  	}
>  	if (start_command(&pager_process))
> diff --git a/perl/Git/SVN/Log.pm b/perl/Git/SVN/Log.pm
> index 3f8350a..34f2869 100644
> --- a/perl/Git/SVN/Log.pm
> +++ b/perl/Git/SVN/Log.pm
> @@ -117,6 +117,7 @@ sub run_pager {
>  	}
>  	open STDIN, '<&', $rfd or fatal "Can't redirect stdin: $!";
>  	$ENV{LESS} ||= 'FRSX';
> +	$ENV{LV} ||= '-c';
>  	exec $pager or fatal "Can't run pager: $! ($pager)";
>  }
>  
> diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
> index ff25908..7fe3367 100755
> --- a/t/t7006-pager.sh
> +++ b/t/t7006-pager.sh
> @@ -37,6 +37,18 @@ test_expect_failure TTY 'pager runs from subdir' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success TTY 'LESS and LV envvars are set for pagination' '
> +	(
> +		sane_unset LESS LV &&
> +		PAGER="env >pager-env.out" &&
> +		export PAGER &&
> +
> +		test_terminal git log
> +	) &&
> +	grep ^LESS= pager-env.out &&
> +	grep ^LV= pager-env.out
> +'
> +
>  test_expect_success TTY 'some commands do not use a pager' '
>  	rm -f paginated.out &&
>  	test_terminal git rev-list HEAD &&
