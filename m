Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28437C433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1A42611BE
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbhEJP0M convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 10 May 2021 11:26:12 -0400
Received: from elephants.elehost.com ([216.66.27.132]:20974 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbhEJPZT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 11:25:19 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 14AFOBDZ043534
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Mon, 10 May 2021 11:24:12 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Git Mailing List'" <git@vger.kernel.org>
References: <011f01d73dd0$ecf91e00$c6eb5a00$@nexbridge.com> <CABPp-BH6RgiMwGLz31nHmis3VTpuEUG--G_6Y+Wfwg24u4Zbag@mail.gmail.com> <012601d73ddf$3d0cf660$b726e320$@nexbridge.com> <CABPp-BE_5c1vXuxPWTO82cGmyajXxpxW+-ycZ+-5vy+tsV3bUA@mail.gmail.com> <012901d73de6$c25a4ff0$470eefd0$@nexbridge.com>
In-Reply-To: <012901d73de6$c25a4ff0$470eefd0$@nexbridge.com>
Subject: RE: [Patch 1/3] connect.c: add nonstopssh variant to the sshVariant set.
Date:   Mon, 10 May 2021 11:24:06 -0400
Message-ID: <01dd01d745b0$875c6920$96153b60$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIWGYGttp5Jdx88vf9L/5ZtrxnlMwG55eaXAXoXgPoC7mL63QI2zlGUqhxkGVA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 30, 2021 1:32 PM, I wrote:
>Subject: RE: [Patch 1/3] connect.c: add nonstopssh variant to the sshVariant set.
>
>On April 30, 2021 1:17 PM, Elijah Newren wrote:
>>On Fri, Apr 30, 2021 at 9:38 AM Randall S. Becker
>><rsbecker@nexbridge.com>
>>wrote:
>>>
>>> On April 30, 2021 12:25 PM, Elijah Newren wrote:
>>> >On Fri, Apr 30, 2021 at 7:58 AM Randall S. Becker
>>> ><rsbecker@nexbridge.com>
>>> >wrote:
>>> >>
>>> >> From ba4beb8ed0dff67ae6b95692d346adce346e2871 Mon Sep 17
>00:00:00
>>> >2001
>>> >> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>>> >> Date: Fri, 30 Apr 2021 09:56:09 -0400
>>> >> Subject: [Patch 1/3] connect.c: add nonstopssh variant to the sshVariant
>set.
>>> >>
>>> >> This enhancement allows the NonStop SSH subsystem to be supported
>>> >> by git without the need of a wrapper script. The command arguments
>>> >> for the platform SSH client in /G/system/zssh/sshoss are
>>> >> constructed based on optional supplied environment variables
>>> >> SSH2_PROCESS_NAME (system defined), SSH_SUPPRESS_QUIET, and
>>SSH_SUPPRESS_BANNER.
>>> >
>>> >Before introducing 3 new special environment variables, I think this
>>> >commit message should explain why you can't just use
>>> >
>>> >GIT_SSH_COMMAND="/G/system/zssh/sshoss -Z -Q -S"
>>>
>>> No, it would be GIT_SSH_COMMAND='/G/system/zssh/sshoss -Z -Q -S
>$ZSSH0'
>>and that does not work correctly in the current git code base.
>>
>>Is the problem that $ZSSH0 may contain spaces, or that $ZSSH0 is
>>expected to change over time and you don't want to have to re-run
>>
>>GIT_SSH_COMMAND="/G/system/zssh/sshoss -Z -Q -S $ZSSH0"
>>
>>each time?
>>
>>> >particularly since GIT_SSH_COMMAND was introduced specifically so
>>> >people wouldn't have to create wrapper scripts to pass to GIT_SSH.
>>>
>>> Going back through the archive to why this is needed:
>>> https://public-inbox.org/git/008101d4f3db$56c20410$04460c30$@nexbridg
>>> e
>>> .com/
>>>
>>> The SSH2_PROCESS_NAME is a system environment variable, not something
>>> I
>>am introducing, that specifies the name of the SSH process. It's format
>>is [\NODE.]$NAME, which causes shell to blank it out. A wrapper script
>>is currently mandatory on this platform.
>>>
>>> I have been looking for a solution since that thread.
>>
>>Ah, so it's the case that $ZSSH0 changes for you, but is set somewhere
>>by the system and you don't want to have to redefine GIT_SSH_COMMAND
>>each time you log into some box.
>>
>>At a minimum, this explanation should be included in the commit message
>>here, otherwise the problem you're trying to address won't be
>>understood by reviewers.  It wasn't at all clear to me from your cover
>>letter or this commit, and I even had trouble parsing it out of the
>>other thread you linked to.  Only this above paragraph about
>>SSH2_PROCESS_NAME and its value on your system explain it. (It's still
>>hard to tell what from your "[\NODE.]$NAME" is literal text and what is
>>meant to be replaced, though, it might be useful to have an example of
>>the literal value of SSH2_PROCESS_NAME on some random node in the
>>explanation as well.)
>
>SSH2_PROCESS_NAME tends not to change much, although it is bound to a set of
>subnets. Example values are $ZSSH0 or \NODE.$ZSSH0, depending on whether
>the system admit decides to qualify the name with it's cluster host name, since
>you could use a different process on a different node. The name may change
>between repositories - so going to github.com would commonly have a different
>process name than a local enterprise server. I really would consider putting this
>in .gitconfig so it can be repository-specific, but I'd prefer to see whether this
>change has legs before doing that.
>
>There are use cases on the platform where, from the user's perspective, this
>value may be random. It is set on an inbound SSH session by the server and
>provided to the shell in that variable. Users will either use the system supplied
>process (somewhat QoS-related) or will select their own.
>
>Do you have suggestions about the other two settings? I don't like the
>environment variable approach, but passing switches through git seems pretty
>heavy to me.
>
>I will do what I can to expand the discussion in the connect.c commit on V2.

I'm wondering whether this is going to move forward or whether changes are needed. There is no V2 since suppression control of the various parameters used to set up the command appears to be needed.

Thanks,
Randall

