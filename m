From: Jeff King <peff@peff.net>
Subject: Re: Super long branch names corrupt `.git/config`
Date: Fri, 5 Oct 2012 11:38:41 -0400
Message-ID: <20121005153841.GB24957@sigill.intra.peff.net>
References: <CAAmo=1BU5N8nbonEb1aZEx=-e8VexwsE74pjm_56dXmCDK+K6g@mail.gmail.com>
 <7v391uyr2w.fsf@alter.siamese.dyndns.org>
 <20121005002942.GB17586@sigill.intra.peff.net>
 <CAH5451=fEDd+EvgEst_G00nQ-yot+2UCbWt_UpduR57bhxHYew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ben Olive <sionide21@gmail.com>, git@vger.kernel.org,
	Ben Walton <bdwalton@gmail.com>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 17:38:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK9zL-0002nH-Aa
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 17:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755585Ab2JEPip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 11:38:45 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42021 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755327Ab2JEPio (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 11:38:44 -0400
Received: (qmail 32084 invoked by uid 107); 5 Oct 2012 15:39:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 05 Oct 2012 11:39:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Oct 2012 11:38:41 -0400
Content-Disposition: inline
In-Reply-To: <CAH5451=fEDd+EvgEst_G00nQ-yot+2UCbWt_UpduR57bhxHYew@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207111>

On Fri, Oct 05, 2012 at 10:36:52AM +1000, Andrew Ardill wrote:

> On 5 October 2012 10:29, Jeff King <peff@peff.net> wrote:
> >...
> >
> >but it feels a little fake. Why 200? Because that will test the config
> >limit, but will not overflow the NAME_MAX limit (at least not on
> >Linux! No clue on other platforms) when we try to create
> >refs/heads/foo-$z200.
> 
> I can't test this particular case right now, but I recently had an
> issue with Windows Server 2008 due to a long filename, that
> essentially meant I couldn't move, change owner or change permissions
> on the given file. Unless someone has more info I can test a bit
> later. Is the idea that we shouldn't allow filenames that will cause
> issues with the underlying OS (or other people's OS) or something
> else?

I don't think it's that we shouldn't allow such filenames. It's only
that the test is flaky, because making the branch name long enough to
test the relaxed config code means that we may run afoul of filesystem
limitations on creating the ref itself.

It's a separate issue whether we should restrict the length of branch
names in order to protect against filesystem limits. I tend to think
not, as we handle the filesystem error just fine. The only reason to do
so would be to protect people on multi-system projects (e.g., you make a
long branch name on Linux that cannot be fetched to a Windows system. Or
something; I did not check the limits for those systems). But I have
never heard of that happening in practice, so I think we can ignore it
for now.

-Peff
