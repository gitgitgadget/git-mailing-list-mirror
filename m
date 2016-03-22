From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 7/7] git: submodule honor -c credential.* from command
 line
Date: Tue, 22 Mar 2016 15:23:10 -0400
Message-ID: <20160322192309.GA9782@sigill.intra.peff.net>
References: <1456786715-24256-1-git-send-email-jacob.e.keller@intel.com>
 <1456786715-24256-8-git-send-email-jacob.e.keller@intel.com>
 <20160322185628.GA19993@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 20:23:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiRte-0002FK-Jc
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 20:23:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbcCVTXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 15:23:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:36066 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750770AbcCVTXO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 15:23:14 -0400
Received: (qmail 14067 invoked by uid 102); 22 Mar 2016 19:23:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 22 Mar 2016 15:23:12 -0400
Received: (qmail 17071 invoked by uid 107); 22 Mar 2016 19:23:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 22 Mar 2016 15:23:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Mar 2016 15:23:10 -0400
Content-Disposition: inline
In-Reply-To: <20160322185628.GA19993@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289545>

On Tue, Mar 22, 2016 at 11:56:28AM -0700, Jonathan Nieder wrote:

> This is failing for me when I use "git submodule add" with a remote
> helper I whitelisted with GIT_ALLOW_PROTOCOL, with current "next":
> 
>  $ bin-wrappers/git submodule add persistent-https://kernel.googlesource.com/pub/scm/git/git sm
>  Cloning into 'sm'...
>  error: bogus format in GIT_CONFIG_PARAMETERS
>  fatal: unable to parse command-line config
>  fatal: clone of 'persistent-https://kernel.googlesource.com/pub/scm/git/git' into submodule path 'sm' failed
> 
> sq_dequote_to_argv doesn't like the space at the beginning of
> $GIT_CONFIG_PARAMETERS.  Reverting 14111fc4 fixes it.  Known
> problem?

It's known that the parsing end is excessively picky, but not this
particular bug. I found the problem; I'll have a patch out in a few
minute after I write a test.

-Peff
