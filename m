From: Jeff King <peff@peff.net>
Subject: Re: Behavior of git rm
Date: Thu, 4 Apr 2013 15:02:11 -0400
Message-ID: <20130404190211.GA15912@sigill.intra.peff.net>
References: <1365000624535-7581485.post@n2.nabble.com>
 <20130403155841.GA16885@sigill.intra.peff.net>
 <7vli8z5xfr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: jpinheiro <7jpinheiro@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 21:02:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNpQu-0002ac-A7
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 21:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764093Ab3DDTCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 15:02:20 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56206 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764066Ab3DDTCS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 15:02:18 -0400
Received: (qmail 5087 invoked by uid 107); 4 Apr 2013 19:04:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Apr 2013 15:04:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2013 15:02:11 -0400
Content-Disposition: inline
In-Reply-To: <7vli8z5xfr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220067>

On Wed, Apr 03, 2013 at 10:35:52AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Of the two situations, I think the first one is less likely to be
> > destructive (noticing that a file is already gone via ENOTDIR), as we
> > are only proceeding with the index deletion, and we end up not touching
> > the filesystem at all.
> 
> Nice to see sound reasoning.

Here's a patch series which I think covers what we've discussed.

  [1/3]: rm: do not complain about d/f conflicts during deletion
  [2/3]: t3600: test behavior of reverse-d/f conflict
  [3/3]: t3600: test rm of path with changed leading symlinks

The first one is the code change, and the rest just documents the cases
we discussed.

The third one is a little subtle. For the most part is it just testing
the normal "changed content requires --force" behavior of rm. But I
think it is worth having because it also makes sure that after deleting
"d/f" when "d" is a symlink to "e", that we do not remove the new
directory "e" nor the symlink "d". I do not think this case was
explicitly planned for, but it does do the right thing now, and given
the subtlety, I'd rather somebody who changes it notice the breakage in
the test suite.

-Peff
