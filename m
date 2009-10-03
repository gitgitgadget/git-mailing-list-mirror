From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 5/7] imap-send: provide fall-back random-source
Date: Sat, 3 Oct 2009 05:58:11 -0400
Message-ID: <20091003095811.GB17873@coredump.intra.peff.net>
References: <1254530385-2824-1-git-send-email-kusmabite@gmail.com>
 <1254530385-2824-2-git-send-email-kusmabite@gmail.com>
 <1254530385-2824-3-git-send-email-kusmabite@gmail.com>
 <1254530385-2824-4-git-send-email-kusmabite@gmail.com>
 <1254530385-2824-5-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Oct 03 11:58:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mu1Nh-0001QM-CO
	for gcvg-git-2@lo.gmane.org; Sat, 03 Oct 2009 11:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754373AbZJCJ6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2009 05:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754131AbZJCJ6P
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Oct 2009 05:58:15 -0400
Received: from peff.net ([208.65.91.99]:45359 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752537AbZJCJ6O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2009 05:58:14 -0400
Received: (qmail 2787 invoked by uid 107); 3 Oct 2009 10:01:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 03 Oct 2009 06:01:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Oct 2009 05:58:11 -0400
Content-Disposition: inline
In-Reply-To: <1254530385-2824-5-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129481>

On Sat, Oct 03, 2009 at 12:39:43AM +0000, Erik Faye-Lund wrote:

> Since some systems (at least Windows) does not have
> /dev/random nor friends, we need another random-source.
> 
> This patch uses the C-runtime's rand()-function as a
> poor-mans random-source.

Hmm. It looks like this arc4 RNG is used just for generating a unique
"X-TUID" header. Which seems to be used in isync (from which imap-send
is derived) to be to avoid duplicates in synchronization. But imap-send
doesn't actually use it for anything, as it just blindly pushes the
messages.

In other words, should all of this TUID code (and the arc4 code) simply
be ripped out?

-Peff
