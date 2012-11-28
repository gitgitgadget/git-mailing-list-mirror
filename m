From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fsck: warn about '.' and '..' in trees
Date: Tue, 27 Nov 2012 23:34:33 -0500
Message-ID: <20121128043433.GB5362@sigill.intra.peff.net>
References: <20121128022736.GA3739@sigill.intra.peff.net>
 <CACsJy8DQCo9UzDadHJ2dF-eK20tFDTVn_ScwV+T7z-qLDJMytw@mail.gmail.com>
 <20121128043215.GA5362@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 05:34:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdZMI-0001kV-Qk
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 05:34:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089Ab2K1Eeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 23:34:36 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59007 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751120Ab2K1Eef (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 23:34:35 -0500
Received: (qmail 3060 invoked by uid 107); 28 Nov 2012 04:35:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Nov 2012 23:35:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Nov 2012 23:34:33 -0500
Content-Disposition: inline
In-Reply-To: <20121128043215.GA5362@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210700>

On Tue, Nov 27, 2012 at 11:32:16PM -0500, Jeff King wrote:

>   $ check dot .
>   error: Invalid path '.'
> 
>   $ check dotdot ..
>   error: Updating '..' would lose untracked files in it
> 
>   $ check dotgit .git
>   error: Updating '.git' would lose untracked files in it
> 
> Interesting that we detect the first one while reading into the cache,
> but apparently try much harder to checkout on the latter two. Not sure I
> want to try "git checkout -f". :)

Actually, I take it back. The "untracked files" check comes _first_, and
if you do "-f", we end up in the verify_path check when trying to pull
the tree into the index. So I think the way git handles it makes sense.

-Peff
