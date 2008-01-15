From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] safecrlf: Add flag to convert_to_git() to disable safecrlf check
Date: Wed, 16 Jan 2008 02:03:12 +0300
Message-ID: <20080115230312.GB13984@dpotapov.dyndns.org>
References: <004D2FB5-2CEA-4DB1-AF8D-D5ADEB0F0508@zib.de> <12003528401309-git-send-email-prohaska@zib.de> <20080115102626.GE2963@dpotapov.dyndns.org> <53A4FB98-25B5-4598-BED8-7D96AF5527F4@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, torvalds@linux-foundation.org,
	git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Jan 16 00:03:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEuou-00028H-Eq
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 00:03:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753748AbYAOXDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 18:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754034AbYAOXDU
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 18:03:20 -0500
Received: from smtp08.mtu.ru ([62.5.255.55]:51266 "EHLO smtp08.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752477AbYAOXDT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 18:03:19 -0500
Received: from smtp08.mtu.ru (localhost [127.0.0.1])
	by smtp08.mtu.ru (Postfix) with ESMTP id 73BADF77D09;
	Wed, 16 Jan 2008 02:03:09 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-191-67.pppoe.mtu-net.ru [85.141.191.67])
	by smtp08.mtu.ru (Postfix) with ESMTP id D52EAF77C67;
	Wed, 16 Jan 2008 02:03:06 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JEuoK-0003jt-RH; Wed, 16 Jan 2008 02:03:12 +0300
Content-Disposition: inline
In-Reply-To: <53A4FB98-25B5-4598-BED8-7D96AF5527F4@zib.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp08.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70572>

On Tue, Jan 15, 2008 at 09:39:00PM +0100, Steffen Prohaska wrote:
> 
> On Jan 15, 2008, at 11:26 AM, Dmitry Potapov wrote:
> 
> >but it also means that there is no longer
> >any warning when you are running git diff with the work tree,
> >which would be useful, because it is what most users do before
> >adding anything.
> 
> My first concern is to avoid data corruption.  But we should also
> avoid to unnecessarily bother users with annoying warnings. 

I don't think we bother users with unnecessary warnings. If there
is a problem then it is better to report it earlier than later,
and we *really* want that the user took some action, i.e. either
to mark this file as binary using .gitattributes or corrected its
endings. However, reporting the same problem twice during running
one command does not look nice...

> Thus
> I thought that guarding only the code paths that modify data in
> an irreversible way is sufficient and hence I only guarded the
> code path that writes to the repository.

This policy makes sense to me, it is just I would prefer if we
could find a way to warn a user a bit earlier...

> The underlying
> assumption is that git checkout is the only way of destroying the
> original data.  Unless you check out you still have the original
> data and can copy them to a safe place.

It is obvious to you but it may be not so obvious to a new user.
Running 'git diff' before check in is a common practice, so if
the warning was reported at that moment then he or she would not
check in.

Anyway, I like your solution for being simple and guarding the
most important pass reliably.

Dmitry
