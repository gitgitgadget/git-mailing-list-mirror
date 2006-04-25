From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: Re: [RFC] get_sha1(): :path and :[0-3]:path to extract from index.
Date: Tue, 25 Apr 2006 10:37:24 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060425083724.GA1663@informatik.uni-freiburg.de>
References: <Pine.LNX.4.64.0604181627101.3701@g5.osdl.org> <7v7j5iph7f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 25 10:37:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYJ34-0005BP-Rq
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 10:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWDYIh2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 04:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWDYIh1
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 04:37:27 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:3010 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1751403AbWDYIh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 04:37:27 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1FYJ30-0001kC-35; Tue, 25 Apr 2006 10:37:26 +0200
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.11.7p2+Sun/8.12.11) id k3P8bOm03088;
	Tue, 25 Apr 2006 10:37:24 +0200 (MEST)
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	Junio C Hamano <junkio@cox.net>, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v7j5iph7f.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19136>

Junio C Hamano wrote:
> [ NOTE! The reason I put "RFC" in the subject rather than "PATCH" is that 
>   I'm not 100% sure this isn't just a "shiny object" of mine rather than a 
>   really useful thing to do. What do people think? Have you ever wanted to 
>   access individual files in some random revision? Do you think this is 
>   useful? I think it's cool and _may_ be useful, but I'm not going to 
>   really push this patch. Consider it a throw-away patch unless somebody 
>   else finds it intriguing enough.. ]
> 
> This is a fairly straightforward patch to allow "get_sha1()" to
> also have shorthands for blob objects in the current index.
I sometimes want to have something like that:

	uzeisberger@io:~/gsrc/linux-2.6$ git cat-file blob v2.6.16:Makefile

That is not a shortcut for objects in the current index, but for blobs
in written trees.

It's easy to hack a script that does that.  Something like that[1]:


	#! /bin/sh

	eval `echo ${1} | sed 's/\\(.*\\):\\(.*\\)/commit=\"\\1^{}\"; file=\"\\2\"/'`

	tree=`git cat-file commit ${commit} | sed -n 's/tree //p'`

	blob=`git ls-tree -r ${tree} | awk "\\\$4 == \\"${file}\\" { print \\\$3 }"`

	git cat-file blob ${blob}


But if the rev-parser could handle that, that would be much finer.  Or
is there already a way to do this that I don't know?

Best regards
Uwe

[1] It's not tested and probably fails if there are some "bad"
characters in ${1} and could be implemented in a much cleverer way.

-- 
Uwe Zeisberger

http://www.google.com/search?q=0+degree+Celsius+in+kelvin
