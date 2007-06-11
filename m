From: Jeff King <peff@peff.net>
Subject: Re: Adding empty directory gives bogus error message
Date: Mon, 11 Jun 2007 08:30:45 -0400
Message-ID: <20070611123045.GA28814@coredump.intra.peff.net>
References: <20070610204648.GA32214@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Mon Jun 11 14:30:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxj2t-0007xY-KJ
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 14:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbXFKMas (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 08:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbXFKMas
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 08:30:48 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4126 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750935AbXFKMar (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 08:30:47 -0400
Received: (qmail 1628 invoked from network); 11 Jun 2007 12:30:59 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 11 Jun 2007 12:30:59 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2007 08:30:45 -0400
Content-Disposition: inline
In-Reply-To: <20070610204648.GA32214@diku.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49847>

On Sun, Jun 10, 2007 at 10:46:48PM +0200, Jonas Fonseca wrote:

> During a talk with madduck on #git today, we stumbled upon this
> confusing error message:
> 
>   $ mkdir repo
>   $ cd repo/
>   $ git init
>   Initialized empty Git repository in .git/
>   $ mkdir empty
>   $ git add empty/
>   The following paths are ignored by one of your .gitignore files:
>   empty/ (directory)
>   Use -f if you really want to add them.
>   $ git add -f empty/
>   fatal: unable to index file empty/

Urgh, that's ugly. The problem is that git-add sticks
assumed-to-be-ignored stuff back into the list of files found by
read_directory, but with some special ignored flags (which aren't used
anywhere else!). When the assumption is wrong (because the path is
_actually_ just empty), you get the bogus message, and when you try to
force it, you get an error from elsewhere in the code.

Patch series will be out momentarily.

-Peff
