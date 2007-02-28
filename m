From: Yann Dirson <ydirson@altern.org>
Subject: Re: gitco - replacement for cvsco
Date: Wed, 28 Feb 2007 20:55:36 +0100
Message-ID: <20070228195536.GB4149@nan92-1-81-57-214-146.fbx.proxad.net>
References: <877iu3q13r.fsf@latte.josefsson.org> <Pine.LNX.4.63.0702271336050.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070227174035.f85e8643.vsu@altlinux.ru> <87bqje74u5.fsf_-_@latte.josefsson.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergey Vlasov <vsu@altlinux.ru>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Simon Josefsson <simon@josefsson.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 20:55:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMUtz-0005Sd-TV
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 20:55:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbXB1Tzu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 14:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751861AbXB1Tzt
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 14:55:49 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:42853 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751122AbXB1Tzt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 14:55:49 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id A022D6993;
	Wed, 28 Feb 2007 20:55:44 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 2D19A1F08A; Wed, 28 Feb 2007 20:55:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87bqje74u5.fsf_-_@latte.josefsson.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41000>

As a big fan of cvsco and friends, I admit I often miss that one in
git repos.

On Wed, Feb 28, 2007 at 03:08:02PM +0100, Simon Josefsson wrote:
> However, one problem with that, compared to 'cvsco', is that
> 'git-reset --hard' does not tell me tell me which files were deleted
> and which file were restored.  May I suggest a --verbose or similar?

Here is a small change to your script that does just that.  It is far
from perfect:

- uses cogito and not plain git.  Not sure how to achieve the same
compact layout with plain git - both cogito and stgit forge this type
of output themselves.  Would be great to get it directly from git
itself...

- not very efficient, and not very secure, since we scan the tree once
for reporting and then once for deleting the files, leaving a window
where files could be created by another program after the cg-status
call, and then removed by git-reset.

You've been warned :)

#!/bin/sh
# gitco - cruel checkout.  Discards everything that has not been
# committed, and checkout missing files.
git clean -d -x
cg status -w
git reset --hard
