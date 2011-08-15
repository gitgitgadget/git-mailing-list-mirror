From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git svn : hook before 'git svn dcommit'
Date: Mon, 15 Aug 2011 14:14:49 -0700
Message-ID: <7vty9ijs1i.fsf@alter.siamese.dyndns.org>
References: <1313438699-9926-1-git-send-email-frederic.heitzmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: =?utf-8?B?RnLDqWTDqXJpYw==?= Heitzmann 
	<frederic.heitzmann@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 15 23:15:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qt4Ut-00037V-PD
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 23:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916Ab1HOVOy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Aug 2011 17:14:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57571 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334Ab1HOVOx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Aug 2011 17:14:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21FA04360;
	Mon, 15 Aug 2011 17:14:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8AdtukZ0Oy3D
	hdR1HacvJCBqbrY=; b=G9spj/RYy5jXUxW/FxcG1g0NbjRSkj1qzrrc7nwvIXH8
	XHAycpAvRK9S8sU/ozm6f7ghVb0tXBe6+vXdRTNnL9bIjTi5N/e5G4PdHUvaWG9e
	px5qj7UHlQjKLAHwpcKqVQcHJclore+LbkOFBqsu42HGBuu5QWmdU/05sz/MI/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=n7Zli1
	6S0Xqq/88x8jDrC8dlWzYJ6gvZ5swrnnuSiWJsqwWrhYLXKI5M8jHEjj0/9330Bi
	ADHPwSfroFtNtI72CMgGEn17Bu4KuxnjNrJm5G1CXqI5Qk9VcctN8XRaLt1a1Qc3
	xnggGqEmd+6bZXCfdfJ4DKarF3I4cixoXt2Nw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 187C5435F;
	Mon, 15 Aug 2011 17:14:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 82807435E; Mon, 15 Aug 2011
 17:14:51 -0400 (EDT)
In-Reply-To: <1313438699-9926-1-git-send-email-frederic.heitzmann@gmail.com>
 (=?utf-8?B?IkZyw6lkw6lyaWM=?= Heitzmann"'s message of "Mon, 15 Aug 2011
 22:04:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9D568CC0-C783-11E0-833D-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179387>

=46r=C3=A9d=C3=A9ric Heitzmann  <frederic.heitzmann@gmail.com> writes:

> The 'pre-svn-dcommit' hook is called before 'git svn dcommit', which =
aborts
> if return value is not zero. The only parameter given to the hook is =
the
> reference given to 'git svn dcommit'. If no paramter was used, hook g=
ets HEAD
> as its only parameter.

It appears that this is in the same spirit as the pre-commit hook used =
in
"git commit", so it may not hurt but I do not know if having a separate
hook is the optimal approach to achieve what it wants to do.

I notice that git-svn users have been happily using the subsystem witho=
ut
need for any hook (not just pre-commit). Does "git svn" need an equival=
ent
of pre-commit hook? If so, does it need equivalents to other hooks as
well? I am not suggesting you to add support for a boatload of other ho=
oks
in this patch---I am trying to see if this is really a necessary change=
 to
begin with.

Eric, do you want this one?

> diff --git a/git-svn.perl b/git-svn.perl
> index 89f83fd..a537858 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -396,6 +396,25 @@ sub init_subdir {
>  	$_repository =3D Git->repository(Repository =3D> $ENV{GIT_DIR});
>  }
> =20
> +sub pre_svn_dcommit_hook {
> +	my $head =3D shift;
> +
> +	my $hook =3D "$ENV{GIT_DIR}/hooks/pre-svn-dcommit";
> +	return 0 if ! -e $hook || ! -x $hook;

Why force two stat(), instead of just "if ! -x $hook"?  Doesn't it resp=
ond
to a non-existing $hook with "there is nothing executable there" just f=
ine?

> +	system($hook, $head);
> +	if ($? =3D=3D -1) {
> +		print "[pre_svn_dcommit_hook] failed to execute $hook: $!\n";
> +		return 1;
> +	} elsif ($? & 127) {
> +		printf "[pre_svn_dcommit_hook] child died with signal %d, %s cored=
ump\n",
> +		($? & 127),  ($? & 128) ? 'with' : 'without';
> +		return 1;
> +	} else {
> +		return $? >> 8;
> +	}
> +}

Should these messages go to the standard output?

>  sub cmd_clone {
>  	my ($url, $path) =3D @_;
>  	if (!defined $path &&
> @@ -505,6 +524,8 @@ sub cmd_dcommit {
>  		. "or stash them with `git stash'.\n";
>  	$head ||=3D 'HEAD';
> =20
> +	return if pre_svn_dcommit_hook($head);
> +
>  	my $old_head;
>  	if ($head ne 'HEAD') {
>  		$old_head =3D eval {
