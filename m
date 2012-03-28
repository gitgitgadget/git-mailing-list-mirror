From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 3/8] gitweb: Extract print_sidebyside_diff_lines()
Date: Wed, 28 Mar 2012 15:33:53 +0100
Message-ID: <201203281633.53916.jnareb@gmail.com>
References: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com> <1332543417-19664-4-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 16:34:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCtwz-0001gm-KR
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 16:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758212Ab2C1OeA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Mar 2012 10:34:00 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:60996 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab2C1Od5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 10:33:57 -0400
Received: by wgbdr13 with SMTP id dr13so1042258wgb.1
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 07:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=MdsAcnJaIeW1YMSFiSnNnbfATg3B6+DpctVXkujpJ1o=;
        b=mSZhS4fvXYDsEXaBwdCR3D5OosA/fmlSJUEMWrbWbcgIJaW1ddwm5VVh+3iRN/pFLt
         1bRVCYKlz0v2xbzTY3B7ZvpIJ2mBwkff6BJYGDUXmQMnZHt2Xh2bRwkH37E08r6p4ccJ
         ORBWaT0B/Oh3Toqoa05kzW2A9p/lCUigkJdeLM2NFc4ewxtTtk3UMWy5oNan7GKNM+UA
         cgIUmgXUic4Pjc/k5y/R86JzOvyHJSCPt60Bz5iV6LKsdi371hsd82gPHN0aRJqrsBuE
         c3+pXm+cNUGYWvNGxAxSpvdP7VwhS8iVW6eSpP7DCMfwTghYqa0/KT+fN0Qllofl3caR
         IyKg==
Received: by 10.180.98.8 with SMTP id ee8mr7699819wib.14.1332945236296;
        Wed, 28 Mar 2012 07:33:56 -0700 (PDT)
Received: from [192.168.1.13] (adhb238.neoplus.adsl.tpnet.pl. [79.184.157.238])
        by mx.google.com with ESMTPS id fz9sm58401601wib.3.2012.03.28.07.33.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Mar 2012 07:33:53 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1332543417-19664-4-git-send-email-michal.kiedrowicz@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194124>

On Fri, 23 Mar 2012, Micha=C5=82 Kiedrowicz wrote:

> Currently, print_sidebyside_diff_chunk() does two things: it
> accumulates diff lines and prints them.  Accumulation may be used to
> perform additional operations on diff lines,  so it makes sense to sp=
lit
> these two things.  Thus, the code that prints diff lines in a side-by=
-side
> manner is moved out of print_sidebyside_diff_chunk() to a separate
> subroutine.
>
Right, that is quite sensible.

> The outcome of this patch is that print_sidebyside_diff_chunk() is no=
w
> much shorter and easier to read.
>=20
Nice effect.

> This is a preparation patch for diff refinement highlightning.  It sh=
ould
> not change the gitweb output, but it slightly changes its behavior.
> Before this commit, context is printed on the class change. Now, it'i=
t
> printed just before printing added and removed lines.

                                                      , and at the end
  of chunk.

IMVHO such change is irrelevant.

Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>

> Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> ---
>  gitweb/gitweb.perl |   97 ++++++++++++++++++++++++++++--------------=
----------
>  1 files changed, 52 insertions(+), 45 deletions(-)

Nice code movement.
=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 1744c40..86d5a02 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4998,6 +4998,53 @@ sub git_difftree_body {
>  	print "</table>\n";
>  }
> =20
> +# Print context lines and then rem/add lines in a side-by-side manne=
r.
> +sub print_sidebyside_diff_lines {
> +	my ($ctx, $rem, $add) =3D @_;
> +
> +	# print context block before add/rem block
> +	if (@$ctx) {
> +		print join '',
> +			'<div class=3D"chunk_block ctx">',
> +				'<div class=3D"old">',
> +				@$ctx,
> +				'</div>',
> +				'<div class=3D"new">',
> +				@$ctx,
> +				'</div>',
> +			'</div>';
> +	}
> +
> +	if (!@$add) {
> +		# pure removal
> +		print join '',
> +			'<div class=3D"chunk_block rem">',
> +				'<div class=3D"old">',
> +				@$rem,
> +				'</div>',
> +			'</div>';
> +	} elsif (!@$rem) {
> +		# pure addition
> +		print join '',
> +			'<div class=3D"chunk_block add">',
> +				'<div class=3D"new">',
> +				@$add,
> +				'</div>',
> +			'</div>';
> +	} else {
> +		# assume that it is change
> +		print join '',
> +			'<div class=3D"chunk_block chg">',
> +				'<div class=3D"old">',
> +				@$rem,
> +				'</div>',
> +				'<div class=3D"new">',
> +				@$add,
> +				'</div>',
> +			'</div>';
> +	}
> +}
> +
>  sub print_sidebyside_diff_chunk {
>  	my @chunk =3D @_;
>  	my (@ctx, @rem, @add);
> @@ -5024,51 +5071,11 @@ sub print_sidebyside_diff_chunk {
>  			next;
>  		}
> =20
> -		## print from accumulator when type of class of lines change
> -		# empty contents block on start rem/add block, or end of chunk
> -		if (@ctx && (!$class || $class eq 'rem' || $class eq 'add')) {
> -			print join '',
> -				'<div class=3D"chunk_block ctx">',
> -					'<div class=3D"old">',
> -					@ctx,
> -					'</div>',
> -					'<div class=3D"new">',
> -					@ctx,
> -					'</div>',
> -				'</div>';
> -			@ctx =3D ();
> -		}
> -		# empty add/rem block on start context block, or end of chunk
> -		if ((@rem || @add) && (!$class || $class eq 'ctx')) {
> -			if (!@add) {
> -				# pure removal
> -				print join '',
> -					'<div class=3D"chunk_block rem">',
> -						'<div class=3D"old">',
> -						@rem,
> -						'</div>',
> -					'</div>';
> -			} elsif (!@rem) {
> -				# pure addition
> -				print join '',
> -					'<div class=3D"chunk_block add">',
> -						'<div class=3D"new">',
> -						@add,
> -						'</div>',
> -					'</div>';
> -			} else {
> -				# assume that it is change
> -				print join '',
> -					'<div class=3D"chunk_block chg">',
> -						'<div class=3D"old">',
> -						@rem,
> -						'</div>',
> -						'<div class=3D"new">',
> -						@add,
> -						'</div>',
> -					'</div>';
> -			}
> -			@rem =3D @add =3D ();
> +		## print from accumulator when have some add/rem lines or end
> +		# of chunk (flush context lines)
> +		if (((@rem || @add) && $class eq 'ctx') || !$class) {
> +			print_sidebyside_diff_lines(\@ctx, \@rem, \@add);
> +			@ctx =3D @rem =3D @add =3D ();
>  		}
> =20
>  		## adding lines to accumulator

--=20
Jakub Narebski
Poland
