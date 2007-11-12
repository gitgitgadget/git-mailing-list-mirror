From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 5/6] push: use same rules as git-rev-parse to resolve refspecs
Date: Mon, 12 Nov 2007 21:48:49 +0100
Message-ID: <DEDBC16B-0BDD-4671-8446-EFD0B32969BF@zib.de>
References: <1194789708646-git-send-email-prohaska@zib.de> <11947897083381-git-send-email-prohaska@zib.de> <11947897081278-git-send-email-prohaska@zib.de> <11947897083159-git-send-email-prohaska@zib.de> <11947897083265-git-send-email-prohaska@zib.de> <1194789709671-git-send-email-prohaska@zib.de> <7v1wav44z8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 21:48:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrgCp-0005oG-SF
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 21:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbXKLUsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 15:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbXKLUsL
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 15:48:11 -0500
Received: from mailer.zib.de ([130.73.108.11]:57371 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986AbXKLUsK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 15:48:10 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lACKlWen007152;
	Mon, 12 Nov 2007 21:47:33 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lACKlWL2009771
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 12 Nov 2007 21:47:32 +0100 (MET)
In-Reply-To: <7v1wav44z8.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64704>


On Nov 12, 2007, at 8:51 PM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> diff --git a/remote.c b/remote.c
>> index bec2ba1..28d8eb7 100644
>> --- a/remote.c
>> +++ b/remote.c
>> @@ -519,10 +519,7 @@ static int count_refspec_match(const char  
>> *pattern,
>>  		char *name = refs->name;
>>  		int namelen = strlen(name);
>>
>> -		if (namelen < patlen ||
>> -		    memcmp(name + namelen - patlen, pattern, patlen))
>> -			continue;
>> -		if (namelen != patlen && name[namelen - patlen - 1] != '/')
>> +		if (!ref_abbrev_matches_full_with_rules(pattern, name,  
>> ref_rev_parse_rules))
>>  			continue;
>
> I vaguely recall that in the old round this check used to be
> without negation '!' in the front.  I think this version is
> correct.

Yes. I started with a syntax inspired by strcmp. But later
the function got match in its name. I think returning a
match with 'true' is more natural; and reserving '-1, 0, 1'
for compare (as in strcmp). Therefore I changed the return
value.

With '!' is correct now. Without '!' was correct before.

	Steffen
