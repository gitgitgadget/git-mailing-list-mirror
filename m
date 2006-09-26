From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] svnimport add support for parsing From lines for author
Date: Tue, 26 Sep 2006 08:51:45 +0100
Message-ID: <4518DC11.5050806@shadowen.org>
References: <20060925110813.GA4419@shadowen.org> <7v7izrtdtw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 26 09:52:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GS7jj-0001fj-M9
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 09:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWIZHwM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 03:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWIZHwM
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 03:52:12 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:49682 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1750739AbWIZHwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 03:52:09 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1GS7jA-0005Sn-KM; Tue, 26 Sep 2006 08:51:40 +0100
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7izrtdtw.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27783>

Junio C Hamano wrote:
> Andy Whitcroft <apw@shadowen.org> writes:
> 
>> svnimport: add support for parsing From: lines for author
> 
> Please do _not_ repeat the summary line in the message body.  It
> is on the Subject: already.

Sorry ... different projects different rules.

>> Now that we have support for parsing Signed-off-by: for author
>> information it makes sense to handle From: as well.
> 
> I take that you are referring to Sasha's change in ae35b304; I
> asked for actual svn users for ACK/NACK but I did not hear any.
> Can I understand that you use svnimport for real projects and
> are happy with Sasha's change? --- that would be an ack that
> would help me sleep better ;-).

Heh.  Yeah I am tracking a small SVN repository which is using the
kernel DCO.  we have From:/S-o-b: much as akpm uses in -mm.  This was
the result of seeing that change and wanting to see if it would pick up
our sign-offs.  It only seemed deficient in From: handling :).  It seems
to work well in practice for me.

> 
>> adds a new -F which will handle From: lines in the comments.  It
>> may be used in combination with -S.
> 
> This sort of makes sense but how common is this?

I think the kernel DCO has started a trend which will expand to other
projects.  The problem it is intended to fix is a general one which
needs addressing in all such projects.

> I also wonder instead of piling up custom flags if it is better
> to let match-and-extract pattern be specified from the command
> line.

I did look at reusing the -S flag, such that -S would be S-o-b: handling
and -SS would be S-o-b: and From:, but this script is currently using
the old getopt implementation which doesn't record repeats.

So you're proposing something more like:

    git svn-import -S "Signed-off-by:" -S "From:" ...

Again, we'll have to update the options handling to get that kind of
behaviour.  How would you feel about -SS in this context.

-apw
