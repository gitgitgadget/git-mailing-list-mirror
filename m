Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4B551F404
	for <e@80x24.org>; Fri, 23 Feb 2018 20:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754872AbeBWUC1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 15:02:27 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34286 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754212AbeBWUCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 15:02:25 -0500
Received: by mail-qk0-f170.google.com with SMTP id l206so12222771qke.1
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 12:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=NZ9z+mlh/7J3ytpWouwv63AgYaQCIiXF0JsN5X8Xa0w=;
        b=ukVyHLgRy3em0NGWN82segYIJG9le7yQakkLxeDK1kKUjT5hfbV5b4c1lY9k+sBFqv
         GpHWH6xWI274iX7dvSqZeZjUFL/yMbQQJIM73K9fcUHYdgNQwDZQkv702Zt0ZoPxtpQ9
         Njf6XMJylvn6UGfVPvDnZBrtxwkOImRz+5swha09Tk4gN6DkXVyI/0nK1b0fKmQjyp3h
         6qBE9NJYRq4iOg7C7cD1bkC9ITzY0p+vau1cbbnJeS4FcX2rE/0K9hpg+0TaQ6/Gmgvt
         k3dPqXkz0xe6cyatr9z30HENz8+UPcZ3zgEK/upJ+/YIc3g+J47MZ/wEI/NupV5udzLr
         PE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NZ9z+mlh/7J3ytpWouwv63AgYaQCIiXF0JsN5X8Xa0w=;
        b=uNSVLdRA2LSpVlNC5HaBdgynlA3iWanDet4QA6LZtxW3YwH+HuxevrQrqklicqwZal
         wnLCmuhKqZzvLV9zsz5cyq0Y/pCfED3oMWMAh499yVry6v1qzgBwsBqD031m5ynLU48X
         btOzb/qrB93HtuFSY7w/CQ6xEK58tibAv6t3b3jD3FhVc5WiZeY3sgEahxBbAaVgvcbO
         R3fhp7pTU2Awf0GrNOZIPNM42CHoxwXIMbqXcs8tJqhskrl3NFcz0qHhsPlmT6ELPq5+
         7BtEr6ONGDtH/cjsWcSWk6cFheMCukoAEeW9Yz3XQk8O1tJuFnYYkGtZtMhcQ9JLlKfs
         rCdg==
X-Gm-Message-State: APf1xPBWystWTJg1Nm52nghsvjOPrJ3CVTYzjEonbyP4rplF5G0CHlAp
        aOSLOI6lwrW/C/et0lx1qUk=
X-Google-Smtp-Source: AG47ELsIMpVkTK9Yul/M5MbogmWMezX5+eIKCSgrcyn9JMbqZu4GVajPx2cOIVmB62JenpIqlR97RA==
X-Received: by 10.55.164.79 with SMTP id n76mr4548224qke.45.1519416143752;
        Fri, 23 Feb 2018 12:02:23 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id q24sm2231355qkq.75.2018.02.23.12.02.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Feb 2018 12:02:22 -0800 (PST)
Subject: Re: [PATCH v4 04/13] commit-graph: implement write_commit_graph()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
        jonathantanmy@google.com, szeder.dev@gmail.com, sbeller@google.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
 <1519066406-81663-5-git-send-email-dstolee@microsoft.com>
 <xmqqmv031d7d.fsf@gitster-ct.c.googlers.com>
 <4d453f29-8e5b-2a98-ab11-415f63613be8@gmail.com>
 <xmqqsh9rtsg0.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8d29382b-e0a7-968f-b231-f27f89f275d3@gmail.com>
Date:   Fri, 23 Feb 2018 15:02:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqsh9rtsg0.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/23/2018 2:30 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>> jt/binsearch-with-fanout introduces one when there is a 256-entry
>> fanout table (not the case here).
>>
>> The bsearch() method in search.h (and used in
>> pack-write.c:need_large_offset) does not return the _position_ of a
>> found element.
>>
>> Neither of these suit my needs, but I could just be searching for the
>> wrong strings. Also, I could divert my energies in this area to create
>> a generic search in the style of jt/binsearch-with-fanout.
> ... me goes and digs ...
>
> What I had in mind was the one in sha1-lookup.c, actually.  Having
> said that, hand-rolling another one is not too huge a deal;
> eventually people will notice and consolidate code after the series
> stabilizes anyway ;-)

