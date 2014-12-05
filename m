From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] prompt: respect GIT_TERMINAL_PROMPT to disable
 terminal prompts
Date: Fri, 5 Dec 2014 04:10:49 -0500
Message-ID: <20141205091049.GB32112@peff.net>
References: <20141204034206.GA1493@peff.net>
 <20141204035228.GB21492@peff.net>
 <xmqqy4qntgs6.fsf@gitster.dls.corp.google.com>
 <20141204210149.GB19953@peff.net>
 <xmqqbnnjrtfi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 10:11:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwous-0006Gj-N5
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 10:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbaLEJK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 04:10:57 -0500
Received: from cloud.peff.net ([50.56.180.127]:48825 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751590AbaLEJKw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 04:10:52 -0500
Received: (qmail 19633 invoked by uid 102); 5 Dec 2014 09:10:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Dec 2014 03:10:52 -0600
Received: (qmail 13436 invoked by uid 107); 5 Dec 2014 09:10:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Dec 2014 04:10:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Dec 2014 04:10:49 -0500
Content-Disposition: inline
In-Reply-To: <xmqqbnnjrtfi.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260860>

On Thu, Dec 04, 2014 at 01:33:53PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Thu, Dec 04, 2014 at 10:24:09AM -0800, Junio C Hamano wrote:
> >
> >> I wish this covered a lot more than just this part from an
> >> end-user's point of view, but this is definitely one of the most
> >> important code paths the mechanism should cover.
> >
> > Which parts do you mean? Stuff like "git add -i"?
> 
> No, more like "tag -s" that eventually leads to somebody prompting
> for the passphrase to unlock your GPG key---and from an end user's
> point of view, that somebody is Git.

Ah, yeah, I definitely agree that GIT_TERMINAL_PROMPT should work there,
too.

> Of course, from _our_ point of view, that somebody is not us.  We do
> not have direct control, certainly from this codepath.

Right, but in theory we can provoke gpg to do what we want when we spawn
it. However, having had zero luck in convincing it to stop asking me for
a passphrase recently in another thread, I do not know what magic
command line option is required. :(

I think it would be OK to merge the git handling of GIT_TERMINAL_PROMPT
(i.e., the patch I sent), and somebody who runs into the issue with gpg
and can figure out how to tame it can scratch their own itch later. I
hate leaving things half-implemented or inconsistent, but I also don't
know how to make gpg do what we want. And doing a partial solution
seems better to me than holding the credential.c half hostage.

-Peff
