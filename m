From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 10/10] git fetch: support host:/~repo
Date: Thu, 21 Nov 2013 15:40:26 -0800
Message-ID: <xmqq38mp2uj9.fsf@gitster.dls.corp.google.com>
References: <201311212142.11216.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Nov 22 00:40:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjdrN-0004KJ-6a
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 00:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753784Ab3KUXk3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Nov 2013 18:40:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40274 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751508Ab3KUXk2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Nov 2013 18:40:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DD9D54913;
	Thu, 21 Nov 2013 18:40:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=aVELFWGIOseS
	9P3MzfB21C45P60=; b=uQwmRLoOc+rU42tAbjJBh+Fae0s7rC3d6m00pe9oeutt
	GPfGjOsHvUIAZ7skP0lrfLuHBt22vpnQ2LEDK4PxZS5NCkHj1Q+m86TOagQ0nu7w
	KgqNbHgaecmAd/0s7kXtdsUtqy7O69VqMhqe0lXqxFbLsjKAKl1A5/3I5MwuYp4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZlUkaU
	p/nPJcP7vNbQakEJf3x5tgZ5M2aPrZvrjDxYUg0r3uOmeC5tELU0ICkxFlL4MNHT
	xunOGb80uJfFeI5snEdNsf+Ve+IvhJzxZFCXBpeBch/vxQKr7KYkIqngJ7ARbu/r
	iupYzhxyuuM+v185PCqJ43PQVNZPaqK/9a8jM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FCE454912;
	Thu, 21 Nov 2013 18:40:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BCD8954910;
	Thu, 21 Nov 2013 18:40:27 -0500 (EST)
In-Reply-To: <201311212142.11216.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Thu, 21 Nov 2013 21:42:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4CFD6238-5306-11E3-ADCA-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238166>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Since commit faea9ccb URLs host:~repo or ssh://host:/~repo
> reach the home directory.
> In 356bece0 support for [] was introduced, and as a side
> effect, [host]:/~repo was the same as [host]:~repo.
> The side effect was removed in c01049ae, "connect.c: Corner case for =
IPv6".
>
> Re-reading the documentation (in urls.txt) we find that
> "ssh://host:/~repo",
> "host:/~repo" or
> "host:~repo"
> specifiy the repository "repo" in the home directory at "host".
>
> So make the handling of "host:/~repo" (or "[host]:/~repo") a feature,
> and revert the possible regression introduced in c01049ae.

Isn't c01049ae a private copy in your repository, a part of this
series?  Perhaps the series needs to be (re)structured to avoid
introducing a "possible regression" in the first place?

Confused...

> ---
>  connect.c             |  3 +--
>  t/t5500-fetch-pack.sh |  4 ++--
>  t/t5601-clone.sh      | 12 ++++++++++--
>  3 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/connect.c b/connect.c
> index 95568ac..2cad296 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -625,8 +625,7 @@ static enum protocol parse_connect_url(const char=
 *url_orig, char **ret_host,
>  	end =3D path; /* Need to \0 terminate host here */
>  	if (separator =3D=3D ':')
>  		path++; /* path starts after ':' */
> -	if ((protocol =3D=3D PROTO_GIT) ||
> -			(protocol =3D=3D PROTO_SSH && separator =3D=3D '/')) {
> +	if (protocol =3D=3D PROTO_GIT || protocol =3D=3D PROTO_SSH) {
>  		if (path[1] =3D=3D '~')
>  			path++;
>  	}
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 69a2110..7d9f18c 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -601,9 +601,9 @@ do
>  		test_expect_success "fetch-pack --diag-url $h:$r" '
>  			check_prot_path $h:$r $p "$r"
>  		'
> -		# No "/~" -> "~" conversion
> +		# Do the "/~" -> "~" conversion
>  		test_expect_success "fetch-pack --diag-url $h:/~$r" '
> -			check_prot_host_path $h:/~$r $p "$h" "/~$r"
> +			check_prot_host_path $h:/~$r $p "$h" "~$r"
>  		'
>  	done
>  done
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index bd1bfd3..62fbd7e 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -348,7 +348,7 @@ test_expect_success MINGW 'clone c:temp is dos dr=
ive' '
>  '
> =20
>  #ip v4
> -for repo in rep rep/home/project /~proj 123
> +for repo in rep rep/home/project 123
>  do
>  	test_expect_success "clone host:$repo" '
>  		test_clone_url host:$repo host $repo
> @@ -356,12 +356,20 @@ do
>  done
> =20
>  #ipv6
> -for repo in rep rep/home/project 123 /~proj
> +for repo in rep rep/home/project 123
>  do
>  	test_expect_success "clone [::1]:$repo" '
>  		test_clone_url [::1]:$repo ::1 $repo
>  	'
>  done
> +#home directory
> +test_expect_success "clone host:/~repo" '
> +	test_clone_url host:/~repo host "~repo"
> +'
> +
> +test_expect_success "clone [::1]:/~repo" '
> +	test_clone_url [::1]:/~repo ::1 "~repo"
> +'
> =20
>  # Corner cases
>  for url in foo/bar:baz [foo]bar/baz:qux [foo/bar]:baz