Ah, sha1_pos(). That definitely satisfies my use case. Thanks! My local 
branch has this replacement.

>
>>>> +				num_large_edges++;
>>>> +				parent = parent->next;
>>>> +			} while (parent);
>>> It feels somewhat wasteful to traverse the commit's parents list
>>> only to count, without populating the octopus table (which I
>>> understand is assumed to be minority case under this design).
>> Since we are writing the commit graph file in-order, we cannot write
>> the octopus table until after the chunk lengths are known.
> Oh, my "minority case" comment was me wondering "since we expect
> there are only a few, why not keep them in memory while we discover
> them here, so that the writing phase that come later do not have to
> go through all commits again counting their parents?  would it be
> more performant and a better trade-off?"  We can certainly do such
> an optimization later (iow, it is not all that crucial issue and
> certainly I didn't mention the above as something that needs to be
> "fixed"--there is nothing broken).
>
>> store the octopus table in memory and then dump it into the file
>> later, but walking the parents is quite fast after all the commits are
>> loaded. I'm not sure the time optimization merits the extra complexity
>> here. (I'm happy to revisit this if we do see this performance
>> lacking.)
>>
>> P.S. I really like the name "octopus table" and will use that for
>> informal discussions of this format.
> I actually do not mind that name used as the official term.  I find
> it far more descriptive and understandable than "long edge" / "large
> edge" at least to a Git person.

I will consider using this in the format and design documents.

>
>> You're right that int_id isn't great, and your more-specific
>> "oid_table_pos" shows an extra reason why it isn't great: when we add
>> the GRAPH_LAST_EDGE bit or set it to GRAPH_PARENT_MISSING, the value
>> is NOT a table position.
> Perhaps I am somewhat biased, but it is quite natural for our
> codebase and internal API to say something like this:
>
>      x_pos(table, key) function's return value is the non-negative
>      position for the key in the table when the key is there; when it
>      returns a negative value, it is (-1 - position) where the "position"
>      is the position in the table they key would have been found if
>      it was in there.
>
> and store the return value from such a function in a variable called
> "pos".  Surely, sometimes "pos" does not have _the_ position, but
> that does not make it a bad name.
>
> Saying "MISSING is a special value that denotes 'nothing is here'"
> and allowing it to be set to a variable that meant to hold the
> position is not such a bad thing, though.  After all, that is how
> you use NULL as a special value for a pointer variable ;-).
>
> Same for using the high bit to mean something else.  Taking these
> together you would explain "low 31-bit of pos holds the position for
> the item in the table.  MISSING is a special value that you can use
> to denote there is nothing.  The LAST_EDGE bit denotes that one
> group of positions ends there", or something like that.
>
>> I think the current name makes the following call very clear:
> It is still a strange name nevertheless.
>
>>>> +char *write_commit_graph(const char *obj_dir)
>>>> +{
>>>> +	struct packed_oid_list oids;
>>>> +	struct packed_commit_list commits;
>>>> +	struct sha1file *f;
>>>> +	int i, count_distinct = 0;
>>>> +	DIR *info_dir;
>>>> +	struct strbuf tmp_file = STRBUF_INIT;
>>>> +	struct strbuf graph_file = STRBUF_INIT;
>>>> +	unsigned char final_hash[GIT_MAX_RAWSZ];
>>>> +	char *graph_name;
>>>> +	int fd;
>>>> +	uint32_t chunk_ids[5];
>>>> +	uint64_t chunk_offsets[5];
>>>> +	int num_chunks;
>>>> +	int num_long_edges;
>>>> +	struct commit_list *parent;
>>>> +
>>>> +	oids.nr = 0;
>>>> +	oids.alloc = (int)(0.15 * approximate_object_count());
>>> Heh, traditionalist would probably avoid unnecessary use of float
>>> and use something like 1/4 or 1/8 ;-)  After all, it is merely a
>>> ballpark guestimate.
>>>
>>>> +	num_long_edges = 0;
>>> This again is about naming, but I find it a bit unnatural to call
>>> the edge between a chind and its octopus parents "long".  Individual
>>> edges are not long--the only thing that is long is your "list of
>>> edges".  Some other codepaths in this patch seems to call the same
>>> concept with s/long/large/, which I found somewhat puzzling.
>> How about "num_extra_edges"...
> Yes, "extra" in the name makes it very understandable.
>

