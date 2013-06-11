From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 21/28] git-remote-mediawiki: Put long code into a subroutine
Date: Tue, 11 Jun 2013 08:42:05 -0700
Message-ID: <7vli6gd582.fsf@alter.siamese.dyndns.org>
References: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr>
	<1370816573-3808-22-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, benoit.person@ensimag.fr,
	matthieu.moy@grenoble-inp.fr
To: =?utf-8?Q?C=C3=A9lestin?= Matte <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 11 17:42:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmQiC-0002sf-JT
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 17:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892Ab3FKPmL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jun 2013 11:42:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56995 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752801Ab3FKPmJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jun 2013 11:42:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A8AD24E32;
	Tue, 11 Jun 2013 15:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8GYPAu9HOdRD
	t3PVk0R1fXUD2zU=; b=JpKmaYXnCaDzimVbVQpWyhBwQYSwbUzMaM2aHVX+Pfv1
	CJdlExbFqw5/nld0pan+KsvfWQzY8i97xWmVoTjOXamZYTMorZphohvVu2+ymLbr
	yc9cTolJKAcJuHj0NNHtQGwzNHqrpcNbll+coXJRS/PLcIhwD2ZptYAoKdmeeqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MuJOpW
	Kui9YcuwEU//D/YguV/1Ky/WEXWz2NYxg+KREw9RArt3CxoLQ4oU+z7xLh8EK+6R
	9volwQQH88gVTfi6RBZ16/Ql6ySkbEyWBd7eqT1KV3KENegmVId0ZObQ4SRVbe7a
	WXOtjioAOKwOzMf+zk2kq3MztGY2b3nMVfKUA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5106124E31;
	Tue, 11 Jun 2013 15:42:08 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E01AB24E2E;
	Tue, 11 Jun 2013 15:42:06 +0000 (UTC)
In-Reply-To: <1370816573-3808-22-git-send-email-celestin.matte@ensimag.fr>
	(=?utf-8?Q?=22C=C3=A9lestin?= Matte"'s message of "Mon, 10 Jun 2013
 00:22:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 789CD5D8-D2AD-11E2-970E-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227455>

C=C3=A9lestin Matte <celestin.matte@ensimag.fr> writes:

> Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> ---
>  contrib/mw-to-git/git-remote-mediawiki.perl |   50 +++++++++++++++++=
----------
>  1 file changed, 31 insertions(+), 19 deletions(-)
>
> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw=
-to-git/git-remote-mediawiki.perl
> index c404e7b..a66cef4 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
> @@ -126,28 +126,13 @@ $wiki_name =3D~ s{[^/]*://}{};
>  $wiki_name =3D~ s/^.*@//;
> =20
>  # Commands parser
> -my @cmd;
> +my @cmds;

I am guessing that the new sub, parse_command, uses a local @cmd and
this is an attempt to avoid using the same name, but this renaming
of the variable is not explained.

I also wonder if you need this global @cmd/@cmds.  Instead of
passing cmdref, wouldn't it be simpler to have the helper split the
line, i.e. something like...

	sub parse_command {
		my ($line) =3D @_;
                my @cmd =3D split(/ /, $line);
		unless (defined @cmd) {
	                return 0;
		}
                ... check capabilities, list, etc....
		return 1;
	}

        while (<STDIN>) {
        	chomp;
                if (!parse_command($_)) {
			unknown command, aborting
                        last;
		}
	}
