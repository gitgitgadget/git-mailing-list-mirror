From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] doc: technical details about the index file format
Date: Thu, 2 Sep 2010 10:56:10 +0200
Message-ID: <AANLkTi=wESk38u1XSTL1rd2__eQzHfSuq-EbqooxmcVw@mail.gmail.com>
References: <201009012054.20482.robin.rosenberg@dewire.com>
	<1283351989-19426-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	robin.rosenberg@dewire.com, srabbelier@gmail.com
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 10:56:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Or5au-0003uA-Ka
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 10:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460Ab0IBI4P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 04:56:15 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51225 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab0IBI4L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 04:56:11 -0400
Received: by iwn5 with SMTP id 5so321503iwn.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 01:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ly8FJvqaEMwM5WJdkZg/WMkZ8tO5PB0G/dxdfe+zLNA=;
        b=KNdHvyhSbDbWXZQbU5B6SdhfnFmvrp1kgFLablhn2to9pDO9635kWbOb2RQEJWKmoB
         M3zif83sKUhK16J6pOBOh4UJDtXWKl18l3zcZ7t/4vV+w30Nwk1FxSE/Kb/sf54dsf44
         vzlsKLCZ9bKYs04p6Yj20m3zcckWMYgx1vwpc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=R3BrpWtlsGwDljEjtpjbsJpDBcbEFyVK2/PLcewWkooeMlGpG0mLcMQNuDaOTklCS5
         bgZR3kgBQpsytzq3Puq4wtZkZPU+R/LFULkEMFbT4Rl3FJJErhM67S5ZjGAdTfBXRodj
         A3jmRrrUqRGhqzT7EOh+2DSO1kjqXFZH8fd4E=
Received: by 10.231.14.140 with SMTP id g12mr9321431iba.84.1283417770713; Thu,
 02 Sep 2010 01:56:10 -0700 (PDT)
Received: by 10.231.15.138 with HTTP; Thu, 2 Sep 2010 01:56:10 -0700 (PDT)
In-Reply-To: <1283351989-19426-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155113>

2010/9/1 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>:
> +=3D=3D Index entry
> +
> + =C2=A0Index entries are sorted in ascending order on the name field=
,
> + =C2=A0interpreted as a string of unsigned bytes. Entries with the s=
ame
> + =C2=A0name are sorted by their stage field.
> +
> + =C2=A032-bit ctime seconds, the last time a file's metadata changed
> + =C2=A0 =C2=A0this is stat(2) data
> +
> + =C2=A032-bit ctime nanoseconds (modulo 1G)
> + =C2=A0 =C2=A0this is stat(2) data

Maybe I'm missing something, but I failed to find where "modulo 1G" com=
es from.
AFAICS (read-cache.c), the stat data are saved almost unmodified
(casted to unsigned int).
(BTW, is 1G the Gravitational Constant or what?)

I'm not sure it is safe to assume that  every system Git will be
ported to defines
"unsigned int" to be 32 bits. OTOH, never met one where it is something=
 else.
Still, using uint32_t (the POSIX types) in ondisk_cache_entry would be =
clearer
(unlikely alignment issues aside.
