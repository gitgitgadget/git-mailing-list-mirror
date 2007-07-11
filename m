From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] send-email: extend sanitize_address_rfc822 to do rfc2047
 quoting
Date: Wed, 11 Jul 2007 10:42:32 +0200
Message-ID: <20070711084232.GE1528MdfPADPa@greensroom.kotnet.org>
References: <11840869641759-git-send-email-ukleinek@informatik.uni-freiburg.de>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Wed Jul 11 10:42:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8XmY-0005Xl-BJ
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 10:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754961AbXGKImf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 11 Jul 2007 04:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755657AbXGKImf
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 04:42:35 -0400
Received: from smtp19.wxs.nl ([195.121.247.10]:57384 "EHLO smtp19.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754961AbXGKIme (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 04:42:34 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp19.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JL000698AUW2Y@smtp19.wxs.nl> for git@vger.kernel.org; Wed,
 11 Jul 2007 10:42:32 +0200 (CEST)
Received: (qmail 32114 invoked by uid 500); Wed, 11 Jul 2007 08:42:32 +0000
In-reply-to: <11840869641759-git-send-email-ukleinek@informatik.uni-freiburg.de>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52144>

On Tue, Jul 10, 2007 at 07:02:43PM +0200, Uwe Kleine-K=F6nig wrote:
>  	my ($recipient) =3D @_;
> -	my ($recipient_name) =3D ($recipient =3D~ /^(.*?)\s+</);
> +	my ($recipient_name, $recipient_addr) =3D ($recipient =3D~ /^(.*?)(=
\s+<.*)/);
> +
> +	if ($recipient_name && $recipient_name =3D~ /[^-a-zA-Z0-9!*+\/ ]/ &=
& $recipient_name !~ /=3D\?utf-8\?q?.*\?=3D/) {

Why the extra test for truthness of $recipient_name ?

>  	if ($recipient_name && $recipient_name =3D~ /\./ && $recipient_name=
 !~ /^".*"$/) {
> -		my ($name, $addr) =3D ($recipient =3D~ /^(.*?)(\s+<.*)/);
> -		$recipient =3D "\"$name\"$addr";
> +		$recipient_name =3D "\"$recipient_name\"";
> +	}
> +
> +	if ($recipient_name) {
> +		return "$recipient_name$recipient_addr";
> +	} else {
> +		return "$recipient";
>  	}
> -	return $recipient;

Why did you introduce interpolation just to get $recipient again?
Then again, why do you need a test at all here?

	return $recipient_name . $recipient_addr;

should work, no?

skimo
