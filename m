From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Use exit 1 instead of die when req_Root fails.
Date: Wed, 17 Oct 2007 11:16:34 -0400
Message-ID: <DC3D43FD-F03D-4E0A-9C2B-DE56F9C16D60@silverinsanity.com>
References: <20071017140547.GA21691@Hermes.cust.hotspot.t-mobile.com> <118833cc0710170739i179e7389k1e44f70086ca88be@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org
To: Morten Welinder <mwelinder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 17:16:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiAdJ-0002or-E3
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 17:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754875AbXJQPQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 11:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757325AbXJQPQT
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 11:16:19 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:55458 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754259AbXJQPQS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 11:16:18 -0400
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 19E711FFC10F;
	Wed, 17 Oct 2007 15:16:17 +0000 (UTC)
In-Reply-To: <118833cc0710170739i179e7389k1e44f70086ca88be@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61382>


On Oct 17, 2007, at 10:39 AM, Morten Welinder wrote:

>>  made it into your repo.  It fixes test failures on my machine  
>> that have
>>  been plauging me for months.
>
> That sounds more like a reason to fix the test.  "die" is the perl
> standard way of reporting an error.  It will print the error message
> on stderr, not on stdout like your version does.
>
> IMHO, of course.

The problem is that die can exit with varying exit codes, and exit  
codes >= 128 make the test suite assume something has gone wrong with  
the test.  In particular, because $! (errcode) and $? (previous shell  
command return) are both 0, it returns 255.  Or at least that's how  
it works out on my system.  I'm not sure why it doesn't do that on  
others.

But the test is expecting a failure here and it appears to be failing  
in the correct way, just with an error code test-lib.sh doesn't  
like.  I asked on list the best way to fix it and Frank Lichtenheld  
said (and nobody objected until now) that this was the best way to  
fix it.

Also, the not printing on STRERR is identical to another section of  
code just below mine:

>     unless ($line eq 'anonymous') {
>        print "E Only anonymous user allowed via pserver\n";
>        print "I HATE YOU\n";
>        exit 1;
>     }

However, amending my patch to print to STDERR is not difficult.

~~ Brian Gernhardt
