Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6497CC433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 02:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39FDF613B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 02:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhEECFa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 22:05:30 -0400
Received: from elephants.elehost.com ([216.66.27.132]:19030 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhEECF3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 22:05:29 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 14524N8g098117
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 4 May 2021 22:04:24 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Philip Oakley'" <philipoakley@iee.email>
Cc:     <git@vger.kernel.org>
References: <043101d73aae$026409b0$072c1d10$@nexbridge.com>     <fa8f81db-d470-130e-115d-7aef5e97e5a7@iee.email> <xmqqlf8u57jl.fsf@gitster.g>
In-Reply-To: <xmqqlf8u57jl.fsf@gitster.g>
Subject: RE: Advise request on adding a new SSH variant
Date:   Tue, 4 May 2021 22:04:15 -0400
Message-ID: <008b01d74152$f68eb3f0$e3ac1bd0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQICl0JKo2eflaadgk4Zc8OO/4gdTgInfQGrAhe9rQeqW3mcYA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Randall S. Becker, Managing Director, Nexbridge Inc.
+1.416.984.9826

>-----Original Message-----
>From: Junio C Hamano <gitster@pobox.com>
>Sent: May 4, 2021 8:49 PM
>To: Philip Oakley <philipoakley@iee.email>
>Cc: Randall S. Becker <rsbecker@nexbridge.com>; git@vger.kernel.org
>Subject: Re: Advise request on adding a new SSH variant
>
>Philip Oakley <philipoakley@iee.email> writes:
>
>> I was also thinking that the lack of replies maybe links to the "Pain
>> points in Git's patch flow" thread <YHaIBvl6Mf7ztJB3@google.com>
>> whereby it's all about the proposed patch, rather than thoughts about
>> a potential patch.
>> (Sort of like the philosophy of science [method] that ignores opinion,
>> and demands evidence)
>
>Actually, the initial message on this matter from Randall came in the patch
form
><011e01d73dd0$ec141530$c43c3f90$@nexbridge.com>, so if it were truly "it's
>all about the proposed patch, rather than thoughts about a potential
patch", it
>would have gained much more responses.
>
>Other than I didn't have time, the reason I didn't respond was that the
concept
>and notation used there were a bit too foreign to me to decide from where
to
>start asking questions.  It wasn't clear what '$ZSSHX' meant (is it the
value of an
>environment variable whose name is ZSSHX, or is it literally a name with
dollar
>in it and is the issue being addressed that it is too cumbersome to quote
it
>properly in value of the GIT_SSH_COMMAND environment variable?) for
>example.  And after reading the message you are responding to twice, I do
not
>quite get what problem we are trying to solve.  Especially since
>
>    No, it would be GIT_SSH_COMMAND='/G/system/zssh/sshoss -Z -Q -S
>    $ZSSH0' and that does not work correctly in the current git code
>    base.
>
>in <012601d73ddf$3d0cf660$b726e320$@nexbridge.com> sounded like we
>have a fairly clearly demonstratable problem (i.e. the handling of the
command
>line given via GIT_SSH_COMMAND is somehow broken). The details of "does not
>work correctly in the current code base" is not yet disclosed but it
sounded like it
>would be possible to tease it out and solve the issue in a more direct way.
But
>yet the solution presented in the three-patch series looked like it was
>sidestepping the entire issue and adding a special case for NonStop without
>having to touch GIT_SSH_COMMAND at all (presumably leaving it still
"broken").

Were it not for the response in thread
https://public-inbox.org/git/008101d4f3db$56c20410$04460c30$@nexbridge.com,
I would take a 100% agreement position. But it sounded like the problem was
platform-related so would not be fixed, thus the variant that avoids the
issue.

By running a shell if GIT_SSH_COMMAND is not a simple path, with potentially
multiple levels of escapes of the $ required, depending on the circumstances
of how the command is run, I would agree completely. However, with a
variant, as described in how the variant operates (from my interpretation),
it seems like the approach of the patch is correct by avoiding shell
variable resolution on an exotic platform rather than solving an otherwise
situation that would not be likely to occur anywhere else.

The environment variable is named SSH2_PROCESS_NAME and contains a value
starting with $ - making a shell interpret it if a shell is started. $ZSSH0
is a typical name used, but the value varies from system to system, except
for the $ that is mandatory to designate the name of a process. There was no
UNIX variant in 1978 when the platform was created, so that prefix character
was chosen. It won't change in the foreseeable future, for the expected
lifespan of the platform.

With all of the above, as long as there is a potential solution, I'm up for
it, but let me know how you would like it to look and I'll try to make it
work.

-Randall "who did not himself come up with the NonStop naming structure" and
"who has no control over how NonStop SSH interprets anything whatsoever"
Becker.


