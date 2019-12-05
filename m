Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99772C43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 19:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB9D224F8
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 19:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="scGaL0Co"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfLEThp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 14:37:45 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45882 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLEThp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 14:37:45 -0500
Received: by mail-qk1-f196.google.com with SMTP id x1so4325968qkl.12
        for <git@vger.kernel.org>; Thu, 05 Dec 2019 11:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=yGHShsIaxk7rAkZFolH+ozhTuo297lZ4kju1TUULo/o=;
        b=scGaL0CohC+hXqTyF1PUojtsWYoeR660uJrPS8HV54OsrcnBbgtCTMCSRrAsmbgShr
         AZqLip9+aMpUQ6NV8MG0i1vb//xR2RAfW4WRVUhSzxFfmegghT/jBgH70S2pAH7jESG4
         fsKNA7LbnmyqdFmjlFWY9YUMBUjEXN+zM4gz/T+YLF9SarU8YqBb9c6uzBCwAjydvJZ3
         kVv8a9ds5Bg5DHKjGw8WL05yCU48ola1eAWcHi+6/68Vcrjt15nVuhRMfxZx9PbwsVLi
         Ax87e+tpOtWerRksrHRP5Tzcmu1HjctILtKd35g0V1mBAAmOxEVuLL1ZRLNBjKu4w0F2
         5EWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yGHShsIaxk7rAkZFolH+ozhTuo297lZ4kju1TUULo/o=;
        b=YaAwiEFImdasAh3WCziKGOIs6N4z70vAe1RYMOdajl81tNWyJ2Ke5BafJ7q9h8+C6z
         3siYXNBkM40N04jjNI3Gt17QiUDQ/LOzf2OXWpV/llJyuv2S7uGMLQf7t3F0hTljVH4p
         wqR1jOJXa5JhnCnI9UkWgJuKmeQq547wzexAGDCoJfOx8ko+Tp5BklT8Uw8hiKKINylG
         ndQRFd7WNl0D4WuTxI4VmcIM/lqGJITloSiWXrgMzIcgqX03eXKn4e99WExsBQYT2uO1
         rNsUZf4f3bSOtnE3Hs6BnMzsyFlj3+MpKMOG6Wa0tp0ZKXSPudrXWZKlRbOcPS1e6dOC
         YRWw==
X-Gm-Message-State: APjAAAUNH7gXKFRpQ+au7XQD7nxgTotraI19NPpE8QumCRIASUab5tGU
        XDEqxSLzVTJNdp90P47SX4EZnb7BpAU=
X-Google-Smtp-Source: APXvYqwarBmk+1PfZONAaHt5QOby4uDqOAldyp8TzfOhKiH8Hfuq38IeqryCPpWz4QXxflBbc/dU0Q==
X-Received: by 2002:a37:2781:: with SMTP id n123mr9740682qkn.163.1575574663541;
        Thu, 05 Dec 2019 11:37:43 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id 206sm5153987qkf.132.2019.12.05.11.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 11:37:43 -0800 (PST)
Subject: Re: [PATCH v4 06/11] git-p4: Fix assumed path separators to be more
 Windows friendly
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
 <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
 <8f5752c12737fd861274609fdafac095ad95c519.1575498578.git.gitgitgadget@gmail.com>
 <xmqqsgly28qs.fsf@gitster-ct.c.googlers.com>
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <e41c1532-9e2e-ef6b-4c3d-af006a1f2ef9@gmail.com>
Date:   Thu, 5 Dec 2019 14:37:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <xmqqsgly28qs.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 12/5/2019 8:38 AM, Junio C Hamano wrote:
> "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Ben Keene <seraphire@gmail.com>
>>
>> When a computer is configured to use Git for windows and Python for windows, and not a Unix subsystem like cygwin or WSL, the directory separator changes and causes git-p4 to fail to properly determine paths.
>>
>> Fix 3 path separator errors:
>>
>> 1. getUserCacheFilename should not use string concatenation. Change this code to use os.path.join to build an OS tolerant path.
>> 2. defaultDestiantion used the OS.path.split to split depot paths.  This is incorrect on windows. Change the code to split on a forward slash(/) instead since depot paths use this character regardless  of the operating system.
>> 3. The call to isvalidGitDir() in the main code also used a literal forward slash. Change the cose to use os.path.join to correctly format the path for the operating system.
> s/isvalid/isValid/;
> s/cose/code/;
>
> Also please wrap your lines at around 72 columns (that will let
> reviewers quote what you write (which adds "> " prefix and consumes
> 2 more columns), and would allow us a handful of exchanges (each
> round adding ">" prefix to consume 1 more column) before bumping
> into the right edge of the terminal at 80 columns.
>
>> These three changes allow the suggested windows configuration to properly locate files while retaining the existing behavior on non-windows operating systems.
>>
>> Signed-off-by: Ben Keene <seraphire@gmail.com>
>> (cherry picked from commit a5b45c12c3861638a933b05a1ffee0c83978dcb2)
> As Denton mentioned, general public do not care if you "cherry
> picked" it from your earlier unpublished work.  Remove it.
>
> Aside from these small nits, the proposed log message for this step
> is quite cleanly done and easily readable.  All the decisions are
> clearly written and agreeable.  Nicely done.


Thank you. I've been working through all the commits and updating them.


>> ---
>>   git-p4.py | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/git-p4.py b/git-p4.py
>> index 2659531c2e..7ac8cb42ef 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -1454,8 +1454,10 @@ def p4UserIsMe(self, p4User):
>>               return True
>>   
>>       def getUserCacheFilename(self):
>> +        """ Returns the filename of the username cache
>> +	    """
> Inconsistent use of spaces and a tab I see on these two lines.
> Intended?

Good catch! It should have been spaces.  Corrected.


>
>>           home = os.environ.get("HOME", os.environ.get("USERPROFILE"))
>> -        return home + "/.gitp4-usercache.txt"
>> +        return os.path.join(home, ".gitp4-usercache.txt")
>>   
>>       def getUserMapFromPerforceServer(self):
>>           if self.userMapFromPerforceServer:
>> @@ -3973,13 +3975,16 @@ def __init__(self):
>>           self.cloneBare = False
>>   
>>       def defaultDestination(self, args):
>> +        """ Returns the last path component as the default git
>> +            repository directory name
>> +        """
>>           ## TODO: use common prefix of args?
>>           depotPath = args[0]
>>           depotDir = re.sub("(@[^@]*)$", "", depotPath)
>>           depotDir = re.sub("(#[^#]*)$", "", depotDir)
>>           depotDir = re.sub(r"\.\.\.$", "", depotDir)
>>           depotDir = re.sub(r"/$", "", depotDir)
>> -        return os.path.split(depotDir)[1]
>> +        return depotDir.split('/')[-1]
>>   
>>       def run(self, args):
>>           if len(args) < 1:
>> @@ -4252,8 +4257,8 @@ def main():
>>                           chdir(cdup);
>>   
>>           if not isValidGitDir(cmd.gitdir):
>> -            if isValidGitDir(cmd.gitdir + "/.git"):
>> -                cmd.gitdir += "/.git"
>> +            if isValidGitDir(os.path.join(cmd.gitdir, ".git")):
>> +                cmd.gitdir = os.path.join(cmd.gitdir, ".git")
>>               else:
>>                   die("fatal: cannot locate git repository at %s" % cmd.gitdir)
