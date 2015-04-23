From: Jeff King <peff@peff.net>
Subject: Re: Installing git binaries on a non-default directory (Ubuntu)
Date: Thu, 23 Apr 2015 16:17:18 -0400
Message-ID: <20150423201718.GB28338@peff.net>
References: <loom.20150410T183218-536@post.gmane.org>
 <xmqq7ftg4l73.fsf@gitster.dls.corp.google.com>
 <0CCD6BBA210ECA418BCD82271FCFD94C556A3CEA@EU-MBX-03.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Macario, Gianpaolo" <Gianpaolo_Macario@mentor.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 22:17:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlNYs-0007mJ-2O
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 22:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758114AbbDWURW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 16:17:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:49373 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754305AbbDWURV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2015 16:17:21 -0400
Received: (qmail 3630 invoked by uid 102); 23 Apr 2015 20:17:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Apr 2015 15:17:20 -0500
Received: (qmail 8631 invoked by uid 107); 23 Apr 2015 20:17:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Apr 2015 16:17:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Apr 2015 16:17:18 -0400
Content-Disposition: inline
In-Reply-To: <0CCD6BBA210ECA418BCD82271FCFD94C556A3CEA@EU-MBX-03.mgc.mentorg.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267708>

On Mon, Apr 13, 2015 at 11:10:51AM +0000, Macario, Gianpaolo wrote:

> Unfortunately it looks to me that the `--prefix=xxx` option provided
> to configure will be hardcoded to the path returned by 'git
> --exec-path', and I do not see how this may actually be made dependent
> on the directory where the binary tarball will be extracted.

Sorry for the late reply, but I just noticed this and happened to be
looking at RUNTIME_PREFIX issues recently.

You're right that no amount of --prefix or other settings can help you
with making binaries that are relocatable after the fact. You do need
something like RUNTIME_PREFIX, but as you found, it does not work very
well on Unix systems.

I do not know if there are other issues, but at least the _first_ issue
that must be dealt with is that git_extract_argv0_path may get a bare
name like "git", without its PATH. So you will have to compute the full
path to the binary in order to find the rest of the files.

There was some minor discussion here:

  http://thread.gmane.org/gmane.comp.version-control.git/267143/focus=267606

(see the notes after the commit message, and the response from
Jonathan).

I hope that helps.

-Peff
