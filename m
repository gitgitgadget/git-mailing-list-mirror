Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93CCC433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 22:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbhK3Wb2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 17:31:28 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:39480 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233346AbhK3Wb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 17:31:27 -0500
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1msBbY-0009p0-EK; Tue, 30 Nov 2021 22:28:05 +0000
Message-ID: <13a5828d-596f-a215-7053-9570be939e5b@iee.email>
Date:   Tue, 30 Nov 2021 22:28:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/4] repack.c: LLP64 compatibility, upcast unity for left
 shift
Content-Language: en-GB
To:     Taylor Blau <me@ttaylorr.com>
Cc:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20211126113614.709-1-philipoakley@iee.email>
 <20211126113614.709-3-philipoakley@iee.email> <YaVxwFuMeK3QsfZj@nand.local>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <YaVxwFuMeK3QsfZj@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/11/2021 00:35, Taylor Blau wrote:
> On Fri, Nov 26, 2021 at 11:36:12AM +0000, Philip Oakley wrote:
>> Visual Studio reports C4334 "was 64-bit shift intended" warning
>> because of size miss-match.
> s/miss-/mis

Thanks. Looks like "miss-pelling" is my blind spot. Will fix V2 soon.
>
>> diff --git a/builtin/repack.c b/builtin/repack.c
>> index 0b2d1e5d82..6da66474fd 100644
>> --- a/builtin/repack.c
>> +++ b/builtin/repack.c
>> @@ -842,7 +842,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>>  			fname_old = mkpathdup("%s-%s%s",
>>  					packtmp, item->string, exts[ext].name);
>>
>> -			if (((uintptr_t)item->util) & (1 << ext)) {
>> +			if (((uintptr_t)item->util) & ((uintptr_t)1 << ext)) {
> This line blames to me from back in 2fcb03b52d (builtin/repack.c: don't
> move existing packs out of the way, 2020-11-17).
>
> The proposed fix here looks good to me (though we were never at any
> practical risk of getting bitten by a down-cast here since the maximum
> value for `ext` is 5).
Agreed. It's nice to get a head start on fixing a group of warnings.

> Thanks,
> Taylor
Philip
