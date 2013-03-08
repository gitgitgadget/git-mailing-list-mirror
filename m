From: Jeff King <peff@peff.net>
Subject: Re: Memory corruption when rebasing with git version 1.8.1.5 on arch
Date: Fri, 8 Mar 2013 16:28:31 -0500
Message-ID: <20130308212831.GA9217@sigill.intra.peff.net>
References: <5139D76D.80703@bernhard-posselt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Bernhard Posselt <mail@bernhard-posselt.com>
X-From: git-owner@vger.kernel.org Fri Mar 08 22:29:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UE4qb-00047t-D4
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 22:29:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413Ab3CHV2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 16:28:34 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41213 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754386Ab3CHV2d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 16:28:33 -0500
Received: (qmail 19053 invoked by uid 107); 8 Mar 2013 21:30:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Mar 2013 16:30:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Mar 2013 16:28:31 -0500
Content-Disposition: inline
In-Reply-To: <5139D76D.80703@bernhard-posselt.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217682>

On Fri, Mar 08, 2013 at 01:19:57PM +0100, Bernhard Posselt wrote:

> Using valgrind gives me:
> 
> $ valgrind /usr/bin/git pull --rebasehttps://github.com/PatrickHeller/core.git  master
> ==5995== Memcheck, a memory error detector
> ==5995== Copyright (C) 2002-2012, and GNU GPL'd, by Julian Seward et al.
> ==5995== Using Valgrind-3.8.1 and LibVEX; rerun with -h for copyright info
> ==5995== Command: /usr/bin/git pull --rebasehttps://github.com/PatrickHeller/core.git  master
> ==5995==
> remote: Counting objects: 5, done.
> remote: Compressing objects: 100% (1/1), done.
> remote: Total 3 (delta 2), reused 3 (delta 2)
> Unpacking objects: 100% (3/3), done.
>  Fromhttps://github.com/PatrickHeller/core
>   * branch            master     -> FETCH_HEAD
> First, rewinding head to replay your work on top of it...
> Applying: distinguish between touch and write
> Applying: remove debug output
> *** Error in `git': malloc(): memory corruption: 0x00000000027f14e0 ***

The problem is likely happening in a sub-command of git-pull, so
valgrind isn't reporting it. Can you try re-running with
"valgrind --trace-children=yes", or alternatively narrow down the
problematic command by setting GIT_TRACE=1 in the environment?

-Peff
