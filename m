From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-svn: Don't rely on $_ after making a function call
Date: Wed, 25 Apr 2007 14:13:43 -0700
Message-ID: <7v4pn4w41k.fsf@assigned-by-dhcp.cox.net>
References: <11775270321427-git-send-email-aroben@apple.com>
	<20070425205948.GA12375@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Roben <aroben@apple.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Apr 25 23:13:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgoo8-0006qh-6v
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 23:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422765AbXDYVNp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 17:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423385AbXDYVNp
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 17:13:45 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:56001 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422765AbXDYVNo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 17:13:44 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070425211344.HMFM1235.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Wed, 25 Apr 2007 17:13:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id rZDi1W00b1kojtg0000000; Wed, 25 Apr 2007 17:13:43 -0400
In-Reply-To: <20070425205948.GA12375@untitled> (Eric Wong's message of "Wed,
	25 Apr 2007 13:59:48 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45579>

Eric Wong <normalperson@yhbt.net> writes:

> Adam Roben <aroben@apple.com> wrote:
>> Many functions and operators in perl set $_, so its value cannot be relied upon
>> after calling arbitrary functions. The solution is simply to copy the value of
>> $_ into a local variable that will not get overwritten.
>
> Does this fix any particular bug?  It looks right to me
> and makes the code easier to follow, so;

I suspect Merlyn has better explanation, but...

     for (list) {
	...	
     }

loop implicitly localizes $_ and does not share this problem,
which I really appreciate whenever I am writing Perl code, but
often enough I was bitten by scripts that use "while (<$fh>)",
which does not localizes $_, and made hard to spot bugs by
clobbering $_.

I find the patch a good safety measure for any future breakages.
