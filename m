From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 8/8] gitweb: Refinement highlightning in combined diffs
Date: Fri, 30 Mar 2012 00:37:10 +0100
Message-ID: <201203300137.11932.jnareb@gmail.com>
References: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com> <1332543417-19664-9-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 01:37:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDOuD-0008Qb-9W
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 01:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760365Ab2C2XhU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Mar 2012 19:37:20 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:42114 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760341Ab2C2XhT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 19:37:19 -0400
Received: by wejx9 with SMTP id x9so38100wej.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 16:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=dbOYPoOAPIZRUei495chlyvIca3GJDfIxZry9CqtYgQ=;
        b=wiPNVXLXg9do+qtjjcCcUezC0FASSTHmG9ozIyQDgIXISyUVEkueeDT1QNAe2xWiYe
         y2sGs7a0nXEfG0y0WFm7yzRjPDN8RBGV37upcgxqyeGLe+pgICmWtBS2c6Ee06bJb1L/
         TNIDDbvrHQ1yShf+5AThRRpExdTMNlmtHZHW/o6QtW4HOA31t1H2oXqVmBXJ980aOkCo
         kdFvkD9J9FCM9MrAARQTjuocUfXzk/df056abOUyOlkBFAbI8bMJED3vmvskS3Ur6gkp
         QBDObpxGT+LAS3pgNAP8rzYy7DqtUlQ4yJMsfywAyx6xvdYOsdGTGDa5+U0r6NjZtqEg
         VvqA==
Received: by 10.180.85.35 with SMTP id e3mr136371wiz.6.1333064237609;
        Thu, 29 Mar 2012 16:37:17 -0700 (PDT)
Received: from [192.168.1.13] (aeh224.neoplus.adsl.tpnet.pl. [83.25.111.224])
        by mx.google.com with ESMTPS id k6sm1200946wie.9.2012.03.29.16.37.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 16:37:16 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1332543417-19664-9-git-send-email-michal.kiedrowicz@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194304>

On Fri, 23 Mar 2012, Micha=C5=82 Kiedrowicz wrote:

> The highlightning of combined diffs is currently disabled.  This is
> because output from a combined diff is much harder to highlight becau=
se
> it's not obvious which removed and added lines should be compared.
>=20
Is -> was?

> Moreover, code that compares added and removed lines doesn't care abo=
ut
> combined diffs. It only skips first +/- character, treating second +/=
-
> as a line content.

Well, we explicitly skip combined diffs.  I think what you want to say
here is that it is not possible to simply use existing algorithm
unchanged for combined diffs.

>=20
> Let's start with a simple case: only highlight changes that come from
> one parent, i.e. when every removed line has a corresponding added li=
ne
> for the same parent.  This way the highlightning cannot get wrong. Fo=
r
> example, following diffs would be highlighted:
>=20
> 	- removed line for first parent
> 	+ added line for first parent
> 	  context line
> 	 -removed line for second parent
> 	 +added line for second parent
>=20
> or
>=20
> 	- removed line for first parent
> 	 -removed line for second parent
> 	+ added line for first parent
> 	 +added line for second parent
>=20
> but following output will not:
>=20
> 	- removed line for first parent
> 	 -removed line for second parent
> 	 +added line for second parent
> 	++added line for both parents

O.K., that's a nice and sensible first step.

I wonder if it would be worth to specify that we currently require that
pattern of '-'-es in pre-image match pattern of '+'-es in postimage.

Nb. the prefix of combined diff would either include '+', or '-',
but never mixed (this is documented, but I had trouble with this).

>=20
> Further changes may introduce more intelligent approach that better
> handles combined diffs.

Very sensible approach.
>=20
> Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>

  Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>

> ---

BTW. I went and checked if this approach helps for non-trivial merges
in git.git history:

* b10656c - helps a bit, though one can see limitation of pre/post-fix
  matching here, but it is present also for non-combined diff.

