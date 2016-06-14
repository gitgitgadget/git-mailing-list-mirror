From: Jeff King <peff@peff.net>
Subject: Re: I lost my commit signature
Date: Tue, 14 Jun 2016 03:58:24 -0400
Message-ID: <20160614075824.GB12563@sigill.intra.peff.net>
References: <CAGrdoOrrpc7OiU74fa-qpjLNxOtm4upAOAfWPG6VbWUjyE0C2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: ZhenTian <loooseleaves@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 09:58:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCjF4-00086t-FT
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 09:58:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbcFNH62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 03:58:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:54432 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750794AbcFNH61 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 03:58:27 -0400
Received: (qmail 12392 invoked by uid 102); 14 Jun 2016 07:58:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 03:58:27 -0400
Received: (qmail 25905 invoked by uid 107); 14 Jun 2016 07:58:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 03:58:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Jun 2016 03:58:24 -0400
Content-Disposition: inline
In-Reply-To: <CAGrdoOrrpc7OiU74fa-qpjLNxOtm4upAOAfWPG6VbWUjyE0C2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297271>

On Tue, Jun 14, 2016 at 03:50:43PM +0800, ZhenTian wrote:

> I commit with -S argument, and I got some output like this:
> 
> You need a passphrase to unlock the secret key for
> user: "Tian Zhen <tianzhen@honovation.com>"
> 4096-bit RSA key, ID 2EF2AD6E, created 2016-05-21
> 
> [master d107770] feat: mobile support free freight hint, closed #1417
>  8 files changed, 58 insertions(+), 29 deletions(-)
>  rewrite static/css/mobile.min.css (64%)
>
> but when I check git log with --show-signature, I can't find my sign.
> 
> my git is 2.4.8, and OS is Ubuntu 14.04.4

Here's a reproduction which should work (and does for me):

  $ git init
  $ echo content >file
  $ git add file
  $ git commit -m foo -S
  You need a passphrase to unlock the secret key for
  user: "Jeff King <peff@peff.net>"
  4096-bit RSA key, ID F9430ED9, created 2016-02-03 (main key ID D7B337A8)

  [master (root-commit) 6b0b230] foo
   1 file changed, 1 insertion(+)
   create mode 100644 file

  $ git log --show-signature
  commit 6b0b230c79f8912bf8b21afc0d12d2cbf54cc74d (HEAD -> master)
  gpg: Signature made Tue 14 Jun 2016 03:55:11 AM EDT using RSA key ID F9430ED9
  gpg: Good signature from "Jeff King <peff@peff.net>"
  gpg:                 aka "Jeff King <peff@github.com>"
  Author: Jeff King <peff@peff.net>
  Date:   Tue Jun 14 03:55:11 2016 -0400

      foo

Does something similar work for you? If so, then we need to figure out
what happened in your original case. Can you show the exact commands you
ran, and what they did output?

If the simple case above doesn't work, then we need to figure out
whether the commit doesn't get a signature, or whether "log
--show-signature" is not working on your system. For the former, I'd try
"git cat-file commit HEAD", which should show the encoded signature
block. If it's there, then presumably something is not working in
calling gpg.

-Peff
