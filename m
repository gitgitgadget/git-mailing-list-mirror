Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,T_HK_NAME_DR shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FD521F462
	for <e@80x24.org>; Fri, 31 May 2019 17:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfEaRYa (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 13:24:30 -0400
Received: from vwp8955.webpack.hosteurope.de ([176.28.35.119]:60616 "EHLO
        vwp8955.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726806AbfEaRYa (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 May 2019 13:24:30 -0400
Received: from [2001:16b8:5c8e:5500:5015:4633:2bbd:77c7]; authenticated
        by vwp8955.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1hWlGU-0002o4-5V; Fri, 31 May 2019 19:24:26 +0200
Subject: Re: [PATCH] make slash-rules more readable
To:     Junio C Hamano <gitster@pobox.com>
References: <20190531074426.6810-1-admin@in-ici.net>
 <xmqqh89awprl.fsf@gitster-ct.c.googlers.com>
From:   "Dr. Adam Nielsen" <admin@in-ici.net>
Cc:     git@vger.kernel.org
Message-ID: <88c6cf45-3908-6561-c3bf-11adf628f8af@in-ici.net>
Date:   Fri, 31 May 2019 19:24:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqh89awprl.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;admin@in-ici.net;1559323469;11dc0a0a;
X-HE-SMSGID: 1hWlGU-0002o4-5V
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 31.05.19 18:30, Junio C Hamano wrote:
> "Dr. Adam Nielsen" <admin@in-ici.net> writes:
> 
>> gitignore.txt: make slash-rules more readable
>>
>> Remove meta-rule in a paragraph for trailing-slash.
>> Be precise whenever a trailing slash would make a
>> difference. Improve paragraph for pattern without slash.
>> Remove rule for leading slash because its now redundant.
>> Instead, add examples for leading slash and asterix in
>> example section.
>>
>> Signed-off-by: Dr. Adam Nielsen <admin@in-ici.net>
>>
>> ---
>>   Documentation/gitignore.txt | 71 ++++++++++++++++++++++++++-----------
>>   1 file changed, 50 insertions(+), 21 deletions(-)
> 
> I think the updated text is readable, except for one nit.
> 
> Specifically, if you took my suggestion in an earlier review to

I guess you are referencing on your review from 08.05.2019 to which I 
responded On 12.05.19 11:56,

 >> The "note" is not incorrect per-se.  The behaviour described is
 >> because the leading slash is removed for the purpose of textual
 >> matching against paths, but still counts as a non-trailing slash for
 >> the purpose of anchoring the pattern to the level of recursion.
 >>
 >> I am not sure if that is obvious to the readers, though.
 >
 > Yes, its not explained to the reader that the leading slash is removed
 > for the purpose of textual matching. But maybe this is not necessary in
 > order to understand the effect of the pattern.

> explicitly say that leading slash is merely a workaround for a
> string without slash to anchor the pattern to the directory and
> it should be treated as if it does not exist otherwise, then ...
> 
>> + - The pattern `doc/frotz` and `/doc/frotz` have the same effect
>> +   in any `.gitignore` file. Both pattern contain a non-trailing
>> +   slash and thus match relative to the location of the
>> +   `.gitignore` file.
> 
> ... this paragraph wouldn't have been necessary.

I think this above example follows from (and thus isn't necessary, but 
just a fine example)

     + - The pattern is matched relative to the location of
     +   the `.gitignore` file. Except if the pattern contains
     +   no slash [...]

Because a pattern with a leading slash has a slash, it "is matched 
relative to the location of the `.gitignore` file".

> 
> Besides, one extra reason why these two have the same effect is not
> given in the updated text to explain away "To which substring of
> path 'doc/frotz' does that leading slash in /doc/frotz match?"
 >
> The updated text does not seem to explain that the leading slash is
> merely to pretend that the pattern "contains a slash so it does not
> apply in a subdirectory" and for the purpose of pattern matching the
> slash does not participate in the textual match, which seems to have
> been lost in the updated patch, relative to the suggestions raised
> in the review of earlier rounds.

I believe its not said anywhere in the docs that the pattern is compared 
  by a textual match to a piece of the full path of a file\folder (where 
the path is represented as in a unix-like OS).

I feel like your proposal from

On 08.05.19 07:33, Junio C Hamano wrote:
 >  - A leading slash, if any, is implicitly removed before matching the
 >    pattern with the pathname, but the pattern still counts as having
 >    a non-trailing slash for the purpose of the above rule.

is great for everyone who knows about the algorithm in the background, 
but for others it might be unclear what is meant.

For example "pathname" is not explained anywhere. Its not clear if 
"pathname" itself contains a leading slash, or in which format the 
"pathname" is represented, or if its is absolute or relative.
And "implicitly removed before matching.." is maybe a bit confusing for 
people that see the matching algorithm as a black box. If its not 
explained anywhere in detail how the matching algorithm is conducted, 
why would it matter to tell that the leading slash is removed implicitly?

Thats why I think, the case with the leading slash is already covered by 
the paragraph

     + - The pattern is matched relative to the location of
     +   the `.gitignore` file. Except if the pattern contains
     +   no slash [...]

and why I put the further explanations (that are not necessary in my 
opinion, but also not obvious) in the example section.

Thus, I don't feel the need to add another paragraph, but if you want, I 
can add

 >  - A leading slash, if any, is implicitly removed before matching the
 >    pattern with the pathname, but the pattern still counts as having
 >    a non-trailing slash for the purpose of the above rule.

as another bullet to the patch.

All the best,
Adam
