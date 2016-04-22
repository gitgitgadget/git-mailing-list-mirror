From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Apr 2016, #06; Thu, 21)
Date: Fri, 22 Apr 2016 00:42:59 -0400
Message-ID: <20160422044258.GA31619@sigill.intra.peff.net>
References: <xmqqy486r4co.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 06:43:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atSvv-0005uf-SV
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 06:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbcDVEnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 00:43:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:53945 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750814AbcDVEnC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 00:43:02 -0400
Received: (qmail 5801 invoked by uid 102); 22 Apr 2016 04:43:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Apr 2016 00:43:01 -0400
Received: (qmail 3539 invoked by uid 107); 22 Apr 2016 04:43:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Apr 2016 00:43:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Apr 2016 00:42:59 -0400
Content-Disposition: inline
In-Reply-To: <xmqqy486r4co.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292165>

On Thu, Apr 21, 2016 at 03:20:39PM -0700, Junio C Hamano wrote:

> * jk/push-client-deadlock-fix (2016-04-20) 5 commits
>  - t5504: drop sigpipe=ok from push tests
>  - fetch-pack: isolate sigpipe in demuxer thread
>  - send-pack: isolate sigpipe in demuxer thread
>  - run-command: teach async threads to ignore SIGPIPE
>  - send-pack: close demux pipe before finishing async process
> 
>  "git push" from a corrupt repository that attempts to push a large
>  number of refs deadlocked waiting for a rejection from the
>  receiving end that will never come.
> 
>  Will merge to 'next'.

Minor nit, but the deadlock is the other way around: the rejection
showed up and our demuxer is blocked writing to a reader who does not
care about it.

Might be worth fixing since this text goes into the topic merge commit
(though I really hope nobody ever has to debug it enough ever again for
that distinction to matter :) ).

> * da/user-useconfigonly (2016-04-01) 2 commits
>  - ident: give "please tell me" message upon useConfigOnly error
>  - ident: check for useConfigOnly before auto-detection of name/email
> 
>  The "user.useConfigOnly" configuration variable makes it an error
>  if users do not explicitly set user.name and user.email.  However,
>  its check was not done early enough and allowed another error to
>  trigger, reporting that the default value we guessed from the
>  system setting was unusable.  This was a suboptimal end-user
>  experience as we want the users to set user.name/user.email without
>  relying on the auto-detection at all.
> 
>  Waiting for Acks.
>  ($gmane/290340)

I think you are waiting for the Ack from the original author on your
tweaks. But FWIW, what you have queued looks good to me.

> * dk/gc-more-wo-pack (2016-01-13) 4 commits
>  - gc: clean garbage .bitmap files from pack dir
>  - t5304: ensure non-garbage files are not deleted
>  - t5304: test .bitmap garbage files
>  - prepare_packed_git(): find more garbage
> 
>  Follow-on to dk/gc-idx-wo-pack topic, to clean up stale
>  .bitmap and .keep files.
> 
>  Waiting for a reroll.
>  ($gmane/284368).

This one's getting pretty stale, but as I recall was pretty close to
done.  I'll try to give it a look in the next couple of days.

-Peff
