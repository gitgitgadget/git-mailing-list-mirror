From: =?UTF-8?B?6rmA64Ko7ZiV?= <namhyung.kim@lge.com>
Subject: Re: [PATCH 1/3] help: Fix help message for aliases
Date: Thu, 15 Mar 2012 14:15:14 +0900
Message-ID: <4F617AE2.9050700@lge.com>
References: <1331779969-8641-1-git-send-email-namhyung.kim@lge.com> <20120315041734.GD4149@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 15 06:15:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S832U-0001ZD-Vy
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 06:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745Ab2COFPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 01:15:18 -0400
Received: from LGEMRELSE7Q.lge.com ([156.147.1.151]:55311 "EHLO
	LGEMRELSE7Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764Ab2COFPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 01:15:16 -0400
X-AuditID: 9c930197-b7c59ae000000e75-4b-4f617ae245c1
Received: from [192.168.0.31] ( [10.177.201.156])
	by LGEMRELSE7Q.lge.com (Symantec Brightmail Gateway) with SMTP id C5.37.03701.2EA716F4; Thu, 15 Mar 2012 14:15:14 +0900 (KST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <20120315041734.GD4149@sigill.intra.peff.net>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193178>

Hi,

2012-03-15 1:17 PM, Jeff King wrote:
> On Thu, Mar 15, 2012 at 11:52:47AM +0900, Namhyung Kim wrote:
>
>> The current "`git br' is aliased to `branch'" looks a bit
>> strange. Prepend 'git' to aliased output too so that the
>> end result will be looked like this:
>>
>>   $ git help br
>>   `git br' is aliased to `git branch'
>
> I think that is a sensible improvement, but...
>
>> diff --git a/builtin/help.c b/builtin/help.c
>> index 61ff798..f85c870 100644
>> --- a/builtin/help.c
>> +++ b/builtin/help.c
>> @@ -445,7 +445,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
>>
>>   	alias = alias_lookup(argv[0]);
>>   	if (alias && !is_git_command(argv[0])) {
>> -		printf("`git %s' is aliased to `%s'\n", argv[0], alias);
>> +		printf("`git %s' is aliased to `git %s'\n", argv[0], alias);
>>   		return 0;
>
> What output does this produce for:
>
>    $ git config alias.foo '!f() { git log $1@{u}..$1; }; f'
>    $ git help foo
>
> ?
>

Oh, I didn't think of such a complicated case. Hmm, how about checking whether 
the first word is a git command or not:

		printf("`git %s' is aliased to `%s%s'\n", argv[0],
			is_git_command(first_word) ? "git " : "", alias);

Thanks,
Namhyung
