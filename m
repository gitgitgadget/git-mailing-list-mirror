From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 15/16] branch: use ref-filter printing APIs
Date: Wed, 13 Apr 2016 18:05:59 -0400
Message-ID: <20160413220559.GC8712@sigill.intra.peff.net>
References: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
 <1460227515-28437-16-git-send-email-Karthik.188@gmail.com>
 <xmqqtwj6pnma.fsf@gitster.mtv.corp.google.com>
 <xmqqinzmpmg2.fsf@gitster.mtv.corp.google.com>
 <CAOLa=ZQ5gwW1vwREsK=h0tDuyk18axHU491brKJM_DR53=9zcQ@mail.gmail.com>
 <CAPc5daUZvP03o+eb2ngvRtV=aoXWGnZH9FKj9bRCEj3MrCT8WQ@mail.gmail.com>
 <CAOLa=ZQnM95mApOmYYZa3SeFq2af5FMmiqh0ZFZDn3EO8U9-Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 00:06:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqSvM-00078g-QT
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 00:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754014AbcDMWGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 18:06:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:49098 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750928AbcDMWGH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 18:06:07 -0400
Received: (qmail 6522 invoked by uid 102); 13 Apr 2016 22:06:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Apr 2016 18:06:01 -0400
Received: (qmail 23093 invoked by uid 107); 13 Apr 2016 22:06:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Apr 2016 18:06:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Apr 2016 18:05:59 -0400
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQnM95mApOmYYZa3SeFq2af5FMmiqh0ZFZDn3EO8U9-Dg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291497>

On Thu, Apr 14, 2016 at 12:31:41AM +0530, Karthik Nayak wrote:

> On Wed, Apr 13, 2016 at 8:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >>> Having said that, doesn't this need to be further adjusted for
> >>> 95c38fb0 (branch: fix shortening of non-remote symrefs, 2016-04-03)?
> >>>
> >>> http://thread.gmane.org/gmane.comp.version-control.git/290622/focus=290624
> >>>
> >>
> >> That was one of the changes made in this version of the patch series :)
> >
> > But with this patch applied, it seems that the tests in Peff's fix
> > does not seem to pass.
> > If I understand correctly, "fix shortening" stops doing your
> > symref:short (which is to
> > shorten the usual "drop refs/heads, refs/remotes, etc.") and makes the
> > shortening
> > conditional. The target of a symref that is found in refs/heads/ gets
> > refs/heads and
> > nothing else stripped.
> 
> Having a look here, WRT to the patch v4 it seems the problem is that
> patch v4 doesn't support v2.6.x behavior, namely that cross-prefix symrefs will
> not be shortened at all. As per the format given in the last patch
> [16/16] it shortens
> the symref irrespective of being cross-prefix symrefs.
> 
> Would it be a good idea to enforce this as in v2.6.x or change it as
> to allow shortening
> of cross-prefix symrefs.

The cross-prefix behavior I put into the test is not something I feel
strongly about; it was mostly just restoring the earlier behavior. I do
think shortening everything is fine, too, as long as there's some way to
get the fully qualified ref. E.g., if `git branch` shows %(symref:short)
or %(symref:strip=2), by default, but you can ask for just %(symref) if
you want (which I think is how you have it implemented now, though I
notice that symrefs don't get nearly as many formatting options as
things like %(upstream)).

If anyone is machine-parsing git-branch output in the first place, they
are Doing It Wrong. And doubly so if they are relying on some obscure
shortening rules that I don't think were ever carefully designed. So I
think we should be free to change it here to what serves users best.

-Peff
