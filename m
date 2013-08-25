From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: search author pattern against mailmap
Date: Sun, 25 Aug 2013 06:30:41 -0400
Message-ID: <20130825103041.GB12556@sigill.intra.peff.net>
References: <xmqqob8ml588.fsf@gitster.dls.corp.google.com>
 <1377424889-15399-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 25 12:31:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDXb3-0006sf-Cw
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 12:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754710Ab3HYKaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 06:30:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:54795 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754347Ab3HYKaq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 06:30:46 -0400
Received: (qmail 28918 invoked by uid 102); 25 Aug 2013 10:30:45 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 25 Aug 2013 05:30:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Aug 2013 06:30:41 -0400
Content-Disposition: inline
In-Reply-To: <1377424889-15399-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232948>

On Sun, Aug 25, 2013 at 12:01:29PM +0200, Antoine Pelisse wrote:

> So I kept clear_mailmap() where you put it, but I think it could be moved
> right after get_revision(). That is because I think format_commit_message()
> will run another read_mailmap() with an heap-allocated string_list.
> Anyway, I'm not sure it makes a big difference here.

Yeah, format_commit_message does not even pay attention to our
revs.mailmap.

It does make me wonder if there should simply be a static singleton
mailmap that gets loaded once per program invocation and then cleaned up
at exit. That is clearly what format_commit_message is doing. Is there
actually a use case for having a custom one in rev_info? It's not like
you can even control where it reads from when you call read_mailmap.

I guess we need it as a boolean "do we want to mailmap at all" for the
regular pretty formats, but it could just be a flag in rev_info instead
of a pointer.

-Peff
