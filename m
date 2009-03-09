From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH/RFD] builtin-revert.c: release index lock when	cherry-picking
 an empty commit
Date: Mon, 09 Mar 2009 12:36:55 -0500
Message-ID: <wesyHaGNnlB5oyurcOVfszxul5Cz5GxJhdT6fDpND5VxH9x2-iHvHg@cipher.nrlssc.navy.mil>
References: <1236418251-16947-1-git-send-email-chris_johnsen@pobox.com> <20090308144240.GA30794@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Chris Johnsen <chris_johnsen@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 09 18:39:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgjRU-0008JY-29
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 18:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbZCIRhe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 13:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbZCIRhd
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 13:37:33 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:46890 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbZCIRhb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 13:37:31 -0400
Received: by mail.nrlssc.navy.mil id n29Hat2W019581; Mon, 9 Mar 2009 12:36:55 -0500
In-Reply-To: <20090308144240.GA30794@coredump.intra.peff.net>
X-OriginalArrivalTime: 09 Mar 2009 17:36:55.0830 (UTC) FILETIME=[A41C3B60:01C9A0DD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112727>

Jeff King wrote:
> On Sat, Mar 07, 2009 at 03:30:51AM -0600, Chris Johnsen wrote:
> 
>> +test_expect_code 1 'cherry-pick an empty commit' '
>> +
>> +	git checkout master &&
>> +	git cherry-pick empty-branch
>> +
>> +'
> 
> Hmm. This test fails for me on FreeBSD. However, it seems to be related
> to a shell portability issue with the test suite. The extra newline
> inside the shell snippet seems to lose the last status. The following
> works fine for me with bash or dash:

> With this minimal example, you can see that the problem is not some
> subtle bug in the test suite:
> 
> -- >8 --
> #!/bin/sh
> 
> eval 'false'
> echo status is $?
> eval 'false
> '
> echo status is $?
> eval 'false
> 
> '
> echo status is $?
> -- 8< --
> 
> generates:
> 
>   status is 1
>   status is 1
>   status is 0

Even /bin/sh (which is unfit for git consumption) on Solaris 7 produces
non-zero for all three tests:

   status is 255
   status is 255
   status is 255

I set SHELL_PATH=/usr/xpg4/bin/sh aka ksh when compiling git which also
handles your test correctly:

   status is 1
   status is 1
   status is 1

IRIX6.5 /bin/sh and /bin/ksh produce the correct results also.

-brandon
