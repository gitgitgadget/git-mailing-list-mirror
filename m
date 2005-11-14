From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git's rev-parse.c function show_datestring presumes gnu date
Date: Mon, 14 Nov 2005 15:08:45 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511141504530.3263@g5.osdl.org>
References: <86zmo6vnnj.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 15 00:10:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbnRd-0003AQ-7X
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 00:09:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbVKNXIv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 18:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbVKNXIv
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 18:08:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19404 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751281AbVKNXIu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Nov 2005 18:08:50 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAEN8mnO007446
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 14 Nov 2005 15:08:48 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAEN8jj1003367;
	Mon, 14 Nov 2005 15:08:47 -0800
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <86zmo6vnnj.fsf@blue.stonehenge.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11863>



On Mon, 14 Nov 2005, Randal L. Schwartz wrote:
> 
> git-rev-parse calls GNU date externally for --since, --after, --before,
> and --until, which will fail on at least OpenBSD and Mac OSX (Darwin).
> 
> At a minimum, this code can be commented out on such platforms.  Better
> would be to have some sort of suitable replacement.

I really wanted to do the date parsing myself, rather than call out to 
date, but I got lazy.

It shouldn't be all that difficult to do some trivial cases (gnu date 
handles totally insane things, we could easily do with just a simpler 
thing). 

Anybody want to handle
 - partial real dates ("August 5th" - figure out the year automatically, 
   and notice that it might be _last_ year since the date only makes 
   sense if it's in the past)
 - relative dates ("5 days ago", "yesterday", "one week ago")

It shouldn't be that hard, and if you do _not_ touch the date.c functions 
(which have to be totally dependable) you can be pretty damn lazy and lax 
and just guess a lot.

		Linus
