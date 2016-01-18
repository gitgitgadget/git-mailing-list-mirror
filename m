From: Jeff King <peff@peff.net>
Subject: Re: Don't use PGP/GPG signatures in mail that contains patches
Date: Mon, 18 Jan 2016 16:48:58 -0500
Message-ID: <20160118214857.GA24136@sigill.intra.peff.net>
References: <569C3F73.3090805@pb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Andrey Utkin <andrey.utkin@pb.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 22:49:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLHfd-0008Kj-UL
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 22:49:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbcARVtC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 16:49:02 -0500
Received: from cloud.peff.net ([50.56.180.127]:55704 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756597AbcARVtA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 16:49:00 -0500
Received: (qmail 6494 invoked by uid 102); 18 Jan 2016 21:49:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 16:49:00 -0500
Received: (qmail 14267 invoked by uid 107); 18 Jan 2016 21:49:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 16:49:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jan 2016 16:48:58 -0500
Content-Disposition: inline
In-Reply-To: <569C3F73.3090805@pb.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284327>

On Mon, Jan 18, 2016 at 03:27:15AM +0200, Andrey Utkin wrote:

> ===== QUOTE =====
> Don't use PGP/GPG signatures in mail that contains patches.
> This breaks many scripts that read and apply the patches.
> (This should be fixable.)
> ===== END QUOTE =====
> 
> This is in Linux' Documentation/email-clients.txt since 2007, and still
> almost nobody signs patch submissions. There are few brave people who
> do, though, and seems it's not the end of world for any "scripts".
> The broken scripts could be an excuse in 2007, but not today.
> 
> Proposal:
> 1. Implement signing option in git-send-email.
> 2. Figure out if anything fails to interoperate.
> 3. Drop the quoted statement or change it to appreciate signing.

I don't know about other receiving scripts, but "git am" will handle
signed PGP-MIME out of the box (I didn't try it with inline signatures,
but I imagine it would stick the "BEGIN PGP MESSAGE" cruft into the
commit message).

However, there's an open question of what to _do_ with such a signature.
The email signature does not function as a valid git commit signature.
So you are left with one of:

  1. The receiver can verify the origin of the email before applying the
     patch.

  2. The receiver can keep a copy of the email "somewhere", so people
     can later re-verify it, and then hand-verify that it matches what
     got applied.

     That "somewhere" may just be a mailing list archive, but you could
     get fancy with scripts and associate it with the applied commit
     (e.g., using "git notes").

But those are really questions for the project. If you are mailing your
patches to Linus, does he actually care about (1)? My general impression
of his past opinion is that it's more important to read the patch text
than the "From" line. Of course subsystem maintainers and other projects
may have different opinions.

I think (2) is more compelling, if only to create a better record in the
mailing list archive. Assuming the receivers of your patches don't mind
(and I know some people really _don't_ like things like PGP-MIME,
because their mail readers are not good at replying in-line to the
patches then), I don't it would be a bad thing to teach git-send-email
an option to send it.

-Peff
