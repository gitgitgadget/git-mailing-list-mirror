From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/8] Makefile: introduce SANE_TOOL_PATH for prepending
	required elements to PATH
Date: Mon, 8 Jun 2009 07:43:51 -0400
Message-ID: <20090608114351.GA13775@coredump.intra.peff.net>
References: <7vk53vlxhz.fsf@alter.siamese.dyndns.org> <67hZHClrEWQHxCRdWosE25_CVQVNIYpTaeW2DKuCCDfW4h-jHQ82zlGcCNn49KcxUKsj-TSJSVQ@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE24eNsO0do05033zPcGsXrwIRCoU8GtXor_XD8ayKlybu-V7PGeTC_PA@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE21Y219yACHqb_DoUmykc1kiOxwRuziSDMczTdmGkyEob9g6DVoIraR4@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE24FbCSWPktK230jx86LzLj0Aqa5g5XoJb3Iv805pzfx5wCPameuSp6M@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE28bOBU_EdMUdyv6uENKCaQfOLQjhGBq3kLwxe6mMrfW4HauaUwWt5eM@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE26gwuGblUI8bcWLxyoPZhmfzJAibRVMtix-zkRUKYe5Y8R8-GRcIkUI@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE2-yxscBzIn8DiQogVPM7EAgcGyYg61V8vYLxFiW6A4ovZp6SOuP0pDM@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE2_PLKo8HHFSCQIZrHM
 fucFNo_Bdy4p79XNP-MU8gnsUflWndiCqfhFM@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Jun 08 13:44:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDdGr-0005Vv-17
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 13:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754686AbZFHLoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 07:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754663AbZFHLn7
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 07:43:59 -0400
Received: from peff.net ([208.65.91.99]:47020 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754620AbZFHLn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 07:43:58 -0400
Received: (qmail 21165 invoked by uid 107); 8 Jun 2009 11:44:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 08 Jun 2009 07:44:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Jun 2009 07:43:51 -0400
Content-Disposition: inline
In-Reply-To: <67hZHClrEWQHxCRdWosE2_PLKo8HHFSCQIZrHMfucFNo_Bdy4p79XNP-MU8gnsUflWndiCqfhFM@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121063>

On Fri, Jun 05, 2009 at 06:36:15PM -0500, Brandon Casey wrote:

> From: Junio C Hamano <gitster@pobox.com>
> 
> Some platforms (like SunOS and family) have kept their common binaries at
> some historical moment in time, and introduced new binaries with modern
> features in a special location like /usr/xpg4/bin or /usr/ucb.  Some of the
> features provided by these modern binaries are expected and required by git.
> If the featureful binaries are not in the users path, then git could end up
> using the less featureful binary and fail.
> 
> So provide a mechanism to prepend elements to the users PATH at runtime so
> the modern binaries will be found.

So this bit me already, and it's only been in next for a day. :) I
_already_ have /usr/xpg4/bin in my PATH before /usr/bin, but with this
patch, I get it stuck at the _beginning_ of my PATH automagically. Which
overrides, against my wishes, the "even more sane than /usr/xpg4/bin"
part of my PATH that comes at the beginning.

Specifically, I have "~peff/local/bin" at the beginning of my PATH which
contains a 'vi' that points to vim. Running "git rebase -i" now puts
/usr/xpg4/bin at the beginning of the PATH (before ~peff/local/bin),
which means I end up running the crappy system vi instead. For bonus
fun, "git commit" still runs the correct 'vi' because it doesn't happen
to be implemented as a shell script.

Am I crazy for not having EDITOR=vim instead of EDITOR=vi? Perhaps. But
I wanted to point out that tweaking the PATH behind the user's back does
cause surprises in the real world.

-Peff
