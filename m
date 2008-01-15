From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git-commit fatal: Out of memory? mmap failed: Bad file descriptor
Date: Mon, 14 Jan 2008 20:42:02 -0600
Message-ID: <478C1D7A.6090103@nrlssc.navy.mil>
References: <4787E981.7010200@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: drafnel@gmail.com
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 15 03:42:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEbl8-0007A1-Uo
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 03:42:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220AbYAOCmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 21:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbYAOCmJ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 21:42:09 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:56915 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbYAOCmH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 21:42:07 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0F2g3Ga006499;
	Mon, 14 Jan 2008 20:42:03 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 14 Jan 2008 20:42:03 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <4787E981.7010200@nrlssc.navy.mil>
X-OriginalArrivalTime: 15 Jan 2008 02:42:03.0199 (UTC) FILETIME=[35B9ACF0:01C85720]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15666001
X-TM-AS-Result: : Yes--20.294800-0-2-1
X-TM-AS-Category-Info: : 2:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1NzA0Mi03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwMDQ3Ni03MDA5NzEtNzA5MjUxLTcwMTQ2MS03?=
	=?us-ascii?B?MDQyNTctNzAxOTM3LTcwNTU4NC03MDU4NjEtNzAxNDAzLTcwMzc0?=
	=?us-ascii?B?Ny03MDAwNTctNzAzOTY5LTcwMDA3My03MDUxNzgtNzAxMjMyLTcw?=
	=?us-ascii?B?MjAxNi03MDA2OTMtNzA1NDUwLTcwMTU5NC0xMjEyNzAtNzA5NTg0?=
	=?us-ascii?B?LTEyMTExNi0xMjE4MjgtNzA1MTY3LTE0ODAzOS0xNDgwNTEtMjAw?=
	=?us-ascii?B?NDA=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70497>

Brandon Casey wrote:
> I got this message from git-commit:
> 
> $ git commit -a
> <edit message, :wq>
> fatal: Out of memory? mmap failed: Bad file descriptor
> Create commit <my_prompt_string>

I ran git-bisect and the result is below. Doesn't look like
much help though.

To reiterate, I only have problems with the builtin-commit,
i.e. 1.5.4.*, the 1.5.3.* series works correctly. Of course
if this is a memory corruption issue, then it could just be
that the pattern of memory accesses in 1.5.3 does not tweak
the problem.

The other possibly useful info is that running
'git commit -a -C HEAD --amend' does not cause the error.



1596456309315befb3fd0a985d50a70ed09493e4 is first bad commit
commit 1596456309315befb3fd0a985d50a70ed09493e4
Author: Junio C Hamano <gitster@pobox.com>
Date:   Sun Dec 16 15:03:58 2007 -0800

    builtin-commit: fix summary output.

    Because print_summary() forgot to call diff_setup_done() after futzing with
    diff output options, it failed to activate recursive diff, which resulted in
    an incorrect summary.

    Signed-off-by: Junio C Hamano <gitster@pobox.com>

:100644 100644 518ebe0347e631c72f4e2a83b948259ee20fd213 61770ef456ca7f5f8342796e66f7ebfd3e1e7f73 M      builtin-commit.c


I've spent a number of hours trying to debug this. If there are any other ideas for
debugging, let me know. I'll keep the repo for a while.

-brandon
