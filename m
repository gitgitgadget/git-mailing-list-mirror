Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B5CC433EF
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 21:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiGJVwt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 17:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJVws (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 17:52:48 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CDCDF64
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 14:52:47 -0700 (PDT)
Received: from host-78-147-178-211.as13285.net ([78.147.178.211] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oAer7-0000fd-Fj;
        Sun, 10 Jul 2022 22:52:46 +0100
Message-ID: <e45c4fc1-3a30-726c-51f3-00caeca0a552@iee.email>
Date:   Sun, 10 Jul 2022 22:52:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/4] doc add: renormalize is not idempotent for CRCRLF
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
 <d3b8ed97a105ea1d7e656c964b7eee378e11ede6.1657385781.git.gitgitgadget@gmail.com>
 <xmqqilo6t2qy.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqilo6t2qy.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/07/2022 22:06, Junio C Hamano wrote:
> "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Philip Oakley <philipoakley@iee.email>
>>
>> Bug report
>>  https://lore.kernel.org/git/AM0PR02MB56357CC96B702244F3271014E8DC9@AM0PR02MB5635.eurprd02.prod.outlook.com/
>> noted that a file containing /r/r/n needed renormalising twice.
> Did you mean backslash, not forward?

Correct. Too many years of Windows.
>
>> This is by design. Lone CR characters, not paired with an LF, are left
>> unchanged. Note the lack of idempotentness of the "clean" filter in the
>> documentation.
> OK.
>
>
>> Renormalize was introduced at 9472935d81e (add: introduce "--renormalize",
>> Torsten Bögershausen, 2017-11-16)
> Does this need to be said "HERE", rather than leaving it to run "git
> blame" for those who became curious?

It was a misguided reminder to cc Torsten about his recollection of the
CRCRLF issue. I'll remove it. I see Torsten has also commented.
>
>> Signed-off-by: Philip Oakley <philipoakley@iee.email>
>> ---
>>  Documentation/git-add.txt | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
>> index 11eb70f16c7..c4a5ad11a6b 100644
>> --- a/Documentation/git-add.txt
>> +++ b/Documentation/git-add.txt
>> @@ -188,7 +188,8 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
>>  	forcibly add them again to the index.  This is useful after
>>  	changing `core.autocrlf` configuration or the `text` attribute
>>  	in order to correct files added with wrong CRLF/LF line endings.
>> -	This option implies `-u`.
>> +	This option implies `-u`. Lone CR characters are untouched, so
>> +	cleaning *^* not idempotent. A CRCRLF sequence cleans to CRLF.
> Lack of verb BE somewhere. 
'^' It took me three re-reads to see my mistyping as my head knew what
I'd meant to write, I've marked above as a note to self.
Aside: Are there any guides / suggestions / how-to's for on-line
reviewing that you can recommend o
> Do we expect our readers all understand the math-y word? 
Ok. It's mainly used in the test directory, and fsmonitor.h, but not in
the user docs.

>  It is not
> too hard to explain it to math-uninitiated, e.g.
>
>     This option implies `-u`.  Note that running renormalize again
>     on the result of running renormalize may make it even "more
>     normal".  A CR-CR-LF sequence would first renormalize to CR-LF
>     (the first CR, a lone CR, is left intact, and CR-LF that follows
>     normalizes to LF).  If you run renormalize again, the resulting
>     CR-LF will normalize down to LF.
>
Torsten had a shorter suggestion I'll also look at.

Philip
