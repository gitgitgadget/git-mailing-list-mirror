From: Jeff King <peff@peff.net>
Subject: Re: {bug} warning: unable to access 'RelNotes/.gitattributes'
Date: Thu, 13 Sep 2012 08:37:40 -0400
Message-ID: <20120913123740.GB4287@sigill.intra.peff.net>
References: <7vpq5qa0w9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 13 14:37:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TC8g3-0008HU-Oi
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 14:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757841Ab2IMMho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 08:37:44 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43411 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757694Ab2IMMhn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 08:37:43 -0400
Received: (qmail 1901 invoked by uid 107); 13 Sep 2012 12:38:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Sep 2012 08:38:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Sep 2012 08:37:40 -0400
Content-Disposition: inline
In-Reply-To: <7vpq5qa0w9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205366>

On Wed, Sep 12, 2012 at 11:32:22PM -0700, Junio C Hamano wrote:

> "git repack" started giving the above warning, and I am guessing
> that the recent 11e50b2 (attr: warn on inaccessible attribute files,
> 2012-08-21) exposed a bug where we ask stat(2) not lstat(2) by
> mistake before deciding to append .gitattributes to see if that
> directory has a per-directory attributes file.

Interesting. I don't get any such warning on repack. And RelNotes points
to a file, so I'm not sure why stat() would make us think it was a dir.

> We simply used to notice and ignore any failure from open() and moved
> on, but we started distinguishing between ENOENT and others (in this
> case, we get ENOTDIR), and added a warning for non-ENOENT cases and I
> think that is what I am seeing.

I can provoke such a warning by doing:

  git check-attr -a RelNotes/foo

I haven't decided whether that's a good or bad thing. It makes sense,
since the file you are asking for would get ENOTDIR, but maybe somebody
is feeding junk to check-attr.

-Peff
