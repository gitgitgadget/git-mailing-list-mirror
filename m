From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/2] close_lock_file(): new function in the lockfile API
Date: Wed, 16 Jan 2008 17:08:27 -0600
Message-ID: <478E8E6B.80702@nrlssc.navy.mil>
References: <7vmyr6bluy.fsf@gitster.siamese.dyndns.org>	<Pine.LNX.4.44.0801152006260.944-100000@demand>	<7vejchr3pf.fsf_-_@gitster.siamese.dyndns.org>	<alpine.LFD.1.00.0801161207220.2806@woody.linux-foundation.org>	<7vodblo6c9.fsf@gitster.siamese.dyndns.org>	<Pine.LNX.4.64.0801161443340.31161@torch.nrlssc.navy.mil>	<7v7ii9o2ld.fsf@gitster.siamese.dyndns.org>	<478E893F.4070100@nrlssc.navy.mil> <7vy7apmlci.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	=?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 00:10:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFHOW-0001lv-9c
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 00:10:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbYAPXJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 18:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbYAPXJd
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 18:09:33 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:42355 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbYAPXJc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 18:09:32 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0GN8SB8029867;
	Wed, 16 Jan 2008 17:08:28 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 16 Jan 2008 17:08:27 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <7vy7apmlci.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 16 Jan 2008 23:08:27.0947 (UTC) FILETIME=[B410E7B0:01C85894]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15666001
X-TM-AS-Result: : Yes--15.172900-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDY3NS03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwMDE2MC03MDM3MzEtNzA0MDM0LTcwMzc4OC03?=
	=?us-ascii?B?MDIwMjAtNzAwNzI2LTcwMTIwMi03MDUxNjctNzA0NDEwLTcwMzgw?=
	=?us-ascii?B?Ny03MDE3MzgtMTM3NzE3LTcwMTQ1NS03MDgxNzktNzA3NDUxLTcw?=
	=?us-ascii?B?MDk3MS03MDkxODUtNzA2NzkxLTcwMjA0Mi0xMzk1MDQtNzAxMTYz?=
	=?us-ascii?B?LTcwMTkzNy03MDQ0MjEtNzAxOTE0LTcwODc5Ny03MDgzMjgtNzAz?=
	=?us-ascii?B?NzEyLTE0ODAzOS0xNDgwNTEtMjAwNDA=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70766>

Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> Mainly, I prefer to not modify the data structures when a failure occurs.
> 
> Ok.  Is the rest of your patch that fixes callers Ok with that
> semantics?

yes.

>  If so, I'd agree that is probably cleaner.  I'll
> scrap the one we are discussing, resurrecting only the api
> documentation part, and replace it with the lockfile.c changes
> from your patch, along with the fixes to callers.

Most of that patch is straight forward, just removing close().

I think you should consider how to handle fdopen on the lock
descriptor and the fact that start_command closes the lock
file descriptor in create_bundle().

After we fdopen, we should always fclose() and never close().
This isn't enforced.

I merely assigned the file descriptor to -1 when it was safe
(i.e. after fclose), and added a comment. We could add another
function which did this automatically, but maybe that is too
much effort, especially in the bundle case.

-brandon
