From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pretty.c: make git_pretty_formats_config return -1 on
 git_config_string failure
Date: Mon, 4 Aug 2014 16:33:51 -0400
Message-ID: <20140804203351.GA12898@peff.net>
References: <1407163275-3006-1-git-send-email-tanayabh@gmail.com>
 <vpqmwbki7h3.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 04 22:34:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEOxD-0000oC-Ew
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 22:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbaHDUdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 16:33:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:45831 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751328AbaHDUdy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 16:33:54 -0400
Received: (qmail 25282 invoked by uid 102); 4 Aug 2014 20:33:54 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 04 Aug 2014 15:33:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Aug 2014 16:33:51 -0400
Content-Disposition: inline
In-Reply-To: <vpqmwbki7h3.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254777>

On Mon, Aug 04, 2014 at 05:45:44PM +0200, Matthieu Moy wrote:

> Tanay Abhra <tanayabh@gmail.com> writes:
> 
> > `git_pretty_formats_config()` continues without checking git_config_string's
> > return value which can lead to a SEGFAULT.
> 
> Indeed, without the patch:
> 
> $ git -c pretty.my= log --pretty=my                        
> error: Missing value for 'pretty.my'                         
> zsh: segmentation fault  git -c pretty.my= log --pretty=my

Hmm. Not related to the original patch, but that really looks like a
bug. Shouldn't "git -c pretty.my= ..." set pretty.my to the empty string?

I'd expect "git -c pretty.my ..." to set it to NULL (i.e., the "implicit
true" you get from omitting the "=" in the config files themselves).

-Peff
