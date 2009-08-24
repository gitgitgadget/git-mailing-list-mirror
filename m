From: Thell Fowler <git@tbfowler.name>
Subject: Re: [PATCH-v2/RFC 3/6] xutils: fix ignore-all-space on incomplete
 line
Date: Sun, 23 Aug 2009 22:26:56 -0500 (CDT)
Message-ID: <alpine.DEB.2.00.0908232044060.29625@GWPortableVCS>
References: <1250999285-10683-1-git-send-email-git@tbfowler.name> <1250999357-10827-3-git-send-email-git@tbfowler.name> <7vvdkfx8rl.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.0908231110500.29625@GWPortableVCS> <7vljlauxmk.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.0908231515020.29625@GWPortableVCS> <7vzl9qtev0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thell Fowler <git@tbfowler.name>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 05:28:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfQEC-0000y3-CY
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 05:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbZHXD1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 23:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbZHXD1V
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 23:27:21 -0400
Received: from 216.38.49.125.servint.net ([216.38.49.125]:52090 "EHLO
	vps5.pyrapat.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbZHXD1V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 23:27:21 -0400
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143] helo=GWPortableVCS.local)
	by vps5.pyrapat.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tbfowler.name>)
	id 1MfQDK-0005CW-5b; Sun, 23 Aug 2009 22:27:22 -0500
X-X-Sender: almostautomated@GWPortableVCS
In-Reply-To: <7vzl9qtev0.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vps5.pyrapat.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tbfowler.name
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126900>

Junio C Hamano (gitster@pobox.com) wrote on Aug 23, 2009:

> Thell Fowler <git@tbfowler.name> writes:
> 
> >> Or we can just move the final else clause up and start the function like
> >> this:
> >> 
> >> 	int i1, i2;
> >> 
> >> 	if (!(flags & XDF_WHITESPACE_FLAGS))
> >>  		return s1 == s2 && !memcmp(l1, l2, s1);
> >> 
> >> 	i1 = i2 = 0;
> >>  	if (flags & XDF_IGNORE_WHITESPACE) {
> >> 		...
> >> 
> >> that would get rid of two unnecessary clearing of variables (i1 and i2,
> >> even though I suspect that the compiler _could_ optimize them out without
> >> such an change), and three flags-bit check in the most common case of not
> >> ignoring any whitespaces.
> >> 
> >
> > HA!  That's a nifty way to do that with the variables.
> 
> My tentative draft to replace the "how about this" patch further reworks
> the loop structure and currently looks like this.
> 
> It adds net 15 lines but among that 12 lines are comments, which is not so
> bad.
> 

It passed every test I threw at it, although it seemed to be a tad bit 
slower than the previous revision on my sample data so I ran the following 
command several times for both the previous and current version:

time for i in {1..10}; do ./t4015-diff-whitespace.sh>/dev/null && 
./t4015-diff-trailing-whitespace.sh >/dev/null; done


And these results are fairly average on what I saw:

Previous version:
real	2m32.669s
user	0m44.051s
sys	1m34.702s


Current version:
real	2m56.818s
user	0m47.671s
sys	1m46.723s

--
Thell
