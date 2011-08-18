From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] stash: Utilize config variable pager.stash.list in stash
 list command
Date: Wed, 17 Aug 2011 21:26:37 -0700
Message-ID: <20110818042620.GA19045@sigill.intra.peff.net>
References: <4e4a58c2.48d6f6ce.bm001@wupperonline.de>
 <4e4b8418.068889fb.bm001@wupperonline.de>
 <7vd3g3ev3j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 06:27:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtuC3-0004DT-Bk
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 06:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206Ab1HRE0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 00:26:43 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53163
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950Ab1HRE0n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 00:26:43 -0400
Received: (qmail 17861 invoked by uid 107); 18 Aug 2011 04:27:22 -0000
Received: from me42036d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.32.228)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Aug 2011 00:27:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Aug 2011 21:26:37 -0700
Content-Disposition: inline
In-Reply-To: <7vd3g3ev3j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179555>

On Wed, Aug 17, 2011 at 11:44:32AM -0700, Junio C Hamano wrote:

> At least "pager.stash.list" should be spelled as "pager.stashList" or
> something. It is not like there are multitude of arbigrary choices that
> may match "pager.*.list" pattern.

The pager code would then assume that was for a command "stashlist". It
probably doesn't matter in practice, but I think it's a little nicer to
keep the namespace properly separated unless there is a good reason not
to.

There are other places where something like this might be handy, too.
For example, auto-pagination of "git branch" or "git tag -l" (but you
wouldn't want to paginate "git branch foo").

> Also a variable can be set to false by setting it to 0, no, etc., so
> you need to inspect it with "git config --bool" to get the canonical
> version of its value.
> 
> What's so difficult to say "git stash list | less" or even "git -p
> stash list"?

Couldn't one make the same argument about git's entire use of the pager?

Anyway, I think his problem is not "I want a pager but I am too lazy to
type it", but rather that "git stash list" will auto-paginate by
default, because it is chaining to "log", which auto-paginates. You can
turn it off with "--no-pager", but pager.stash seems to have no effect.

-Peff
