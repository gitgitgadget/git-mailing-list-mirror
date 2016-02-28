From: Jeff King <peff@peff.net>
Subject: Re: Fwd: git clone does not respect command line options
Date: Sun, 28 Feb 2016 00:01:13 -0500
Message-ID: <20160228050113.GA19131@sigill.intra.peff.net>
References: <CAMDzUtzoiJWzckTX818HJV=su0eEP35gsNDJ=+k_me08EDvxRg@mail.gmail.com>
 <CAMDzUtxQPMty0Nncr7Yj3up6Zb6F-E0QudOMOZO_jG-Goq0YBg@mail.gmail.com>
 <20160226073444.GA26340@sigill.intra.peff.net>
 <xmqqegbzl86d.fsf@gitster.mtv.corp.google.com>
 <CAMDzUtxnSeTrfBWWqeOVQm30x5nE6fC9LSx=YNSws2h24TmchQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Guilherme <guibufolo@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 06:01:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZtTu-0006M5-8C
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 06:01:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbcB1FBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 00:01:17 -0500
Received: from cloud.peff.net ([50.56.180.127]:50896 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750713AbcB1FBR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 00:01:17 -0500
Received: (qmail 26932 invoked by uid 102); 28 Feb 2016 05:01:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 28 Feb 2016 00:01:16 -0500
Received: (qmail 16671 invoked by uid 107); 28 Feb 2016 05:01:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 28 Feb 2016 00:01:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Feb 2016 00:01:13 -0500
Content-Disposition: inline
In-Reply-To: <CAMDzUtxnSeTrfBWWqeOVQm30x5nE6fC9LSx=YNSws2h24TmchQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287742>

On Sun, Feb 28, 2016 at 09:03:43AM +0530, Guilherme wrote:

> What is the current situation if credential.helper is set twice in the same
> config file.
> 
> Either
> [credential]
>   helper = first
>   helper = second
> 
> or with
> [credential]
>   helper = first
> 
> [credenital]
>   helper = second
> 
> Will both be used by git clone?

Yes, both are used, as documented in gitcredentials(7).

> How do i remove these from the command line?
> I tried git config --unset credential.helper but that only gives you a
> warning and does not remove any.

Try --unset-all.

Also make sure you tell "git config" to operate on the file that
actually contains them. In v2.8.0-rc0 (but not in any released version),
we have --show-origin, and you can do:

  $ git config --show-origin --get-all credential.helper
  file:/home/peff/.gitconfig      cache
  file:.git/config        first
  file:.git/config        second

Write operations work on .git/config by default; if the entries are in
your ~/.gitconfig, use "--global --unset-all".

> Worse is that if second is the empty string there is no way for one to know
> there is a second set unless he tries to delete the first one. But one
> still cannot query the value of the second.

Try --get-all, which will print all values for a key (you can also use
--get-regexp if you want to find other credential.* keys).

-Peff
