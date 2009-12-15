From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Generic filters for git archive?
Date: Tue, 15 Dec 2009 14:06:54 +0100
Message-ID: <4B2789EE.1030104@lsrfire.ath.cx>
References: <f9d2a5e10912071706m10ed7112ob7db47cdfac510d6@mail.gmail.com>	 <4B202945.50200@lsrfire.ath.cx> <f9d2a5e10912142308o50c8b9edy63bb485658c93a03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 14:07:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKX7m-0005zA-68
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 14:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759503AbZLONH2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Dec 2009 08:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759464AbZLONH2
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 08:07:28 -0500
Received: from india601.server4you.de ([85.25.151.105]:53293 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759435AbZLONH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 08:07:27 -0500
Received: from [10.0.1.101] (p57B7CC50.dip.t-dialin.net [87.183.204.80])
	by india601.server4you.de (Postfix) with ESMTPSA id 6AE9E2F8045;
	Tue, 15 Dec 2009 14:07:24 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <f9d2a5e10912142308o50c8b9edy63bb485658c93a03@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135285>

Am 15.12.2009 08:08, schrieb Russ Dill:
> hmm..It does seem to be running. But I'd really like to use the
> gitattributes from the tagged version I'm exporting and I don't want
> the smudge filter to run on files I'm working on in my source tree,
> just on the export.

This seems to work here:

   $ git version
   git version 1.6.3.3

   $ mkdir /tmp/x
   $ cd /tmp/x
   $ git init
   Initialized empty Git repository in /tmp/x/.git/

   $ echo sc >a
   $ git add a

   $ echo '#!/bin/sh' >f
   $ echo 'sed "s/sc/Santa Claus/"' >>f
   $ chmod 755 f
   $ git config filter.sc.smudge ./f

   $ echo 'a filter=3Dsc' >.gitattributes
   $ git add .gitattributes

   $ git commit -m.
   [master (root-commit) 57f6bef] .
    2 files changed, 2 insertions(+), 0 deletions(-)
    create mode 100644 .gitattributes
    create mode 100644 a

   $ rm .gitattributes

   $ git archive --prefix=3Dx HEAD | tar xf - xa
   $ cat xa
   Santa Claus

   $ git archive --prefix=3Dy --worktree-attributes HEAD | tar xf - ya
   $ cat ya
   sc

The first archive call uses the committed .gitattributes file and runs
the file through the smudge filter.  The second one uses the worktree
version, which doesn't exist, so no filtering occurs.

What commands do you use?

Thanks,
Ren=C3=A9
