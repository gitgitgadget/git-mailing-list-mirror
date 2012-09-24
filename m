From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] git: expand user path in --git-dir
Date: Mon, 24 Sep 2012 10:52:08 -0400
Message-ID: <20120924145208.GB10349@sigill.intra.peff.net>
References: <5060588D.3080202@drmicha.warpmail.net>
 <fdeaa78c0a520ce80e6d2cb09978dab348104eaf.1348491039.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Sep 24 16:52:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGA1H-0005mN-Hs
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 16:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755717Ab2IXOwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 10:52:14 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56970 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754031Ab2IXOwO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 10:52:14 -0400
Received: (qmail 32130 invoked by uid 107); 24 Sep 2012 14:52:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Sep 2012 10:52:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Sep 2012 10:52:08 -0400
Content-Disposition: inline
In-Reply-To: <fdeaa78c0a520ce80e6d2cb09978dab348104eaf.1348491039.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206279>

On Mon, Sep 24, 2012 at 02:57:20PM +0200, Michael J Gruber wrote:

> Currently, all paths in the config file are subject to tilde expansion
> for user paths while the argument to --git-dir is not expanded, and
> neither are paths in the environment such as GIT_DIR. From the user
> perspective, though, the two commands
> 
> GIT_DIR=~user/foo git command
> git --git-dir=~user/foo command
> 
> currently behave differently because in the first case the shell would
> perform tilde expansion, but not in the second. Also, one may argue that
> specifying '--git-dir=' is like specifying a config variable (which
> cannot exist for this purpose).
> 
> Thus, make arguments to '--git-dir' undergo tilde expansion.
> ---
> So, here's a simple patch implementing tilde expansion for --git-dir. It passes
> all tests. It's done doing the expansion on the setting side.
> 
> Alternatively, one might do it on the getting side, i.e. when reading GIT_DIR,
> so that paths passed directly through the environment undergo tilde expansion
> as well. We don't do this for any environment variable yet, so I didn't go
> that far.

Keep in mind that every layer of expansion you add is a layer of quoting
somebody else must do in order to pass through certain paths.  I will
admit that putting a "~" into a path is relatively uncommon, but this
patch is a regression for anybody who does so with --git-dir (they will
now need to quote the "~" against not just their shell, but against
git). Expanding environment variables like GIT_DIR means that we would
also need to quote things we put into GIT_DIR.

-Peff
