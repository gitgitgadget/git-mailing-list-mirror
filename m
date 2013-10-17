From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] doc: git-foo was obsoleted several years ago
Date: Wed, 16 Oct 2013 21:18:07 -0400
Message-ID: <20131017011807.GA14759@sigill.intra.peff.net>
References: <1379763429-3443-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq7gdc7v70.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 17 03:18:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWcEC-0001hm-7s
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 03:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761347Ab3JQBSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 21:18:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:50719 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760887Ab3JQBSK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 21:18:10 -0400
Received: (qmail 3893 invoked by uid 102); 17 Oct 2013 01:18:10 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 16 Oct 2013 20:18:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Oct 2013 21:18:07 -0400
Content-Disposition: inline
In-Reply-To: <xmqq7gdc7v70.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236287>

On Wed, Oct 16, 2013 at 02:38:27PM -0700, Junio C Hamano wrote:

> >  Documentation/git-checkout.txt | 4 ++--
> [...]
> I recall that I wanted to see this change happen myself long time
> ago, and suspect that there may have been some reason that prevented
> us from doing so.  I might have found that AsciiDoc back then did
> not like the input if the headline name "git-checkout(1)" did not
> match the filename "git-checkout.txt" and the command in the NAME
> section "git-checkout", or links "linkgit:git-checkout[1]" from
> other pages couldn't have SP there, or something silly like that.

Yes, I think it is still broken. After applying Felipe's patch:

  $ cd Documentation
  $ make git-checkout.1
      GEN cmd-list.made
      SUBDIR ../
  make[1]: `GIT-VERSION-FILE' is up to date.
      ASCIIDOC git-checkout.xml
      XMLTO git-checkout.1

So far, so good...

  $ man -l git-checkout.1
  man: git-checkout.1: No such file or directory

Huh?

  $ ls git?checkout.1
  git_checkout.1

Oh.

There is similar asciidoc (actually, I think it is docbook) cleverness
with:

  $ make gitignore.1
      GEN cmd-list.made
      SUBDIR ../
      make[1]: `GIT-VERSION-FILE' is up to date.
      XMLTO gitignore.1

  $ ls gitignore.[0-9]
  gitignore.5

Now obviously what I asked for is wrong (we do not actually know how to
make gitignore.1), but I have certainly been confused by this in the
past when working on pages outside of section 1.

In both cases, it would be nice if we could tell xmlto "no, really, put
the output in this file". I'm not sure that is an option, though,
because in theory docbook output may be multiple files (the "-o" option
actually specifies an output directory).

Since we know our manpages are a much simpler case, we could probably
work around it by teaching the Makefile that building "git-foo.txt"
generates git_foo.1, and then moving that to git-foo.1.

-Peff
