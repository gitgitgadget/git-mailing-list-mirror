From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] config: Add --null/-z option for null-delimted output
Date: Tue, 19 Jun 2007 03:16:32 +0200
Message-ID: <200706190316.33340.jnareb@gmail.com>
References: <f2t6na$5bi$1@sea.gmane.org> <11821227322913-git-send-email-frank@lichtenheld.de> <Pine.LNX.4.64.0706190151160.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Frank Lichtenheld <frank@lichtenheld.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 19 03:11:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0SFm-000264-Cv
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 03:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755898AbXFSBKy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 18 Jun 2007 21:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755853AbXFSBKx
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 21:10:53 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:22179 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755390AbXFSBKw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 21:10:52 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1110ugf
        for <git@vger.kernel.org>; Mon, 18 Jun 2007 18:10:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EgyOshyRKW2n3tmYLsLgC+CuctjaswOsu/XbvgPCbazPcmx7MTTa9LWxrQDsQ3DmlKh/obpKYwBt1iC4kvtQ46y9/RI2Zw1KGHhjhS3BnchxdEoaRQxcNNCub1xSbDCO9x94w1lz2S5zyizEawrTdu+C5s9NkUEZPEC2ArNRsgE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MBPfeefscY0H1Iq9K8WQVWkckALvsMQkAa0d7+E1U2Jes+glkkrkduQYYjzYrCx2hilxIqRREMOIOzGu7fYqRwdCEpaIrvarprfA3uvQT1LjuajGzZTcd200jp6wc6cGUJunKOWQ09EHmwLjkbZZxbsI1VbQJVep968PIxsZtZ0=
Received: by 10.82.178.11 with SMTP id a11mr12458123buf.1182215451525;
        Mon, 18 Jun 2007 18:10:51 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id d26sm1055559nfh.2007.06.18.18.10.49
        (version=SSLv3 cipher=OTHER);
        Mon, 18 Jun 2007 18:10:50 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0706190151160.4059@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50435>

Johannes Schindelin wrote:

> As for the FIXME: [...]

Please read original message carefully:

>> =A0Note the FIXME. Does anyone remember the reason why --get-regexp
>> =A0and --list use different output format?

I think the FIXME is for --get-regexp. And was added by the patch.

> If you have a config like this:=20
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0[core]
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0Some =3D where
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0over
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0the =3D core.rainbow
>=20
> git-config -z would output something like this:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0core.some\0where\0core.over\0core.the\0core.r=
ainbow\0
>=20
> Right?

=46alse. Delim is different from term. You would get

	core.some\nwhere\0core.over\0core.the\ncore.rainbow\0

> As you can see, it is quite hard for a parser to find out what is
> key, and what is value.

	local $/ =3D "\0";

	while (my $line =3D <$fd>) {
		chomp $line;
		my ($key, $value) =3D split(/\n/, $line, 2);

		push @{$config{$key}}, $value if defined $key;
	}

--=20
Jakub Narebski
Poland
