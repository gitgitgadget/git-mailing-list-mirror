Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB98EC433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 11:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJMLaK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 07:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiJMLaI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 07:30:08 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAC563F16
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 04:30:05 -0700 (PDT)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oiwPc-0001uY-AL;
        Thu, 13 Oct 2022 12:30:04 +0100
Message-ID: <4cb7d3cb-36ff-0302-45c0-aa61644ef90b@iee.email>
Date:   Thu, 13 Oct 2022 12:30:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: Git diff misattributes the first word of a line to the previous
 line
Content-Language: en-GB
To:     Johannes Sixt <j6t@kdbg.org>, Gurjeet Singh <gurjeet@singh.im>
Cc:     git@vger.kernel.org
References: <CABwTF4U-KXHF7=8RWY7Ecbspz205Msa3syZFiWYDg3XmZsNGVw@mail.gmail.com>
 <f2453084-9f9a-74a1-6a43-0c1b91c95e93@kdbg.org>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <f2453084-9f9a-74a1-6a43-0c1b91c95e93@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Gurjeet,

On 13/10/2022 07:45, Johannes Sixt wrote:
> Am 13.10.22 um 07:51 schrieb Gurjeet Singh:
>> Git diff seems to get confused about word boundaries, and includes the
>> first word from the next line.
> No, that would misattribute the perceived malfunction.
>
>> It seems that the first word of a line gets attributed to the previous
>> line, ignoring the fact that there's an intervening newline before the
>> word.

Given that this effect is a part of the design (LF => whitespace), are
there any changes to the *documentation* that could be made to help
clarify this? E.g. looking back (you did check the manual? ;-) did you
miss some aspect in the man pages that could have been more prominent,
placed earlier, or clarified?

Why is this way of reporting even expected (e.g. confusion between
flowed text, and line oriented code, without a mode change), etc. ?

Any other `retrospective` thoughts that could help?

--
Philip

>> [...]
>> $ git diff --word-diff=plain /tmp/1.txt /tmp/2.txt
>> diff --git a/tmp/1.txt b/tmp/2.txt
>> index 8239f93..099fb80 100644
>> --- a/tmp/1.txt
>> +++ b/tmp/2.txt
>> @@ -1,2 +1,2 @@
>>     x = yz [-ab-]{+opt1+}
>> {+    ac+} = [-cd ef-]{+pq opt2+}
>>
>> $ cat /tmp/1.txt
>>     x = yz
>>     ab = cd ef
>>
>> $ cat /tmp/2.txt
>>     x = yz opt1
>>     ac = pq opt2
> The reason for this is that the implementation of word-diff does not
> treat newline characters in any special way. They are treated as
> "whitespace" like any other character that is not captured by the
> word-diff patterns. Whitespace characters following each word are
> recorded, but are disregarded when the word-diff is computed. When the
> text is reconstructed in the output, these recorded space characters are
> printed only for unchanged and added words, but are not printed for
> removed words (IIRC). Combine this with the fact that when there is a
> change, i.e., a combination of removal and addition, then the removal is
> printed before the addition, and you get the observed output.
>
> I don't see an easy solution for this without completely rewriting the
> implementation.
>
> -- Hannes
>

