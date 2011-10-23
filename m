From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/22] Refactor to accept NUL in commit messages
Date: Sun, 23 Oct 2011 12:07:45 -0400
Message-ID: <20111023160744.GA22444@sigill.intra.peff.net>
References: <1319277881-4128-1-git-send-email-pclouds@gmail.com>
 <7vobx863v3.fsf@alter.siamese.dyndns.org>
 <CACsJy8B=TsC4A=R6b3jyYBCvorEDBYHQ8uA864WrB0-3pgNyKA@mail.gmail.com>
 <7vipng5k80.fsf@alter.siamese.dyndns.org>
 <CACsJy8CA2cqJqt7cUN1CdnOb3=qE6B2XTd1oQKZ7osVz09kSGg@mail.gmail.com>
 <7vehy459bg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 23 18:07:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RI0ab-0006dt-QO
	for gcvg-git-2@lo.gmane.org; Sun, 23 Oct 2011 18:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987Ab1JWQHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Oct 2011 12:07:50 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39922
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751550Ab1JWQHt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2011 12:07:49 -0400
Received: (qmail 3503 invoked by uid 107); 23 Oct 2011 16:07:57 -0000
Received: from 75-147-138-244-SFBA.hfc.comcastbusiness.net (HELO sigill.intra.peff.net) (75.147.138.244)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 23 Oct 2011 12:07:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 23 Oct 2011 12:07:45 -0400
Content-Disposition: inline
In-Reply-To: <7vehy459bg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184141>

On Sun, Oct 23, 2011 at 02:46:59AM -0700, Junio C Hamano wrote:

> > But when it comes to "Git" Porcelains (e.g. the log family of commands),
> > we do assume people do not store random binary byte sequences in commits,
> > and we do take advantage of that assumption by splitting each "line" at
> > LF, indenting them with 4 spaces, etc. In other words, a commit log in the
> > Git context _is_ pretty much text and not arbitrary byte sequence.
> 
> Think what would cutting at a byte whose value is 012 and adding four
> bytes whose values are 040 to each of "lines" that formed with such
> cutting do to UTF-16 goo, even if it does not contain any NUL byte. As far
> as Git Porcelains are concerned, it is no different from random binary
> byte sequences.

But as Duy mentions, we have an encoding header. Shouldn't we treat it
like binary goo until we do reencode_log_message, and _then_ we can
break it into lines?

-Peff
