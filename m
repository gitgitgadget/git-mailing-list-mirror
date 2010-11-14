From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 003/160] gettext: fix bug in git-sh-i18n's eval_gettext()
 by using envsubst(1)
Date: Sun, 14 Nov 2010 15:27:57 -0600
Message-ID: <20101114212757.GD10150@burratino>
References: <1289747245-23263-1-git-send-email-avarab@gmail.com>
 <1289747245-23263-3-git-send-email-avarab@gmail.com>
 <20101114181605.GI26459@burratino>
 <7vmxpb1ztf.fsf@alter.siamese.dyndns.org>
 <AANLkTinh_Nkxvw7Z5HU=TbJHHFRZeWgr0COJ+N96OeTd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 22:28:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHk7q-00084G-QB
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 22:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756945Ab0KNV2e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 16:28:34 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42785 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755284Ab0KNV2d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 16:28:33 -0500
Received: by gxk23 with SMTP id 23so2655035gxk.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 13:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=tBx6f2zAcOFJLG4sR+iftSZqx4it3nLdVjI4pig3Vlw=;
        b=dJMa6gzKi+0PKJiXsvkhqe/9lDFvXaajA1LXGjx2plVIJj7/xzG1hbOMEol+j91v6v
         3mYJY+HGa3v3riL0FnpFHdMgj7nRigVqRR4EGFNENbV+oInunB3R5KnYE6HNtsaqhDpk
         mTdD07epj0JBuRS74oafhql2lDyjfHN768kuw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=v2FEHlL8qr+bsUCRVob2T8ojqUulmnkZy8dP1XpNjh1NvPfyREQ7RhQ0J8vgnQEpV6
         GCANiZASOn3ypJaNy4EorBxxoikzPyjawoBoljBvykezXMySvSc84OZu+bO84mVDf/Bn
         oaXBFWRLzZp0ROo89ZfxhJK1NyO/sVxFJgOzo=
Received: by 10.150.196.19 with SMTP id t19mr8227157ybf.299.1289770112013;
        Sun, 14 Nov 2010 13:28:32 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id q18sm2412203ybk.15.2010.11.14.13.28.29
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 13:28:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTinh_Nkxvw7Z5HU=TbJHHFRZeWgr0COJ+N96OeTd@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161445>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Thanks for the suggestion. I'll put it in envsubst/ then.
>=20
> Any idea about the issue of it being linked to too many things?

Maybe http://thread.gmane.org/gmane.comp.version-control.git/160842
is related?

> tried to add another entry to this section:
>=20
>     git-%$X: %.o $(GITLIBS)
>         $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filte=
r
> %.o,$^) $(LIBS)
>=20
>     git-imap-send$X: imap-send.o $(GITLIBS)
>         $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filte=
r %.o,$^) \
>             $(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL)
>=20
> But it wasn't actually used. But then again I don't know Makefile
> hacking that much.

If you send output from "make envsubst" from your attempt with V=3D1,
I can try to debug it.
