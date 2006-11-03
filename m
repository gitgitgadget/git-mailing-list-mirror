X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/n] gitweb: Use '&iquot;' instead of '?' in esc_path
Date: Fri, 3 Nov 2006 17:19:12 +0100
Message-ID: <200611031719.13073.jnareb@gmail.com>
References: <200610301953.01875.jnareb@gmail.com> <7vzmbds4pw.fsf@assigned-by-dhcp.cox.net> <7vvem1s29g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 3 Nov 2006 16:19:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=icYYX2bfdqgRII80RTO1eoXPsUw+OFhEOkvSkR7tCOXHOvhDy9mOnv42BbR3QiNsUBeVfiK3IJ/vBROHEBOIZcuWm2xgx1+uuBQwGBhGBM9DAz8u2n7L9l9ECyz7lc8D2HTDHlAZIRfHxVED3RAFgxfZT2sMls1GkmJ9x7CNnm8=
User-Agent: KMail/1.9.3
In-Reply-To: <7vvem1s29g.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30862>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg1l0-0006Kk-9X for gcvg-git@gmane.org; Fri, 03 Nov
 2006 17:19:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753329AbWKCQSz convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006 11:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753331AbWKCQSz
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 11:18:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:32336 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1753329AbWKCQSy
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 11:18:54 -0500
Received: by ug-out-1314.google.com with SMTP id m3so450487ugc for
 <git@vger.kernel.org>; Fri, 03 Nov 2006 08:18:53 -0800 (PST)
Received: by 10.67.97.18 with SMTP id z18mr2949035ugl.1162570732403; Fri, 03
 Nov 2006 08:18:52 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id 29sm1024239uga.2006.11.03.08.18.51; Fri, 03 Nov
 2006 08:18:52 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

 Junio C Hamano wrote:
>
> Junio C Hamano <junkio@cox.net> writes:
>=20
>> Jakub Narebski <jnareb@gmail.com> writes:
>>
>>> Use "&iquot;" Latin 1 entity ("&#191;" -- inverted question mark =3D
>>> turned question mark, U+00BF ISOnum) instead '?' as replacements fo=
r
>>> control characters and other undisplayable characters.
>>>
>>> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
>>
>> Do you have something against our Spanish and Latin American
>> friends?  ;-)
>>
>> I wonder if there is a more suitable replacement character that
>> is accepted across scripts?
>=20
> I have a suspicion that instead of finding an exotic character,
> just showing the byte value in \octal, perhaps in different
> color, might be more portable and easier.  For one thing, it
> helps to show the exact byte value than just one substitution
> character if you are troubleshooting gitweb.
=20
Or perhaps we can use Unicode Control Pictures U+2400 =E2=80=93 U+243F=20
(9216=E2=80=939279) ("Unicode quoting"):

http://www.alanwood.net/unicode/control_pictures.html
http://www.unicode.org/charts/PDF/U2400.pdf

# quote unsafe characters and escape filename to HTML
sub esc_path {
	my $str =3D shift;
	$str =3D esc_html($str);
	$str =3D~ s!([[:cntrl:]])!sprintf('<span class=3D"cntrl">&#%04d;</span=
>', 9216+ord($1))!eg;
	return $str;
}

with perhaps the following CSS

span.cntrl {
	border: dashed #aaaaaa;
	border-width: 1px;
	padding: 0px 2px 0px 2px;
	margin:  0px 2px 0px 2px;
}

What do you think of it?
--=20
Jakub Narebski
