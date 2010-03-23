From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Tue, 23 Mar 2010 14:49:40 +0100
Message-ID: <201003231449.42190.jnareb@gmail.com>
References: <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com> <201003231222.40745.jnareb@gmail.com> <41f08ee11003230523h2c5f93b1l7e94d6c85a93a706@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, gitzilla@gmail.com,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 14:50:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu4UZ-0007Qm-4q
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 14:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460Ab0CWNtx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 09:49:53 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:45969 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418Ab0CWNtw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 09:49:52 -0400
Received: by fxm5 with SMTP id 5so2960643fxm.29
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 06:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=FPAkfYULA9AxlsQBL3c2s6KseUb+r/MMVJwXC9rSjwY=;
        b=u+y5AyBbrYSeWBWmlbvfPoIO0toNqIKoIKoGjgDWSndVnrQpDeZltyTcIlKjVfHuVq
         ADXgN7pDP2wGwamDiAnhgixX7nbA3eYwNZD3akfAKQ8ILuJHicBk3/DUBOsZ/y2fbpjN
         gmDN9BoRNM221csbZ7EQaTQOY77PAv5puy0T4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=bJqFsebh5/cHvGt6wOL7Ptkfdsy42v8dV9UQV9fv/YF5w6xsUO5bJcwOqHrV0Db5/E
         GRXDmZtkNmiK+wdGBTdhw4HxAvWYKGnATIm257OPqqL90yhC6/Cx/l0KHqcxupbun3rV
         Qs/UCNbWPQSTFKvRR8if+/adldy0zvOXpftLc=
Received: by 10.223.15.21 with SMTP id i21mr1906619faa.58.1269352191136;
        Tue, 23 Mar 2010 06:49:51 -0700 (PDT)
Received: from [192.168.1.13] (absh220.neoplus.adsl.tpnet.pl [83.8.127.220])
        by mx.google.com with ESMTPS id 14sm4685444fxm.5.2010.03.23.06.49.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Mar 2010 06:49:48 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <41f08ee11003230523h2c5f93b1l7e94d6c85a93a706@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143014>

On Tue, Mar 23, 2010, Bo Yang wrote:
> On Tue, Mar 23, 2010 at 7:22 PM, Jakub Narebski <jnareb@gmail.com> wr=
ote:
> >
> > This would work with the simplest case, but not in more complicated
> > cases, like for example preimage and postimage with different size.
> >
> > Take for example the following chunk (fragment):
> >
> > diff --git a/run-command.c b/run-command.c
> > index 2feb493..3206d61 100644
> > --- a/run-command.c
> > +++ b/run-command.c
> > @@ -67,19 +67,21 @@ static int child_notifier =3D -1;
> >
> > =A0static void notify_parent(void)
> > =A0{
> > - =A0 =A0 =A0 write(child_notifier, "", 1);
> > + =A0 =A0 =A0 ssize_t unused;
> > + =A0 =A0 =A0 unused =3D write(child_notifier, "", 1);
> > =A0}
> >
> > =A0static NORETURN void die_child(const char *err, va_list params)
> >
> > If you follow ssize_t line, it is created. =A0If you follow line wi=
th
> > write, which is 2nd line in postimage, its previous version is 1st
> > line in preimage.
> >
> >
> > Another example would be reordering of lines, or reordering with
> > some change.
>=20
> Ah, yes, you are right.
>=20
> And now, I really get the difference between the understanding about
> line level browser of us. :) When users want to browsing the history
> of some line or line range, you want to display only the related line=
s
> to them, but I want to display the minim diff hunk to them. :)
> And I think displaying the minimum diff hunk is sensible and feasible=
=2E
> Could you please tell me what do you think about this?

The problem is not what (part of) diff you would display.  The problem
is with following the history (with history simplification).  *After*
displaying diff / chunk / chunk fragment, do we further follow history
of the whole preimage?  Or do we follow history of line pre-change
starting from blamed commit?

If we *don't* follow the history, how line-level browser is different
from (wrapped) git-blame?


Try to come with the result of line-level history for some line in
git sources "by hand": this would help in discussion about what=20
line-level history browser should do, and perhaps even be first test
of it (see e.g. tests for git-blame).

--=20
Jakub Narebski
Poland
