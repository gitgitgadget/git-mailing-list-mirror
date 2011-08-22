From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [Git 1.7.6.557.gcee4] git stash
Date: Mon, 22 Aug 2011 14:58:20 -0500
Message-ID: <fbFntd6r8tmN4NcET9Ya3OWDfsrxz1tfPv7GaddGfwwdirG8AgjrG8ARoR2-ZhadzpRI2DU2ZtTGdWAUGJeUZuBXmxWX5eSmT16u5cBjtec@cipher.nrlssc.navy.mil>
References: <CAE1pOi1D+J5_fmsdhho1FRAipyO3Ri7GS_wy4fTNtCGbatDaDg@mail.gmail.com> <AkGXRtqs8Fopo0L4Aw4Wa2DwgVP6ZLr_un-c4jhUixdk1LTUHK2twg@cipher.nrlssc.navy.mil> <CAE1pOi2OnHpu+kBj8Z47nb7C-MHFpUMAc8ArG3haWpncEDQ-jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: David Caldwell <david@porkrind.org>,
	Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 22 21:59:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvaeY-0000lI-01
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 21:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455Ab1HVT7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 15:59:17 -0400
Received: from mail3.nrlssc.navy.mil ([128.160.11.249]:51112 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753582Ab1HVT7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 15:59:16 -0400
Received: by mail3.nrlssc.navy.mil id p7MJwMXm002143; Mon, 22 Aug 2011 14:58:51 -0500
In-Reply-To: <CAE1pOi2OnHpu+kBj8Z47nb7C-MHFpUMAc8ArG3haWpncEDQ-jA@mail.gmail.com>
X-OriginalArrivalTime: 22 Aug 2011 19:58:20.0716 (UTC) FILETIME=[D79F16C0:01CC6105]
X-Virus-Scanned: clamav-milter 0.97.2 at mail3
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179884>

On 08/22/2011 01:43 PM, Hilco Wijbenga wrote:
> On 22 August 2011 10:15, Brandon Casey
> <brandon.casey.ctr@nrlssc.navy.mil> wrote:
>> On 08/22/2011 01:01 AM, Hilco Wijbenga wrote:
>>> Hi David,
>>>
>>> I noticed your very timely change to git stash in the current master
>>> branch. I tried it but it doesn't behave as I was expecting/hoping.
>>
>> It looks like it is actually creating the stash correctly, but it's
>> just not deleting the ignored directory.

>> Something like this is probably the appropriate fix:
>>
>> diff --git a/git-stash.sh b/git-stash.sh
>> index f4e6f05..a2d4b4d 100755
>> --- a/git-stash.sh
>> +++ b/git-stash.sh
>> @@ -240,7 +240,7 @@ save_stash () {
>>                test "$untracked" = "all" && CLEAN_X_OPTION=-x || CLEAN_X_OPTION
>>                if test -n "$untracked"
>>                then
>> -                       git clean --force --quiet $CLEAN_X_OPTION
>> +                       git clean --force --quiet -d $CLEAN_X_OPTION
>>                fi
>>
>>                if test "$keep_index" = "t" && test -n $i_tree
>>
>> Needs tests.
> 
> I just tried it with the extra -d and it all seems to work
> beautifully. Should your patch be sent anywhere?

It needs a couple of tests added to t/t3905-stash-include-untracked.sh
to demonstrate that this functionality works correctly and to ensure
that it doesn't break in the future.

Need tests at least for:

   --all stashes untracked / ignored in subdirectory
   --include-untracked stashes untracked in subdirectory, leaves ignored alone

Do we currently test that stash leaves untracked / ignored alone when
--all or --include-untracked are not supplied?

And it needs a commit message following the guidelines in
Documentation/SubmittingPatches.  Then it can be submitted to this list
using format-patch and send-email.  Interested??? :)  otherwise I'll try
to get to it later tonight.

-Brandon
