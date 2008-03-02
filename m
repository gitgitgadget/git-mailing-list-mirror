From: Jeff King <peff@peff.net>
Subject: Re: Redefine semantics of find_unique_abbrev()
Date: Sun, 2 Mar 2008 02:42:30 -0500
Message-ID: <20080302074230.GD3935@coredump.intra.peff.net>
References: <7vpruf9q5a.fsf@gitster.siamese.dyndns.org> <20080301050641.GB8969@coredump.intra.peff.net> <7vd4qdtw7k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 08:43:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JViqi-0002r6-RY
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 08:43:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbYCBHmd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 02:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbYCBHmc
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 02:42:32 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1750 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752070AbYCBHmc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 02:42:32 -0500
Received: (qmail 5220 invoked by uid 111); 2 Mar 2008 07:42:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 02 Mar 2008 02:42:31 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Mar 2008 02:42:30 -0500
Content-Disposition: inline
In-Reply-To: <7vd4qdtw7k.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75742>

On Sat, Mar 01, 2008 at 11:35:11PM -0800, Junio C Hamano wrote:

> That is, "for objects we have, make sure it uniquely identifies,
> otherwise, make sure the phoney name is long enough such that it would not
> name any existing object".

I think your logic is correct, and I think naming it 'exists' is more
readable (I don't have a tendency not to double-negate).

But...

> -		if (!status ||
> -		    (is_null && status != SHORT_NAME_AMBIGUOUS)) {
> +		if (exists
> +		    ? !status
> +		    : status == SHORT_NAME_NOT_FOUND) {
>  			hex[len] = 0;
>  			return hex;
>  		}

Maybe it is just me, but I find the ternary operator here reduces
readability. I would have liked the more verbose:

  if ((exists && !status) ||
      (!exists && status == SHORT_NAME_NOT_FOUND)) {

But now I am just painting your bikeshed.

-Peff
