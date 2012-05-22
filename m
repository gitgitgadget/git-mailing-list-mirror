From: Jeff King <peff@peff.net>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Tue, 22 May 2012 03:37:40 -0400
Message-ID: <20120522073740.GA10093@sigill.intra.peff.net>
References: <4FB9F92D.8000305@alum.mit.edu>
 <20120521174525.GA22643@sigill.intra.peff.net>
 <20120521221417.GA22664@sigill.intra.peff.net>
 <20120521235219.GA5589@sigill.intra.peff.net>
 <4FBB0F21.5080608@alum.mit.edu>
 <20120522041123.GA9972@sigill.intra.peff.net>
 <4FBB3D2B.4010300@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Fick <mfick@codeaurora.org>,
	git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 22 09:38:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWjfN-00042f-MG
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 09:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755614Ab2EVHho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 03:37:44 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51570
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755594Ab2EVHhm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 03:37:42 -0400
Received: (qmail 15080 invoked by uid 107); 22 May 2012 07:38:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 May 2012 03:38:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 May 2012 03:37:40 -0400
Content-Disposition: inline
In-Reply-To: <4FBB3D2B.4010300@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198185>

On Tue, May 22, 2012 at 09:15:55AM +0200, Michael Haggerty wrote:

> If it is not too much trouble, please let me know where I can obtain
> your test repo and what commands you used to get your result.  (Was
> the local repo already a full clone of the remote, including all 400k
> references?  How was the remote set up--sharing data or not, local or
> remote?  Warm or cold disk cache?)

I've put the repo up at:

  https://gist.github.com/raw/2767328/603926240fabb4d3e3abc3c93a1913d91852cc7e/rails.tar.gz

You can reproduce the slow-down with:

  cd rails.git &&
  git fetch . refs/*:refs/*

which should be a no-op, as we already have all of the refs. I don't
know if the problem is actually specific to fetch; that was just how I
noticed it.

When I try it with both 'next' and v1.7.10, I see that the latter is
much faster.  I did my tests with a warm cache, but the interesting
number is the CPU time, which is quite different.

-Peff
