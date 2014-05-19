From: Jeff King <peff@peff.net>
Subject: Re: Git showing tags in logs when it shouldn't
Date: Mon, 19 May 2014 10:53:33 -0400
Message-ID: <20140519145333.GB20289@sigill.intra.peff.net>
References: <CAHd499Dx8aZVm0yr7bSo2JTsmJt0p_b2H64pmjCCZFQCVWfZKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 19 16:53:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmOwd-000499-QI
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 16:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754171AbaESOxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 10:53:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:55039 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752075AbaESOxf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 10:53:35 -0400
Received: (qmail 18796 invoked by uid 102); 19 May 2014 14:53:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 May 2014 09:53:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 May 2014 10:53:33 -0400
Content-Disposition: inline
In-Reply-To: <CAHd499Dx8aZVm0yr7bSo2JTsmJt0p_b2H64pmjCCZFQCVWfZKA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249581>

On Mon, May 19, 2014 at 08:17:07AM -0500, Robert Dailey wrote:

> I have run the following command:
> 
> log --graph --abbrev-commit --decorate --date=relative
> --format=format:'%C(bold blue)%h%C(reset)%x09%C(bold
> green)(%ar)%C(reset)%C(bold yellow)%d%C(reset) %C(dim
> white)%an%C(reset) - %C(white)%s%C(reset)'
> 
> After running this, I am seeing tag labels in the log graph. I believe
> these shouldn't be showing because the docs for --decorate state that
> refs/tags/ should not show. I'm also obviously not specifying --tags
> 
> Is this a bug? If not, what changes do I need to make? I only want to
> see branch labels, nothing else.

I assume the docs you are referring to are (from "git help log"):

  --no-decorate, --decorate[=short|full|no]
    Print out the ref names of any commits that are shown. If short is
    specified, the ref name prefixes refs/heads/, refs/tags/ and
    refs/remotes/ will not be printed. If full is specified, the full
    ref name (including prefix) will be printed. The default option is
    short.

The intent of that is to say that if we are in "short" mode, then for
any ref names we show, we will show them without their "refs/heads",
"refs/tags", or "refs/remotes" prefixes. Not that we will omit those
refs entirely (if you omitted those three, you would generally have
nothing left).

So no, it is not a bug, the code is working as intended. Patches welcome
for rewriting the documentation to make this more clear (I thought it
was pretty clear, but I believe you are the second person in the last
few weeks to misread it in exactly the same way, so it is not just you).

I don't think there is currently a way to specify exactly what you want.
Off the top of my head, it would be something like a
"--decorate-refs=<pattern>" option, which lets you specify which refs
are interesting (right now, we always decorate _all_ refs). But that
does not yet exist, and somebody would have to volunteer to implement
it.

-Peff
