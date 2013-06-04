From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-remote-mediawiki: use git.pm functions for credentials
Date: Tue, 04 Jun 2013 11:44:35 -0700
Message-ID: <7vr4gh7m24.fsf@alter.siamese.dyndns.org>
References: <1370344292-7088-1-git-send-email-benoit.person@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, celestin.matte@ensimag.fr,
	Benoit Person <benoit.person@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: benoit.person@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 04 20:44:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjwDu-0003En-NG
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 20:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427Ab3FDSok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 14:44:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38466 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751289Ab3FDSoj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 14:44:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C93425C0C;
	Tue,  4 Jun 2013 18:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o9EZuxlHDlXkF1bb4jfxNbQLrJk=; b=LgWwMp
	oaAwgBLb5nC2DeZ9gu2qNcCi+A/IeoPZM1++H6xjZAyF2PUxcNJQqMKYaS8fLsRd
	8DRRjVLoZD8vFxkBcYuYBHCQk0JTfmkpdq0XnR00AhIpK06NBKCivuGhotNWzYT7
	w9KlVC2THbvNEzrixaFEyxymdom1GfIkzsZO0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DzxOgkFkXFgqiQLQqwtkT7XyMGYZEwd8
	T5QsGh7GTHbEUmyoRFXm0+oSEkyvy3eeAuD1y1cFf52LFzlowXAs+56fcPj2fAXI
	pUPq4IwvY88T7Z42SjQ9/lHjxbktCglO3dCLC76muphdFHM0ilKoPZkbvDgKb05p
	Xgz/LhyP4mc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EBC725C0B;
	Tue,  4 Jun 2013 18:44:38 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF90F25C01;
	Tue,  4 Jun 2013 18:44:36 +0000 (UTC)
In-Reply-To: <1370344292-7088-1-git-send-email-benoit.person@ensimag.fr>
	(benoit person's message of "Tue, 4 Jun 2013 13:11:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CE63FECC-CD46-11E2-9EB5-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226391>

benoit.person@gmail.com writes:

> From: Benoit Person <benoit.person@ensimag.fr>
>
> In 52dce6d, a new credential function was added to git.pm, based on
> git-remote-mediawiki's functions. The logical follow-up is to use
> those functions in git-remote-mediawiki.
>
> Signed-off-by: Benoit Person <benoit.person@ensimag.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> ---
>  contrib/mw-to-git/git-remote-mediawiki.perl | 66 ++++-------------------------
>  1 file changed, 9 insertions(+), 57 deletions(-)

With s/git.pm/Git.pm/, the above looks perfect.

> @@ -217,22 +167,24 @@ sub mw_connect_maybe {
>  	$mediawiki = MediaWiki::API->new;
>  	$mediawiki->{config}->{api_url} = "$url/api.php";
>  	if ($wiki_login) {
> -		my %credential = (url => $url);
> -		$credential{username} = $wiki_login;
> -		$credential{password} = $wiki_passwd;
> -		credential_run("fill", \%credential);
> +		my %credential = (
> +			'url' => $url,
> +			'username' => $wiki_login,
> +			'password' => $wiki_passwd
> +		);
> +		Git::credential \%credential;
>  		my $request = {lgname => $credential{username},
>  			       lgpassword => $credential{password},
>  			       lgdomain => $wiki_domain};
>  		if ($mediawiki->login($request)) {
> -			credential_run("approve", \%credential);
> +			Git::credential \%credential, 'approve';

The example in perl/Git.pm for =item credential shows the subroutine
call without surrounding parentheses, and that is perfectly valid
Perl, but given that the prevalent style of subroutine calls made in
this file seems to be with them, i.e. subr(arg, arg), you might want
to consider being consistent here (and in the implicit 'fill' call
several lines above, and 'reject' call below).

Thanks.

>  			print STDERR "Logged in mediawiki user \"$credential{username}\".\n";
>  		} else {
>  			print STDERR "Failed to log in mediawiki user \"$credential{username}\" on $url\n";
>  			print STDERR "  (error " .
>  				$mediawiki->{error}->{code} . ': ' .
>  				$mediawiki->{error}->{details} . ")\n";
> -			credential_run("reject", \%credential);
> +			Git::credential \%credential, 'reject';
>  			exit 1;
>  		}
>  	}
