From: Jeff King <peff@peff.net>
Subject: Re: Tiny bug report, interaction between alias and help
Date: Mon, 21 Jan 2008 22:43:29 -0500
Message-ID: <20080122034329.GA1271@coredump.intra.peff.net>
References: <20080119142750.GA9182@phenix.progiciels-bpi.ca> <20080119174146.GA3913@coredump.intra.peff.net> <fcaeb9bf0801200159k26303a18ned2eef8e6b5b65d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?Fran=E7ois?= Pinard <pinard@iro.umontreal.ca>,
	git mailing list <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 04:44:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHA3P-000102-Rw
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 04:44:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620AbYAVDnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 22:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752285AbYAVDnd
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 22:43:33 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3437 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752079AbYAVDnc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 22:43:32 -0500
Received: (qmail 30659 invoked by uid 111); 22 Jan 2008 03:43:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 21 Jan 2008 22:43:30 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Jan 2008 22:43:29 -0500
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0801200159k26303a18ned2eef8e6b5b65d2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71412>

On Sun, Jan 20, 2008 at 04:59:13PM +0700, Nguyen Thai Ngoc Duy wrote:

> I've been hit by this and came up with a similar approach as well. But
> I dropped it because it made aliases higher precedence than git-foo
> while git aliases cannot override git-foo (builtin or external ones).
> Is there any other way to make "git-help" respect git command
> executing order?

Yes, and that is an issue in my refactored patch as well. The tricky
thing is that usually we say "try git-foo as a real git command, and
then fall back to aliases" but we can't here, because "try git-foo"
involves exec'ing something else.

It should be possible to do a lookup on "git-foo" and find out if it is
a real git command, but I don't know how involved that will be. I'll
look at it before I resend post-1.5.4.

And of course the other option is "so what?" People with alias.commit
set will get the alias text rather than the man page. But they will
quickly figure out that alias.commit doesn't actually _work_, and
presumably remove it.

-Peff
