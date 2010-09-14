From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: use catfile() to concatenate files
Date: Tue, 14 Sep 2010 12:26:32 -0700
Message-ID: <7v7hio86tz.fsf@alter.siamese.dyndns.org>
References: <1284490944-16964-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 14 21:26:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ovb9U-00055i-LY
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 21:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747Ab0INT0n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 15:26:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42145 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464Ab0INT0m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Sep 2010 15:26:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DBFF6D6C36;
	Tue, 14 Sep 2010 15:26:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mwG1vSOVaR8A
	vtdLltIYFigyXMw=; b=XnCPY5DB5FisG4CCD/2sMLtI5HEtmEqQDKazeXlJ8Jxw
	SYAjN0n1EpWezGAYmLAo4TykYn7IDBkBJf1ZUHjDrzKmFUQx1CiIA5vKgbB/ggER
	ApvVycOSV2krbgJ2yuRPx1+RM5QsoLPEAkWI4oXt0jziMNWz9XMYmSTTJ73eFcU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=uZIFEU
	b/dSla9lCPI1jSsjOoDT4hvgRWPf+p09sXT7jCOMBMnSNW4PUDUP0k+yTU9nxKEb
	KlW81atU7sNLwh9jgDtLTew3xdiTY0eyzZB7ZCWuGRPbk+WjvBValw4mwsDlbHdB
	MC71ZKdvzvfVmSSX6IOFICtZc1SaSMngYZUJo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B805AD6C34;
	Tue, 14 Sep 2010 15:26:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 016A0D6C32; Tue, 14 Sep
 2010 15:26:33 -0400 (EDT)
In-Reply-To: <1284490944-16964-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue\, 14 Sep
 2010 19\:02\:24 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FDBDB3B4-C035-11DF-9413-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156204>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Change send-email to use Perl's catfile() function instead of
> "$dir/$file". If send-email is given a $dir that ends with a / we'll
> end up printing a double slashed path like "dir//mtfnpy.patch".
>
> This doesn't cause any problems since Perl's IO layer will handle it,
> but it looks ugly.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>

If you mentioned in the proposed log message that File::Spec::Functions
have been with us since Perl 5.6.1, it would have saved me (and others)
some time worrying about the portability issues.

>  git-send-email.perl |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 6dab3bf..7f702e3 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -24,6 +24,7 @@ use Text::ParseWords;
>  use Data::Dumper;
>  use Term::ANSIColor;
>  use File::Temp qw/ tempdir tempfile /;
> +use File::Spec::Functions qw(catfile);
>  use Error qw(:try);
>  use Git;
> =20
> @@ -511,7 +512,7 @@ while (defined(my $f =3D shift @ARGV)) {
>  		opendir(DH,$f)
>  			or die "Failed to opendir $f: $!";
> =20
> -		push @files, grep { -f $_ } map { +$f . "/" . $_ }
> +		push @files, grep { -f $_ } map { catfile($f, $_) }
>  				sort readdir(DH);
>  		closedir(DH);
>  	} elsif ((-f $f or -p $f) and !check_file_rev_conflict($f)) {
> --=20
> 1.7.3.rc1.234.g8dc15
