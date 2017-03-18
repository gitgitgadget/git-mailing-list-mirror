Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 869E32095B
	for <e@80x24.org>; Sat, 18 Mar 2017 15:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751127AbdCRPJ4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 11:09:56 -0400
Received: from lang.hm ([66.167.227.134]:38826 "EHLO bifrost.lang.hm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751007AbdCRPJy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 11:09:54 -0400
Received: from dlang-laptop ([10.2.0.162])
        by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id v2IEwFIU005939;
        Sat, 18 Mar 2017 06:58:15 -0800
Date:   Sat, 18 Mar 2017 07:58:14 -0700 (PDT)
From:   David Lang <david@lang.hm>
X-X-Sender: dlang@dlang-laptop
To:     =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Is there a way to have a local version of a header file?
In-Reply-To: <CACBZZX5FMdjuxxNru+XfTQdSXEQ_b0OP2rngGZLf1sSHR_D8Ng@mail.gmail.com>
Message-ID: <nycvar.QRO.7.75.62.1703180750460.3797@qynat-yncgbc>
References: <nycvar.QRO.7.75.62.1703180724490.3797@qynat-yncgbc> <CACBZZX5FMdjuxxNru+XfTQdSXEQ_b0OP2rngGZLf1sSHR_D8Ng@mail.gmail.com>
User-Agent: Alpine 2.20.17 (DEB 179 2016-10-28)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1846243750-1489849095=:3797"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1846243750-1489849095=:3797
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 18 Mar 2017, Ævar Arnfjörð Bjarmason wrote:

> On Sat, Mar 18, 2017 at 3:29 PM, David Lang <david@lang.hm> wrote:
>> for an embedded project built inside the Arduino IDE, (alternate firmware
>> for a home automation project) there is a need to set a number of parameters
>> that we really don't want in the main repo (wifi network IDs/passwords)
>>
>> right now, we have these things set as #defines in a header file.
>>
>> We need to distribute a base version of this file for new people to get
>> started.
>>
>> Is there any way to have git define a file in such a way that if it doesn't
>> exist in the worktree it gets populated, but if it does exist it doesn't get
>> overwritten? (as I type this, I'm thinking a trigger may work, but we need
>> it to work on Linux, Windows and OSX)
>>
>> Any thoughts on a sane way to handle this situation?
>
> There's no sane way to do what you're describing without renaming the file.
>
> But the sanest way to do this is to have a config.h.example
>
> Then you have "/config.h" in the .gitignore file.
>
> And you tell the users to copy the *.example file to *.h, and your
> program then includes the *.h file.
>
> If you wanted to provide defaults you could just #include the
> config.h.example first, so #defines in the *.h file would clobber
> those in the *.example.

That's what we currently have (user_config.h and user_config_override.h)

I was hoping to not have the situation where downloading and trying to compile 
will complain about a missing include file (if the users don't copy 
user_config_override_example.h to user_config_override.h) while letting us do a 
.gitignore on user_config_override.h

for many people using this project, this is the first time they have ever 
compiled anything, and we have the typical set of people not reading 
instructions :-/

Darn, I was hoping that the scenario of needing to have a config file provided 
in the repo, while not overwriting local changes to it was common enough that 
there were some tricks available. This is a little harder as the running code 
doesn't have a filesystem so we are limited to what we can do in the compiler 
and git (no makefile even, the Arduino folks consider that too complicated, it 
just slurps up all .ino files in a directory and compiles them)

--8323328-1846243750-1489849095=:3797--
