From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH?] Fix 'git show' on signed tag of signed tag of commit
Date: Tue, 1 Jul 2008 18:39:11 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0807011836500.32725@wbgn129.biozentrum.uni-wuerzburg.de>
References: <1214905624-29517-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jul 01 18:40:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDitk-0002TK-J2
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 18:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbYGAQjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 12:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbYGAQjO
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 12:39:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:33055 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751660AbYGAQjN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 12:39:13 -0400
Received: (qmail invoked by alias); 01 Jul 2008 16:39:12 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp061) with SMTP; 01 Jul 2008 18:39:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/14VQ/T6X1tab1kAZro+7kbOL9OPJ6uplpLXvsW6
	9pz81HlGkvOjYE
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <1214905624-29517-1-git-send-email-trast@student.ethz.ch>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87052>

Hi,

On Tue, 1 Jul 2008, Thomas Rast wrote:

> The cmd_show loop resolves tags by showing them, then pointing the
> object to the 'tagged' member.  However, this object is not fully
> initialized; it only contains the SHA1.  (This resulted in a segfault
> if there were two levels of tags.)  We apply parse_object to get a
> full object.
> 
> Noticed by Kalle Olavi Niemitalo on IRC.
> 
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
> 
> I'm not 100% sure this is the right fix; I just had a quick stab at the 
> code, made a fix and tested it.  It probably leaks memory too, not sure 
> if this is a problem.

AFAICT this is the correct way to solve the problem.

We do not "leak" memory here, since we just assume objects to be 
singletons (they are immutable, after all).

FWIW I had a "release_all_objects()" function in my personal fork for a 
long time, which was quite painful to write.  But maintaining the "move 
all builtins into libgit.a and avoid fork()&&exec()ing them" patch was the 
only user, and since it became way too painful to maintain out of the 
tree, I dropped both.

Ciao,
Dscho
