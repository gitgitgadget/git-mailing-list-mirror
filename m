From: Jeff King <peff@peff.net>
Subject: Re: Best way to apply textconv to a working tree file
Date: Tue, 1 Jun 2010 13:04:27 -0400
Message-ID: <20100601170426.GC9702@sigill.intra.peff.net>
References: <a1ace6b77167a2ad4b4995e8c4d09761@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, diane.gasselin@ensimag.imag.fr,
	axel.bonnet@ensimag.imag.fr, matthieu.moy@grenoble-inp.fr
To: =?utf-8?Q?Cl=C3=A9ment?= Poulain <clement.poulain@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 01 19:04:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJUtK-00071N-Ov
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 19:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756775Ab0FAREc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 13:04:32 -0400
Received: from peff.net ([208.65.91.99]:49545 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751485Ab0FAREa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 13:04:30 -0400
Received: (qmail 32654 invoked by uid 107); 1 Jun 2010 17:04:36 -0000
Received: from adsl-99-133-187-56.dsl.bltnin.sbcglobal.net (HELO sigill.intra.peff.net) (99.133.187.56)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 01 Jun 2010 13:04:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Jun 2010 13:04:27 -0400
Content-Disposition: inline
In-Reply-To: <a1ace6b77167a2ad4b4995e8c4d09761@ensimag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148140>

On Tue, Jun 01, 2010 at 03:41:05PM +0200, Cl=C3=A9ment Poulain wrote:

> We are wondering what is the best way to do the textconv. Here are so=
me
> solutions we thought about:

One solution you didn't mention would be to do it all yourself:

  driver=3D`git check-attr diff "$file" | cut -d: -f3`
  textconv=3D`git config diff.$driver.textconv`
  $textconv <$file >$file.converted

This has the advantage of working with existing versions of git. The
downside is that it's more code (e.g., my parsing above is quite sloppy
and loose. Doing it right would be a few more lines).

=46urthermore, it doesn't use the textconv cache at all. For working tr=
ee
files, this might not matter (if you pull the sha1 out of the index,
though, you can still check the cache, and unchanged working tree files
are likely to be in the cache). But for blobs in general, the cache is
worth using.

-Peff
