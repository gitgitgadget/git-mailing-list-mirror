From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/hooks: avoid requiring root access in usage
 instructions
Date: Fri, 19 Oct 2012 21:19:33 -0700
Message-ID: <7vzk3hhj1m.fsf@alter.siamese.dyndns.org>
References: <20121020003104.GA26596@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Olivier Berger <olivier.berger@it-sudparis.eu>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"Kevin P. Fleming" <kpfleming@digium.com>,
	Chris Hiestand <chiestand@salk.edu>,
	Miklos Vajna <vmiklos@suse.cz>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 20 06:19:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPQXP-00050l-39
	for gcvg-git-2@plane.gmane.org; Sat, 20 Oct 2012 06:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458Ab2JTETj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2012 00:19:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59313 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751066Ab2JTETi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2012 00:19:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 870A262A2;
	Sat, 20 Oct 2012 00:19:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bdZIWc9v0FxnTeUMchB+hVgOhCE=; b=VRIIJP
	auyrTLCETGms6ewBNJrEKWWQXD6jbdnY5JCrHptwjl3V0wCKCp4yBnOfqiS54saM
	46cl4fjerhJmUAW6lEi6R3BczkSdIgsxJz0Xu7zCpaCLyOFj7jKslTe0baQIcPF8
	akX/c85ax91wL72i1aaAPphEhlNrDvqI6l99U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qtju+M6KK2tliek89HZ3n/ZZx5bkr5le
	qsRpyA+vWCu/Is3dw5D9sTVZQyCobbkKWH4ufUdQFpshrQKShY0iVNZkDD1ArUIV
	GHtf94jHGlDK3UZ9Giahkrbm00G5r5cFYi/8GteosyUvHlYjYDtXfdNvWCrh/Uad
	611igCQUTRo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7223862A1;
	Sat, 20 Oct 2012 00:19:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 85435629D; Sat, 20 Oct 2012
 00:19:35 -0400 (EDT)
In-Reply-To: <20121020003104.GA26596@elie.Belkin> (Jonathan Nieder's message
 of "Fri, 19 Oct 2012 17:31:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B0E39BA-1A6D-11E2-811A-9A8C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208079>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Comments in hooks/post-receive-email suggest:
>
>  For example, on debian the hook is stored in
>  /usr/share/git-core/contrib/hooks/post-receive-email:
>
>   chmod a+x post-receive-email
>   cd /path/to/your/repository.git
>   ln -sf /usr/share/git-core/contrib/hooks/post-receive-email hooks/post-receive
>
> Doing that means changing permissions on a file provided by a package,
> which is problematic in a number of ways: the permissions would be
> likely to change back in later upgrades, and changing them requires
> root access.  Copying the script into each repo that uses it is not
> much better, since each copy would be maintained separately and not
> benefit from bugfixes in the master copy.
>
> Better to ship the hook with executable permission and remove the
> chmod line so enabling the hook becomes a one-step process: just
> symlink it into place.
>
> Likewise for the pre-auto-gc-battery hook.
>
> Reported-by: Olivier Berger <olivier.berger@it-sudparis.eu>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> From <http://bugs.debian.org/687391>.
>
> Thoughts?

We already encourage casting-in-stone a particular version of the
sample hook when a new repository is created by copying them from
the template directory.  This prevents from surprising users when an
updated version of Git changes the behaviour of these samples.  Even
if you think bugs in older ones may be corrected in newer ones,
silently updating the hook the user chose to use by inspecting one
particular version is not something we would want to do lightly. A
buggy devil you know is better than a devil that suddenly changes
its behaviour depending on when your sysadmin updates the version of
Git without your knowing.

I personally think the same applies to these contrib/ hooks, and I
would think it is simpler and more consistent to correct the
instruction in these files to tell users to copy them.

Adding +x bits to these files is a good idea but that is orthogonal
to copying vs symlinking, I think.

> Jonathan
>
>  contrib/hooks/post-receive-email  | 1 -
>  contrib/hooks/pre-auto-gc-battery | 1 -
>  2 files changed, 2 deletions(-)
>  mode change 100644 => 100755 contrib/hooks/pre-auto-gc-battery
>
> diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
> index 8ca6607a..359f1ad2 100755
> --- a/contrib/hooks/post-receive-email
> +++ b/contrib/hooks/post-receive-email
> @@ -13,7 +13,6 @@
>  # For example, on debian the hook is stored in
>  # /usr/share/git-core/contrib/hooks/post-receive-email:
>  #
> -#  chmod a+x post-receive-email
>  #  cd /path/to/your/repository.git
>  #  ln -sf /usr/share/git-core/contrib/hooks/post-receive-email hooks/post-receive
>  #
> diff --git a/contrib/hooks/pre-auto-gc-battery b/contrib/hooks/pre-auto-gc-battery
> old mode 100644
> new mode 100755
> index 1f914c94..9d0c2d19
> --- a/contrib/hooks/pre-auto-gc-battery
> +++ b/contrib/hooks/pre-auto-gc-battery
> @@ -13,7 +13,6 @@
>  # For example, if the hook is stored in
>  # /usr/share/git-core/contrib/hooks/pre-auto-gc-battery:
>  #
> -# chmod a+x pre-auto-gc-battery
>  # cd /path/to/your/repository.git
>  # ln -sf /usr/share/git-core/contrib/hooks/pre-auto-gc-battery \
>  #	hooks/pre-auto-gc
