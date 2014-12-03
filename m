From: Luis Henriques <henrix@camandro.org>
Subject: Re: [RFC][PATCH] send-email: add --[no-]xmailer option
Date: Wed, 3 Dec 2014 10:13:45 +0000
Message-ID: <20141203101344.GA2809@charon.olymp>
References: <20140324213814.GA1267@achilles.my.domain>
 <20141202193243.GA2999@charon.olymp>
 <20141203023419.GA10519@dcvr.yhbt.net>
 <CE4526D6-F223-4FD8-A66E-F39D85E843B2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 11:14:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xw6wa-0005IG-5W
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 11:14:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbaLCKNz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Dec 2014 05:13:55 -0500
Received: from balrog.mythic-beasts.com ([93.93.130.6]:50032 "EHLO
	balrog.mythic-beasts.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbaLCKNx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 05:13:53 -0500
Received: from [2.81.129.121] (port=49254 helo=localhost)
	by balrog.mythic-beasts.com with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <henrix@camandro.org>)
	id 1Xw6wO-0005l2-G9; Wed, 03 Dec 2014 10:13:49 +0000
Content-Disposition: inline
In-Reply-To: <CE4526D6-F223-4FD8-A66E-F39D85E843B2@gmail.com>
X-BlackCat-Spam-Score: -28
X-Mythic-Debug: Threshold =  On = 
X-Spam-Status: No, score=-2.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260642>

On Tue, Dec 02, 2014 at 07:22:10PM -0800, Kyle J. McKay wrote:
> On Dec 2, 2014, at 18:34, Eric Wong wrote:
>=20
> >Luis Henriques <henrix@camandro.org> wrote:
> >>On Mon, Mar 24, 2014 at 09:38:27PM +0000, Luis Henriques wrote:
> >>>Add --[no-]xmailer that allows a user to disable adding the 'X-Mai=
ler:'
> >>>header to the email being sent.
> >>>
> >>
> >>Ping
> >>
> >>It's been a while since I sent this patch.  Is there any interest i=
n
> >>having this switch in git-send-email?
> >
> >I wasn't paying attention when the original was sent, but this
> >looks good to me.
> >
> >Acked-by: Eric Wong <normalperson@yhbt.net>
> >
> >>I honestly don't like disclosing too much information about my syst=
em,
> >>in this case which MUA I'm using and its version.
> >
> >Right on.  I would even favor this being the default.
>=20
> I fully agree with you.
>=20
> >Auto-generated Message-Id headers also shows the use of git-send-ema=
il;
> >perhaps there can be a way to configure that, too.  However,
> >git-send-email respects manually-added Message-Id headers in the
> >original patch, so it's less of a problem, I suppose.
>=20
> It can be hashed like so to avoid leaking information:

Awesome, I like this idea too!

Cheers,
--=20
Lu=EDs

>=20
> diff --git a/git-send-email.orig b/git-send-email.new
> index f3d75e8..d0b4bff 100755
> --- a/git-send-email.orig
> +++ b/git-send-email.new
> @@ -27,6 +27,7 @@ use Data::Dumper;
>  use Term::ANSIColor;
>  use File::Temp qw/ tempdir tempfile /;
>  use File::Spec::Functions qw(catfile);
> +use Digest::MD5 qw(md5_hex);
>  use Error qw(:try);
>  use Git;
>=20
> @@ -901,8 +903,10 @@ sub make_message_id {
>  		require Sys::Hostname;
>  		$du_part =3D 'user@' . Sys::Hostname::hostname();
>  	}
> -	my $message_id_template =3D "<%s-git-send-email-%s>";
> +	my $message_id_template =3D "%s-git-send-email-%s";
>  	$message_id =3D sprintf($message_id_template, $uniq, $du_part);
> +	@_ =3D split /@/, $message_id;
> +	$message_id =3D '<'.substr(md5_hex($_[0]),0,31).'@'.substr(md5_hex(=
$_[1]),1,31).'>';
>  	#print "new message id =3D $message_id\n"; # Was useful for debuggi=
ng
>  }
>=20
> ---
>=20
> --Kyle
