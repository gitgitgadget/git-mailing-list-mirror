Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E48441FD99
	for <e@80x24.org>; Sun, 14 Aug 2016 23:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315AbcHNXXW (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 19:23:22 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:17553 "EHLO
	smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbcHNXXV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 19:23:21 -0400
Received: from PhilipOakley ([92.22.48.2])
	by smtp.talktalk.net with SMTP
	id Z4kQb42dIcpskZ4kQbC8Vh; Mon, 15 Aug 2016 00:23:18 +0100
X-Originating-IP: [92.22.48.2]
X-Spam:	0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=dUEO/agNDYQW2w9YSFWSZw==:117
 a=dUEO/agNDYQW2w9YSFWSZw==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=fKXudXtD-pwHR-lXDuoA:9 a=0RhZnL1DYvcuLYC8JZ5M:22
 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <73D1326EA2D94A1D8898884BF047C1B5@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Junio C Hamano" <gitster@pobox.com>
Cc:	"GitList" <git@vger.kernel.org>
References: <20160814214630.1312-1-philipoakley@iee.org><20160814214630.1312-4-philipoakley@iee.org> <xmqqvaz3j8ln.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH v1 3/3] doc: rebase: clarify fixup! fixup! constraint
Date:	Mon, 15 Aug 2016 00:23:18 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfHPA52Lj0ViKTTV7HvPNykaKOlKPa6ppQKwSW869scpsbfT/LvBJ0et3mTShvkncvumUFwVKkRcnQyvggTsl0YhKhW/Wm1tuh06v/wYo/yauEB7/fxYz
 VpxHzCNWxxdlrO8Tqnctiw9OnggPmaIen8wSkm3LIyKS5da3wJLb95Va2UF1+HQvHljZCecuoV5eiQ==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> Philip Oakley <philipoakley@iee.org> writes:
>
>> 22c5b13 (rebase -i: handle fixup! fixup! in --autosquash, 2013-06-27)
>
> That's a noun that names a commit object.  What about it?

It's the commit that introduced the original change that's being clarified. 
Is a paragraph needed or simply "Ref commit: .."

>
>> I certainly misunderstood what this meant. It sounded like only one 
>> fixup! was
>> allowed per commit (i.e. one mistake) - fixing two mistakes wouldn't be
>> allowed. Hindsight is a wonderful thing.
>
> I think this is about

Yes, but the original wording didn't make me think that.

>
> git commit -m foo
> ... some other commits
>        git commit -m 'fixup! foo'
> ... even more other commits
>        git commit -m 'fixup! fixup! foo'
>
> The last one is technically a fixup of the second one, but as long
> as the second one is to be applied _and_ the last one comes after
> the second one, we could say that both of them are fix-ups for the
> very first one.  And that is what the original text says.

No. To me it said "You can only have one fixup (commit) for any given 
commit". So that's one original, and one fixup. After that the autosquash 
would leave the remaining fixup commits in their original positions in the 
commit sequence. Hence the patch.

>
> I have a feeling that if the editor session to edit the todo drops
> the second one and leaves this:
>
> pick foo
>        fixup fixup! fixup! foo
>
> the command _should_ notice that the second one that is required to
> apply the last one is gone and error out, but probably the code does
> not do so, and if that is the case, I think "they fix the very first
> commit that invited these fixups" is a more reasonable description
> than the more technically stringent "fixup! fixup! is to fix what
> the fixup! did", which is not what the code implements.
>
>> Also, does 'earliest commit requiring fixup/squash' fully convey that
>> its the one to fix.
>
> I cannot tell if that a question or a statement?

It's a question. In your prior para you offer "they fix the very first
> commit that invited these fixups" as an alternate.
It's when a users mental model is that they got their first fixup wrong and 
it's that fixup they are correcting, and later they add different fixups to 
the orignal that it all gets hairy.
(diffs must have the right sequence, while snapshots don't care - so if we 
keep the diff sequence, we don't care about the user's mental model as the 
end results are the same).

The writeup needs to cope with the mental model rather than the end result.

It maybe that the whole 'fixup/squash' capability should be brought out as a 
small separate section to give space to these points and the user 
understanding.
>
>> ---
>>  Documentation/git-rebase.txt | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
>> index 66b789a..91eb107 100644
>> --- a/Documentation/git-rebase.txt
>> +++ b/Documentation/git-rebase.txt
>> @@ -425,9 +425,9 @@ without an explicit `--interactive`.
>>  automatically modify the todo list of rebase -i
>>  so that the commit marked for squashing comes right after the
>>  commit to be modified, and change the action of the moved
>> - commit from `pick` to `squash` (or `fixup`).  Ignores subsequent
>> - "fixup! " or "squash! " after the first, in case you referred to an
>> - earlier fixup/squash with `git commit --fixup/--squash`.
>> + commit from `pick` to `squash` (or `fixup`).  Commits with repeated
>> + "fixup! " or "squash! " in the subject line are considered to refer
>> + to the earliest commit requiring fixup/squash.
>>  +
>>  This option is only valid when the '--interactive' option is used.
>>  +
> 

