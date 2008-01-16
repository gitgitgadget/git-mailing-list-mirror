From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/2] close_lock_file(): new function in the lockfile API
Date: Wed, 16 Jan 2008 14:46:23 -0600 (CST)
Message-ID: <Pine.LNX.4.64.0801161443340.31161@torch.nrlssc.navy.mil>
References: <7vmyr6bluy.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.44.0801152006260.944-100000@demand> <7vejchr3pf.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0801161207220.2806@woody.linux-foundation.org>
 <7vodblo6c9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	=?X-UNKNOWN?Q?Kristian_H=C3=B8gsberg?= <krh@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 21:48:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFFBJ-00071n-56
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 21:48:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbYAPUro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 15:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbYAPUrn
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 15:47:43 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53383 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbYAPUrn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 15:47:43 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0GKkOuc028406;
	Wed, 16 Jan 2008 14:46:24 -0600
Received: from torch.nrlssc.navy.mil ([128.160.25.59]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 16 Jan 2008 14:46:23 -0600
In-Reply-To: <7vodblo6c9.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 16 Jan 2008 20:46:23.0861 (UTC) FILETIME=[DB509A50:01C85880]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15666001
X-TM-AS-Result: : Yes--13.041800-0-4-1
X-TM-AS-Category-Info: : 4:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDY3NS03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwMDY0OC03MTEyMTktNzAzNzMxLTEzNzcxNy03?=
	=?us-ascii?B?MDA5NzEtNzA0ODUyLTcwMTUxMy03MDA3MjYtNzA5MDY1LTcwMTYw?=
	=?us-ascii?B?NC03MDIzNzUtNzAxNDU1LTcxMTQzMi03MDA3NTgtNzAzNzg4LTcw?=
	=?us-ascii?B?NDkzMC03MDA0NzYtMTQ4MDM5LTE0ODA1MC0yMDA0Mw==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70745>

On Wed, 16 Jan 2008, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> On Wed, 16 Jan 2008, Junio C Hamano wrote:
>>> +
>>> +void close_lock_file(struct lock_file *lk)
>>> +{
>>> +	close(lk->fd);
>>> +	lk->fd = -1;
>>> +}
>>
>> Since one of the main purposes of closing would be the error testing of
>> writes that haven't made it out yet on filesystems like NFS that do
>> open-close cache serialization, I'd suggest doing this as
>>
>> 	int close_lock_file(struct lock_file *lk)
>> 	{
>> 		int fd = lk->fd;
>> 		lk->df = -1;
>> 		return close(fd);
>> 	}
>>
>> to give the return code.
>
> Yup!  You are as always right.

My patch does this, though I understand it may take some time to review.

I left the lk->fd unmodified when close() failed in case the caller
would like to include it in an error message.

-brandon
