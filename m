Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA62CC433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 16:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A46FC61468
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 16:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhD3QjQ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 30 Apr 2021 12:39:16 -0400
Received: from elephants.elehost.com ([216.66.27.132]:43204 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhD3QjP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 12:39:15 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 13UGcOXA094336
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 30 Apr 2021 12:38:25 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Elijah Newren'" <newren@gmail.com>
Cc:     "'Git Mailing List'" <git@vger.kernel.org>
References: <011f01d73dd0$ecf91e00$c6eb5a00$@nexbridge.com> <CABPp-BH6RgiMwGLz31nHmis3VTpuEUG--G_6Y+Wfwg24u4Zbag@mail.gmail.com>
In-Reply-To: <CABPp-BH6RgiMwGLz31nHmis3VTpuEUG--G_6Y+Wfwg24u4Zbag@mail.gmail.com>
Subject: RE: [Patch 1/3] connect.c: add nonstopssh variant to the sshVariant set.
Date:   Fri, 30 Apr 2021 12:38:18 -0400
Message-ID: <012601d73ddf$3d0cf660$b726e320$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIWGYGttp5Jdx88vf9L/5ZtrxnlMwG55eaXqkG692A=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 30, 2021 12:25 PM, Elijah Newren wrote:
>On Fri, Apr 30, 2021 at 7:58 AM Randall S. Becker <rsbecker@nexbridge.com>
>wrote:
>>
>> From ba4beb8ed0dff67ae6b95692d346adce346e2871 Mon Sep 17 00:00:00
>2001
>> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>> Date: Fri, 30 Apr 2021 09:56:09 -0400
>> Subject: [Patch 1/3] connect.c: add nonstopssh variant to the sshVariant set.
>>
>> This enhancement allows the NonStop SSH subsystem to be supported by
>> git without the need of a wrapper script. The command arguments for
>> the platform SSH client in /G/system/zssh/sshoss are constructed based
>> on optional supplied environment variables SSH2_PROCESS_NAME (system
>> defined), SSH_SUPPRESS_QUIET, and SSH_SUPPRESS_BANNER.
>
>Before introducing 3 new special environment variables, I think this commit
>message should explain why you can't just use
>
>GIT_SSH_COMMAND="/G/system/zssh/sshoss -Z -Q -S"

No, it would be GIT_SSH_COMMAND='/G/system/zssh/sshoss -Z -Q -S $ZSSH0' and that does not work correctly in the current git code base.

>particularly since GIT_SSH_COMMAND was introduced specifically so people
>wouldn't have to create wrapper scripts to pass to GIT_SSH.

Going back through the archive to why this is needed: https://public-inbox.org/git/008101d4f3db$56c20410$04460c30$@nexbridge.com/

The SSH2_PROCESS_NAME is a system environment variable, not something I am introducing, that specifies the name of the SSH process. It's format is [\NODE.]$NAME, which causes shell to blank it out. A wrapper script is currently mandatory on this platform.

I have been looking for a solution since that thread.

-Randall

