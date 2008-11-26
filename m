From: Jeff King <peff@peff.net>
Subject: Re: format-patch problem when using relative
Date: Wed, 26 Nov 2008 13:01:54 -0500
Message-ID: <20081126180154.GA7584@coredump.intra.peff.net>
References: <17081052-4480-4971-9F38-BD5C48087379@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nikola =?utf-8?B?S25lxb5ldmnEhw==?= <laladelausanne@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 19:03:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5OjI-0004y6-Q2
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 19:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbYKZSB5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Nov 2008 13:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752305AbYKZSB5
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 13:01:57 -0500
Received: from peff.net ([208.65.91.99]:3028 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752256AbYKZSB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 13:01:56 -0500
Received: (qmail 19803 invoked by uid 111); 26 Nov 2008 18:01:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 26 Nov 2008 13:01:56 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Nov 2008 13:01:54 -0500
Content-Disposition: inline
In-Reply-To: <17081052-4480-4971-9F38-BD5C48087379@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101753>

On Wed, Nov 26, 2008 at 05:12:02PM +0100, Nikola Kne=C5=BEevi=C4=87 wro=
te:

> git format-patch -o patches -n --relative=3Dclick click/master myclic=
k
>
> This produced a bunch of files in patches directory, most of which ar=
e =20
> empty. When I tried this --stdout, I had something like this:

Hmm. It seems that there is no history pruning done with --relative, so
you will still end up with commits that make no changes. However, this
is intentional. See cd676a51:

    diff --relative: output paths as relative to the current subdirecto=
ry
    [...]
     - This works not just with diff but also works with the log
       family of commands, but the history pruning is not affected.

       In other words, if you go to a subdirectory, you can say:

            $ git log --relative -p

       but it will show the log message even for commits that do not
       touch the current directory.  You can limit it by giving
       pathspec yourself:

            $ git log --relative -p .

       This originally was not a conscious design choice, but we
       have a way to affect diff pathspec and pruning pathspec
       independently.  IOW "git log --full-diff -p ." tells it to
       prune history to commits that affect the current subdirectory
       but show the changes with full context.  I think it makes
       more sense to leave pruning independent from --relative than
       the obvious alternative of always pruning with the current
       subdirectory, which would break the symmetry.

So I think what you really want is:

  git format-patch --relative=3Dclick click/master myclick -- click

to limit the path pruning to the 'click' directory.

-Peff
