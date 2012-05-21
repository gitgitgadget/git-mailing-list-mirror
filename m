From: Jeff King <peff@peff.net>
Subject: [PATCHv2 0/15] ident cleanups git_default_name
Date: Mon, 21 May 2012 19:09:17 -0400
Message-ID: <20120521230917.GA474@sigill.intra.peff.net>
References: <20120518230528.GA30510@sigill.intra.peff.net>
 <20120518231933.GH30031@sigill.intra.peff.net>
 <7v7gw69rbz.fsf@alter.siamese.dyndns.org>
 <20120521063145.GB2077@sigill.intra.peff.net>
 <7v396t99up.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 22 01:09:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWbjB-00064w-NX
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 01:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577Ab2EUXJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 19:09:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51189
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751586Ab2EUXJU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 19:09:20 -0400
Received: (qmail 7618 invoked by uid 107); 21 May 2012 23:09:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 May 2012 19:09:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 May 2012 19:09:17 -0400
Content-Disposition: inline
In-Reply-To: <7v396t99up.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198145>

On Mon, May 21, 2012 at 02:11:58AM -0700, Junio C Hamano wrote:

> > So I think my preference would be:
> >
> >   - apply the patch below as 5.5/13
> >
> >   - tweak patch 9 to remove the extra trimming
> >
> >   - add a patch 14 to call strbuf_trim on the name and email buffers
> >     after reading them from system files.
> 
> Sounds sensible; thanks.

Here's the whole series again. Most of it is unchanged, but given the
ordering problem earlier, it seems reasonable to just post it all again.

  [01/15]: ident: split setup_ident into separate functions
  [02/15]: http-push: do not access git_default_email directly
  [03/15]: fmt-merge-msg: don't use static buffer in record_person
  [04/15]: move identity config parsing to ident.c
  [05/15]: move git_default_* variables to ident.c
  [06/15]: ident: trim trailing newline from /etc/mailname

  This one is new and fixes the t4014 failure. The earlier version I
  posted trimmed all trailing whitespace, but there's not much point in
  being thorough, since this code gets removed later, anyway.

  [07/15]: format-patch: use default email for generating message ids
  [08/15]: fmt_ident: drop IDENT_WARN_ON_NO_NAME code
  [09/15]: ident: don't write fallback username into git_default_name
  [10/15]: drop length limitations on gecos-derived names and emails

  This one drops the new code from patch 6, as it is pointless with
  strbufs. I considered reordering the patches to avoid patch 6
  altogether, but there is a circular dependency with getting rid of the
  WARN case in patch 8.

  [11/15]: ident: report passwd errors with a more friendly message
  [12/15]: ident: use full dns names to generate email addresses
  [13/15]: ident: use a dynamic strbuf in fmt_ident
  [14/15]: ident: trim whitespace from default name/email

  This one is new, and actually does a good job of trimming unnecessary
  whitespace (from both the front and back, and from both name and
  email).

  [15/15]: format-patch: refactor get_patch_filename

-Peff
