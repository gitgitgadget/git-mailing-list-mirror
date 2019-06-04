Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ECF41F462
	for <e@80x24.org>; Tue,  4 Jun 2019 10:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfFDKku (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 06:40:50 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:45249 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbfFDKku (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 06:40:50 -0400
Received: from [192.168.1.22] ([78.148.161.28])
        by smtp.talktalk.net with SMTP
        id Y6s3h83XYgI7iY6s3hKFDf; Tue, 04 Jun 2019 11:40:48 +0100
X-Originating-IP: [78.148.161.28]
X-Spam: 0
X-OAuthority: v=2.3 cv=KYisTjQD c=1 sm=1 tr=0 a=ujKALdKAi7z8notBBWqKeA==:117
 a=ujKALdKAi7z8notBBWqKeA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8 a=9MajLSotQnU0hF5pxEYA:9 a=QEXdDO2ut3YA:10
Subject: Re: [PATCH] make slash-rules more readable
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Dr. Adam Nielsen" <admin@in-ici.net>,
        Git List <git@vger.kernel.org>
References: <20190531074426.6810-1-admin@in-ici.net>
 <xmqqh89awprl.fsf@gitster-ct.c.googlers.com>
 <979f6497-5e26-4a93-c345-f61b31c736c6@talktalk.net>
 <xmqqsgsqv98w.fsf@gitster-ct.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <221eab3b-75a1-c108-79a4-e2654c844d91@iee.org>
Date:   Tue, 4 Jun 2019 11:40:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqsgsqv98w.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfGAi27emAfeRADE6qq4rZBtHGU0StEAJusVlfVXdFykQ+3uEq1iHVpKArFwvJItu5DbotCOahN0/jaEzYlaVvG0WbG3bZwefVmHt7sNt8yKILnXEuNJ1
 j7B3assgPPfsTbviLrySSlovVyT5ClGT+kkhOJq80TRdQCh4pE/vZ9rKwHeod3PB5eQVwJSgvSHPR8euFaV1MFfiaMGYP7D6X/guN4So8h8hRDoww1RBZJsC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/06/2019 19:01, Junio C Hamano wrote:
> Philip Oakley <philipoakley@talktalk.net> writes:
>
>>  From a user perspective, implementation issues shouldn't be part of
>> the description unless absolutely essential.
>> Most user aren't aware of the implementation so don't grok/understand
>> what the fuss is about and ignore it...
> Oh, absolutely.  But unfortunately I do not see what that principle
> has anything to do with the comments you made in your message.
>
>>> Specifically, if you took my suggestion in an earlier review to
>>> explicitly say that leading slash is merely a workaround for a
>>> string without slash to anchor the pattern to the directory and
>>> it should be treated as if it does not exist otherwise, then ...
> Perhaps you thought "workaround" refers to some implementation
> glitch?  That is not what the word means in that sentence.  It is a
> technique to work around "you need a slash somewhere in the pattern
> to anchor it to a specific directory" that is a very user visible
> design.
It is the fact that we have ended up describing what needs to be done 
from having had the implementation problem. Thus we (accidentally) lock 
ourselves into a 'difficult to explain' situation.
>    The user absolutely need to be aware of it, if s/he wants
> to anchor a pattern that does not have a slash
No. That (as I read it, regarding the need for an initial slash) is the 
lock-in.

We should explain it from the other end  - to anchor the pattern one 
needs a slash either at the beginning or middle.

> (e.g. "I need a
> pattern to name/match the README file at this level but not in any
> of the subdirectories"), and an extra leading slash is a way to mark
> such a pattern that otherwise does not have a slash as anchored.
>
> The fact that the leading slash is such a syntactic marking of a
> pattern *and* is not a part of the pattern itself, would not help
> you understand the implementation, but you need to know it in order
> to use that feature effectively.
>
>>>> + - The pattern `doc/frotz` and `/doc/frotz` have the same effect
>>>> +   in any `.gitignore` file. Both pattern contain a non-trailing
>>>> +   slash and thus match relative to the location of the
>>>> +   `.gitignore` file.
>>> ... this paragraph wouldn't have been necessary.
>> ...leading to that user mistake having to be explained in numerous Q&A
>> threads - Why can't we an explicit explanation of this common user
>> mistake?
>> Arguably the issue is the special trailing slash rule getting
>> users confused..
> What common user mistake?  The above is about leading slash rule, by
> the way, so perhaps you are getting confused?
We do get a reasonable number of queries to the list regarding 
.gitignore patterns which generally indicate that user have been 
confused and failed to understand the overall man page description (both 
leading and training slashes being somehow special but exactly how they 
haven't fully fathomed..) (and plenty on StackOverflow)

I'll ad some more feedback to Adam's side of the thread, and a possible 
alternate suggestion.

Philip
