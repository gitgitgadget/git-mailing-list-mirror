Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17C2A20323
	for <e@80x24.org>; Thu, 16 Mar 2017 17:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754466AbdCPRFH (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 13:05:07 -0400
Received: from avasout01.plus.net ([84.93.230.227]:34810 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751960AbdCPRFG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 13:05:06 -0400
Received: from [10.0.2.15] ([146.90.175.94])
        by avasout01 with smtp
        id wh331u00722aPyA01h341f; Thu, 16 Mar 2017 17:03:04 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=BZKo6vl2 c=1 sm=1 tr=0
 a=c4JbszTospdBBUsinAk+iw==:117 a=c4JbszTospdBBUsinAk+iw==:17
 a=IkcTkHD0fZMA:10 a=OJpt_-zRAPkoagTw4_cA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 2/5] sha1_file.c: make pack-name helper globally
 accessible
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20170316142647.t6tthkcgon3rpg4m@sigill.intra.peff.net>
 <20170316142706.kt56a43phiuhhra7@sigill.intra.peff.net>
 <20170316143152.gdeaprlsercvwmiw@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <fefb69e1-325d-5ec6-0954-1445ce8ad9be@ramsayjones.plus.com>
Date:   Thu, 16 Mar 2017 17:03:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170316143152.gdeaprlsercvwmiw@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 16/03/17 14:31, Jeff King wrote:
> On Thu, Mar 16, 2017 at 10:27:06AM -0400, Jeff King wrote:
> 
>> -/*
>> - * Return the name of the pack or index file with the specified sha1
>> - * in its filename.  *base and *name are scratch space that must be
>> - * provided by the caller.  which should be "pack" or "idx".
>> - */
>> -static char *sha1_get_pack_name(const unsigned char *sha1,
>> -				struct strbuf *buf,
>> -				const char *which)
>> + char *odb_pack_name(struct strbuf *buf,
>> +		     const unsigned char *sha1,
>> +		     const char *ext)
>>  {
>>  	strbuf_reset(buf);
>>  	strbuf_addf(buf, "%s/pack/pack-%s.%s", get_object_directory(),
>> -		    sha1_to_hex(sha1), which);
>> +		    sha1_to_hex(sha1), ext);
>>  	return buf->buf;
>>  }
> 
> Incidentally, this entire function could be implemented as:
> 
>   return git_path_buf(buf, "objects/pack/pack-%s.%s",
>                       sha1_to_hex(sha1), ext);
> 
> as the git_path() functions are smart enough to replace "objects/" with
> the true object directory when necessary. I don't know if people find
> that more or less readable. Since it's buried in a helper function, I
> doubt it matters much either way. The git_path functions do also do some
> path normalization, which might be of value.

Hmm, I don't have strong feelings either way.

However, I note that the only normalization going on (that I can see)
is to remove .//* from the beginning of the resulting string. I don't
know why, but I guess it is to cater to people using the various
GIT_ environment variables doing things like:

   $ GIT_OBJECT_DIRECTORY=./my-objects git ....

It has always puzzled me slightly, why the git_path functions do this
normalization, but (for example) setup_git_env(), git_path_from_env(),
get_common_dir(), ... don't! ;-)

ATB,
Ramsay Jones


