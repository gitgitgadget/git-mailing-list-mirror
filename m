From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Cannot clone the git repository shared over http with
 authorization.
Date: Sun, 1 Apr 2012 21:45:36 +0200
Message-ID: <20120401194534.GA16512@ecki>
References: <20120401184804.GJ3236@szczaw.snafu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Artur R. Czechowski" <arturcz@hell.pl>
X-From: git-owner@vger.kernel.org Sun Apr 01 21:45:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEQip-0004TH-NN
	for gcvg-git-2@plane.gmane.org; Sun, 01 Apr 2012 21:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077Ab2DATpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Apr 2012 15:45:51 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:42710 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752653Ab2DATpu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Apr 2012 15:45:50 -0400
Received: from localhost (p5B22DD1B.dip.t-dialin.net [91.34.221.27])
	by bsmtp.bon.at (Postfix) with ESMTP id 4F3C8A7EB5;
	Sun,  1 Apr 2012 21:46:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120401184804.GJ3236@szczaw.snafu.pl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194482>

On Sun, Apr 01, 2012 at 08:48:04PM +0200, Artur R. Czechowski wrote:
> 
> arturcz@szczaw:/tmp$ git clone http://blabluga.hell.pl/git/test.git
> Cloning into 'test'...
> error: The requested URL returned error: 401 (curl_result = 22, http_code = 401, sha1 = e884293079beab9f2583b59b4e05479fc84fc588)
> error: Unable to find e884293079beab9f2583b59b4e05479fc84fc588 under http://blabluga.hell.pl/git/test.git
> Cannot obtain needed commit e884293079beab9f2583b59b4e05479fc84fc588
> while processing commit c64bcf957545f61436d405326d985521dc45058f.
> error: Fetch failed.

I've been looking at this a bit. It's probably worth mentioning that the
problem does _not_ happen if username and password are specified in the
URL or in the .netrc. In both of those cases, curl is taking care of the
credentials itself.

So far I figured out that setting 'git config http.maxRequests 1' fixes
the problem as well. Looking at the output with GIT_CURL_VERBOSE=1 set,
it seems that some GET requests use the credentials, while others do
not. My guess is that the CURLOPT_USERPWD option does not apply to all
threads.

Clemens
