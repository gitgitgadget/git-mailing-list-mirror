From: Jeff King <peff@peff.net>
Subject: Re: I lost my commit signature
Date: Tue, 14 Jun 2016 05:41:21 -0400
Message-ID: <20160614094121.GA13971@sigill.intra.peff.net>
References: <CAGrdoOrrpc7OiU74fa-qpjLNxOtm4upAOAfWPG6VbWUjyE0C2Q@mail.gmail.com>
 <20160614075824.GB12563@sigill.intra.peff.net>
 <CAGrdoOp=dDkiTr+Sb-uZWx66b4hoZCYAiRjfgYqoE8H4-kXJvg@mail.gmail.com>
 <20160614081854.GA13457@sigill.intra.peff.net>
 <CAGrdoOqfcacG488u-MA7UiapgvJEGNX2QaRq8BMmycEWg-BGWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: ZhenTian <loooseleaves@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 11:41:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCkqf-00043w-VL
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 11:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbcFNJlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 05:41:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:54466 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751701AbcFNJlY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 05:41:24 -0400
Received: (qmail 16654 invoked by uid 102); 14 Jun 2016 09:41:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 05:41:24 -0400
Received: (qmail 26606 invoked by uid 107); 14 Jun 2016 09:41:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 05:41:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Jun 2016 05:41:21 -0400
Content-Disposition: inline
In-Reply-To: <CAGrdoOqfcacG488u-MA7UiapgvJEGNX2QaRq8BMmycEWg-BGWg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297278>

On Tue, Jun 14, 2016 at 04:39:38PM +0800, ZhenTian wrote:

> I want to set gpg -v to pgp.program, but if I set it, it can't call gpg:
> ```
> error: cannot run gpg -v: No such file or directory
> error: could not run gpg.
> fatal: failed to write commit object
> ```
> 
> I have tried set gpg.program value to `gpg|/tmp/log`, `/usr/bin/gpg
> -v`, `gpg -v`, `"/usr/bin/gpg -v"`
> 
> only after I set to `gpg` or `/usr/bin/gpg` without any argument, it will work.

Ah, right. Most of the time we run such programs as shell commands, but
it looks like we do not. So you'd have to do something like:

	cat >/tmp/fake-gpg <<-\EOF
	#!/bin/sh
	gpg -v "$@"
	EOF
	chmod +x /tmp/fake-gpg
	git config gpg.program /tmp/fake-gpg

-Peff
