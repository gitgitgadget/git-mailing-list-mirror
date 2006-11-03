X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC 1/n] gitweb: Better git-unquoting and gitweb-quoting of pathnames
Date: Fri, 3 Nov 2006 13:09:06 +0100
Message-ID: <200611031309.07180.jnareb@gmail.com>
References: <200610301953.01875.jnareb@gmail.com> <200611031159.02065.jnareb@gmail.com> <7vodro91ye.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 3 Nov 2006 12:09:07 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ihi8hHZMLB0QUE/RKBaPS5CZOSJduT2TEVPF28MAuCI9CoUKX4MBcvuRVyr8gOCkzq9v19wp9yZekMu8ZgJsg/5LYJcrY8rTCz4dTrFW4ZjmSMPPJKyqdbCJGo2pth0Ok0DmomMJHeX/gZSGutjNgSttW+tCG0GY9nVjpK4bm8c=
User-Agent: KMail/1.9.3
In-Reply-To: <7vodro91ye.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30836>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfxqq-00005s-3T for gcvg-git@gmane.org; Fri, 03 Nov
 2006 13:08:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750956AbWKCMIp convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006 07:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWKCMIp
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 07:08:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:16994 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1750956AbWKCMIo
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 07:08:44 -0500
Received: by ug-out-1314.google.com with SMTP id m3so386939ugc for
 <git@vger.kernel.org>; Fri, 03 Nov 2006 04:08:43 -0800 (PST)
Received: by 10.67.117.18 with SMTP id u18mr2542298ugm.1162555722692; Fri, 03
 Nov 2006 04:08:42 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id 28sm759899ugc.2006.11.03.04.08.42; Fri, 03 Nov
 2006 04:08:42 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Dnia pi=B1tek 3. listopada 2006 12:58, Junio C Hamano napisa=B3:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
>> Perhaps it should be "LF ('\n') and TAB ('\t')".
>=20
> Official terminology seems to call \t "HT", but my feeling is
> that we would not need that comment there.

O.K. I'll remove that comment.

>> Or
>> 	return $es{$seq} if exists $es{$seq};
>=20
> Although gitweb is full of that syntax, I personally do not like
> it very much.  It is really hard to read when you are trying to
> skim through the code quickly.  You would have to say "why
> return it?  ah -- only when it exists, then it makes sense",
> which is a hiccup that disrupts the thought process.

O.K., I'll change style from

	return chr(oct($seq))  if ($seq =3D~ m/^[0-7]{1,3}$/);
	return $es{$seq}       if exists $es{$seq};
	return $seq;

to the more readable form

	if ($seq =3D~ m/^[0-7]{1,3}$/) {
		return chr(oct($seq));
	} elsif (exists $es{$seq}) {
		return $es{$seq};
	}
	return $seq;

I think it is better to leave final "return $seq;" outside else block.
--=20
Jakub Narebski
