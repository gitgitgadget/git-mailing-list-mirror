From: Jeff King <peff@peff.net>
Subject: Re: git submodule should honor "-c credential.helper" command line
 argument
Date: Tue, 2 Feb 2016 23:25:55 -0500
Message-ID: <20160203042554.GA21179@sigill.intra.peff.net>
References: <56B0E3AA.30804@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Marc Strapetz <marc.strapetz@syntevo.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 05:26:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQp0z-0007B3-Ug
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 05:26:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755701AbcBCEZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 23:25:58 -0500
Received: from cloud.peff.net ([50.56.180.127]:36530 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755612AbcBCEZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 23:25:57 -0500
Received: (qmail 31226 invoked by uid 102); 3 Feb 2016 04:25:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Feb 2016 23:25:57 -0500
Received: (qmail 20926 invoked by uid 107); 3 Feb 2016 04:25:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Feb 2016 23:25:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Feb 2016 23:25:55 -0500
Content-Disposition: inline
In-Reply-To: <56B0E3AA.30804@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285328>

On Tue, Feb 02, 2016 at 06:13:14PM +0100, Marc Strapetz wrote:

> git -c credential.helper=helper submodule update --init submodule
> 
> does not invoke "helper", but falls back to the default strategies.
> When configuring in ~/.gitconfig:
> 
> [credential]
>   helper=helper
> 
> git submodule update --init submodule
> 
> works fine. This behavior is somewhat unexpected -- is this a bug or by
> intention? In case intention, what's the recommended way to "inject"
> credentials helpers to work on submodules without modifying Git's config
> files?
> 
> Tested with Git 2.5.0 (Windows).

I think the problem is that when git "switches" to working in the
submodule repository, it clears the environment, which includes any "-c"
command switches. This makes sense for some situations, but not for
others. This thread shows a similar problem:

  http://thread.gmane.org/gmane.comp.version-control.git/264840

Jens suggested there adding an option to tell clone to pass specific
variables to the submodule, which I think makes sense. AFAIK, nobody has
done any work yet on that approach.

-Peff
