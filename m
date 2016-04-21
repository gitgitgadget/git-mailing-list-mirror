From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 04/12] worktree.c: mark current worktree
Date: Thu, 21 Apr 2016 11:40:59 -0400
Message-ID: <20160421154058.GA9525@sigill.intra.peff.net>
References: <1460897965-486-1-git-send-email-pclouds@gmail.com>
 <1461158693-21289-1-git-send-email-pclouds@gmail.com>
 <1461158693-21289-5-git-send-email-pclouds@gmail.com>
 <CAPig+cR99Nx=dk+zT2Jgpr2ZgYM4v0q2vX7v6TXmWHU5k6ga3w@mail.gmail.com>
 <CACsJy8DwzfsPthWy6pG2t0cGVT0kcrJT7xWdyvs+0EPFDbNtSQ@mail.gmail.com>
 <CACsJy8ATaYx0Fk-7HK9Rz_o687hxCLuOJYJ6DkBd4Xk8sP+byw@mail.gmail.com>
 <CAPig+cQkT8vb-OVdS_ALVuDii9njY6BN2FhkXt=CavAfyeO2Fg@mail.gmail.com>
 <20160421151355.GA6200@sigill.intra.peff.net>
 <xmqqk2jrt1kz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>,
	Reto =?utf-8?Q?Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 17:41:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atGj7-0000CR-2r
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 17:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498AbcDUPlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 11:41:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:53575 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751829AbcDUPlD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 11:41:03 -0400
Received: (qmail 11542 invoked by uid 102); 21 Apr 2016 15:41:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 Apr 2016 11:41:01 -0400
Received: (qmail 9955 invoked by uid 107); 21 Apr 2016 15:41:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 Apr 2016 11:41:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Apr 2016 11:40:59 -0400
Content-Disposition: inline
In-Reply-To: <xmqqk2jrt1kz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292116>

On Thu, Apr 21, 2016 at 08:37:32AM -0700, Junio C Hamano wrote:

> >> > While we're at it, how about renaming it to pathcmp (and its friend
> >> > strncmp_icase to pathncmp)?
> >> 
> >> Yes, that seems like a good idea. For anyone familiar with
> >> strcasecmp() or stricmp(), having "icase" in the name makes it seem as
> >> though it's unconditionally case-insensitive, so dropping it from the
> >> name would likely be beneficial.
> >
> > Seconded (thirded?). I have been caught by this confusion in the past,
> > too.
> 
> I agree that strcmp_icase() gives a false impression that it always
> ignores case differences, but a new name that does not at all hint
> that it may do icase comparison as necessary will catch me by an
> opposite confusion in the future.

To me, the benefit is that you don't have to care about ignore_case. You
have asked to compare two paths, and any system-appropriate magic should
be applied. That may be icase, or it may be weird unicode normalization.

I think the key thing missing is that this is only about _filesystem_
paths. You would not want to use it for tree-to-tree pathname
comparisons. So maybe "fspath" or something would be more descriptive.

-Peff
