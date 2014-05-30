From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] git log: support "auto" decorations
Date: Fri, 30 May 2014 16:48:53 -0400
Message-ID: <20140530204853.GA9271@sigill.intra.peff.net>
References: <alpine.LFD.2.11.1405291523520.8270@i7.linux-foundation.org>
 <20140530015855.GG28683@sigill.intra.peff.net>
 <CA+55aFzwy09-i=hpBy-5bYS6eowGzkdcF65cFJpL2qnJvYq85w@mail.gmail.com>
 <20140530065737.GA13591@sigill.intra.peff.net>
 <xmqqvbsn9pfx.fsf@gitster.dls.corp.google.com>
 <20140530170330.GA25443@sigill.intra.peff.net>
 <xmqqmwdz9nl9.fsf@gitster.dls.corp.google.com>
 <20140530183441.GA3704@sigill.intra.peff.net>
 <xmqqmwdz809b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 30 22:49:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqTjX-0005au-Nt
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 22:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167AbaE3Us4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 16:48:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:34439 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751776AbaE3Usz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 16:48:55 -0400
Received: (qmail 31674 invoked by uid 102); 30 May 2014 20:48:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 May 2014 15:48:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 May 2014 16:48:53 -0400
Content-Disposition: inline
In-Reply-To: <xmqqmwdz809b.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250480>

On Fri, May 30, 2014 at 01:44:32PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Subject: [PATCH] reuse commit->buffer when parsing signatures
> > ...
> > Signed-off-by: Jeff King <peff@peff.net>
> 
> Hmph, unfortunately this seems to break t7510.

Urgh, sorry for not testing more thoroughly.

I imagine it is because of the strlen(commit->buffer) I introduced.
Unfortunately I do not know if we have an easy way to know the length of
commit->buffer, short of hitting sha1_object_info (which is somewhat
expensive to do for every commit).

I wonder if it would be sane to remove or quote NULs when attaching the
buffer to commit->buffer. That would _break_ signatures, but that is a
good thing. I do not think there is a reason to have NULs in your commit
message unless you are doing something malicious (or using utf16, but
that already is horribly broken).

-Peff
