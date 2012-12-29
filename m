From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] do not write null sha1s to on-disk index
Date: Sat, 29 Dec 2012 05:42:47 -0500
Message-ID: <20121229104247.GA30283@sigill.intra.peff.net>
References: <20120728150132.GA25042@sigill.intra.peff.net>
 <20120728150524.GB25269@sigill.intra.peff.net>
 <20121229100130.GA31497@elie.Belkin>
 <20121229102707.GA26730@sigill.intra.peff.net>
 <20121229103430.GG18903@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 11:43:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Totsk-000325-Bn
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 11:43:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619Ab2L2Kmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2012 05:42:53 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38754 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752530Ab2L2Kmv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2012 05:42:51 -0500
Received: (qmail 28671 invoked by uid 107); 29 Dec 2012 10:44:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 29 Dec 2012 05:44:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Dec 2012 05:42:47 -0500
Content-Disposition: inline
In-Reply-To: <20121229103430.GG18903@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212306>

On Sat, Dec 29, 2012 at 02:34:30AM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > I can't reproduce here. I can checkout v3.2.35, and I guess that the
> > patch you are applying comes from f5f1654, but I don't know your
> > local modification to sound/usb/midi.c.
> 
> No local modification.  The unstaged change after "git am --abort" to
> recover from a conflicted git am is a longstanding bug (at least a
> couple of years old).
> 
> The patch creating conflicts is
> 
> 	queue-3.2/alsa-usb-audio-fix-missing-autopm-for-midi-input.patch
> 
> from git://git.kernel.org/pub/scm/linux/kernel/git/bwh/linux-3.2.y-queue.git

Hrm. But your output does not say there is a conflict. It says you have
a local modification and it does not try the merge:

> $ git am -3sc /tmp/alsa-usb-audio-fix-missing-autopm-for-midi-input.patch
> Applying: ALSA: usb-audio: Fix missing autopm for MIDI input
> Using index info to reconstruct a base tree...
> Falling back to patching base and 3-way merge...
> error: Your local changes to the following files would be overwritten by merge:
>       sound/usb/midi.c
> Please, commit your changes or stash them before you can merge.
> Aborting

If I try to apply it, I get a real conflict:

  $ git checkout v3.2.35
  $ git am -3sc linux-3.2.y-queue/queue-3.2/alsa-usb-audio-fix-missing-autopm-for-midi-input.patch
  Applying: ALSA: usb-audio: Fix missing autopm for MIDI input
  Using index info to reconstruct a base tree...
  M       sound/usb/midi.c
  Falling back to patching base and 3-way merge...
  Auto-merging sound/usb/midi.c
  CONFLICT (content): Merge conflict in sound/usb/midi.c

Although running "git am --abort" after that does seem to produce the
"cache entry has null sha1" error. So I can start investigating from
there.

-Peff
