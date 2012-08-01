From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-am: make a config setting for --keep-non-patch
 switch
Date: Wed, 01 Aug 2012 11:48:23 -0700
Message-ID: <7v1ujqfnyg.fsf@alter.siamese.dyndns.org>
References: <1343841535-25652-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 20:48:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwdyD-0001m1-HI
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 20:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897Ab2HASs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 14:48:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41436 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753384Ab2HASs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 14:48:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B92F89EFB;
	Wed,  1 Aug 2012 14:48:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=El7bH2GPqCvXzEYokM8BStRTqig=; b=seqOTp
	17udOFV0EJ2gXPamFxOLoVR9nZsptzaV9A2USzRrMzMJlFeDVd2sldMuvPAFeWE4
	ZrycsNrb+gSBTy4nKsFw5IN7cwkKROJ4h2xkmmdvwb7H6cF/2aGAMwJCOgsgQ1Ip
	BrfyrWDgyo1/3frMxRpTX9unruiirAnWCW4rU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YPg8oqoID48lUP+S1ggxU80u+DZJEb2o
	4pTi/drHzZdm0UMOeWmhVoAXXeTAUV0jQdBfy+qXpda4pRHKx3RFb25+mgvcFuTA
	ZITm8xCPuuUizFG9XcQa8psfLWOkp4qp/6WixwQfmf8Ly9LVl10NquoNOArUcXyu
	lunoeSYXBBc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A68E39EFA;
	Wed,  1 Aug 2012 14:48:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF8C09EF9; Wed,  1 Aug 2012
 14:48:24 -0400 (EDT)
In-Reply-To: <1343841535-25652-1-git-send-email-paul.gortmaker@windriver.com>
 (Paul Gortmaker's message of "Wed, 1 Aug 2012 13:18:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 79786D78-DC09-11E1-9553-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202719>

Paul Gortmaker <paul.gortmaker@windriver.com> writes:

> In order to make a commit be invariant (excluding ID) over
> a format-patch and subsequent am cycle, one needs to use
> the '--keep-non-patch' so that commits like:
>
> 	[PATCH] [i386] fix foo bar arch/x86/mm
>
> only lose the [PATCH] and not the [i386] part.  Since it
> is a common desire (e.g. linux kernel stable trees) to have
> the subjects remain invariant during a backport, there is
> a genuine need for making this the default behaviour from
> a config file, versus specifying it in scripts and on the
> command line each time.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>
> See http://lkml.indiana.edu/hypermail/linux/kernel/1203.1/01817.html
> for additional background; stable maintainers using it etc.

That's a blast from the past; it would have been so much nicer
if the patch came earlier ;-)

The patch looks from sane; we may want to have a test in t4150, just like
we have tests for am.keepcr in t4253.  We have plenty of time as we
are in feature freeze right now.

Thanks.

>
>  Documentation/config.txt               | 9 +++++++++
>  Documentation/git-am.txt               | 4 ++++
>  contrib/completion/git-completion.bash | 1 +
>  git-am.sh                              | 8 ++++++++
>  4 files changed, 22 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index a95e5a4..47aded5 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -655,6 +655,15 @@ am.keepcr::
>  	by giving '--no-keep-cr' from the command line.
>  	See linkgit:git-am[1], linkgit:git-mailsplit[1].
>  
> +am.keepnonpatch::
> +	Normally git-mailinfo strips from the Subject line, all leading
> +	strings bracketed with [ and ] pairs.  If this setting is true,
> +	git-am will call git-mailinfo with the parameter '-b' so that only
> +	the pairs whose bracketed string contains the word "PATCH" are
> +	stripped.  Can be overridden by giving ' '--no-keep-non-patch'
> +	from the command line.
> +	See linkgit:git-am[1], linkgit:git-mailinfo[1].
> +
>  apply.ignorewhitespace::
>  	When set to 'change', tells 'git apply' to ignore changes in
>  	whitespace, in the same way as the '--ignore-space-change'
> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index 19d57a8..790efdb 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -41,7 +41,11 @@ OPTIONS
>  	Pass `-k` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
>  
>  --keep-non-patch::
> +--no-keep-non-patch::
>  	Pass `-b` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
> +	The `am.keepnonpatch` configuration variable can be used to specify
> +	the default behaviour.  The `--no-keep-non-patch` is useful to
> +	override any `am.keepnonpatch` setting.
>  
>  --keep-cr::
>  --no-keep-cr::
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index ffedce7..04339df 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1758,6 +1758,7 @@ _git_config ()
>  		advice.statusHints
>  		alias.
>  		am.keepcr
> +		am.keepnonpatch
>  		apply.ignorewhitespace
>  		apply.whitespace
>  		branch.autosetupmerge
> diff --git a/git-am.sh b/git-am.sh
> index c02e62d..9f6adbf 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -16,6 +16,7 @@ s,signoff       add a Signed-off-by line to the commit message
>  u,utf8          recode into utf8 (default)
>  k,keep          pass -k flag to git-mailinfo
>  keep-non-patch  pass -b flag to git-mailinfo
> +no-keep-non-patch do not pass -b flag to git-mailsplit, independent of am.keepnonpatch
>  keep-cr         pass --keep-cr flag to git-mailsplit for mbox format
>  no-keep-cr      do not pass --keep-cr flag to git-mailsplit independent of am.keepcr
>  c,scissors      strip everything before a scissors line
> @@ -381,6 +382,11 @@ then
>      keepcr=t
>  fi
>  
> +if test "$(git config --bool --get am.keepnonpatch)" = true
> +then
> +    keep=b
> +fi
> +
>  while test $# != 0
>  do
>  	case "$1" in
> @@ -402,6 +408,8 @@ do
>  		keep=t ;;
>  	--keep-non-patch)
>  		keep=b ;;
> +	--no-keep-non-patch)
> +		keep= ;;
>  	-c|--scissors)
>  		scissors=t ;;
>  	--no-scissors)
