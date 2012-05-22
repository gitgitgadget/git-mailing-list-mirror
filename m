From: Jeff King <peff@peff.net>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Tue, 22 May 2012 13:01:01 -0400
Message-ID: <20120522170101.GA11600@sigill.intra.peff.net>
References: <4FB9F92D.8000305@alum.mit.edu>
 <20120521174525.GA22643@sigill.intra.peff.net>
 <CACsJy8Dw+mbP+ttTP6gAfX9o4q4NyZgPYpbhS=tket=5fvBXwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 22 19:01:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWsSM-0004tJ-HA
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 19:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756264Ab2EVRBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 13:01:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51802
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753712Ab2EVRBE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 13:01:04 -0400
Received: (qmail 19799 invoked by uid 107); 22 May 2012 17:01:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 May 2012 13:01:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 May 2012 13:01:01 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8Dw+mbP+ttTP6gAfX9o4q4NyZgPYpbhS=tket=5fvBXwg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198206>

On Tue, May 22, 2012 at 07:18:00PM +0700, Nguyen Thai Ngoc Duy wrote:

> On Tue, May 22, 2012 at 12:45 AM, Jeff King <peff@peff.net> wrote:
> > The rails/rails network repository at GitHub (i.e., a master repo with
> > all of the objects and refs for all of the forks) has about 400K refs,
> > and has been the usual impetus for me finding and fixing these sorts of
> > quadratic problems.
> 
> Off topic and pure speculation. With 400k refs, each one 20 byte in
> length, the pathname part only can take 7MB. Perhaps packed-refs
> should learn prefix compressing too, like index v4, to reduce size
> (and hopefully improve startup speed). Compressing refs/heads/ and
> refs/tags/ only could gain quite a bit already.

In this case, the packed-refs file is 30MB. Even just gzipping it takes
it down to 2MB. As far as I know, we don't ever do random access on the
file, but instead just stream it into memory.

-Peff
