From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] unpack-trees: do not abort when overwriting an
 existing file with the same content
Date: Tue, 22 Jan 2013 15:19:29 -0500
Message-ID: <20130122201929.GB23521@sigill.intra.peff.net>
References: <1358594648-26851-1-git-send-email-pclouds@gmail.com>
 <1358768433-26096-1-git-send-email-pclouds@gmail.com>
 <20130121231515.GD17156@sigill.intra.peff.net>
 <CACsJy8AFKXYkHbUf4aqBpCg+v06oFsvHq_zxQFE4BOCzTDAqtg@mail.gmail.com>
 <7vwqv6c7oe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 21:19:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxkK2-0006V7-1n
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 21:19:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755813Ab3AVUTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 15:19:33 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44040 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754738Ab3AVUTc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 15:19:32 -0500
Received: (qmail 28279 invoked by uid 107); 22 Jan 2013 20:20:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 Jan 2013 15:20:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Jan 2013 15:19:29 -0500
Content-Disposition: inline
In-Reply-To: <7vwqv6c7oe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214248>

On Mon, Jan 21, 2013 at 05:45:05PM -0800, Junio C Hamano wrote:

> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > On Tue, Jan 22, 2013 at 6:15 AM, Jeff King <peff@peff.net> wrote:
> >> Can you elaborate on when this code is triggered?
> >>
> >> In the general case, shouldn't we already know the sha1 of what's on
> >> disk in the index, and be able to just compare the hashes? And if we
> >> don't, because the entry is start-dirty, should we be updating it
> >> (possibly earlier, so we do not even get into the "need to write" code
> >> path) instead of doing this ad-hoc byte comparison?
> 
> If the index knows what is in the working tree, I think I agree.

Right. I was wondering why it didn't (and if it doesn't, why we are not
saving the information there).

But I think I was letting my inaccurate mental model of the index get in
the way. I tend to think of the stat information as "if the file matches
this stat info, then it has sha1 X". But that is not true. The sha1 we
store is the actual index entry, and if it does not match what is in the
working tree, we do not know or store the sha1 of what is in the working
tree. We cannot just "refresh" that value and compare it, which is what
I was implying.

So I think I was just confused. That is what I get for not actually
doing low-level index stuff enough.

> > git reset HEAD~10
> > # blah that was a mistake, undo it
> > git checkout HEAD@{1}

It seems like

  git reset HEAD@{1}

would be the correct undo, as the original never touched the working
tree.

-Peff
