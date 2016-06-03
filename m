From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] completion: add git status
Date: Fri, 3 Jun 2016 13:17:11 -0400
Message-ID: <20160603171711.GC3858@sigill.intra.peff.net>
References: <20160601141510.Horde.M2zGuJrzBNqf_2zYLo0P2Sx@webmail.informatik.kit.edu>
 <9ef8cfd8fb89bcacd123ddbebc12f961a292ef8b.1464879648.git.thomas.braun@virtuell-zuhause.de>
 <1464880296.3720.0.camel@virtuell-zuhause.de>
 <xmqqtwhbtq46.fsf@gitster.mtv.corp.google.com>
 <8f5e515b-8efc-0160-820e-d81885fc6c36@virtuell-zuhause.de>
 <xmqqzir2p6yv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Braun <thomas.braun@virtuell-zuhause.de>,
	git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 19:17:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8sik-00024D-Al
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 19:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694AbcFCRRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 13:17:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:48658 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752087AbcFCRRO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 13:17:14 -0400
Received: (qmail 24087 invoked by uid 102); 3 Jun 2016 17:17:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jun 2016 13:17:13 -0400
Received: (qmail 24050 invoked by uid 107); 3 Jun 2016 17:17:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jun 2016 13:17:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Jun 2016 13:17:11 -0400
Content-Disposition: inline
In-Reply-To: <xmqqzir2p6yv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296354>

On Fri, Jun 03, 2016 at 09:34:00AM -0700, Junio C Hamano wrote:

> Thomas Braun <thomas.braun@virtuell-zuhause.de> writes:
> 
> >>> +			if [ -n "$(__git_find_on_cmdline "--ignored")" ]; then
> >> 
> >> Same question as the "--untracked-files=no vs -uno" applies here.
> >
> > Is there a short version of --ignored? I could not find one in the help,
> > and from a look into cmd_status in commit.c I would say there is none.
> 
> I was primarily wondering about the effect of parse-options have.
> It lets you truncate a long option to its unique prefix (e.g.
> "--untracked-files=all" can be spelled as "--unt=all").  It seems
> that "--ignored" must be spelled in full, which means the use of
> find-on-cmdline we see above is OK, but the reason why it is so is a
> bit subtle.  It may deserve a comment there, perhaps.

I don't think we handle arguments to unique-prefix options throughout
the completion. There's lots of:

  case "${words[c]}" in
  --foo) ...
  --bar) ...
  --etc) ...

I suspect trying to support them everywhere would be a moderate pain,
and I doubt it is all that useful. We already know the person is using
tab-completion, so the natural thing to do after typing "--unt" is to
hit "<Tab>" rather than "=". That gives you the same effect, with the
added feedback that you're using a recognized action.

I know not everybody will the "natural thing" I claim, and if it were
easy to support everywhere, I don't mind doing it. But I suspect
(without thinking very hard on it) that it would make those case
statements a bit harder to read and maintain.

-Peff
