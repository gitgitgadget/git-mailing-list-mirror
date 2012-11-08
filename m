From: Jeff King <peff@peff.net>
Subject: Re: Long clone time after "done."
Date: Thu, 8 Nov 2012 17:11:28 -0500
Message-ID: <20121108221128.GA11186@sigill.intra.peff.net>
References: <CAMJd5AQBbnFqT5xrFuPOEsJevwDE=jUgBVFZ5KqTZk5zv5+NOw@mail.gmail.com>
 <CAMJd5ASL1UPfzUmfXqACuYuGhXQjJLqbsjq7dfpRpF4K-hZFtA@mail.gmail.com>
 <20121108155607.GD15560@sigill.intra.peff.net>
 <CAMJd5AQ24u11BH6rMAHvR95N4ys6KHfEQKD1uLzr+=TDgN_69Q@mail.gmail.com>
 <20121108203332.GQ15560@sigill.intra.peff.net>
 <CAMJd5ARLCk_WQTbyLciv0LnrMa_J0YstNsrq-hLYM5DXiO0hLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Uri Moszkowicz <uri@4refs.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 23:11:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWaKA-0008R0-DE
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 23:11:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757171Ab2KHWLd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 17:11:33 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36772 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756796Ab2KHWLc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 17:11:32 -0500
Received: (qmail 1248 invoked by uid 107); 8 Nov 2012 22:12:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Nov 2012 17:12:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Nov 2012 17:11:28 -0500
Content-Disposition: inline
In-Reply-To: <CAMJd5ARLCk_WQTbyLciv0LnrMa_J0YstNsrq-hLYM5DXiO0hLA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209193>

On Thu, Nov 08, 2012 at 03:49:32PM -0600, Uri Moszkowicz wrote:

> I'm using RHEL4. Looks like perf is only available with RHEL6.

Yeah, RHEL4 is pretty ancient; I think it predates the invention of
"perf".

> heads: 308
> tags: 9614
> 
> Looking up the tags that way took a very long time by the way. "git
> tag | wc -l" was much quicker. I've already pruned a lot of tags to
> get to this number as well. The original repository had ~37k tags
> since we used to tag every commit with CVS.

Hmm. I think for-each-ref will actually open the tag objects, but "git
tag" will not. That would imply that reading the refs is fast, but
opening objects is slow. I wonder why.

How many packs do you have in .git/objects/pack of the repository?

> All my tags are packed so cat-file doesn't work:
> fatal: git cat-file refs/tags/some-tag: bad file

The packing shouldn't matter. The point of the command is to look up the
refs/tags/some-tag ref (in packed-refs or in the filesystem), and then
open and write the pointed-to object to stdout. If that is not working,
then there is something seriously wrong going on.

-Peff
