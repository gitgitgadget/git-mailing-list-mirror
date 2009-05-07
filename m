From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 4/4] t4200: avoid passing a non-newline terminated file
 to sed
Date: Thu, 07 May 2009 09:57:19 -0500
Message-ID: <_6ButG1D1Yw2WmmzcwyJjDYXsQ4Xp1VSI7VKH_AFjgKZ7nVeFjzl3g@cipher.nrlssc.navy.mil>
References: <-ElxRhvpfY_jx1Ps8nJ42rHdrKbR03T1y96WpGK19gM@cipher.nrlssc.navy.mil> <IHOAO7NDkb8K9nkprnkd2cQW6duDZ3aYmQzpqboBi5HibQoO83nGG2Z4562gIb22HVW3ho6Z250@cipher.nrlssc.navy.mil> <IHOAO7NDkb8K9nkprnkd2TGjPUHc5N7wdnoXRYKelDZEem1S0tynQeYlVheR46_5TDmYxS1O9i4@cipher.nrlssc.navy.mil> <IHOAO7NDkb8K9nkprnkd2QibZp-GnWBSpcJ8fxO9NTUsmXbuv4_2x5S6YNLzUogav4gLkrx9ClI@cipher.nrlssc.navy.mil> <IHOAO7NDkb8K9nkprnkd2ZsdySdVG_ssYL84wqJwNHZYBqMWRKBIa_Ni6jJRHumlZvrQcXOEMhQ@cipher.nrlssc.navy.mil> <IHOAO7NDkb8K9nkprnkd2ep5vFgQr-bAuDGJW-OdtSbS6WmpSHl041GRSXpP3OcDP4_PsYKsQDU@cipher.nrlssc.navy.mil> <4A028D24.9@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 07 16:57:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M252X-0004Nk-JX
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 16:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760975AbZEGO50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 10:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758166AbZEGO5Z
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 10:57:25 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:41241 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758765AbZEGO5X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 10:57:23 -0400
Received: by mail.nrlssc.navy.mil id n47EvKrT017036; Thu, 7 May 2009 09:57:20 -0500
In-Reply-To: <4A028D24.9@viscovery.net>
X-OriginalArrivalTime: 07 May 2009 14:57:20.0176 (UTC) FILETIME=[1EF2A300:01C9CF24]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118482>

Johannes Sixt wrote:
> Brandon Casey schrieb:
>> Some versions of sed exit non-zero if the file they are supplied is not
>> newline terminated.  Solaris's /usr/xpg4/bin/sed is one such sed.  So
>> rework this test to avoid doing so.
>> ---
>>  t/t4200-rerere.sh |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
>> index b68ab11..48dbd8e 100755
>> --- a/t/t4200-rerere.sh
>> +++ b/t/t4200-rerere.sh
>> @@ -190,7 +190,7 @@ test_expect_success 'file2 added differently in two branches' '
>>  	git add file2 &&
>>  	git commit -m version2 &&
>>  	test_must_fail git merge fourth &&
>> -	sha1=$(sed -e "s/	.*//" .git/MERGE_RR) &&
>> +	sha1=$({ cat .git/MERGE_RR; echo; } | sed -e "s/	.*//") &&
> 
> Couldn't that line become
> 
> 	sha1=$(cat .git/MERGE_RR) &&
> 	sha1=%{sha1%%	*} &&
> 
> (a literal tab before the '*')?

Yes, that works here.  The line above has been removed so it's moot for
this case.  Your change could be applied at line 60 of t4200-rerere.sh to
replace my perl call that was just applied if you think it is worth it.

-brandon
