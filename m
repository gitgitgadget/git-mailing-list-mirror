From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 4/7] submodule update --init: correct path handling in
 recursive submodules
Date: Tue, 29 Mar 2016 12:49:50 -0700
Message-ID: <CAGZ79kZZoxBsAfsTohrLqf2f01fmbjK2rrOG5vQ6ShT-zOjeJw@mail.gmail.com>
References: <1459207703-1635-1-git-send-email-sbeller@google.com>
	<1459207703-1635-5-git-send-email-sbeller@google.com>
	<xmqqbn5xxe25.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jacob Keller <jacob.keller@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 21:50:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akzeG-0003hN-QO
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 21:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078AbcC2Ttw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 15:49:52 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:33166 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753994AbcC2Ttw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 15:49:52 -0400
Received: by mail-io0-f169.google.com with SMTP id a129so36848263ioe.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 12:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=jiZFyAT9muaiACGeROD2XTy8B/WmYmA3GN+XPg7ExYE=;
        b=chddDL3iwFM6XtX8msosJGig5CFK3U5nK+FYGwFPRCcwHVlPHifjUNw4XKkCeI2ATZ
         axgOd9ktzHzESQUWLKCCHHhYAO+3A3TQWwvq5BJHxGXTg5gwnksNu3N0rVNPyc/4PH+F
         6G/Qj8k618BTg5N5iEbkgKtzLTSmKWfJMR6vQfip1pXQR4itQtPhjiKNxNcp+W7B0Y6t
         tk/fRAV6FnjijcS/G/3sX7JByK4cnDPM3uROYRXMc/9KQLJmHw3IZ5HAMKXoZGiexyaz
         e0IMHEUZlB0uBCf0JykFvzgLNSXlwWXemU5anPf+/neaumSXDZxYWdpi7zBttvJyvRdG
         y2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=jiZFyAT9muaiACGeROD2XTy8B/WmYmA3GN+XPg7ExYE=;
        b=YMjV0Xf2QjV3oPWxQA+3it87u8+/cK2to8smnboUlo0od5CnY1mGHO6ZFRC0CO3Sfc
         kcm141BG9w5sIBuwmROdx9hoe3k8rTKzXUnyflhfd+SXbohfrmnEKiuaUw7TR5OZqZ5o
         z7v+TNdN/dF/JJUA+VVgyp39ZsMhHpN4lHlT/A+cnShtaqlBIW4I37cSTWpVsNGEg02k
         d0FCPr6C+1u4WMNXYA8kepnd0AgyoVrS1rqKbC1z8pcMCmrmcc1KGSlUlk6w8it4MR3n
         KbzwgLaHD7Ebn+bQW2/NcktPgG7uNDApfneZRYmzT9vL9DUBUizbijD9wS/+ZNYs5+J5
         8N5Q==
X-Gm-Message-State: AD7BkJL+ISO+IlGruYcdMhv3tUkkiQk9NsbNMbw4e69ImaYIrLo0hOuLF06wMxir5ZRWUC0CmKOAG8SdBnxAHYHY
X-Received: by 10.107.184.8 with SMTP id i8mr4903655iof.96.1459280990995; Tue,
 29 Mar 2016 12:49:50 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Tue, 29 Mar 2016 12:49:50 -0700 (PDT)
In-Reply-To: <xmqqbn5xxe25.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290176>

On Tue, Mar 29, 2016 at 12:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This fixes the test introduced by the parent commit.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>
> The first hunk in this patch touches lines that goes away with
> d5bc3cd2 (submodule: port init from shell to C, 2016-03-14) on
> your sb/submodule-init topic and the whole block is replaced
> by a call to "submodule--helper init".
>
> I'll drop the first hunk when merging this series to 'pu' for now;
> hopefully you did not inherit the bug when rewriting the part into
> "submodule--helper init".

After examining this patch more closely for a better commit message, the second
hunk also goes away, i.e. only the test will remain.

Maybe I can roll this series on top of origin/sb/submodule-init, to
avoid confusion.

>
> Thanks.
>
>>  git-submodule.sh            | 5 +++--
>>  t/t7406-submodule-update.sh | 2 +-
>>  2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 2838069..a7c8599 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -474,7 +474,7 @@ cmd_init()
>>               die_if_unmatched "$mode"
>>               name=$(git submodule--helper name "$sm_path") || exit
>>
>> -             displaypath=$(relative_path "$sm_path")
>> +             displaypath=$(relative_path "$prefix$sm_path")
>>
>>               # Copy url setting when it is not set yet
>>               if test -z "$(git config "submodule.$name.url")"
>> @@ -826,8 +826,9 @@ Maybe you want to use 'update --init'?")"
>>               if test -n "$recursive"
>>               then
>>                       (
>> -                             prefix="$prefix$sm_path/"
>> +                             prefix="$(relative_path $prefix$sm_path)/"
>>                               clear_local_git_env
>> +                             wt_prefix=
>>                               cd "$sm_path" &&
>>                               eval cmd_update
>>                       )
>> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
>> index c1b9ffa..3bd1552 100755
>> --- a/t/t7406-submodule-update.sh
>> +++ b/t/t7406-submodule-update.sh
>> @@ -118,7 +118,7 @@ Submodule path '../super/rebasing': checked out '${rebasingsha1}'
>>  Submodule path '../super/submodule': checked out '${submodulesha1}'
>>  EOF
>>
>> -test_expect_failure 'submodule update --init --recursive from subdirectory' '
>> +test_expect_success 'submodule update --init --recursive from subdirectory' '
>>       git -C recursivesuper/super reset --hard HEAD^ &&
>>       (cd recursivesuper &&
>>        mkdir tmp &&
