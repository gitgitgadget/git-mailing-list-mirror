Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AC3C433DB
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 16:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5942B64E33
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 16:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbhCNQ5P (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 12:57:15 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:35432 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232431AbhCNQ5B (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 12:57:01 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id E9DA94049B;
        Sun, 14 Mar 2021 17:56:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1615741019; x=1617555420; bh=axADaeBpVHvov97jR+/
        diQsS0IwCOOWEvfZ7Wh4nKeg=; b=eeTUdIpI5kJV6PPare4peW5cdRzzTMK+KeD
        BA4+p6T9Ii6V6wN0cURKoej+fhgzffzDFctx/B9BCF1JCDaJN8SDl47dhT6CgNQR
        2QcoQCRzcUATsADJeUEoeHV2uyWbIEoZrKKU4qKrv60WjIKKLH5eDv+tVcKQV1Mk
        dQgfadtC99Upiq4yhcb6j68K4LAhyd1OvfPQOZDj8r6aQnWnLrZ3JFPXzSAXbFQx
        ajJE2HvBGvWHsl6YSST9S7ehrqTgxKKBxNfGTbvsrzyqgRI2MVw07tO+74j1bf11
        3urSsva6NR5nRlcPxucdM/8ecpBaQWt/rASHdJwkcpRrGBkBN69f8IhgJAIY34HV
        5wrHvoHq13iad/GZQHG5sfI1jdjLBqoLNiOSZndMVFKxChhUVbwbvVNAEIn4f+Rd
        21N4104ZYxpNqwJ+W+6KHjrN+inqwGaXe37YKLwsr/RD0AVrAABLdKMmBY3NbsRE
        pRcJ80zAq82INdtWUeTdnKCC1t5rHWn1fwFjje6kGbVfVaxcDYSrdb/hPf1ZO3nk
        LCQkutBWYogR0tndEr9qpZq59IVi2N0S3UccjEqHAsrElZlnRttucu3vTjedtkOO
        siwdfONc6HnMqT7UeH/dK9v83PbcLCg4HptUGYXVkEFBosMMearUGURWgJLd6X/p
        en55P2iE=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3GQSkl5cw5RF; Sun, 14 Mar 2021 17:56:59 +0100 (CET)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 29B5840483;
        Sun, 14 Mar 2021 17:56:58 +0100 (CET)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id DAA0CB1B;
        Sun, 14 Mar 2021 17:56:56 +0100 (CET)
Subject: Re: [PATCH 3/7] clone: free or UNLEAK further pointers when finished
To:     Jeff King <peff@peff.net>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <ajrhunt@google.com>
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
 <107e98d00e1685e0144ee2415b8220c53542e5a3.1615228580.git.gitgitgadget@gmail.com>
 <YEZ3Gf0f/NfXiwW2@coredump.intra.peff.net>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <9856ec4c-b8dc-3c93-ee20-f818672375b7@ahunt.org>
Date:   Sun, 14 Mar 2021 17:56:54 +0100
MIME-Version: 1.0
In-Reply-To: <YEZ3Gf0f/NfXiwW2@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/03/2021 20:12, Jeff King wrote:
> On Mon, Mar 08, 2021 at 06:36:16PM +0000, Andrzej Hunt via GitGitGadget wrote:
> 
>> @@ -1017,9 +1017,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>>   	repo_name = argv[0];
>>   
>>   	path = get_repo_path(repo_name, &is_bundle);
>> -	if (path)
>> +	if (path) {
>> +		free(path);
>>   		repo = absolute_pathdup(repo_name);
> 
> You mentioned that "path" gets reused again later. Should we use
> FREE_AND_NULL() to make sure that nobody tries to look at it in the
> meantime?

That sounds sensible - I wasn't too sure at first because we are 
unconditionally setting path later... but I can't see an reason not to 
make this safer.

But that makes me wonder if the definition of path should set it to NULL 
too. Setting it to NULL after freeing it guarantees that we can't read 
the old value anymore. However later code has no idea if path will be 
NULL or merely initialised (at least until we overwrite it with the new 
path).

I've provisionally updated my patch to also set path = NULL at point of 
definition, but I don't know if that's idiomatic in this scenario.

> 
>> @@ -1393,6 +1394,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>>   	strbuf_release(&reflog_msg);
>>   	strbuf_release(&branch_top);
>>   	strbuf_release(&key);
>> +	free_refs(mapped_refs);
>> +	free_refs((void *)remote_head_points_at);
> 
> We should avoid casting away constness when possible (because it is
> often a sign that sometimes the variable _isn't_ pointing to owned
> memory). In this case, I think freeing is the right thing; our
> guess_remote_head() returns a copy of the struct (which is non-const).
> Should remote_head_points_at just be declared without const?

I think so - I'll change remote_head_points_at to non-const.

>> +	free_refs((void *)refs);
> 
> This one is more questionable to me. It comes from
> transport_get_remote_refs(), which does return a const pointer. And it
> looks like that memory is owned by the transport struct. So presumably
> we need to tell the transport code to clean itself up (or mark it with
> UNLEAK). Or perhaps there's a bug in the transport code (e.g., should it
> be freeing transport->remote_refs in transport_disconnect()? You'd want
> to make sure that no other callers expect the ref list to live on past
> the disconnect).

There are indeed multiple locations where we store the fetched refs, 
followed by transport_disconnect(), followed by trying to use the refs 
(that are nomimanlly owned by the now disconnected transport):

https://git.kernel.org/pub/scm/git/git.git/tree/builtin/remote.c?h=next#n953
https://git.kernel.org/pub/scm/git/git.git/tree/builtin/ls-remote.c?h=next#n122

However all other locations could handle free()'ing during 
transport_disconnect - and the 2 I've linked to above are easy enough to 
fix. So I'll give up on free_refs() from cmd_clone(), and will move it 
into transport_disconnect() as suggested. I've added a new patch to the 
end of the series to take care of this change.

(Which ultimately means we've now solved the same pattern of leak for 
all 5 users of transport_get_remote_refs().)
