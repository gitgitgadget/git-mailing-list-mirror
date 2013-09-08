From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/3] index-pack: add --unpack-limit to unpack objects
Date: Sun, 8 Sep 2013 00:44:17 -0400
Message-ID: <20130908044417.GD14019@sigill.intra.peff.net>
References: <1378091107-31682-1-git-send-email-pclouds@gmail.com>
 <1378428363-14086-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 06:44:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIWrJ-0002Sm-75
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 06:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379Ab3IHEoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 00:44:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:42194 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023Ab3IHEoU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 00:44:20 -0400
Received: (qmail 32172 invoked by uid 102); 8 Sep 2013 04:44:20 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 07 Sep 2013 23:44:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Sep 2013 00:44:17 -0400
Content-Disposition: inline
In-Reply-To: <1378428363-14086-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234178>

On Fri, Sep 06, 2013 at 07:46:01AM +0700, Nguyen Thai Ngoc Duy wrote:

> ---
>  I had something that could unpack without writing to temp pack file
>  but I scraped it and chose this way because it follows closely how
>  index-pack works. It's a good thing imo because .pack v4 is coming
>  and I don't know how v4 may impact this unpack code path. Once things
>  are settled, we can revisit and open a separate code path if it's
>  still a good idea.

>From a cursory read, this seems fine. If it were done in complete
isolation, I'd say it was a slight regression, just because we are doing
more I/O for the unpack case, and it is not really saving us any code
(it is not like we can throw away unpack-objects, as I think we would
want to keep it as a last resort for getting data out of malformed or
otherwise non-indexable packs).

But I can also see it making pack v4 handling easier. So it would make
sense to me to put it at the start of a series adding pack v4 indexing.
By the end of the series you would be able to see the benefits of the
reduced code complexity. Until then, it is a "probably this will help
later" change.

-Peff