* 8b132bc - helps a bit, though char-interdiff or word-interdiff might
  be better.  Nb. I think that red background for 'marked' is a bit
  too dark (intensive).

* c58499c - doesn't help too much.

* f629c23, aa145bf - helps.

>  gitweb/gitweb.perl |   57 +++++++++++++++++++++++++++++++++++++++---=
---------
>  1 files changed, 43 insertions(+), 14 deletions(-)
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 872ba12..c056e83 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5057,12 +5057,12 @@ sub print_inline_diff_lines {
>  # Format removed and added line, mark changed part and HTML-format t=
hem.
>  # Impementation is based on contrib/diff-highlight

Implementation
   ^---

>  sub format_rem_add_line {
> -	my ($rem, $add) =3D @_;
> +	my ($rem, $add, $num_parents) =3D @_;
>  	my @rem =3D split(//, $rem);
>  	my @add =3D split(//, $add);
>  	my ($esc_rem, $esc_add);
> -	# Ignore +/- character, thus $prefix_len is set to 1.
> -	my ($prefix_len, $suffix_len) =3D (1, 0);
> +	# Ignore leading +/- characters for each parent.
> +	my ($prefix_len, $suffix_len) =3D ($num_parents, 0);

Nice.

[...]
> @@ -5099,15 +5099,43 @@ sub format_rem_add_line {
> =20
>  # HTML-format diff context, removed and added lines.
>  sub format_ctx_rem_add_lines {
> -	my ($ctx, $rem, $add, $is_combined) =3D @_;
> +	my ($ctx, $rem, $add, $num_parents) =3D @_;
>  	my (@new_ctx, @new_rem, @new_add);
> +	my $can_highlight =3D 0;
> +	my $is_combined =3D ($num_parents > 1);
> =20
>  	# Highlight if every removed line has a corresponding added line.
> -	# Combined diffs are not supported ATM.
> -	if (!$is_combined && @$add > 0 && @$add =3D=3D @$rem) {
> +	if (@$add > 0 && @$add =3D=3D @$rem) {
> +		$can_highlight =3D 1;
> +
> +		# Highlight lines in combined diff only if the chunk contains
> +		# diff between the same version, e.g.
> +		#
> +		#    - a
> +		#   -  b
> +		#    + c
> +		#   +  d
> +		#
> +		# Otherwise the highlightling would be confusing.
> +		if ($is_combined) {
> +			for (my $i =3D 0; $i < @$add; $i++) {
> +				my $prefix_rem =3D substr($rem->[$i], 0, $num_parents);
> +				my $prefix_add =3D substr($add->[$i], 0, $num_parents);
> +
> +				$prefix_rem =3D~ s/-/+/g;
> +
> +				if ($prefix_rem ne $prefix_add) {
> +					$can_highlight =3D 0;
> +					last;
> +				}
> +			}
> +		}
> +	}

Good.

> +
> +	if ($can_highlight) {
>  		for (my $i =3D 0; $i < @$add; $i++) {
>  			my ($line_rem, $line_add) =3D format_rem_add_line(
> -			        $rem->[$i], $add->[$i]);
> +			        $rem->[$i], $add->[$i], $num_parents);
>  			push @new_rem, $line_rem;
>  			push @new_add, $line_add;
>  		}

[...]
> @@ -5326,7 +5355,7 @@ sub git_patchset_body {
> =20
>  	} continue {
>  		if (@chunk) {
> -			print_diff_chunk($diff_style, $is_combined, \%from, \%to, @chunk)=
;
> +			print_diff_chunk($diff_style, scalar @hash_parents, \%from, \%to,=
 @chunk);
>  			@chunk =3D ();
>  		}
>  		print "</div>\n"; # class=3D"patch"

I was wondering about 'commitdiff' between two commits, which is not
combined even ifany of those commits is a merge commit... but it looks
like it works all right.

--=20
Jakub Narebski
Poland
