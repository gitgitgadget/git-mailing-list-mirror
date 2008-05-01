From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: detecting rename->commit->modify->commit
Date: Thu, 1 May 2008 23:39:40 +0300
Message-ID: <20080501203940.GA3524@mithlond.arda.local>
References: <4819CF50.2020509@tikalk.com> <20080501144524.GA10876@sigill.intra.peff.net> <4819DCF1.7090504@tikalk.com> <20080501152035.GB11145@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ittay Dror <ittayd@tikalk.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 01 22:45:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrfew-0005pl-FQ
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 22:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbYEAUoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 16:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753331AbYEAUoy
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 16:44:54 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:50784 "EHLO
	jenni2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750903AbYEAUoy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 16:44:54 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni2.rokki.sonera.fi (8.0.013.9)
        id 481789310021D835; Thu, 1 May 2008 23:39:41 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JrfZ6-0001Nr-4b; Thu, 01 May 2008 23:39:40 +0300
Content-Disposition: inline
In-Reply-To: <20080501152035.GB11145@sigill.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80939>

Jeff King wrote (2008-05-01 11:20 -0400):

> Hmm, looking at the code, though, 50% is supposed to be the default
> minimum. So there might actually be a bug.

I did some testing... A file, containing 10 lines (about 200 bytes),
renamed and then modified (similarity index being a bit over 50%). Git
detected the rename just fine with "git diff -M" over the rename and
change. When I edited the file even more (similarity only 40%) "git diff
-M" didn't detect the rename but "git diff -M4" did. To me it looks like
this works nicely, better than I expected, actually.

Smaller files than that do not seem to work with "git diff -M" over the
rename and changes. They can be followed with "git log --follow -p"
which works even with the two-line "hello\nworld". And of course there
is always

  git diff commit1:path1/file1 commit2:path2/file2

I'd conclude that for logs and diffs renames are detected very nicely
and there's no problem at all to get wanted information from the repo.
I wonder how this rename detection/tracking has become such a big thing,
a debate even. But maybe merges are different.
