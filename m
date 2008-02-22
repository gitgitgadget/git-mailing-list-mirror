From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 22 Feb 2008 12:47:59 -0600
Message-ID: <47BF18DF.6050100@nrlssc.navy.mil>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org> <7vodavd9qw.fsf@gitster.siamese.dyndns.org> <7vbq6tset4.fsf@gitster.siamese.dyndns.org> <7vmyq9gk94.fsf@gitster.siamese.dyndns.org> <7vk5la4oxq.fsf@gitster.siamese.dyndns.org> <7vejbc44hu.fsf@gitster.siamese.dyndns.org> <7v8x1fymei.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802211024200.17164@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 22 19:50:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JScyj-0005Yf-2D
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 19:50:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756614AbYBVSuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 13:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756244AbYBVSuA
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 13:50:00 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50781 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756224AbYBVSt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 13:49:59 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m1MIlw9p027158;
	Fri, 22 Feb 2008 12:48:02 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 22 Feb 2008 12:47:58 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <alpine.LSU.1.00.0802211024200.17164@racer.site>
X-OriginalArrivalTime: 22 Feb 2008 18:47:58.0873 (UTC) FILETIME=[71B23890:01C87583]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15736001
X-TM-AS-Result: : Yes--15.393800-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtNzA0MjU3LTcwNTE3OC03MDAxOTQtNzA5NTg0LTcwMTI5OC03?=
	=?us-ascii?B?MDM0OTEtNzA3NDUxLTcwMjU2OC03MDU4NjEtMTEzMjMwLTcwNjY0?=
	=?us-ascii?B?OS03MDc3NTAtNzAwNDc2LTcwMzE3OS03MDEzMDUtNzAyNzI2LTEw?=
	=?us-ascii?B?NTI1MC03MDQ0MjUtMTIxNjI0LTcwNDcxMi03MDI2MzgtNzAxOTE0?=
	=?us-ascii?B?LTcwNDk4My03MDEyMzYtNzAxNjA0LTcxMDcxOC03MDkxMzctNzAz?=
	=?us-ascii?B?NzEyLTcwMTIwMi0xMDY0MjAtNzA1OTc0LTcwNzQxMC03MDY4OTEt?=
	=?us-ascii?B?NzAzMTU3LTcwMjEyNi03MDEwMDUtMTIxMTE2LTcwMjE0My0xNDgw?=
	=?us-ascii?B?MzktMTQ4MDUxLTIwMDQy?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74746>

Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 20 Feb 2008, Junio C Hamano wrote:

>> * js/reflog-delete (Fri Jan 4 19:11:37 2008 -0600) 2 commits
>>  + builtin-reflog.c: fix typo that accesses an unset variable
>>  + Teach "git reflog" a subcommand to delete single entries
>>
>> There was a patch that uses this to implement "git-stash drop",
>> which I didn't queue, as the command name and the UI was
>> undecided yet.  Dscho was in favor of "pop" without "drop".
> 
> Maybe it is time to "drop" this topic?

The issue with drop or pop (for me) was that deleting a reflog
entry was causing error messages to be printed.

'reflog delete' can cause read_ref_at() to print an error message in
two ways.

  1) If a reflog entry is deleted in the middle of the reflog, then
     read_ref_at() will print an error message "warning: Log %s has
     gap after %s". This is a sanity check which checks that the
     previous reflog entry's "new" sha1 is equal to the current reflog
     entry's "old" sha1.

  2) If the top-most reflog entry does not match what is in refs/<ref>
     then read_ref_at() will print an error message "warning: Log %s
     unexpectedly ended on %s". This is another sanity check.

We can either disable these sanity checks, or change the code to ensure that
they pass, or do nothing in which case 'reflog delete' should probably be
removed.

For the first issue, we could rewrite the "old" sha1 while expiring reflog
entries. We would lose some of the meaning of reflog entries in this case.

For the second issue, the ref needs to be rewritten with the sha1 of the
top-most reflog entry. This makes sense for stash, but not for any other
ref.

I'm thinking that two new options to git-reflog are needed which will
implement the above two ideas. One will rewrite the "old" sha1 for each
reflog entry so that it points to the previous entry. The other will
update the ref so that it points at the top-most reflog entry.

thoughts? suggestion for the names for the options?

-brandon
