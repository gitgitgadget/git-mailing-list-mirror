Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44CDA1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 13:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932250AbeB1Ne3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 08:34:29 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42958 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932131AbeB1Ne0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 08:34:26 -0500
Received: by mail-qt0-f196.google.com with SMTP id t6so2902575qtn.9
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 05:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=z62HXZcHQU8tu7nMMKjyVhNpg78Z8nbFuHbck75aqAc=;
        b=qTIUnB/zaa+HOhStcA7XwF1UPvbk48l9sTtKSf0gj9n4Z0k/o0z/Y5Thyqg87Hrn8z
         xDVxWfaVmuJqE8uULa5qvmOcCfjEHcid9FVyMNZNCJlP+JoTJXOkCT+sjEecVQRfs9K7
         djFLlWRrSFDIhOcSr3ow8KyFxgluixnDyZ7WddvkrMDpPNLdRdwGZWdLHrnVohzkkCSw
         9VGebX4BlpwE4PJ0gj6fzEQPpNNhosHMuhYtT7nBT/vnRLLJnPF5KB++TBxrKBg2s5ZR
         w0gqNY3VXjIiVGRFq31d4ZUPnM8y9bUrNWnUZK4nZZZEIpmzgIGhE8Uu8mkV1o29wl2Q
         c6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=z62HXZcHQU8tu7nMMKjyVhNpg78Z8nbFuHbck75aqAc=;
        b=GvZoW1a29CFFobhqGMzemlkWeY5JGGBkljWBVkyj7p83yhqv2v8ekaTYWsgk634rKK
         aKPM+KUNuptyyt4nGZPzZMzvBApFGDnV/ZuADNPU1zDOpG7bl4NFchujvBRfXFXFqleT
         Hp53D1mK5CERf2jn9w2kwpT0QJu6z+gA4sMU2rde4t2v6Wg2Le8HrQwIpvQhpIu0CgVS
         TesTLA5JimujnTf086OfEkP1q31gvw5jghxxJV+tsV39CU21m61sCKzrr09DnPTwMJGI
         7E+bLfiBAHBZ+pNt1CvfyFICEwZipz1d1nnigkIwdU6aKU5QitoYwKlF9IDggwXdel+M
         yWxQ==
X-Gm-Message-State: APf1xPBLgKT5TbTqG9TzX833cr1ASgZL4TI3+CxyyOJD0ztLi8j1MWTE
        jZLPHNQgPefd1kdTGwq127dBxm6/
X-Google-Smtp-Source: AG47ELv9iwfWrYt4soP86diU7jTjK4px+MKgJWkPchuIjdnW0dEP4H0SYK9uN9fjhuNdkWq/OqivsQ==
X-Received: by 10.237.36.221 with SMTP id u29mr27993861qtc.116.1519824865677;
        Wed, 28 Feb 2018 05:34:25 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id 58sm1144019qtm.51.2018.02.28.05.34.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Feb 2018 05:34:24 -0800 (PST)
Subject: Re: [PATCH] revision.c: reduce object database queries
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
References: <1519522496-73090-1-git-send-email-dstolee@microsoft.com>
 <20180226013048.GA8677@sigill.intra.peff.net>
 <20180226013822.GA9385@sigill.intra.peff.net>
 <xmqqefl6nhud.fsf@gitster-ct.c.googlers.com>
 <20180228063707.GA4409@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <43e0daf5-e6d9-5a2c-ebc2-43df8fa94204@gmail.com>
Date:   Wed, 28 Feb 2018 08:34:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228063707.GA4409@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/28/2018 1:37 AM, Jeff King wrote:
> On Tue, Feb 27, 2018 at 03:16:58PM -0800, Junio C Hamano wrote:
>
>>>> This code comes originally form 454fbbcde3 (git-rev-list: allow missing
>>>> objects when the parent is marked UNINTERESTING, 2005-07-10). But later,
>>>> in aeeae1b771 (revision traversal: allow UNINTERESTING objects to be
>>>> missing, 2009-01-27), we marked dealt with calling parse_object() on the
>>>> parents more directly.
>>>>
>>>> So what I wonder is whether this code is simply redundant and can go
>>>> away entirely. That would save the has_object_file() call in all cases.
>> Hmm, interesting. I forgot all what I did around this area, but you
>> are right.
> I'll leave it to Stolee whether he wants to dig into removing the
> has_object_file() call. I think it would do the right thing, but the
> most interesting bit would be how it impacts the timings.

This patch was so small that I could understand the full implication of 
my change.

I'm still very unfamiliar with the object walking machinery in 
revision.c. There are a lot of inter-dependencies that are taking time 
for me to understand and to feel confident that I won't cause a side 
effect in a special case. I do appreciate that Junio added a test in 
aeeae1b771.

I'll make a note to revisit this area after I have a better grasp of the 
object walk code, but I will not try removing the has_object_file() call 
now.

>
>>> There's a similar case for trees. ...
>>> though technically the existing code allows _missing_ trees, but
>>> not on corrupt ones.
>> True, but the intention of these "do not care too much about missing
>> stuff while marking uninteresting" effort is aligned better with
>> ignoring corrupt ones, too, I would think, as "missing" in that
>> sentence is in fact about "not availble", and stuff that exists in
>> corrupt form is still not available anyway.  So I do not think it
>> makes a bad change to start allowing corrupt ones.
> Agreed. Here it is in patch form, though as we both said, it probably
> doesn't matter that much in practice. So I'd be OK dropping it out of
> a sense of conservatism.
>
> -- >8 --
> Subject: [PATCH] mark_tree_contents_uninteresting: drop has_object check
>
> It's generally acceptable for UNINTERESTING objects in a
> traversal to be unavailable (e.g., see aeeae1b771). When
> marking trees UNINTERESTING, we access the object database
> twice: once to check if the object is missing (and return
> quietly if it is), and then again to actually parse it.
>
> We can instead just try to parse; if that fails, we can then
> return quietly. That halves the effort we spend on locating
> the object.
>
> Note that this isn't _exactly_ the same as the original
> behavior, as the parse failure could be due to other
> problems than a missing object: it could be corrupted, in
> which case the original code would have died. But the new
> behavior is arguably better, as it covers the object being
> unavailable for any reason. We'll also still issue a warning
> to stderr in such a case.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   revision.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index 5ce9b93baa..221d62c52b 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -51,12 +51,9 @@ static void mark_tree_contents_uninteresting(struct tree *tree)
>   {
>   	struct tree_desc desc;
>   	struct name_entry entry;
> -	struct object *obj = &tree->object;
>   
> -	if (!has_object_file(&obj->oid))
> +	if (parse_tree_gently(tree, 1) < 0)
>   		return;
> -	if (parse_tree(tree) < 0)
> -		die("bad tree %s", oid_to_hex(&obj->oid));
>   
>   	init_tree_desc(&desc, tree->buffer, tree->size);
>   	while (tree_entry(&desc, &entry)) {

