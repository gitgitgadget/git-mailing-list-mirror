Return-Path: <SRS0=sBbF=2V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7348C2D0C2
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 10:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B86206DB
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 10:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfLaKBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Dec 2019 05:01:51 -0500
Received: from smtprelay08.ispgateway.de ([134.119.228.106]:46277 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfLaKBv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Dec 2019 05:01:51 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay08.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1imELS-0005cW-Qr; Tue, 31 Dec 2019 11:01:46 +0100
Subject: Re: [PATCH v2 1/3] t: fix quotes tests for --pathspec-from-file
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.503.git.1577727747.gitgitgadget@gmail.com>
 <pull.503.v2.git.1577733329.gitgitgadget@gmail.com>
 <6193dc7396b9cc6cb78f382c1b1679d6bb455fe4.1577733329.git.gitgitgadget@gmail.com>
 <CAPig+cSSqAxuHYg9DxuJzC7m2HAt8F2YPNxT0x5+SksCGic4MA@mail.gmail.com>
 <20191231002607.GC13606@google.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <17de8859-10c2-b3e0-df5d-bf6d2681a528@syntevo.com>
Date:   Tue, 31 Dec 2019 11:01:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191231002607.GC13606@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luckily, trailing \n didn't matter much, and I could also send input via 
commandline argument instead of stdin, so here-doc is really the most 
readable solution here.

Fixed it in V3, thanks for your suggestion!

On 30.12.2019 22:55, Eric Sunshine wrote:
 > So, you want git-checkout to receive the following, quotes, backslash,
 > and no newline, on its standard input?
 >
 >      "file\101.t"
 >
 > If so, another way to achieve the same without taxing the brain of the
 > reader or the next person who works on this code would be:
 >
 >      tr -d "\012" | git checkout --pathspec-from-file=- HEAD^1 <<-\EOF &&
 >      "file\101.t"
 >      EOF
 >
 > Although it's three lines long, the body of the here-doc is the
 > literal text you want sent to the Git command, so no counting
 > backslashes, and no need for a lengthy in-code comment.
 >
 > But is the "no newline" bit indeed intentional? If not, then a simple
 > echo would be even easier (though with a bit more escaping):
 >
 >      echo "\"file\101.t\"" | git checkout --pathspec-from-file=- 
HEAD^1 &&
 >

On 31.12.2019 1:26, Jonathan Nieder wrote:
>> But is the "no newline" bit indeed intentional? If not, then a simple
>> echo would be even easier (though with a bit more escaping):
>>
>>      echo "\"file\101.t\"" | git checkout --pathspec-from-file=- HEAD^1 &&
> 
> For portability, that would be
> 
> 	printf "%s\n" "\"file\101.t\"" | ...
> 
> because some implementations of echo interpret escapes by default.
