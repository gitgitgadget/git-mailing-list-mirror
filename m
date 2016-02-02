From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Identify where a Git config is defined
Date: Tue, 2 Feb 2016 05:15:51 -0500
Message-ID: <20160202101551.GA17349@sigill.intra.peff.net>
References: <3226E251-73F9-4410-84DE-49C8FFAD92EB@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Users <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 11:22:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQY5w-0002qa-JH
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 11:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754407AbcBBKV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 05:21:56 -0500
Received: from cloud.peff.net ([50.56.180.127]:36032 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754294AbcBBKVz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 05:21:55 -0500
Received: (qmail 13044 invoked by uid 102); 2 Feb 2016 10:21:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Feb 2016 05:21:55 -0500
Received: (qmail 12044 invoked by uid 107); 2 Feb 2016 10:15:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Feb 2016 05:15:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Feb 2016 05:15:51 -0500
Content-Disposition: inline
In-Reply-To: <3226E251-73F9-4410-84DE-49C8FFAD92EB@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285247>

On Tue, Feb 02, 2016 at 10:27:06AM +0100, Lars Schneider wrote:

> Using "git config --list" shows me all configs but sometimes I have a
> hard time to figure out where a certain config is defined. This is
> especially true on Windows as I found the system config in various
> places. I wonder if other people would find it useful to enable
> something like "git config --list --print-source" where every config
> value is printed with the file where it originates from.

We discussed this exact thing a while ago, and it looks like I started
on a patch, but didn't pursue it much further. There's some discussion
in there if you are interested in designing such a feature:

  http://thread.gmane.org/gmane.comp.version-control.git/190027/focus=190267

It looks like I tweaked it at some point, and I've been carrying this in
my tree (rebasing forward and using it in my normal build):

  git fetch git://github.com/peff/git jk/config-sources

Feel free to use it as a starting point if that's helpful. I don't
recall offhand how close it is to ready.

> If I read the source correctly this would mean I would need to change
> "config_fn_t" to pass not only key and value but also the config
> source file in addition. Since "config_fn_t" is used in many places
> this would be a big change that probably is not worth the effort?!

There's a global struct for the current config file.  In the patches
above, I just added an accessor function. Hooray for single-threaded
programs.

> Alternatively I was thinking about "git config --print-source-files"
> to print all config files that Git would parse. This would already
> help to find the configs and would probably be a smaller change.

I think the "--sources" option is more useful, because it can show
included files, too.

-Peff
