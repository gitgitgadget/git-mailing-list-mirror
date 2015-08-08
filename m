From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] sha1_file.c: rename move_temp_to_file() to
 finalize_temp_file()
Date: Sat, 8 Aug 2015 05:12:22 -0400
Message-ID: <20150808091222.GA24707@sigill.intra.peff.net>
References: <xmqqh9oawrsy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 11:12:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZO0B8-00082P-HE
	for gcvg-git-2@plane.gmane.org; Sat, 08 Aug 2015 11:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932732AbbHHJMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2015 05:12:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:42432 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932497AbbHHJM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2015 05:12:29 -0400
Received: (qmail 436 invoked by uid 102); 8 Aug 2015 09:12:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Aug 2015 04:12:29 -0500
Received: (qmail 21567 invoked by uid 107); 8 Aug 2015 09:12:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Aug 2015 05:12:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Aug 2015 05:12:22 -0400
Content-Disposition: inline
In-Reply-To: <xmqqh9oawrsy.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275512>

On Fri, Aug 07, 2015 at 05:24:29PM -0700, Junio C Hamano wrote:

> Since 5a688fe4 ("core.sharedrepository = 0mode" should set, not
> loosen, 2009-03-25), we kept reminding ourselves:
> 
>     NEEDSWORK: this should be renamed to finalize_temp_file() as
>     "moving" is only a part of what it does, when no patch between
>     master to pu changes the call sites of this function.
> 
> without doing anything about it.  Let's do so.
> 
> The purpose of this function was not to move but to finalize.  The
> detail of the primarily implementation of finalizing was to link the
> temporary file to its final name and then to unlink, which wasn't
> even "moving".  The alternative implementation did "move" by calling
> rename(2), which is a fun tangent.

This is definitely a better name. But while we are touching the area, my
other pet peeve about this function is that it is really specific to
moving _object_ temp files around. It started life as static-local to
sha1-file.c, so not mentioning objects is OK, but when it became a
global, it's a bit confusing.

Maybe finalize_object_file() would be a better name?

-Peff
