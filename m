From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jan 2009, #04; Mon, 19)
Date: Mon, 19 Jan 2009 23:40:21 -0500
Message-ID: <20090120044021.GE30714@sigill.intra.peff.net>
References: <7vbpu3r745.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 05:43:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP8Rw-0002hG-Ck
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 05:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754334AbZATEk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 23:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754064AbZATEk1
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 23:40:27 -0500
Received: from peff.net ([208.65.91.99]:49979 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753002AbZATEk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 23:40:26 -0500
Received: (qmail 31457 invoked by uid 107); 20 Jan 2009 04:40:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 19 Jan 2009 23:40:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Jan 2009 23:40:21 -0500
Content-Disposition: inline
In-Reply-To: <7vbpu3r745.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106437>

On Mon, Jan 19, 2009 at 01:13:30AM -0800, Junio C Hamano wrote:

> * jk/signal-cleanup (Sun Jan 11 06:36:49 2009 -0500) 3 commits
>  - pager: do wait_for_pager on signal death
>  - refactor signal handling for cleanup functions
>  - chain kill signals for cleanup functions
> 
> Sorry, I lost track.  What is the status of this one?

I need to clean up and re-send. The three improvements needed are:

  - there is a related Windows cleanup from JSixt, which I will send
    when I re-post

  - the test needs a few tweaks to be portable to Windows

  - Some of the signal handlers should be guarded from inserting
    themselves multiple times. I don't think any are dangerous to run
    twice (they generally traverse a list, cleaning up files, and then
    remove the list elements), but I'm not sure that you can't get some
    stupid behavior, like inserting one handler per diff'd file, which
    will unnecessarily allocate memory.

This series fixes pager handling for interrupted git programs.  There is
also a related fix that needs to be done for forked git programs. I
posted a "how about this" patch to use run_command for external git
programs, but it has some serious problems ("git bogus" no longer
reports an error!).

I have unfortunately not had very much git time lately, but I'll try to
come up with something for both cases this week.

-Peff
