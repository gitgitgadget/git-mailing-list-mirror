From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/32] cache-tree: ignore CE_REMOVE entries in
 verify_cache()
Date: Tue, 24 Aug 2010 19:48:21 -0500
Message-ID: <20100825004821.GA10423@burratino>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
 <1282688422-7738-4-git-send-email-pclouds@gmail.com>
 <20100824231536.GE2376@burratino>
 <AANLkTi=P-PoBWwDbfGs7v1BTwvJ7uwfe7hd7A+Y7M361@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 02:50:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo4Bz-0000fO-2W
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 02:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754634Ab0HYAuJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 20:50:09 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38796 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283Ab0HYAuG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Aug 2010 20:50:06 -0400
Received: by qwh6 with SMTP id 6so9536qwh.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 17:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=+ukSjGA3S2PHYOO/raj1439F/4ZCKALyKuQIanUJSPw=;
        b=q2/hm+cYf3CN6b6mCyM+NqlB+Av9TiypLFgx0L/5UDUa7SmaTWAq9QSeDGsOhoEmzX
         kzPtwErqjw1AuhhRQZ9F5Kg1U+4V+Lp/2f5GIngTgbRkhBfw29HFfB0nYR1RAA9hBQpF
         B/dw00HOLWg0tzL/x5o/SFTIB9fj2fX8RIFck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=qFapP/aaOlYmlN5qXKLtR1rGX8MBgJihu7u7o1ChLxj1hkYmQC1XKgVPXaFLacDW/+
         GURjon+u/aXe6fQrOzd1pPKZ65XMBPuxixIVPmEdccs5Cm3b2fyF6Oa4HGX3Nc8l2h00
         SkfPhYRdm4nvVzDPYwDWpRqU6m/gGAgpLenuc=
Received: by 10.224.43.163 with SMTP id w35mr5046975qae.92.1282697405883;
        Tue, 24 Aug 2010 17:50:05 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id f15sm839944qcr.13.2010.08.24.17.50.04
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 17:50:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=P-PoBWwDbfGs7v1BTwvJ7uwfe7hd7A+Y7M361@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154389>

Nguyen Thai Ngoc Duy wrote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

>>> --- a/cache-tree.c
>>> +++ b/cache-tree.c
>>> @@ -156,6 +156,8 @@ static int verify_cache(struct cache_entry **ca=
che,
>>> =C2=A0 =C2=A0 =C2=A0 funny =3D 0;
>>> =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < entries; i++) {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cache_entry=
 *ce =3D cache[i];
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ce->ce_flags & CE_R=
EMOVE)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 continue;
[...]
> I was lazy. In patch 26, upload-narrow-merge do three way merge and
> drop staged entries within narrow tree (this is at server side,
> conflicts within narrow tree will be handled at client side later).
> Instead of removing staged entries, I mark them CE_REMOVE.

Ah, ok; so it's to avoid spending time in remove_marked_cache_entries()=
=2E

I think (though it wouldn't come up in your application) that to keep
this and avoid caller confusion one would need something like

		if ((cache[i]->ce_flags & CE_REMOVE) ||
		    (cache[i+1]->ce_flags & CE_REMOVE))
			continue;

in the other loop.  I say "something like" because a person could have
marked some some but not all stages with CE_REMOVE, causing
file/directory conflicts to be missed.

Thanks for the explanation.
