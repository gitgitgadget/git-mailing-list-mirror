Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641B7CD37B0
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 23:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjIOXeE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 19:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbjIOXeB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 19:34:01 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BBD1FDE
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 16:33:56 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-7a5170c78e6so1011253241.2
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 16:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694820836; x=1695425636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L51A1sEaETUjHw6tLFkUpq+5vLc93JmHoSswOvCo6+I=;
        b=ev43N1AYOOcByhvnQUPY2e8pEdz3NuP/T9gk2ESWzJDuTFvV21rnoMxhErTxDTMk/j
         Tk3KsjHI+lkRxJxJs6nosBm7byoguP80mguwLYJJKYl5pqOupWQIeqAmMa/MsSLqLLOU
         xzkexSeRKBQ2kshYvTHjmpaOVA9nbtbF8DE54l55+IXkKc958XcGWTsaOdFn9eTW8pDp
         rdkLEhBaxe2qLHqQbjs4FizLV3lYVsoylax2RweE6Cqid/1urpRpw6sHXX3PsDOUgoof
         rZYsp5u5pWi5JaDtqcQ5F+M/5wv46ydXcI5fmVur1Cos1hzN7NM1rJeO1D+9bzHirEz9
         dCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694820836; x=1695425636;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L51A1sEaETUjHw6tLFkUpq+5vLc93JmHoSswOvCo6+I=;
        b=AXvvp3/xz+rbi3uBGVyTwvwqeBBtj4DIMCbckyhLWD9UqwJYYtBbRYDZACyDHo07+a
         0SvAjgjqSaurG/6dOjwwqv8gfRFmV0HvgYUEZIGm+XbCjocYNFkBd6sEQgnc8upcuJ/N
         1Z2hppFrKN1uSs7Z7Gx3+0IKd1khnHGDiIrp6YH8z2KYa1sIsN+WuIdt7Vlq1RRawAmo
         VD26YCTo4/ss8Xbppm2AnVZQF21BZTIXjHiIAPrNFFXE7qJt046uD1eIajKK5T+CR/2A
         KvcxHDJU/OOMps1sI2xn2MNLEFKOBNDyUXvFtxeopHfGgPwRXJCcIJ05OccSYtux5l8p
         BSFA==
X-Gm-Message-State: AOJu0YzlvaPGx7qFoK/UNE8dmE9JOF1GQt5/of6zNgb5+lgpY1tXggE5
        2V/DQ/gVPX7dC0fkd+DHwSFZMmMu37s=
X-Google-Smtp-Source: AGHT+IEO+on+vf6UneFm6B7HEoVc8fO5QnidEJ+cabKKdLbRff7qjQBLN0jvueaIugG4GP4XTYvu6w==
X-Received: by 2002:a67:fa1a:0:b0:44d:4e57:5c4f with SMTP id i26-20020a67fa1a000000b0044d4e575c4fmr3084899vsq.33.1694820835834;
        Fri, 15 Sep 2023 16:33:55 -0700 (PDT)
Received: from ?IPV6:2600:4040:266f:b900::387? ([2600:4040:266f:b900::387])
        by smtp.gmail.com with ESMTPSA id u19-20020a0cf1d3000000b00655e4826738sm1622208qvl.31.2023.09.15.16.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 16:33:55 -0700 (PDT)
Message-ID: <454d8b7b-96df-ec8f-2285-e022de66c66c@gmail.com>
Date:   Fri, 15 Sep 2023 19:33:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: BUG: git-gui no longer executes hook scripts
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        me@yadavpratyush.com
References: <bd510f6d-6613-413b-6d64-c3d2fd01d8a9@gmail.com>
 <xmqqa5tngynh.fsf@gitster.g> <xmqq5y4bgxy1.fsf@gitster.g>
From:   Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <xmqq5y4bgxy1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 9/15/23 13:15, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Shouldn't this "is it absolute" check with "$cmd" also check if $cmd
>> has either forward or backward slash in it?
>>
>> Checking the use of _which with fixed arguments, it is used to spawn
>> git, gitk, nice, sh; and _which finding where they appear on the
>> search path does sound sane.  But _which does not seem to have the "if
>> given a command with directory separator, the search path does not
>> matter.  The caller means it is relative to the $cwd" logic at all,
>> so it seems it is the callers responsibility to make sure it does
>> not pass things like ".git/hooks/pre-commit" to it.
> In other words, something along this line may go in the right
> direction (I no longer speak Tcl, and this is done with manual in
> one hand, while typing with the other hand).
>
I think a simpler fix is just to examine the number of path components - 
more than one means a relative or absolute command (/foo splits into two 
parts). The below works for me on Linux.

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 277a2b1c8c..0c39d9fa26 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -118,7 +118,7 @@ proc sanitize_command_line {command_line from_index} {
     set i $from_index
     while {$i < [llength $command_line]} {
         set cmd [lindex $command_line $i]
-       if {[file pathtype $cmd] ne "absolute"} {
+       if {[llength [file split $cmd]] < 2} {
             set fullpath [_which $cmd]
             if {$fullpath eq ""} {
                 throw {NOT-FOUND} "$cmd not found in PATH"


We could also wrap the entirety of commit aae9560a in

     if {[is_Windows]} { ... }

as all of this code is fixing a Windows specific vulnerability, though a 
fix like the above is needed regardless.

Mark

