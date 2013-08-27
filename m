From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Aug 2013, #06; Tue, 27)
Date: Tue, 27 Aug 2013 16:51:25 -0400
Message-ID: <20130827205125.GA23783@sigill.intra.peff.net>
References: <xmqqsixvaqh5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 22:51:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEQEe-0001JZ-SY
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 22:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809Ab3H0Uv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 16:51:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:49384 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751652Ab3H0Uv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 16:51:28 -0400
Received: (qmail 4478 invoked by uid 102); 27 Aug 2013 20:51:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Aug 2013 15:51:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Aug 2013 16:51:25 -0400
Content-Disposition: inline
In-Reply-To: <xmqqsixvaqh5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233160>

On Tue, Aug 27, 2013 at 12:22:30PM -0700, Junio C Hamano wrote:

> * jk/config-int-range-check (2013-08-21) 2 commits
>   (merged to 'next' on 2013-08-22 at 465efb3)
>  + teach git-config to output large integers
>  + config: properly range-check integer values
> 
>  Originally merged to 'next' on 2013-08-22
> 
>  "git config --int section.var 3g" should somehow diagnose that the
>  number does not fit in "int" (on 32-bit platforms anyway) but it
>  did not.
> 
>  Will cook in 'next'.

I think Jonathan had some concerns about the test in the first one, and
there was an open question in the second of whether we wanted to add
something like --ulong, call it something more agnostic like
--file-size, or simply teach --int to use 64-bit integers everywhere for
simplicity.

Thoughts?

> * jk/mailmap-incomplete-line (2013-08-25) 2 commits
>  - mailmap: avoid allocation when reading from blob
>  - mailmap: handle mailmap blobs without trailing newlines
> 
>  Will merge to 'next'.

Did you want me to squash these? The second one more or less eradicates
the changes made to the first one. I mainly did them separately in case
we were going to only do the first half on maint.

> * jk/write-broken-index-with-nul-sha1 (2013-08-26) 1 commit
>  - write_index: optionally allow broken null sha1s
> 
>  Am I waiting for another reroll?

Yep, just sent v3.

> [Stalled]
> [...]
> * jk/list-objects-sans-blobs (2013-06-06) 4 commits
>  . archive: ignore blob objects when checking reachability
>  . list-objects: optimize "revs->blob_objects = 0" case
>  . upload-archive: restrict remote objects with reachability check
>  . clear parsed flag when we free tree buffers
> 
>  Attempt to allow "archive --remote=$there $arbitrary_sha1" while
>  keeping the reachability safety.
> 
>  Seems to break some tests in a trivial and obvious way.

You can probably discard this one (though you may want to take the
bottom as a separate cleanup). I think we decided that the right
strategy is to do the ":" split as we do now, but then do the normal
commit-level reachability check on the left-hand side. I just haven't
gotten around to writing the code yet.

-Peff
