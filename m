From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: cvsimport still not working with cvsnt
Date: Fri, 29 Apr 2011 17:27:29 -0500
Message-ID: <20110429222729.GB5916@elie>
References: <7vy65bkw72.fsf@alter.siamese.dyndns.org>
 <4D61EA4B.3020708@burntmail.com>
 <7vtyfxgdz2.fsf@alter.siamese.dyndns.org>
 <7vipwbbrcc.fsf@alter.siamese.dyndns.org>
 <AANLkTinUtUNGO3NK=JPTqnwcTtPMYjmLw82wJZ5nC-32@mail.gmail.com>
 <4D644FEE.5030004@burntmail.com>
 <7vaahnbmu2.fsf@alter.siamese.dyndns.org>
 <4D69DF29.8030701@burntmail.com>
 <7vvd056fyk.fsf@alter.siamese.dyndns.org>
 <4DBA3E14.7090602@burntmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin@laptop.org>,
	Emil Medve <Emilian.Medve@freescale.com>,
	git <git@vger.kernel.org>, Pascal Obry <pascal@obry.net>,
	Clemens Buchacher <drizzd@aon.at>
To: Guy Rouillier <guyr@burntmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 30 00:27:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFwA3-00055w-GT
	for gcvg-git-2@lo.gmane.org; Sat, 30 Apr 2011 00:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220Ab1D2W1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 18:27:38 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39685 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932134Ab1D2W1h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 18:27:37 -0400
Received: by iyb14 with SMTP id 14so3400424iyb.19
        for <git@vger.kernel.org>; Fri, 29 Apr 2011 15:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=fufJw0maymnMKNXLNT60qPqvLvIWbt+yEW6nWlTYb8g=;
        b=smXu28n2zML1ujouS1eVpZZ3YicQXcUGxhIjaOomBU9FoAsAUuDsHT/r1VvuSVlPFt
         VkJ2roPgZxfE3MXvCbMD4Sy+Tvyw3O88Sby+YIHPHgmyjI6NMYyZhBRi7KUAnpiT3Q1L
         mUids4z4np0kkNqSaa7Q/f5urUGBQAhzQITs4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XHhWKTJXAbIleJwDTtlpUEnBoLeIJPOEqussIUVGXzYYLsABAMkXa1OL4I/GbQfzPn
         siUwFHNNWIKZjpZlK5nurOcqDbANhec53uuoH+YFM7mzy/2ZvC8asGKWNrrAnDEXZRuO
         mH0DQbrciNuZMX1PRTNhyZCcnhbc8vrC90AcQ=
Received: by 10.42.139.136 with SMTP id g8mr1507116icu.141.1304116056357;
        Fri, 29 Apr 2011 15:27:36 -0700 (PDT)
Received: from elie ([69.209.62.211])
        by mx.google.com with ESMTPS id xe5sm1156171icb.22.2011.04.29.15.27.32
        (version=SSLv3 cipher=OTHER);
        Fri, 29 Apr 2011 15:27:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DBA3E14.7090602@burntmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172499>

Guy Rouillier wrote:

> Note that I've left this test in, although I still think it is a bad idea:
>
>    elsif (!$pass) {
>       $pass = "A";
>    }
[...]
> But that doesn't explain why it was put in there in the first
> place.  I still say a better idea, if we don't want to allow an empty
> password, is to error out rather than silently set a bogus password.

It might be a good idea after all to do something else in that case
(as a separate patch :)), but it would require a little investigation.
Isn't the convention in CVS for anonymous pserver access to accept an
arbitrary password?

> The CVS password file separates tokens with a space character, while
> the CVSNT password file separates tokens with an equal (=) character.
> Add a sub find_password_entry that accepts the password file name
> and a delimiter to eliminate code duplication.
> ---

Sounds sensible to my untrained ears.  Sign-off?

[...]
> +++ b/git-cvsimport.perl
> @@ -227,6 +227,30 @@ sub new {
>  	return $self;
>  }
> 
> +sub find_password_entry {
> +	my ($cvspass, @cvsroot) = @_;
> +	my ($file, $delim) = @$cvspass;
> +	my $pass;
> +	local ($_);
> +
> +	if (open(my $fh, $file)) {
> +		# :pserver:cvs@mea.tmt.tele.fi:/cvsroot/zmailer Ah<Z
> +		while (<$fh>) {
> +			chomp;
> +			s/^\/\d+\s+//;
> +			my ($w, $p) = split($delim,$_,2);
> +			for my $cvsroot (@cvsroot) {
> +				if ($w eq $cvsroot) {
> +					$pass = $p;
> +					last;

In the old code, this "last" applied to the while loop, while in the
new code it applies to the for loop.  Intentional?

[...]
> +			if (1 < @loc) {
> +				die("More than one cvs password files have ".
> +				    "entries for CVSROOT $opt_d: @loc");

Grammar nit: "More than one" is singular (weird, eh?).  It might
be clearer to say:

	"Multiple cvs password files have " .
	"entries for CVSROOT $opt_d: @loc"

(or "Both cvs password files").

Thanks again, and hope that helps.

Regards,
Jonathan
