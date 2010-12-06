From: Drew Northup <drew.northup@maine.edu>
Subject: Re: git reset and ctime
Date: Mon, 06 Dec 2010 12:37:17 -0500
Message-ID: <1291657037.30271.17.camel@drew-northup.unet.maine.edu>
References: <AANLkTimyYTup+PqJFJ+2g-tVwWXA2bxTT3noonEuKBSu@mail.gmail.com>
	 <20101204005131.GB15906@burratino>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: ghazel@gmail.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 06 18:43:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPf5r-0001v7-JK
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 18:43:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196Ab0LFRnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 12:43:12 -0500
Received: from beryl.its.maine.edu ([130.111.32.94]:54969 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015Ab0LFRnL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 12:43:11 -0500
Received: from [130.111.39.151] (drew-northup.unet.maine.edu [130.111.39.151])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id oB6HbME4005096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 6 Dec 2010 12:37:22 -0500
In-Reply-To: <20101204005131.GB15906@burratino>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=4 Fuz1=4
	Fuz2=4
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: oB6HbME4005096
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1292261843.65799@VWoXo2Sl1Xe+18F1PZQf/w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163002>


On Fri, 2010-12-03 at 18:51 -0600, Jonathan Nieder wrote:
> Hi Greg,
> 
> ghazel@gmail.com wrote:
> 
> > I've encountered a strange issue where "git reset --hard" insists on
> > "Checking out files ..." when all that is changed is the ctime
> 
> There is a performance trade-off.  Refreshing the index requires
> reading+hashing the existing file if the stat information changed;
> this could be faster or slower than blindly overwriting depending on
> the situation.

> >              My deploy process (capistrano) maintains a cached copy of
> > a git repo, which it fetches, resets, and then hardlinks files from
> > when a deploy occurs ( https://github.com/37signals/fast_remote_cache
> > ). The hardlinking step is meant to save the time of copying the file.
> > but hardlinking changes the ctime of the source files.
> 
> Interesting.  Setting "[core] trustctime = false" in the repository
> configuration could be a good solution (no performance downside I can
> think of).

It is worth noting that many file-based backup systems which do "online"
backups (such as in use where I work) restore the atime by default at
the expense of the ctime (logic being that the atime may have had value
and the ctime changes either way--which may or may not be true) on unix
style filesystems. While many of the git command-line things I have run
seem to figure this out ok, it drives gitk nuts. As far as I am
concerned this is a small price to pay for a solid daily-updated backup
of my machine(s) to be available. I haven't yet put "git reset" of any
sort to use (obviously I just haven't been breaking enough things yet),
but I suspect that it would react in a similar way.

-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
