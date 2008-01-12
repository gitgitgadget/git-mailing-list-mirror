From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] git-relink.perl: warn() instead of die() on directory
 open failure
Date: Fri, 11 Jan 2008 20:26:51 -0600
Message-ID: <4788256B.2080007@nrlssc.navy.mil>
References: <4787B15D.3070105@nrlssc.navy.mil> <7vabnbzt6t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 03:27:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDW5j-0003v8-7U
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 03:27:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978AbYALC04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 21:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754014AbYALC0z
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 21:26:55 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:41026 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753762AbYALC0z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 21:26:55 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0C2QqSE024235;
	Fri, 11 Jan 2008 20:26:52 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 11 Jan 2008 20:26:51 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <7vabnbzt6t.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 12 Jan 2008 02:26:51.0947 (UTC) FILETIME=[975667B0:01C854C2]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15652001
X-TM-AS-Result: : Yes--6.402500-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDY3NS03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwMDE2MC03MDM3MzEtNzExOTUzLTcwMjAyMC0x?=
	=?us-ascii?B?ODcwNjctNzAxNDU1LTcwNDk4MC03MDAwMDktNzA1NDYxLTcwNDYw?=
	=?us-ascii?B?NS03MDc0NTEtNzA0Mjg3LTcwOTgyMy03MDUxNzgtMTIxNTQ4LTcw?=
	=?us-ascii?B?Mzg1MS0xMDYyMzAtNzAzNzEyLTcwNDQzMC03MDQ5MjctNzA0MzMy?=
	=?us-ascii?B?LTcwMDUxNi03MDM3ODgtNzAzODAyLTcwMjExMy03MDkwMjEtNzAw?=
	=?us-ascii?B?NzU2LTcwNjA2MC0xMDY0MjAtNzAxOTE0LTcwNzIyNS03MDEyMDIt?=
	=?us-ascii?B?MTQ4MDM5LTE0ODA1MS0yMDA0Mg==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70254>

Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
>> ---
>>
>>
>> Sometimes the repository to link to is not under your control.
>> If it contains files or unreadable directories, git-relink will
>> die without this patch.
> 
> I am not so sure if dying is a bad behaviour, if it is because
> you are trying to link against an object store that you may not
> be able to read.  I actually think we should actively refuse to,
> in order to prevent future problems.  After seeing the command
> die, you will talk to the owner of that "master" object store
> and ask him to fix permissions (or he may choose to say "please
> do not share with me").

The case for me was that the objects directory contained temporary
pack files. This is a perfectly valid state for a git repository,
but relink() currently aborts the whole effort when it encounters
a non-directory.

Stale tmp packs can remain if the user aborted a git command before
it was finished. (hmm, maybe git-gc --prune could remove these too?)

I only mentioned the unreadable directory case as another possibility.
You're probably right about that one.

-brandon
