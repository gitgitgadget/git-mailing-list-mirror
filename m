Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646C2C4167D
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 14:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237901AbiKWO2x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 09:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238719AbiKWO1I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 09:27:08 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C5E65863
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 06:26:03 -0800 (PST)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oxqhN-0000ex-7y;
        Wed, 23 Nov 2022 14:26:01 +0000
Message-ID: <7a6c3d32-4494-e209-9877-e8784f0c3502@iee.email>
Date:   Wed, 23 Nov 2022 14:26:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4] pretty-formats: add hard truncation, without ellipsis,
 options
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GitList <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
References: <20221102120853.2013-1-philipoakley@iee.email>
 <20221112143616.1429-1-philipoakley@iee.email> <xmqqfsedywli.fsf@gitster.g>
 <d80d1b97-b0c0-148b-afb7-f5210366e463@iee.email> <xmqqedtvu7py.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqedtvu7py.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/11/2022 00:57, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>>> As a design question, what should "Trunc" do in such a case now?  I
>>> do not think we can still call it "hard truncate" if the feature
>>> gives "[][]" (i.e. fill only 4 display columns, resulting in a
>>> string that is not wide enough) or "[][][]" (i.e. exceed 5 columns
>>> that are given), but of course chomping a letter in the middle is
>>> not acceptable behaviour, so ...
>> The design had already covered those cases. The author already had those
>> thoughts
> Sorry, I was saying that none of
>
>  * giving only [][] to fill only 4 display columns, without filling
>    the given 5 display columns,
>
>  * giving [][][] to fill 6 display columns, exceeding the given 5
>    display columns,
>
>  * giving [][][ that chomps a letter in the middle, in a failed
>    attempt to fill exactly 5 displya columns.
>
> would be a sensible design of the behaviour for "Trunc", so I am not
> sure what "had already covered" really mean...
>
I'm still unsure what you are trying to say here.

Is this a question about the prior `trunc`, `mtrunc`, and `ltrunc`
design and tests?
e.g. how complete are their tests?

Is it looking for an extended explanation of the 'fit in N-columns'
design approaches that they all have?

I'm happy to add a paragraph saying that an `Mtrunc`, i.e. miss out the
middle characters to fit the set column width, without using the two dot
ellipsis (`..`), was considered a non starter because of potential
confusion when looking at such output when tabulated.

The existing code (and tests) already covers the need to hide the
characters those two dots (ellipsis) consumed win the N-column tabulated
output. The tests also include utf8-encoded characters.

All the previous tests for `trunc` and `'ltrunc` (i.e. with ellipsis)
have been repeated for the `Trunc` and `Ltrunc` (without ellipsis) hard
truncation commands, and their expected outputs updated, including the
use of the qz_to_tab_space  for those case where trailing spaces are now
present.

Does that cover your questions?

--
Philip
