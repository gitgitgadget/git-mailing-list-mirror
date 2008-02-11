From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: warning: no common commits - slow pull
Date: Sun, 10 Feb 2008 20:53:42 -0500
Message-ID: <20080211015342.GA26205@mit.edu>
References: <200802102007.38838.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Len Brown <lenb@kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 02:54:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JONsR-0005fP-Mq
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 02:54:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbYBKByB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 20:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbYBKByB
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 20:54:01 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:57459 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751197AbYBKByA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2008 20:54:00 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m1B1rijP028440;
	Sun, 10 Feb 2008 20:53:44 -0500 (EST)
Received: from closure.thunk.org (c-66-30-1-139.hsd1.ma.comcast.net [66.30.1.139])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m1B1rg75022941
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 10 Feb 2008 20:53:43 -0500 (EST)
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1JONra-0006yX-RK; Sun, 10 Feb 2008 20:53:42 -0500
Content-Disposition: inline
In-Reply-To: <200802102007.38838.lenb@kernel.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73452>

On Sun, Feb 10, 2008 at 08:07:38PM -0500, Len Brown wrote:
> A couple of hours ago I pulled my reference copy of Linux tree,
> which brought the tip here:
> 
> commit 7cf712db6087342e5e7e259d3883a7b5ac3212d1
> Merge: 58a14ee... 30ddb15...
> Author: Linus Torvalds <torvalds@woody.linux-foundation.org>
> Date:   Sun Feb 10 12:03:57 2008 -0800
> 
>     Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6
> 
> Then, 10 minutes ago I did a pull to bring the head here:
> 
> commit 19af35546de68c872dcb687613e0902a602cb20e
> Author: Linus Torvalds <torvalds@woody.linux-foundation.org>
> Date:   Sun Feb 10 14:18:14 2008 -0800
> 
>     Linux 2.6.25-rc1
> 
> But this second pull seems to have re-downloaded 172MB,
> when it should have only needed the last few commits.

Yeah, I have this problem very often when I push to the ext4 tree on
master.kernel.org.  Apparently the push/pull logic isn't smart about
objects are found via objects/info/alterntaes, so it will needlessly
transfer objects that it doesn't need to.

What I do to deal with this problem is I'll manually log into
master.kernel.org, and then use the command "git-update-ref
refs/heads/origin 19af35546de68c872dcb687613e0902a602cb20e", and then
go back and do the push/pull.  Once there is a head which points to the
latest from Linus, then the push/pull logic is smart and will only
download the few commitments that aren't in the local git repository
and aren't found in a shared repository.

Annoying, but as long as you have shell access on the machine with the
destination repository, you can work around it.

					- Ted
