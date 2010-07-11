From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Question about 'branch -d' safety
Date: Sun, 11 Jul 2010 21:05:39 +0200
Message-ID: <201007112105.40951.jnareb@gmail.com>
References: <20091230065442.6117@nanako3.lavabit.com> <20100711133730.GA10338@localhost> <7v1vb9hnd9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clemens Buchacher <drizzd@aon.at>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 11 21:05:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OY1qc-0001ez-Go
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 21:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754747Ab0GKTFt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Jul 2010 15:05:49 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38953 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754604Ab0GKTFs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 15:05:48 -0400
Received: by fxm14 with SMTP id 14so1950891fxm.19
        for <git@vger.kernel.org>; Sun, 11 Jul 2010 12:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=St5d8y9vWbjF5UiFd65wpONoil0r+mM9vs170MWuzwU=;
        b=lwPa5RuIlbGZEmW6BxtZDYI0LS5H1HkX/rbWHkoms+03wm70Wyduwuc7TWY2fMdI/L
         +wHEDEBCGyd/lAVk710b8zcYWR6rZ+0ubEH2gai3+zz+6fIOAlJian2P4JSuGj8QPeeB
         ARMe2J/qx8Qn/xFIKXfiowf20pNOYno+/6OCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=P24KxeM0eacmQjQq7n9UGJOe3/ISdM/M0hbICnZw2xjTgoSFfZDlBq5gISO2R6Od/a
         93aHJYbhRydu6NABEjXbJV+9jao09nPsETM+Qo74brcaddG5z8uiVvLgJwpmTj9vB8ct
         XSUIvXUtFyo32Z8HUau9jwzjiovE3oncJTy6I=
Received: by 10.223.121.193 with SMTP id i1mr465430far.85.1278875146651;
        Sun, 11 Jul 2010 12:05:46 -0700 (PDT)
Received: from [192.168.1.13] (abwj181.neoplus.adsl.tpnet.pl [83.8.233.181])
        by mx.google.com with ESMTPS id s17sm7335178faa.45.2010.07.11.12.05.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Jul 2010 12:05:45 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v1vb9hnd9.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150783>

Dnia niedziela 11. lipca 2010 20:41, Junio C Hamano napisa=B3:
> Clemens Buchacher <drizzd@aon.at> writes:
>=20
> > Known issues:
> >
> >  - The reflog cannot be accessed while the ref does not exist.
> >
> >  - Older git versions will not resurrect the reflog, and therefore
> >    leave the renamed reflog behind.
> >
> >  - Breaks t7701, because git-expire tries to lock log entries,
> >    which fails because ~ is an illegal character for refs.
> >
> >  - Breaks t9300.
>=20
> Perhaps a few obvious ones are missing?
>=20
>  - It is no longer possible to get rid of objects associated with the
>    history of a branch by deleting the branch and then running gc.

I think that reflog for deleted branches would still follow gc.reflogEx=
pire
and gr.reflogExpireUnreachable, and that it would be automatically dele=
ted
when it becomes empty.  I don't know if provided implementation assures
this.

>  - It is no longer possible to trust git that you would start a histo=
ry of
>    a branch afresh when you create one.  If you happened to have an
>    unrelated branch with the same name in the past, the new branch
>    inherits reflog entries when it shouldn't.

That's a valid concern.

>=20
> What problem are you guys really trying to solve?

The problem is that if you delete branch by accident, it might be hard
to restore it, and its reflog vanishes forever.  And with relaxed
protection of 'git branch -d' this might happen more frequently (in the
case of circular origin's).

--=20
Jakub Narebski
Poland
