From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Fix UTF Encoding issue
Date: Mon, 3 Dec 2007 18:02:54 +0100
Message-ID: <200712031802.55514.jnareb@gmail.com>
References: <4753D419.80503@clearchain.com> <m3prxougmx.fsf@roke.D-201> <20071203163856.GA24269@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ismail =?iso-8859-1?q?D=F6nmez?= <ismail@pardus.org.tr>,
	Junio C Hamano <gitster@pobox.com>,
	Alexandre Julliard <julliard@winehq.org>,
	Benjamin Close <Benjamin.Close@clearchain.com>,
	git@vger.kernel.org,
	Perl Unicode Mailing List <perl-unicode@perl.org>,
	Dan Kogai <dankogai@dan.co.jp>
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon Dec 03 18:03:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzEha-0002B1-SQ
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 18:03:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbXLCRDE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Dec 2007 12:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbXLCRDE
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 12:03:04 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:22667 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbXLCRDC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 12:03:02 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2740310nfb
        for <git@vger.kernel.org>; Mon, 03 Dec 2007 09:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=wlYQK/x/Bg5CEed9098mcS1j391IzZhFV/k0jJA0Xdw=;
        b=qvk8ozaFOyHlnsSSqqH3o4dyzAv/5pW8clotnLVWNKoP1Qej+ciMSL5xRrpHuzJibMl5kqYVklzNmiEy5TiDDvNu45JcORQfXaPdUnw+RnXTZY2+3utD+cR+GCYbqxDFK4717KZibnxZ37ReQbpNw8JTRwKirdfZUO4ssN7IJCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sjeDJBPLAlRGKPsuLmRxdUnzViKKn+s8PFgt30chFjM91PqiUZ2Jcqan+tDWmcaCqhjGsv0aKt9mg32K3hUM9Tm/f8YPTonbJ5/RkQ8MX0NH2LjwZ5QfnEvGDL9v0vJ2rpIJ0seeVWlu74yT+YzQE5LNBQHnNyw7R6KCMDtahQQ=
Received: by 10.86.26.11 with SMTP id 11mr10773571fgz.1196701380273;
        Mon, 03 Dec 2007 09:03:00 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.225.86])
        by mx.google.com with ESMTPS id l12sm6092858fgb.2007.12.03.09.02.56
        (version=SSLv3 cipher=OTHER);
        Mon, 03 Dec 2007 09:02:58 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20071203163856.GA24269@auto.tuwien.ac.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66924>

On Mon, 3 Dec 2007, Martin Koegler wrote:
> On Mon, Dec 03, 2007 at 04:06:48AM -0800, Jakub Narebski wrote:
>> Ismail D=F6nmez <ismail@pardus.org.tr> writes:
>>> Monday 03 December 2007 Tarihinde 12:14:43 yazm??t?:
>>>> Benjamin Close <Benjamin.Close@clearchain.com> writes:
>>>>> -	eval { $res =3D decode_utf8($str, Encode::FB_CROAK); };
>>>>> -	if (defined $res) {
>>>>> -		return $res;
>>>>> -	} else {
>>>>> -		return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
>>>>> -	}
>>>>> +	eval { return ($res =3D decode_utf8($str, Encode::FB_CROAK)); }=
;
>>>>> +	return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
>>>>>  }
>=20
> This version is broken on Debian sarge and etch. Feeding a UTF-8 and =
a latin1
> encoding of the same character sequence yields to different results.

[...]

> eval { $res =3D decode_utf8(...); }
> if ($@)=20
>      return decode(...);
> return $res
>=20
> or
>=20
> eval { $res =3D decode_utf8(...); }
> if (defined $res)
>       return $res;
> else
>     return decode(...);
>=20
> show the same (wrong) behaviour on Debian sarge. They do not always
> decode non UTF-8 characters correctly, eg.
> #=F6=E4=FC does not work
> #=E4=F6=FC=E4 does work
>=20
> On Debian etch, both versions are working.

I don't know enough Perl to decide if it is a bug in gitweb usage
of decode_utf8, if it is a bug in your version of Encode, or if it
is bug in Encode.

Send copy of this mail to maintainers of Encode perl module.
--=20
Jakub Narebski
Poland
