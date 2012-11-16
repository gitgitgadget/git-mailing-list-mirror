From: Jeff King <peff@peff.net>
Subject: Re: Auto-repo-repair
Date: Fri, 16 Nov 2012 11:00:04 -0800
Message-ID: <20121116190004.GA2310@sigill.intra.peff.net>
References: <0c0e34a4-16ab-40a0-9293-af94e34e4290@zcs>
 <dbae3a06-c14b-4c06-9863-ae4771968fe1@zcs>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Enrico Weigelt <enrico.weigelt@vnc.biz>
X-From: git-owner@vger.kernel.org Fri Nov 16 20:00:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZR9M-0008Sv-VH
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 20:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172Ab2KPTAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 14:00:08 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50555 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752908Ab2KPTAH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 14:00:07 -0500
Received: (qmail 29831 invoked by uid 107); 16 Nov 2012 19:00:56 -0000
Received: from 204-16-157-26-static.ipnetworksinc.net (HELO sigill.intra.peff.net) (204.16.157.26)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 16 Nov 2012 14:00:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Nov 2012 11:00:04 -0800
Content-Disposition: inline
In-Reply-To: <dbae3a06-c14b-4c06-9863-ae4771968fe1@zcs>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209894>

On Fri, Nov 16, 2012 at 06:51:45PM +0100, Enrico Weigelt wrote:

> I've broken some repo (missing objects), eg by messing something up
> w/ alternates, broken filesystem, or whatever. And I've got a bunch
> of remotes which (together) contain all of the lost objects.
> 
> Now I'd like to run some $magic_command which automatically fetches
> all the missing objects and so repair my local repo.
> 
> Is this already possible right now ?

You can't reliably just grab the broken objects, because most transports
don't support grabbing arbitrary objects (you can do it if you have
shell access to a known-good repository, but it's not automated).

The simplest thing is usually to re-clone the known-good remotes, then
copy the resulting packfiles into your original repository. You'll have
duplicated objects until your next "gc", but the resulting repack should
skip any corrupted objects and use the known-good ones.

-Peff
