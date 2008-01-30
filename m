From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] git-relink: avoid hard linking in objects/info directory
Date: Wed, 30 Jan 2008 10:19:22 -0600
Message-ID: <47A0A38A.7050600@nrlssc.navy.mil>
References: <479FAB9A.9040009@nrlssc.navy.mil>	 <b77c1dce0801292334p7c348744re6a7fdbb0f17d5b3@mail.gmail.com>	 <7vd4rjivy5.fsf@gitster.siamese.dyndns.org> <b77c1dce0801300008r7c6c38f5i97ffd30d022d533b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 17:24:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKFjl-0005Eh-KO
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 17:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756391AbYA3QXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 11:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756328AbYA3QXf
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 11:23:35 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:60320 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756059AbYA3QXe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 11:23:34 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0UGJMLN006395;
	Wed, 30 Jan 2008 10:19:22 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 30 Jan 2008 10:19:22 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <b77c1dce0801300008r7c6c38f5i97ffd30d022d533b@mail.gmail.com>
X-OriginalArrivalTime: 30 Jan 2008 16:19:22.0976 (UTC) FILETIME=[DFE80E00:01C8635B]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15694001
X-TM-AS-Result: : Yes--4.327000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtNzAwMDczLTcwOTc1NS03MDQ5MzQtNzAxNDU1LTcwMTE2My03?=
	=?us-ascii?B?MDgxNzktNzA5MDY1LTE4ODAxOS03MDI1NjgtNzA0OTI3LTEyMTMz?=
	=?us-ascii?B?OC0xNDgwMzktMTQ4MDUxLTIwMDQz?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72059>

Rafael Garcia-Suarez wrote:
> On 30/01/2008, Junio C Hamano <gitster@pobox.com> wrote:
>> The statement is trying to find directories whose names match
>> /^[0-9a-f]{2}$/ (two hexdigits) or /^pack$/.
> 
> Ah, I see better now.
> 
>> But I do agree that listing things to skip is a fragile approach
>> than listing things you know are safe to relink.
>>
>> How about doing it this way instead?
>>
>>  git-relink.perl |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/git-relink.perl b/git-relink.perl
>> index f6b4f6a..9101926 100755
>> --- a/git-relink.perl
>> +++ b/git-relink.perl
>> @@ -40,7 +40,7 @@ my $master_dir = pop @dirs;
>>  opendir(D,$master_dir . "objects/")
>>         or die "Failed to open $master_dir/objects/ : $!";
>>
>> -my @hashdirs = grep !/^\.{1,2}$/, readdir(D);
>> +my @hashdirs = grep { ($_ eq 'pack') || /^[0-9a-f]{2}$/ } readdir(D);
> 
> Fine, except that one can factorize one step further:
>     grep /^(pack|[0-9a-f]{2})$/, readdir(D);

Looks fine to me.

-brandon
