From: Jeff King <peff@peff.net>
Subject: Re: Parse --o in format-patch
Date: Fri, 28 Jun 2013 12:49:59 -0400
Message-ID: <20130628164959.GC9127@sigill.intra.peff.net>
References: <20130628160459.GA16832@paksenarrion.iveqy.com>
 <20130628163153.GA9127@sigill.intra.peff.net>
 <20130628164440.GA21354@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Fri Jun 28 18:50:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Usbsc-0003HG-5U
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 18:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755866Ab3F1Qub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 12:50:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:49663 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754638Ab3F1QuD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 12:50:03 -0400
Received: (qmail 9629 invoked by uid 102); 28 Jun 2013 16:51:10 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Jun 2013 11:51:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Jun 2013 12:49:59 -0400
Content-Disposition: inline
In-Reply-To: <20130628164440.GA21354@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229214>

On Fri, Jun 28, 2013 at 06:44:40PM +0200, Fredrik Gustafsson wrote:

> On Fri, Jun 28, 2013 at 12:31:53PM -0400, Jeff King wrote:
> > It's possible to have an "optional" argument by using the
> > PARSE_OPT_OPTARG flag. However, it is not backwards compatible from the
> > user's perspective, as they must use the "sticked" form:
> 
> That would be a possibility but I don't like breaking backwards
> compability.

Yes, I did not say it outright, but I meant "...and that is why we
cannot go that route." :)

> my goal is to make:
>        git format-patch [-k] [(-o|--output-directory) <dir> | --stdout] [ <since> | <revision range> ]
> to be:
>        git format-patch [-k] [(-o|--output-directory) [dir] | --stdout] [ <since> | <revision range> ]
> 
> that would do:
> git format patch -> current dir
> git format patch -o -> default dir (for example GIT_DIR/.outgoing/)
> git format patch -o <dir> -> user defined <dir>

Ah, that makes much more sense to me.

> But I guess I would need a new option instead. Something like
> --default-output-dir.

It depends on how the default is specified. Is it hard-coded? Or do you
specify format.outputDirectory? If the latter, I would think you would
want it on all the time when "-o" is not given[1], and no new option is
required. Otherwise, yes, I'd think you would want a new option.

-Peff

[1] format-patch may be considered plumbing, in which case an output
    directory config option might cause problems with scripts that
    expect to run it and find the output in the current directory. I'm
    not sure how big a deal that is.
