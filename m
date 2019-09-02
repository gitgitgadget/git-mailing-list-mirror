Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84FC81F461
	for <e@80x24.org>; Mon,  2 Sep 2019 22:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfIBWNT (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 18:13:19 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:32162 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbfIBWNT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 18:13:19 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1i4uZY-0003Ip-4j; Mon, 02 Sep 2019 23:13:16 +0100
Subject: Re: [PATCH 1/1] rebase -r: let `label` generate safer labels
To:     Matt Rogers <mattr94@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Matt R via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.327.git.gitgitgadget@gmail.com>
 <4a02c38442dd8a4c0381adc8db0dce81c253da09.1567432900.git.gitgitgadget@gmail.com>
 <444f3ec4-abdf-1aa9-e8a8-8b5346b939e8@gmail.com>
 <xmqq5zmav9ej.fsf@gitster-ct.c.googlers.com>
 <3edd55ed-b507-a14a-5cfb-0bfe471efbbc@iee.email>
 <CAOjrSZtw+wYHxFRQCfb80xzm9OsGDh2rW8uD+AYYdmDPxk5DFQ@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <b39e5215-f5d6-eca3-7f08-813b5508d779@iee.email>
Date:   Mon, 2 Sep 2019 23:13:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAOjrSZtw+wYHxFRQCfb80xzm9OsGDh2rW8uD+AYYdmDPxk5DFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/09/2019 22:47, Matt Rogers wrote:
> I can redo the commit, I had thought that I had previously fixed the 
> author but I guess I was mistaken.
>
> As for issues with non utf-8 encodings, I don't know of any simple way 
> to check for those except for restricting to asci alphanumeric characters

If I read the Wikipedia article [1] about the utf-8 design choices it is 
pretty reasonable and robust most of the time, though that maybe a part 
one way trapdoor.

> Also the code given doesn't resolve onelines that consist only of 
> restricted file names (e.g. COM, NUL, etc. On windows)

It maybe that the rebase doc may need (if it happens) a short comment 
warning of that.

Also need to check if the `label_oid()` function actually makes the 
label distinct, hence prevents such labels from being used as such a 
restricted file name - i.e. does it include the oid element.

Ultimately the label could be tweaked to have say the 4char prefix to 
fool the Windows 'starts with' name detection - which assumes I 
understand how some of those bad filenames are detected...
>
>
>
> On Mon, Sep 2, 2019, 5:24 PM Philip Oakley <philipoakley@iee.email> wrote:
>
>     On 02/09/2019 19:29, Junio C Hamano wrote:
>     > I see there are "lets make sure it is unique by suffixing "-%d" in
>     > other codepaths; would that help if this piece of code yields a
>     > label that is not unique?
>     maybe use a trailing 4 characters  of the oid to get a reasonably
>     unique
>     label?
>
>     Oh, just seen dscho's "we make sure that the labels are unique,
>     via the
>     `label_oid()` function!", maybe needs mentioning in the commit
>     message
>     if re-rolled.
>
>     Philip
>

[1] https://en.wikipedia.org/wiki/UTF-8#Description
