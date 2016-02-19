From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv13 5/7] git submodule update: have a dedicated helper for
 cloning
Date: Fri, 19 Feb 2016 14:08:21 -0500
Message-ID: <20160219190821.GA777@sigill.intra.peff.net>
References: <1455838398-12379-1-git-send-email-sbeller@google.com>
 <1455838398-12379-6-git-send-email-sbeller@google.com>
 <20160219120310.GB10204@sigill.intra.peff.net>
 <CAGZ79kbp+A1J4isLGftMiA2UZM16NO6nUycraj4U==2Zv6kHVQ@mail.gmail.com>
 <CAPig+cR6SKwM7x=n6fdZDscm2GLTNQq-ZNvB-ELqAk6dk1jGFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 20:08:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWqPr-0005q2-U6
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 20:08:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993206AbcBSTI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 14:08:28 -0500
Received: from cloud.peff.net ([50.56.180.127]:45667 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030273AbcBSTIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 14:08:25 -0500
Received: (qmail 8838 invoked by uid 102); 19 Feb 2016 19:08:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Feb 2016 14:08:23 -0500
Received: (qmail 31408 invoked by uid 107); 19 Feb 2016 19:08:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Feb 2016 14:08:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Feb 2016 14:08:21 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cR6SKwM7x=n6fdZDscm2GLTNQq-ZNvB-ELqAk6dk1jGFw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286740>

On Fri, Feb 19, 2016 at 12:20:48PM -0500, Eric Sunshine wrote:

> >>> +             argv_array_pushl(&cp->args, "--path", sub->path, NULL);
> >>> +             argv_array_pushl(&cp->args, "--name", sub->name, NULL);
> >>> +             argv_array_pushl(&cp->args, "--url", strdup(url), NULL);
> >>
> >> No need to strdup() here; argv_array handles its own memory, so this
> >> just leaks (and if we were keeping it, it should be xstrdup(), of
> >> course).
> >
> > We cannot remove the strdup as the url is a local variable we read in from
> > git_config_get_string and the local variable is going out of scope before the
> > child process ends?
> >
> > I'll change it to xstrdup then.
> 
> When Peff said "argv_array handles its own memory", he meant that it
> does xstrdup() itself, so there's no need for you to do so a second
> time manually (leaking a string as a consequence).

Exactly. :) Sorry for not being clear the first time around.

-Peff
