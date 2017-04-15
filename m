Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B7981FA14
	for <e@80x24.org>; Sat, 15 Apr 2017 12:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753428AbdDOMal (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 08:30:41 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:13026 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751955AbdDOMal (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2017 08:30:41 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3w4v4v6sd0z5tlB;
        Sat, 15 Apr 2017 14:30:39 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 704F71CFA;
        Sat, 15 Apr 2017 14:30:39 +0200 (CEST)
From:   Johannes Sixt <j6t@kdbg.org>
Subject: Re: Index files autocompletion too slow in big repositories (w /
 suggestion for improvement)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Carlos Pita <carlosjosepita@gmail.com>
References: <CAELgYhf1s43p62t6W14S=nDt-O247cPqsPMUDfye1OTnDND3Gg@mail.gmail.com>
 <CAELgYhfwwLZXGN9yHZ04koDwGn3=KbuJOxhLM-+PCbumTmMunw@mail.gmail.com>
 <CACBZZX7Ajf1c9YKP=MO0T9SV7d0-XZsT=RthJocqZw4_TcCcQw@mail.gmail.com>
Cc:     =?UTF-8?B?4oCcZ2l0QHZnZXIua2VybmVsLm9yZ+KAnQ==?= 
        <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Message-ID: <3711baf1-af54-b5c9-25e8-9613312c536a@kdbg.org>
Date:   Sat, 15 Apr 2017 14:30:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CACBZZX7Ajf1c9YKP=MO0T9SV7d0-XZsT=RthJocqZw4_TcCcQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cc Gábor, resent with working email (hopefully); please follow-up on 
this mail.

Am 15.04.2017 um 00:33 schrieb Ævar Arnfjörð Bjarmason:
> On Sat, Apr 15, 2017 at 12:08 AM, Carlos Pita <carlosjosepita@gmail.com> wrote:
>> This is much faster (below 0.1s):
>>
>> __git_index_files ()
>> {
>>     local dir="$(__gitdir)" root="${2-.}" file;
>>     if [ -d "$dir" ]; then
>>         __git_ls_files_helper "$root" "$1" | \
>>             sed -r 's@/.*@@' | uniq | sort | uniq
>>     fi
>> }
>>
>> time __git_index_files
>>
>> real    0m0.075s
>> user    0m0.083s
>> sys    0m0.010s
>>
>> Most of the improvement is due to the simpler, non-grouping, regex.
>> Since I expect most of the common prefixes to arrive consecutively,
>> running uniq before sort also improves things a bit. I'm not removing
>> leading double quotes anymore (this isn't being done by the current
>> version, anyway) but this doesn't seem to hurt.
>>
>> Despite the dependence on sed this is ten times faster than the
>> original, maybe an option to enable fast index completion or something
>> like that might be desirable.
>
> It's fine to depend on sed, these shell-scripts are POSIX compatible,
> and so is sed, we use sed in a lot of the built-in shellscripts.

This is about command line completion. We go a long way to avoid forking 
processes there. What is 10x faster on Linux despite of forking a 
process may not be so on Windows.

(I'm not using bash command line completion on Windows, so I can't tell 
what the effect of your suggested change is on Windows. I hope Gábor can 
comment on it.)

-- Hannes
