Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1119C55179
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 13:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A791820829
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 13:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900490AbgJ0NLS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 09:11:18 -0400
Received: from mail-gateway-shared02.cyon.net ([194.126.200.224]:50818 "EHLO
        mail-gateway-shared02.cyon.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2900487AbgJ0NLS (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 27 Oct 2020 09:11:18 -0400
X-Greylist: delayed 512 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Oct 2020 09:11:17 EDT
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared02.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <dev+git@drbeat.li>)
        id 1kXOcb-0000qe-PZ
        for git@vger.kernel.org; Tue, 27 Oct 2020 14:02:43 +0100
Received: from [10.20.10.232] (port=4370 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.93)
        (envelope-from <dev+git@drbeat.li>)
        id 1kXOca-00FkNJ-L0; Tue, 27 Oct 2020 14:02:40 +0100
Subject: Re: [PATCH] gitk: macOS: ignore osascript errors
To:     Stefan Haller <lists@haller-berlin.de>, paulus@ozlabs.org
Cc:     git@vger.kernel.org
References: <20201025175149.11853-1-dev+git@drbeat.li>
 <c4ca1c3b-0563-c35b-5bc0-5accddd0ad3a@haller-berlin.de>
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <1bd2f23c-9429-470d-d536-a5c844721715@drbeat.li>
Date:   Tue, 27 Oct 2020 14:02:40 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <c4ca1c3b-0563-c35b-5bc0-5accddd0ad3a@haller-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: de-CH
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-OutGoing-Spam-Status: No, score=-1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26.10.20 18:21, Stefan Haller wrote:
> On 25.10.20 18:51, Beat Bolli wrote:
>> Starting gitk on a macOS 10.14.6 (Mojave) system fails with the error
>>
>>      Error in startup script: 2020-10-25 17:16:44.568
>> osascript[36810:18758270]
>>      Error loading /Library/QuickTime/EyeTV MPEG
>> Support.component/Contents/MacOS/EyeTV MPEG Support:
>>      dlopen(/Library/QuickTime/EyeTV MPEG
>> Support.component/Contents/MacOS/EyeTV MPEG Support, 0x0106):
>>      code signature in (/Library/QuickTime/EyeTV MPEG
>> Support.component/Contents/MacOS/EyeTV MPEG Support)
>>      not valid for use in process: mapping process is a platform
>> binary, but mapped file is not
>>      [[this same message repeated dozens of times]]
> 
> While the code change itself makes sense to me, the justification is a
> bit strange. This error message suggests that something is messed up on
> your system. Your commit message makes it sound as if all people on
> macOS 10.14.6 get this error, which is not the case.

You're right; renaming the parent directory makes the error go away, but
I'd still like to keep my system working with all installed software.

>> Ignore errors from the osascript invocation, especially because this
>> macOS
>> version seems to correctly place the gitk window in the foreground.
> 
> Whether gitk comes to the foreground on start depends on the Tcl/Tk
> version, not the macOS version. With Tk 8.6 it does, so it might
> actually be nice to add a version check here. (I'm not requesting that
> you actually do that as part of this patch; just saying.)

wish(1) version 8.5 is bundled with macOS Mojave.

> 
>> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
>> ---
>>   gitk | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/gitk b/gitk
>> index 23d9dd1..8551711 100755
>> --- a/gitk
>> +++ b/gitk
>> @@ -12290,11 +12290,11 @@ if {[catch {package require Tk 8.4} err]} {
>>     # on OSX bring the current Wish process window to front
>>   if {[tk windowingsystem] eq "aqua"} {
>> -    exec osascript -e [format {
>> +    catch { exec osascript -e [format {
>>           tell application "System Events"
>>               set frontmost of processes whose unix id is %d to true
>>           end tell
>> -    } [pid] ]
>> +    } [pid] ] }
>>   }
> 
> Like I said, the change itself looks good to me, especially since the
> corresponding code in git gui is also guarded by a catch.
> 
> Best,
> Stefan

Cheers, Beat
