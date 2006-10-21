From: Junio C Hamano <junkio@cox.net>
Subject: Re: On blame/pickaxe
Date: Fri, 20 Oct 2006 20:20:38 -0700
Message-ID: <7vods6icc9.fsf@assigned-by-dhcp.cox.net>
References: <7vr6xddm7h.fsf@assigned-by-dhcp.cox.net>
	<20061016022159.GZ20017@pasky.or.cz>
	<7v8xjgvjys.fsf@assigned-by-dhcp.cox.net>
	<200610161602.49811.Josef.Weidendorfer@gmx.de>
	<453393E5.3020203@shadowen.org> <20061017004429.GC20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 05:20:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb7Pf-0005HG-0i
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 05:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992814AbWJUDUk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 23:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992817AbWJUDUk
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 23:20:40 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:22233 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S2992814AbWJUDUj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 23:20:39 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061021032038.IKJT6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Oct 2006 23:20:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id crLP1V00b1kojtg0000000
	Fri, 20 Oct 2006 23:20:24 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061017004429.GC20017@pasky.or.cz> (Petr Baudis's message of
	"Tue, 17 Oct 2006 02:44:29 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29578>

Petr Baudis <pasky@suse.cz> writes:

>> >> If the user is not prepared to see code movement, pickaxe can be
>> >> run without -M nor -C to get the classic blame output.
>
> Ok, so in this case -M and -C does not mean just looking for
> copies/movements in other files but inside the same file as well.
>
> Perhaps we might want to differentiate those two cases since searching
> in all files might be significantly slower.

I do not personally worry about people confusing -M/-C to
pickaxe with -M/-C given to diff (to pickaxe, use of diff is
purely an internal implementation issue), and reused -M and -C
to mean quite different things.  -M is to detect line movement
inside a file (it is not strictly limited to "line movement",
though. It _is_ about "copies and moves within the same file").
On the other hand, -C (and its stronger form -C -C) is to detect
copies and moves across file boundaries (but wholesale "file
rename" comes as part of the basic algorithm so you do not have
to ask for it with -M nor -C).  So in that sense pronouncing M
"move" and C "copy" is not accurate.  Their differences is
already what you said "we might want".

However they match the cost expectation people are used to in
diff options pretty well.  -M is not so expensive and -C is
somewhat.  -C -C is like find-copies-harder and is quite
expensive.

Also currently the code does not do "move" detection at all.
Contrary to intuition, move detection is more expensive than
copy detection in this case.
