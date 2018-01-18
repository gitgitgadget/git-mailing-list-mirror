Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93AD11FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 22:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753921AbeARWIK (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 17:08:10 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:54286 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750718AbeARWIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 17:08:09 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id cILveThMcAp17cILveDYP0; Thu, 18 Jan 2018 22:08:08 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=EsGilWUA c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=1XWaLZrsAAAA:8 a=XcpDTPfKAAAA:8 a=w4rfsmNkK4XTtirAVdYA:9 a=QEXdDO2ut3YA:10
Message-ID: <32EA49C74ECD470F8EE898D965833E02@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Jacob Keller" <jacob.keller@gmail.com>,
        "Stefan Beller" <sbeller@google.com>
Cc:     "Johannes Schindelin" <johannes.schindelin@gmx.de>,
        "Git mailing list" <git@vger.kernel.org>,
        "Junio C Hamano" <gitster@pobox.com>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <20180118183618.39853-1-sbeller@google.com> <20180118183618.39853-3-sbeller@google.com> <CA+P7+xpwYDeNHfzMtHJkKEB8-A+kZ95wBEn0RC5R8pWbgKOmiQ@mail.gmail.com>
Subject: Re: [PATCH 10/8] [DO NOT APPLY, but improve?] rebase--interactive: introduce "stop" command
Date:   Thu, 18 Jan 2018 22:08:09 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 180118-34, 18/01/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfE9YqqbR2Mk97y4vAksUsK55GG/q60yZcsFKUwpYogEA6zDmEFqDlUOPSldqMPH2dyGcih+TRB9DmTM/RAWHOAI/mbEjEvb9IBqLtMkkwEIZFeqkK+x8
 bmE9Dod+XiDXRQB9k7FuTSruYOC+qdb6s0k0BGh94MHqzF0F/y2pl6+gtpxAuqSkipIyCM26w6G7ed1Ymsk3ochT4Zm2nHQXrIBmGrhU+cfPPZvgaTz5CJkN
 wv8ja6lzCMfpRJ9SS/+h7WPEs2rE7PHlUB2QgsqXFF0wa+q10AlxTVwwi/OhjgVU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Jacob Keller" <jacob.keller@gmail.com>
> On Thu, Jan 18, 2018 at 10:36 AM, Stefan Beller <sbeller@google.com> 
> wrote:
>> Jake suggested using "x false" instead of "edit" for some corner cases.
>>
>> I do prefer using "x false" for all kinds of things such as stopping
>> before a commit (edit only let's you stop after a commit), and the
>> knowledge that "x false" does the least amount of actions behind my back.
>>
>> We should have that command as well, maybe?
>>
>
>
> I agree. I use "x false" very often, and I think stop is probably a
> better solution since it avoids spawning an extra shell that will just
> fail. Not sure if stop implies too much about "stop the whole thing"
> as opposed to "stop here and let me do something manual", but I think
> it's clear enough.
>
'hold' or 'pause' maybe options (leads to 
http://www.thesaurus.com/browse/put+on+hold offering procastinate etc.)
'adjourn'.

>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  git-rebase--interactive.sh |  1 +
>>  sequencer.c                | 10 ++++++++++
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>> index 3cd7446d0b..9eac53f0c5 100644
>> --- a/git-rebase--interactive.sh
>> +++ b/git-rebase--interactive.sh
>> @@ -166,6 +166,7 @@ l, label <label>= label current HEAD with a name
>>  t, reset <label> = reset HEAD to a label
>>  b, bud = reset HEAD to the revision labeled 'onto', no arguments
>>  m, merge [<label-or-commit>]* = create a merge commit using a given 
>> commit's message
>> +y, stay = stop for  shortcut for
>>
>>  These lines can be re-ordered; they are executed from top to bottom.
>>  " | git stripspace --comment-lines >>"$todo"
>> diff --git a/sequencer.c b/sequencer.c
>> index 2b4e6b1232..4b3b9fe59d 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -782,6 +782,7 @@ enum todo_command {
>>         TODO_RESET,
>>         TODO_BUD,
>>         TODO_MERGE,
>> +       TODO_STOP,
>>         /* commands that do nothing but are counted for reporting 
>> progress */
>>         TODO_NOOP,
>>         TODO_DROP,
>> @@ -803,6 +804,7 @@ static struct {
>>         { 'l', "label" },
>>         { 't', "reset" },
>>         { 'b', "bud" },
>> +       { 'y', "stay" },
>>         { 'm', "merge" },
>>         { 0,   "noop" },
>>         { 'd', "drop" },
>> @@ -1307,6 +1309,12 @@ static int parse_insn_line(struct todo_item *item, 
>> const char *bol, char *eol)
>>                 return 0;
>>         }
>>
>> +       if (item->command == TODO_STOP) {
>> +               item->commit = NULL;
>> +               item->arg = "";
>> +               item->arg_len = 0;
>> +       }
>> +
>>         end_of_object_name = (char *) bol + strcspn(bol, " \t\n");
>>         item->arg = end_of_object_name + strspn(end_of_object_name, " 
>> \t");
>>         item->arg_len = (int)(eol - item->arg);
>> @@ -2407,6 +2415,8 @@ static int pick_commits(struct todo_list 
>> *todo_list, struct replay_opts *opts)
>>                                 /* `current` will be incremented below */
>>                                 todo_list->current = -1;
>>                         }
>> +               } else if (item->command == TODO_STOP) {
>> +                       todo_list->current = -1;
>>                 } else if (item->command == TODO_LABEL)
>>                         res = do_label(item->arg, item->arg_len);
>>                 else if (item->command == TODO_RESET)
>> --
>> 2.16.0.rc1.238.g530d649a79-goog
>> 

