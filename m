From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/6] run_external_diff: use an argv_array for the command
 line
Date: Sat, 19 Apr 2014 21:35:00 -0400
Message-ID: <20140420013500.GB10531@sigill.intra.peff.net>
References: <20140419191128.GA9266@sigill.intra.peff.net>
 <20140419191706.GA8981@sigill.intra.peff.net>
 <CAA6TxYu=AX_RWQq4gr7cv6ZppPerRw30NY_Wbi1r8qEBma7Ctg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Max L <infthi.inbox@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 03:35:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wbgfl-0000oy-SC
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 03:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755179AbaDTBfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 21:35:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:34618 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754793AbaDTBfD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2014 21:35:03 -0400
Received: (qmail 12025 invoked by uid 102); 20 Apr 2014 01:35:03 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 19 Apr 2014 20:35:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 19 Apr 2014 21:35:00 -0400
Content-Disposition: inline
In-Reply-To: <CAA6TxYu=AX_RWQq4gr7cv6ZppPerRw30NY_Wbi1r8qEBma7Ctg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246545>

On Sun, Apr 20, 2014 at 02:09:49AM +0400, Max L wrote:

> One more note: at this moment the problem is slightly deeper. This
> array is next passed to the execvp function, which now falls with
> EFAULT on two my machines (both faced this problem after upgrading to
> ubuntu 14.04, everything 'worked' fine before, looks like now execvp
> checks input more strictly). This leads to non-working 'git difftool'.

Interesting. We're overwriting whatever is after spawn_arg on the stack,
so I'd expect the fork/exec to work, but the function to complain while
popping the stack frame (though I couldn't get it to do so). I wonder if
some kind of stack protection is kicking in, and the NULL doesn't get
written or something. Either way, we should definitely address it.

-Peff
