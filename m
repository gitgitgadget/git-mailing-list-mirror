From: Jeff King <peff@peff.net>
Subject: Re: crash on git diff-tree -Ganything <tree> for new files with
 textconv filter
Date: Wed, 7 Nov 2012 16:13:39 -0500
Message-ID: <20121107211339.GA29184@sigill.intra.peff.net>
References: <508C29E4.5000801@arcor.de>
 <20121028120104.GE11434@sigill.intra.peff.net>
 <508D8DF7.7040007@arcor.de>
 <20121029060524.GB4457@sigill.intra.peff.net>
 <508EE4E4.1080407@arcor.de>
 <20121029223521.GJ20513@sigill.intra.peff.net>
 <509ACE63.9070007@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Wed Nov 07 22:13:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWCwe-0007eb-I1
	for gcvg-git-2@plane.gmane.org; Wed, 07 Nov 2012 22:13:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767Ab2KGVNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2012 16:13:43 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34556 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752497Ab2KGVNn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2012 16:13:43 -0500
Received: (qmail 21811 invoked by uid 107); 7 Nov 2012 21:14:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 Nov 2012 16:14:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Nov 2012 16:13:39 -0500
Content-Disposition: inline
In-Reply-To: <509ACE63.9070007@arcor.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209142>

On Wed, Nov 07, 2012 at 10:10:59PM +0100, Peter Oberndorfer wrote:

> >> For me the key to reproduce the problem was to have 2 commits.
> >> Adding the file in the root commit it did not work. [1]
> > You probably would need to pass "--root" for it to do the diff of the
> > initial commit.
> >
> > The patch below fixes it, but it's terribly inefficient (it just detects
> > the situation and reallocates). It would be much better to disable the
> > reuse_worktree_file mmap when we populate the filespec, but it is too
> > late to pass an option; we may have already populated from an earlier
> > diffcore stage.
> Hi,
> I tested your patch, and i can confirm it fixes the problem for me.
> (also on my real world test in msysgit)

Thanks for the report. I'd still like to pursue using a regex library
that does not require NUL-termination, but I've been distracted by other
things. I'm going to hold back my copy-to-a-NUL-buffer patch for now and
see if I can get to the regex thing this week.

-Peff
