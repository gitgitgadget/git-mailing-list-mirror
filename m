From: Jeff King <peff@peff.net>
Subject: Re: Parse --o in format-patch
Date: Fri, 28 Jun 2013 12:31:53 -0400
Message-ID: <20130628163153.GA9127@sigill.intra.peff.net>
References: <20130628160459.GA16832@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Fri Jun 28 18:32:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Usbab-0003Gm-LF
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 18:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755398Ab3F1Qb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 12:31:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:49540 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754544Ab3F1Qb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 12:31:57 -0400
Received: (qmail 8784 invoked by uid 102); 28 Jun 2013 16:33:03 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Jun 2013 11:33:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Jun 2013 12:31:53 -0400
Content-Disposition: inline
In-Reply-To: <20130628160459.GA16832@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229211>

On Fri, Jun 28, 2013 at 06:05:00PM +0200, Fredrik Gustafsson wrote:

> I don't quite manage to figure out gits argv parsing and would need some
> help on the way.
> 
> I want:
> git format-patch -o outdir HEAD~
> 
> Work exactly the way it does now, setting output_directory to outdir.
> But I also want
> git format-patch -o HEAD~
> 
> to set output_directory with a NULL value so that I can assign a default
> value to it. Is that even possible with the current argv-parsing implementation?

It's possible to have an "optional" argument by using the
PARSE_OPT_OPTARG flag. However, it is not backwards compatible from the
user's perspective, as they must use the "sticked" form:

  git format-patch -ooutdir ...

to specify the argument. Otherwise, it is not clear in:

  git format-patch -o outdir HEAD~

whether "outdir" is the argument to "-o", or if it is simply the next
argument.

However, if you are just interested in "turning off" a previously given
argument, we usually spell that with the "--no-" prefix to the long
option (e.g., "--no-output-directory" in this case).

I'm not clear how that interacts with your example, though. Your example
tries to use "-o" to set output_directory to NULL. But it is already
NULL if you do not specify any "-o" at all.

-Peff
