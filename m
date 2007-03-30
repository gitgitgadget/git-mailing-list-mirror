From: Jeff King <peff@peff.net>
Subject: Re: Could git status know about -M ?
Date: Fri, 30 Mar 2007 00:19:24 -0400
Message-ID: <20070330041923.GA9320@coredump.intra.peff.net>
References: <20070330000949.GB41089@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Olivier Galibert <galibert@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 06:19:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HX8aT-0003sO-1u
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 06:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945932AbXC3ET1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 00:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945937AbXC3ET0
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 00:19:26 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1573 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945932AbXC3ET0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 00:19:26 -0400
Received: (qmail 21772 invoked from network); 30 Mar 2007 04:19:57 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 30 Mar 2007 04:19:57 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2007 00:19:24 -0400
Content-Disposition: inline
In-Reply-To: <20070330000949.GB41089@dspnet.fr.eu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43494>

On Fri, Mar 30, 2007 at 02:09:49AM +0200, Olivier Galibert wrote:

> Right now git status shows renames only if the deleted file is
> strictly identical to the added file.  If you do an even minor
> modification (say, change a "" include to a <> one) it becomes a
> del/add pair which is way less readable.  Easily fixable?

It uses the same rename detection as git-diff, which computes a
similarity score. For example, try this:

  $ git init
  $ head -n 1000 /usr/share/dict/words >foo
  $ git-add foo; git-commit -m 'added file'
  $ git-mv foo bar
  $ git-status ;# shows rename because files are identical
  $ echo changes >>bar; git-add bar
  $ git-status ;# still shows rename because files are similar
  $ echo rewrite >bar; git-add bar
  $ git-status ;# now files are too dissimilar to find rename

My guess is that your changes, even though they seem small, or
preventing the rename detection from working.  If you have a very small
file, even a few changes can make the files too dissimilar.

-Peff
