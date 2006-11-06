X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/n] gitweb: Use '&iquot;' instead of '?' in esc_path
Date: Mon, 6 Nov 2006 22:58:08 +0100
Message-ID: <200611062258.08320.jnareb@gmail.com>
References: <200610301953.01875.jnareb@gmail.com> <7virhw5hoi.fsf@assigned-by-dhcp.cox.net> <200611032333.49794.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 6 Nov 2006 21:57:53 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NnWsbWnNN0CKvdur8wM+GNMSq6MjoxvWZBG26/0xohTwYWq4E5BcXOt19vbelHfLYzIOWBZqjRrksQ6V62LqNgvFRnrzb2p3zcGSrXkN6K7lyRkoffEoGIIMNENnObPqdSx7ZVAdvbudBd8xaRRTH2B8+a6w+QUvlrJEvPHEjjI=
User-Agent: KMail/1.9.3
In-Reply-To: <200611032333.49794.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31027>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhCTN-0001TH-JZ for gcvg-git@gmane.org; Mon, 06 Nov
 2006 22:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752936AbWKFV5i convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006 16:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753054AbWKFV5i
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 16:57:38 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:33848 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1752936AbWKFV5h
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 16:57:37 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1021356ugc for
 <git@vger.kernel.org>; Mon, 06 Nov 2006 13:57:35 -0800 (PST)
Received: by 10.67.30.6 with SMTP id h6mr8079004ugj.1162850255598; Mon, 06
 Nov 2006 13:57:35 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id x26sm5043666ugc.2006.11.06.13.57.34; Mon, 06 Nov
 2006 13:57:35 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:
> 3. Use Character Escape Codes (CEC), using alphabetic and octal
> =A0 =A0backslash sequences like those used in C. Probably need to esc=
ape
> =A0 =A0backslash (quoting character) too. Has the advantage of being =
widely
> =A0 =A0understood in POSIX world. Has the disadvantage of need for es=
cape
> =A0 =A0sequence table/hash. Has the advantage that it works for all
> =A0 =A0characters - simple octal backslash sequence if they have no s=
pecial
> =A0 =A0escape sequence.

Here is example code for this:

	sub esc_path {
		my $str =3D shift;

		sub quot {
			my $seq =3D shift;
			my %es =3D (
				"\t" =3D> '\t', # tab            (HT, TAB)
				"\n" =3D> '\n', # newline        (NL)
				"\r" =3D> '\r', # return         (CR)
				"\f" =3D> '\f', # form feed      (FF)
				"\b" =3D> '\b', # backspace      (BS)
				"\a" =3D> '\a', # alarm (bell)   (BEL)
				"\e" =3D> '\e', # escape        (ESC)
				"\013" =3D> '\v', # vertical tab (VT)
			);

			if (exists $es{seq}) {
				return $es{$seq};
			}
			return sprintf("\\%03o", ord($seq));
		}
	=09
		$str =3D esc_html($str);
		$str =3D~ s/([[:cntrl:]])/'<span class=3D"cntrl">' . quot($1) . '</sp=
an>'/eg;
		return $str;
	}

--=20
Jakub Narebski
