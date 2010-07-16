From: Johan Herland <johan@herland.net>
Subject: Re: Find successor of common ancestor
Date: Fri, 16 Jul 2010 14:19:39 +0200
Message-ID: <201007161419.39469.johan@herland.net>
References: <20100716082937.GA22894@nibiru.local> <AANLkTintIToGZu3fvK4aE5LFL7MgOnlfwKgsZ79Q0-o1@mail.gmail.com> <20100716090613.GB22894@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: weigelt@metux.de
X-From: git-owner@vger.kernel.org Fri Jul 16 14:20:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZjtk-0000Tl-SZ
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 14:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965294Ab0GPMUF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jul 2010 08:20:05 -0400
Received: from smtp.opera.com ([213.236.208.81]:41635 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965291Ab0GPMUD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jul 2010 08:20:03 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o6GCJdbo015659
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 16 Jul 2010 12:19:48 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <20100716090613.GB22894@nibiru.local>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151148>

On Friday 16 July 2010, Enrico Weigelt wrote:
> * Santi B=E9jar <santi@agolina.net> wrote:
> > On Fri, Jul 16, 2010 at 10:29 AM, Enrico Weigelt <weigelt@metux.de>=
=20
wrote:
> > > Hi folks,
> > >
> > >
> > > suppose the following situation:
> > >
> > > I've forked some branch A into B, now A and B have evolved
> > > independently for quite some time into A' and B'. Now I'd like
> > > to rebase B' along A' history line step by step - first on A+1,
> > > then A+3, ... until A' (that's what I'd call zip-rebase).
> >
> > This is just what "git rebase"  does:
> >
> > $ git checkout B'
> > $ git rebase A'
>
> Yes, but I need to find out A+1 for my zip-rebase.

IINM you have the following situation

A0---A1---A2---A3---A4  <-- A'
  \
   B1---B2---B3--B4  <-- B'

=2E..and you want to rebase B' (i.e. B1 through B4), first onto A1, the=
n=20
onto A2, the onto A3, and finally onto A4. I have no idea WHY you would=
=20
want to do this (rebasing directly onto A4 (like Santi suggests) is=20
much cheaper), but you can certainly coax Git into doing it, anyway.

To list commits A1, A2, A3, A4 (in that order), do:

  git rev-list --reverse B'..A'

You can now loop over the results like this:

  git checkout B'
  for a in $(git rev-list --reverse ..A'); do
      git rebase $a
  done


Hope this helps,

=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
