From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git commit --allow-empty-message -m '' fails
Date: Fri, 1 May 2015 21:06:06 -0400
Message-ID: <20150502010605.GA5634@peff.net>
References: <CANuW5x0eKVAToG76rJr6+n-Fdg7E5c8mHb8NvnQUT2PBzxjjPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Josh Hagins <hagins.josh@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 02 03:06:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoLsr-0007gU-73
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 03:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbbEBBGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 21:06:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:53163 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751385AbbEBBGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 21:06:09 -0400
Received: (qmail 2507 invoked by uid 102); 2 May 2015 01:06:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 20:06:09 -0500
Received: (qmail 2811 invoked by uid 107); 2 May 2015 01:06:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 21:06:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 May 2015 21:06:06 -0400
Content-Disposition: inline
In-Reply-To: <CANuW5x0eKVAToG76rJr6+n-Fdg7E5c8mHb8NvnQUT2PBzxjjPQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268205>

On Fri, May 01, 2015 at 07:31:08PM -0400, Josh Hagins wrote:

> When passed the `--allow-empty-message` flag with no `-m`, `git
> commit` will open the editor and allow you to exit with an empty
> message, as expected.
> 
> However, when passed `-m ''` in addition to `--allow-empty-message`,
> the commit fails. Example below:
> 
>     $ git commit -a --allow-empty-message -m ''
>     error: switch `m' requires a value
>     usage: git commit [<options>] [--] <pathspec>...
>     ...
> 
> Shouldn't the `-m` switch know whether the `--allow-empty-message`
> flag has been passed?

It should. It works here for me:

  $ git commit --allow-empty --allow-empty-message -m ''
  [master 2957ea1]

The message you're seeing comes from the option-parser, which thinks
there isn't any argument to `-m` at all. I can get the same result like:

  $ git commit --allow-empty --allow-empty-message -m
  error: switch `m' requires a value
  ...

Are you running the command inside another bit of shell script that
might be eating the empty argument (e.g., eval-ing it inside of another
set of single quotes or something like that)?

-Peff
