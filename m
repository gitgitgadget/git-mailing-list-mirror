From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] notes: Use get_sha1_committish instead of read_ref in
 init_notes()
Date: Tue, 16 Jun 2015 23:22:31 -0400
Message-ID: <20150617032231.GA24505@peff.net>
References: <1434503731-26414-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Jun 17 05:22:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z53vz-0006hb-9a
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 05:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755393AbbFQDWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 23:22:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:47177 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752554AbbFQDWe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 23:22:34 -0400
Received: (qmail 8085 invoked by uid 102); 17 Jun 2015 03:22:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Jun 2015 22:22:34 -0500
Received: (qmail 21627 invoked by uid 107); 17 Jun 2015 03:22:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Jun 2015 23:22:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Jun 2015 23:22:31 -0400
Content-Disposition: inline
In-Reply-To: <1434503731-26414-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271808>

On Wed, Jun 17, 2015 at 10:15:31AM +0900, Mike Hommey wrote:

> init_notes() is essentially the only point of entry to the notes API.
> It is an arbitrary restriction that all it allows as input is a strict
> ref name, when callers may want to give an arbitrary committish.
> 
> This has the side effect of enabling the use of committish as notes refs
> in commands allowing them, e.g. git log --notes=foo@{1}, although
> I haven't checked whether that's the case for all of them.

What about expand_notes_ref? We call that on the argument to "--notes".
I guess it is OK to expand "foo@{1}" into "refs/notes/foo@{1}", but what
about other more arcane syntaxes, like ":/"?

In a sense that is weirdly broken already:

  $ git log --notes=:/foo >/dev/null
  warning: notes ref refs/notes/:/foo is invalid

but I wonder if we should be making expand_notes_ref a little more
careful as part of the same topic.

-Peff
