From: Jeff King <peff@peff.net>
Subject: Re: [RFC] git checkout $tree -- $path always rewrites files
Date: Sun, 9 Nov 2014 04:42:43 -0500
Message-ID: <20141109094243.GA17369@peff.net>
References: <20141107081324.GA19845@peff.net>
 <xmqqegtfgcfx.fsf@gitster.dls.corp.google.com>
 <20141107191745.GB5695@peff.net>
 <CANiSa6hufp=80TaesNpo1CxCbwVq3LPXvYaUSbcmzPE5pj_GGw@mail.gmail.com>
 <CANiSa6ggX-DJSXLzjYwv1K2nF1ZrpJ3bHvPjh6gFnqSLQaqZFQ@mail.gmail.com>
 <CAPc5daWdzrHr8Rdksr3HycMRQu0=Ji7h=BPYjzZj7MH6Ko0VgQ@mail.gmail.com>
 <20141108083040.GA15833@peff.net>
 <CANiSa6gqu9cRJ4gY5M4ou_zQP=1+U2_C9nHDOoaX01yYn5C+aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 10:42:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnP1K-00035B-AK
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 10:42:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbaKIJmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 04:42:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:38219 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751447AbaKIJmr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 04:42:47 -0500
Received: (qmail 27098 invoked by uid 102); 9 Nov 2014 09:42:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 09 Nov 2014 03:42:47 -0600
Received: (qmail 18258 invoked by uid 107); 9 Nov 2014 09:42:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 09 Nov 2014 04:42:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Nov 2014 04:42:43 -0500
Content-Disposition: inline
In-Reply-To: <CANiSa6gqu9cRJ4gY5M4ou_zQP=1+U2_C9nHDOoaX01yYn5C+aw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 08, 2014 at 08:19:21AM -0800, Martin von Zweigbergk wrote:

> > What should:
> >
> >   git checkout HEAD -- some-new-path
> >
> > do in that case? With the current code, it actually barfs, complaining
> > that nothing matched some-new-path (because it is not part of HEAD, and
> > therefore we don't consider it at all), and aborts the whole operation.
> > I think we would want to delete some-new-path in that case, too.
> 
> I don't think we'd want it to be deleted. I would view 'git reset
> --hard' as the role model here, and that command (without paths) would
> not remove the file. And applying it to a path should not change the
> behavior, just restrict it to the paths, right?

Are you sure about "git reset" here? If I do:

  git init
  echo content >file && git add file && git commit -m base
  echo modified >file
  echo new >some-new-path
  git add file some-new-path
  git reset --hard

then we delete some-new-path (it is not untracked, because the index
knows about it). That makes sense to me. I.e., we treat it with the same
"preciousness" whether it is named explicitly or not.

-Peff
