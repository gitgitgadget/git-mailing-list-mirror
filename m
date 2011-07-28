From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] gitweb: Git config keys are case insensitive, make
 config search too
Date: Thu, 28 Jul 2011 13:14:24 -0700
Message-ID: <7vtya6kvrz.fsf@alter.siamese.dyndns.org>
References: <20110727205118.10439.58875.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 22:14:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmWyW-0002Gj-QA
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 22:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755880Ab1G1UO2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jul 2011 16:14:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33509 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755275Ab1G1UO1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2011 16:14:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 965795617;
	Thu, 28 Jul 2011 16:14:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=eMPTHalYdb1L
	LzJehNvALJ9f23Q=; b=R6Ib3dJlrNYDUxyVjU4mWSiHm5Ki7lS5CBPpFz3rGGnC
	yJAZzvbGSujA1/9fYiA7YPM0YtQ85OQ/P/Iw4xMQKFK0oSKaNjnU7F2ZrTy9p4oH
	JH2Pw3dZwG/UJwo+8RFv3NPWF2gJm0uUfjkLbc3nHaVPLgNXJU3DyGEndhbyfaU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qARGJm
	CgtMlIWevL0hQu4z9wYptfj9xDvcJqTM69R0snKFEGBErKte75vLIZllpK7PkmVq
	9OWDfBy6V3uuYz2llI1CNOVC4tZpDZRl5zscUCpAhagRXfWJoB8idGgHnGh97ZGS
	5bLEUclUxJhEVog3OpOdm//0dRjaIkeSgy55s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D8785616;
	Thu, 28 Jul 2011 16:14:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21B1C5615; Thu, 28 Jul 2011
 16:14:26 -0400 (EDT)
In-Reply-To: <20110727205118.10439.58875.stgit@localhost.localdomain> (Jakub
 Narebski's message of "Wed, 27 Jul 2011 22:53:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 30FF64B0-B956-11E0-8AB2-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178112>

Jakub Narebski <jnareb@gmail.com> writes:

> "git config -z -l" that gitweb uses in git_parse_project_config() to
> populate %config hash returns section and key names of config
> variables in lowercase (they are case insensitive).  When checking
> %config in git_get_project_config() we have to take it into account.
>
> Gitweb does not (yet?) use git config variables with subsection, so w=
e
> can simply lowercase $key in git_get_project_config (only subsection
> names are case sensitive).

Why stop there, I have to wonder, instead of futureproofing with minimu=
m
cost, even with something na=C3=AFve like:

	if (my ($hi, $mi, $lo) =3D ($key =3D~ /^([^.]*)\.(.*)\.(.*)$)) {
		$key =3D join(".", lc($hi), $mi, lc($lo);
	} else {
        	$key =3D lc($key);
	}

> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> I think it is a resend, but I haven't found first version.
>
> The patch is unchanged, but commit message got improved.
> It is not as much bugfix as hardening (against user e.g. adding
> new overridable feature via gitweb config file).
>
>  gitweb/gitweb.perl |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 1070805..90b5a73 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2526,6 +2526,7 @@ sub git_get_project_config {
> =20
>  	# key sanity check
>  	return unless ($key);
> +	$key =3D lc($key); # assuming there is no subsection
>  	$key =3D~ s/^gitweb\.//;
>  	return if ($key =3D~ m/\W/);
> =20
