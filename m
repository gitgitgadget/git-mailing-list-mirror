Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C37520D09
	for <e@80x24.org>; Sun,  4 Jun 2017 15:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751339AbdFDPFR (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Jun 2017 11:05:17 -0400
Received: from avasout07.plus.net ([84.93.230.235]:46164 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbdFDPFP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2017 11:05:15 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout07 with smtp
        id Uf5C1v0031keHif01f5Ers; Sun, 04 Jun 2017 16:05:14 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=fgHOuhvu7hAj4AubdDUA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] submodule foreach: correct $sm_path in nested submodules
 from a dir
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     Stefan Beller <sbeller@google.com>, bmwill@google.com,
        gitster@pobox.com
Cc:     git@vger.kernel.org, pc44800@gmail.com
References: <20170515183405.GA79147@google.com>
 <20170603003710.5558-1-sbeller@google.com>
 <0a0ad045-0c58-aaaf-d0ac-a4fa17570356@ramsayjones.plus.com>
Message-ID: <1fc84ffc-aa8d-5da4-bae1-8db9865f6ce5@ramsayjones.plus.com>
Date:   Sun, 4 Jun 2017 16:05:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <0a0ad045-0c58-aaaf-d0ac-a4fa17570356@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 03/06/17 15:07, Ramsay Jones wrote:
[snip]

>> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
>> index 74bc6200d5..52e3ef1325 100644
>> --- a/Documentation/git-submodule.txt
>> +++ b/Documentation/git-submodule.txt
>> @@ -218,20 +218,24 @@ information too.
>>  
>>  foreach [--recursive] <command>::
>>  	Evaluates an arbitrary shell command in each checked out submodule.
>> -	The command has access to the variables $name, $path, $sha1 and
>> -	$toplevel:
>> -	$name is the name of the relevant submodule section in .gitmodules,
>> -	$path is the name of the submodule directory relative to the
>> -	superproject, $sha1 is the commit as recorded in the superproject,
>> -	and $toplevel is the absolute path to the top-level of the superproject.
>> -	Any submodules defined in the superproject but not checked out are
>> -	ignored by this command. Unless given `--quiet`, foreach prints the name
>> -	of each submodule before evaluating the command.
>> -	If `--recursive` is given, submodules are traversed recursively (i.e.
>> -	the given shell command is evaluated in nested submodules as well).
>> -	A non-zero return from the command in any submodule causes
>> -	the processing to terminate. This can be overridden by adding '|| :'
>> -	to the end of the command.
>> +	The command has access to the following variables:
>> ++
>> +* `$name` is the name of the relevant submodule section in .gitmodules,
>> +* `$sha1` is the commit as recorded in the superproject.
>> +* `$sm_path` is the path recorded in the superproject.
> 
> Just to be sure, the 'path recorded in the superproject' means the
> same thing as the 'name of the submodule directory relative to the
> superproject'. Yes?
> 
>> +* `$toplevel` is the absolute path to its superproject, such that
>> +  `$toplevel/$sm_path` is the absolute path of the submodule.
>> +* `$dpath` contains the relative path from the current working directory
>> +   to the submodules root directory.

BTW, I have not given any thought to what happens to these
variables/paths if you run '--recursive'. I assume the new
'recursed' submodule takes on the role of the 'superproject'
in the definitions above. Hmm, but what does $dpath show?
(having 'recursed', is the cwd now at the top level of the
'new' superproject?)

Hmm, you have changed several command to recurse into
submodule(s) (I haven't followed that effort closely), so
I suppose it should have some measure of consistency with
those commands. (whatever that means ;-)

ATB,
Ramsay Jones


