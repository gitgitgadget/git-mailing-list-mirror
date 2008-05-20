From: Jeff King <peff@peff.net>
Subject: Re: git mergetool vs stash apply
Date: Tue, 20 May 2008 05:02:59 -0400
Message-ID: <20080520090258.GB31703@sigill.intra.peff.net>
References: <c6c947f60805200102h3fd27742vfd9310912907cfa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alexander Gladysh <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 11:03:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyNlD-0003PA-Rr
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 11:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758419AbYETJDE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 05:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757542AbYETJDD
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 05:03:03 -0400
Received: from peff.net ([208.65.91.99]:4115 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152AbYETJDB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 05:03:01 -0400
Received: (qmail 23929 invoked by uid 111); 20 May 2008 09:03:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 20 May 2008 05:03:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 May 2008 05:02:59 -0400
Content-Disposition: inline
In-Reply-To: <c6c947f60805200102h3fd27742vfd9310912907cfa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82473>

On Tue, May 20, 2008 at 12:02:44PM +0400, Alexander Gladysh wrote:

> The git mergetool ignores conflicts by git stash apply:
> 
> $ git stash apply
> Auto-merged path/file.ext
> CONFLICT (content): Merge conflict in path/file.ext
> 
> $ git mergetool
> merge tool candidates: kdiff3 kdiff3 tkdiff xxdiff meld gvimdiff
> opendiff emerge vimdiff
> No files need merging
> 
> While path/file.ext do contain merge conflict.

I think there is something else going on, because it _does_ generally
work. This simple test case should confirm:

  mkdir repo && cd repo && git init
  echo content >file && git add . && git commit -m one
  echo changes >>file && git commit -a -m two
  echo more >>file && git stash
  git checkout -b other HEAD^
  echo different changes >>file && git commit -a -m three
  git stash apply
  git mergetool

I get:
  Normal merge conflict for 'file':
    {local}: modified
    {remote}: modified
  Hit return to start merge resolution tool (xxdiff):

So there is perhaps something specific about your setup or your conflict
that is causing mergetool not to work as expected. Can you give us a
test case that fails?

-Peff
