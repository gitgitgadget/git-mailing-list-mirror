From: Yann Dirson <ydirson@altern.org>
Subject: Re: StGIT rebasing safeguard
Date: Thu, 14 Jun 2007 23:30:32 +0200
Message-ID: <20070614213032.GR6992@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070611003117.4736.33551.stgit@gandelf.nowhere.earth> <20070611003330.4736.69293.stgit@gandelf.nowhere.earth> <b0943d9e0706121509j5088e164iadedb561501d6a55@mail.gmail.com> <20070613203821.GQ6992@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 14 23:30:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hywtg-0001jo-AB
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 23:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbXFNVa1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 17:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbXFNVa0
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 17:30:26 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:42370 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750775AbXFNVa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 17:30:26 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 1AE3F5A153;
	Thu, 14 Jun 2007 23:30:24 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 243381F158; Thu, 14 Jun 2007 23:30:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070613203821.GQ6992@nan92-1-81-57-214-146.fbx.proxad.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50221>

On Wed, Jun 13, 2007 at 10:38:21PM +0200, Yann Dirson wrote:
> > The HEAD in my repository fails the test suite. Do you have any
> > additional patches pending (some patches were not applied in order as
> > I had to manually fix the conflicts). Anyway, please check my
> > repository for any missing patches.
> 
> Oh, I had not noticed you had applied
> bd69feaf7c3c94b6e7e216ea8091064af9cdfa97.  Sorry, I was not explicit
> enough when posing this, only the cover mail included "RFC" in the
> subject.  As described in that mail, there are problems both with the
> original approach (Karl's test failing), and with that new one (that
> exisiting test failing).
> 
> Do you have any idea on how we could overcome the problem ?  In the
> meantime, we could possibly just comment that testcase out (or add
> support for continuing the testsuite even with a failure) - the
> problem it exhibits is probably less common than the one that was
> fixed.

Well, the patch I just sent which adds GIT_SKIP_TESTS support allows
to see that this patch indeed breaks another test - the testsuite can
be forced to skip them [1] for the sake of checking one did not break
anything else, but the second test that does not pass is annoying as
well, due to a similar problem:

When the parent branch is a rewinding one (eg. an stgit stack), then
the old version of the patch will be turned to unreachable by
pull/rebase, and we probably have even no way of telling stgit that it
is indeed expected, since the parent stack is a local one.  My own
workflow on StGIT is affected by the issue, since my "bugs" stack is
forked off my "master" stack (but hopefully an hydra will help me ;).

That makes me suspecting the reachability approach is a dead-end, and
we should either get back to the approach of recording old-base, or
find another solution.

Best regards,
-- 
Yann

[1] GIT_SKIP_TESTS='t2100.4 t2102.3' make test
