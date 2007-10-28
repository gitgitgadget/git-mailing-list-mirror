From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 4/8] rev-parse: teach "git rev-parse --symbolic" to print the full ref name
Date: Sun, 28 Oct 2007 08:58:22 +0100
Message-ID: <79CE31EE-0975-48EB-8B3E-FC9D6A8EB3E4@zib.de>
References: <119350380778-git-send-email-prohaska@zib.de> <11935038081211-git-send-email-prohaska@zib.de> <11935038081650-git-send-email-prohaska@zib.de> <1193503808519-git-send-email-prohaska@zib.de> <11935038083369-git-send-email-prohaska@zib.de> <7v3avvy9yc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 28 08:57:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im31W-0004OA-Ix
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 08:57:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbXJ1H5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 03:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbXJ1H5N
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 03:57:13 -0400
Received: from mailer.zib.de ([130.73.108.11]:63557 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750762AbXJ1H5N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 03:57:13 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9S7v5pT013291;
	Sun, 28 Oct 2007 08:57:06 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1072b.pool.einsundeins.de [77.177.7.43])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9S7utQw022479
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 28 Oct 2007 08:56:55 +0100 (MET)
In-Reply-To: <7v3avvy9yc.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62535>


On Oct 28, 2007, at 8:28 AM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> "git rev-parse --symbolic" used to return the ref name as it was
>> specified on the command line. This is changed to returning the
>> full matched ref name, i.e. "git rev-parse --symbolic master"
>> now typically returns "refs/heads/master".
>
> This is to expose "dwim_ref" logic, so it might be a good idea
> to introduce a new option --dwim-ref for this purpose.
>
> 	git rev-parse --symbolic master^2
>
> is designed to give "master^2" or fail if "master" is not a
> merge.

So the idea of --symbolic is really to return the argv as is?
No change whatsoever allowed. Why would someone need this?
Is it only for convenience when writing shell code?


> Similarly, you would diagnose a failure if somebody asks
> to show
>
> 	git rev-parse --dwim-ref master~4
>
> instead of giving "refs/heads/master~4".

What I proposed is to teach git rev-parse to return a full
symbolic ref name. Maybe

	git rev-parse --full-symbolic
	git rev-parse --full-ref

But honestly, I don't care that much about this patch. Maybe
we just put it aside?


>> +static void show_rev(int type, const unsigned char *sha1, const  
>> char *name, const char* real_name)
>> @@ -131,7 +133,7 @@ static void show_default(void)
>>
>>  		def = NULL;
>>  		if (!get_sha1(s, sha1)) {
>> -			show_rev(NORMAL, sha1, s);
>> +			show_rev(NORMAL, sha1, s, 0);
>
> A null pointer constant in git sources is spelled "NULL" not "0".

Ok. I'll fix this in all patches.


>> @@ -213,6 +215,7 @@ int cmd_rev_parse(int argc, const char **argv,  
>> const char *prefix)
>>  {
>>  	int i, as_is = 0, verify = 0;
>>  	unsigned char sha1[20];
>> +	char* real_name = 0;
>
> Pointer sign '*' in git sources go next to the name not the
> type, as:
>
> 	char *real_name = NULL;

I know and I tried hard to follow this convention, although
I think its the wrong choice ;)

	Steffen
