From: Jeff King <peff@peff.net>
Subject: Re: Parallel refactoring and git merge nightmare
Date: Thu, 12 Apr 2012 01:41:55 -0400
Message-ID: <20120412054155.GB27369@sigill.intra.peff.net>
References: <1334160803.74554.YahooMailNeo@web160603.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Pap =?utf-8?Q?L=C3=B4rinc?= <paplorinc@yahoo.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 07:42:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SICnD-0003w3-9C
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 07:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756586Ab2DLFl7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Apr 2012 01:41:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58280
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756522Ab2DLFl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 01:41:58 -0400
Received: (qmail 22678 invoked by uid 107); 12 Apr 2012 05:42:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Apr 2012 01:42:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Apr 2012 01:41:55 -0400
Content-Disposition: inline
In-Reply-To: <1334160803.74554.YahooMailNeo@web160603.mail.bf1.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195295>

On Wed, Apr 11, 2012 at 09:13:23AM -0700, Pap L=C3=B4rinc wrote:

> I think the=20
> problem arises because git doesn't track
>  moves, therefore I constantly get conflicts of type "local modified,=
=20
> remote deleted" (or even both deleted) when in fact it was only modif=
ied
>  and moved, it could have been merged without conflicts (-> apply my=20
> changes and move the file to the new location).

Git does rename detection at the time of merge, and will apply changes
to the destination file. I'm not sure why this isn't working for you.
Some theories:

  1. Git may give up on finding renames if it is very computationally
     expensive. It will print a warning in that case, but you may miss
     it in the output. You might try:

        git config merge.renamelimit 0

     to turn off the limiting.

  2. Do your files actually look like renames? Git's inexact rename
     detection looks at the file content, and correlates removed and
     added files that have a high percentage of similar content. If mos=
t
     of the file ended up changed, then the pair is not considered a
     rename.

-Peff
