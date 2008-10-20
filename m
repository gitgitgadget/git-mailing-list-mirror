From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: [PATCH] fix for "index-pack: rationalize delta resolution code"
Date: Mon, 20 Oct 2008 21:14:00 +0200
Message-ID: <20081020191400.GA18743@fiberbit.xs4all.nl>
References: <alpine.LFD.2.00.0810201357340.26244@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Oct 21 00:40:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks0Es-0001iO-Q7
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 21:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303AbYJTTPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 15:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751981AbYJTTPN
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 15:15:13 -0400
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:4804 "EHLO
	smtp-vbr8.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbYJTTPM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 15:15:12 -0400
Received: from fiberbit.xs4all.nl (fiberbit.xs4all.nl [80.101.187.211])
	by smtp-vbr8.xs4all.nl (8.13.8/8.13.8) with ESMTP id m9KJE162060483;
	Mon, 20 Oct 2008 21:14:01 +0200 (CEST)
	(envelope-from marco.roeland@xs4all.nl)
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.69)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1Ks0CW-0005dZ-On; Mon, 20 Oct 2008 21:14:00 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810201357340.26244@xanadu.home>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98732>

On Monday October 2008 at 14:12 Nicolas Pitre wrote:

> My bad.  A small detail went through the crack: the real_type of
> a delta object is the real_type of its base object.
> 
> Without this, the created index will be wrong as the actual object SHA1
> won't match the object.
> 
> Signed-off-by: Nicolas Pitre <nico@cam.org>
> ---
> 
> If you got a corrupted .idx file because of this ('git verify-pack' 
> should tell) then just toss it and recreate with a fixed 'git 
> index-pack'.
> 
> Could anyone having problems fetching from kernel.org with git from the 
> next branch confirm that this also fixes that? Thanks.

I still seem to have the same problem after patching:

$ git pull
remote: Counting objects: 279, done.
remote: Compressing objects: 100% (78/78), done.
remote: Total 177 (delta 136), reused 135 (delta 99)
Receiving objects: 100% (177/177), 66.59 KiB, done.
fatal: pack has bad object at offset 53487: failed to apply delta
fatal: index-pack failed

'git verify-pack' does _not_ report an error for either pack or index.
This is with git from branch next at 8f0e41f379d486dd27766d84d994eb1da5b8319d
trying to pull from git://git.kernel.org/pub/scm/git/git.git

This is on Debian 'sid' with an AMD64 architecture.

I've put the whole ".git" directory (warning: almost 35MB) for
investigation at:

http://www.xs4all.nl/~fiberbit/http://www.xs4all.nl/~fiberbit/git-next-8f0e41f3-bad-index.tgz

I hope I've patched correctly. After applying (cleanly) and rebuilding
simply executing "./git" from the workdirectory still uses the old
version. Only after using "make install" I get the patched version,
which as shown above still gives an error, from the die() at line 528 in
index-pack.c: bad_object(delta_obj->idx.offset, "failed to apply
delta");

Not much more time tonight here, but perhaps it's easier to reproduce
now with the copy of an affected .git directory.
-- 
Marco Roeland
