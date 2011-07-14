From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git commit generation numbers
Date: Thu, 14 Jul 2011 12:08:34 -0700 (PDT)
Message-ID: <m3tyaoadfs.fsf@localhost.localdomain>
References: <CA+55aFxZq1e8u7kXu1rNDy2UPgP3uOyC5y2j7idKSZ_4eL=bWw@mail.gmail.com>
	<20110714183710.GA26820@sigill.intra.peff.net>
	<CA+55aFy5Kr1oHgvQ0m4m+4zJVSTU-QPc_a-cbv=tDDMG0u_-2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 14 21:08:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhRH7-0003mK-Nw
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 21:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052Ab1GNTIh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jul 2011 15:08:37 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:42114 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925Ab1GNTIg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2011 15:08:36 -0400
Received: by fxd18 with SMTP id 18so1503270fxd.11
        for <git@vger.kernel.org>; Thu, 14 Jul 2011 12:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=oRuGgaqe4sJnS8y8wokjqxYVLfOEU4+MbFXBPo332OQ=;
        b=AWdf7mYvlRzF6tNx3IAD+GcB8t35VO8NMEWKodZYVc5erXx/HnNSX7DCKwh7vpYTxp
         vWCantR5zN4xh4j8QGgByLSefKyMqiuvoClxKu5FGPIcTRTeEC36Li3BOFUwYMOvzF9/
         XRcIv6E0OUgIdyXNySCcWS81PZ6zDiwLPONsg=
Received: by 10.204.126.216 with SMTP id d24mr957392bks.365.1310670515420;
        Thu, 14 Jul 2011 12:08:35 -0700 (PDT)
Received: from localhost.localdomain (abva152.neoplus.adsl.tpnet.pl [83.8.198.152])
        by mx.google.com with ESMTPS id s16sm453259fah.0.2011.07.14.12.08.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jul 2011 12:08:34 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p6EJ82It004618;
	Thu, 14 Jul 2011 21:08:12 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p6EJ7ZAE004604;
	Thu, 14 Jul 2011 21:07:35 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CA+55aFy5Kr1oHgvQ0m4m+4zJVSTU-QPc_a-cbv=tDDMG0u_-2Q@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177158>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Jul 14, 2011 at 11:37 AM, Jeff King <peff@peff.net> wrote:
> >
> > There's also one other issue with generation numbers. How do you ha=
ndle
> > grafts and object-replacement refs? =A0If you graft history, your e=
mbedded
> > generation numbers will all be junk, and you can't trust them.
>=20
> So I don't think this is a real problem in practice.
>=20
> Grafts are already unreliable. You cannot sanely merge over a graft,
> and it has nothing to do with generation numbers.
>=20
> I'm actually sorry that we ever did grafting. It's fundamentally
> broken, and can actually destroy your repository (by hiding real
> parents and then causing the commits to get garbage collected). So I
> don't think grafting should be used as an argument for or against
> anything - it's a hack that breaks some fundamental git database
> constraints.

What about object-replacement refs (i.e. "git replace" and refs/replace=
/)?

This is modern replacement for grafts mechanism, which is safe against
garbage collecting, and contrary to grafts it is transferable (as a ref=
).

With replacement objects (e.g. to repair some fragment of history to
make it bisectable - I think that was original idea behind introducing
git-replace, or instead of grafts to join with historical repository -
IIRC the reason why grafts mechanism was created) you can also have
invalid generation numbers if they are stored in commit headers.  With
generation cache we can simply invaliate it if grafts or replacements
change...

P.S. grafts are quite useful when doing history surgery.  Create
grafts, check history, use git-filter-branch to make new DAG
permanent, remove grafts.

P.P.S. What about "grafts lite", i.e. shallow clone?  With generation
cache we can invalidate it when depth changes...

--=20
Jakub Nar=EAbski
Poland
