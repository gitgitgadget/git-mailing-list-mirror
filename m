Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 916B61F803
	for <e@80x24.org>; Mon,  7 Jan 2019 13:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfAGN0u (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 08:26:50 -0500
Received: from mout.web.de ([217.72.192.78]:52717 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbfAGN0u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 08:26:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1546867598;
        bh=1mSZL9hZL4tlIuAyeueFfiUfsmlt1OQekyEWNMn0C38=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=O4J1gHdLiX0w1PI98ZA7Nx6dFBkb2Njoi9r32Wi0PV6mf4n/4+6mPNHms2kQC+YMI
         IY+VxA7yWZWh4HKbt9lC9dQZ34YnztQWwNZWJ3GculRtSVJR2x8IgXHJaH+sjfIGv+
         tPfYtqclGTmfP/h3nE3SdF7HxIC6vYmNPbcG0mxs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.36] ([91.20.59.41]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MZlR4-1h0mxc2kZi-00La1V; Mon, 07
 Jan 2019 14:26:38 +0100
Subject: Re: [PATCH 1/3] object-store: factor out odb_loose_cache()
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <xmqqh8explya.fsf@gitster-ct.c.googlers.com>
 <3512c798-aa42-6fba-ee82-d33a8985be91@web.de>
 <b87e7e01-baa6-6fb2-7081-0042ecd3b6b7@web.de>
 <20190107082702.GB21362@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <4b9198d2-4994-6d26-74ee-e737ecc34af3@web.de>
Date:   Mon, 7 Jan 2019 14:26:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190107082702.GB21362@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2bImAADKBr+2CqNt5/oC76h23L4d+MCC1T+esnBUOhw6uhhR8Yr
 YiHbSEbEjmTsjagE8n7X8GPzwS6NNqkTO++xlnT3dDAd8xGmp7wnjEA9ZHax5uqHsbcM4S4
 7CDumXaQQ/WSAseA+4nbyrJHmFFJcaPeS5LSxn3tUGMCZMAOm480axxnTl8ZhaFs++bmJ+U
 P5T97uW0VeW7SJF2S/nOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cTbmdsrsOvY=:o2wj/ThfTFYkdNkQNcaB2Z
 aokSrRoZc1keieKON5RZpxRNdDfrn2UuFH0thVPNEdgktqoEnyj+gHaBfx34aySeuTA5bYjcR
 6d4ikKiboYfzVsYLwngmPGaCh8RZRwIs0pO+HdQpYHUZXTgGzy7RNdGoHE9TWnZ7ZqP113Usg
 gqqyItXXGBTq6gBhz2keoAOcDFKoG1b552ouir3wYC82oIo/jYf4NimmnFLr/gb8ki1qzp4bY
 OQwz27kgYpT6ykXyci283maC9L7ZVnK9syn6Mmufk+loSnFZ+6MxXCJIHhmlDVGG4huLA666s
 h+KlsFsLrehvzNXPnwm3O1PHeweqNTbudP00rhNwjKxmYRMNf4Jo1RdaF09CgwADf60Q+/+Ba
 wl2Sw17r6oA1u+vxTq5kuyNjWwu/bbenfnbYH/fEe9SxEIy4gKLyPxSVHCwYAqAI8MT75zLJs
 Metmglpjp+nObLiV66YoxyHNPsPhEv8TZWbvoy7sOMgh7UTo36W3KT2u5TjlN6VC6LVSn7BiX
 7olcNDlF5KME8z5v+1Wb6sDNh6TDNbi35yiOJ7xWCfXQ6g5uurnkPlLI2OYlwCZNCFdoHinku
 wpMnWtkg3CHCnD6dB4ne2IoP27ZN3T9qnNwfn64f4v3YwSONpljFh9WARHAKTFwd24ln9egok
 wk9eeOIh9PnJYJY+c0LI49PlQTktHuf+2OyEmb46hLExZxIzcoNpWxINFgYCjn1atgGRZtbSy
 K6UbF3NbQayzzs87nZkKTFW306CPPGYxylerWlnczOST4R5XFsDN1hwyUn0WUTOncfVqS7eq3
 n9N8LYQjGKkcJRf9IdpPNBVNESdrPF7C3eFv/+kb0RAo7jp/aYH3YrusmPe1oLHVkWjJlik8Q
 lSevY69W0zSbikRb0DYxxJ3KmLAQM1RdiaWe51mqKwFRQa6LtZs6g+Jy/iNmN7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.01.2019 um 09:27 schrieb Jeff King:
> On Sun, Jan 06, 2019 at 05:45:30PM +0100, René Scharfe wrote:
>> diff --git a/object-store.h b/object-store.h
>> index 60758efad8..7236c571c0 100644
>> --- a/object-store.h
>> +++ b/object-store.h
>> @@ -54,6 +54,13 @@ void add_to_alternates_memory(const char *dir);
>>   */
>>  void odb_load_loose_cache(struct object_directory *odb, int subdir_nr);
>>  
>> +/*
>> + * Populate and return the loose object cache array corresponding to the
>> + * given object ID.
>> + */
>> +struct oid_array *odb_loose_cache(struct object_directory *odb,
>> +				  const struct object_id *oid);
>> +
> 
> I think the ugly-interfaced odb_load_loose_cache() can become "static"
> now, as the only outside caller (from sha1-name.c) has gone away.
> 
>> +struct oid_array *odb_loose_cache(struct object_directory *odb,
>> +				  const struct object_id *oid)
>> +{
>> +	int subdir_nr = oid->hash[0];
>> +	odb_load_loose_cache(odb, subdir_nr);
>> +	return &odb->loose_objects_cache;
>> +}
>> +
>>  void odb_load_loose_cache(struct object_directory *odb, int subdir_nr)
> 
> You'd need to re-order these definitions, of course (or alternatively,
> just fold the load function inline into odb_loose_cache()).

Yes, the functions are arranged so that odb_load_loose_cache() can be
inlined easily.  I meant to include a patch for that but then quibbled
about keeping the BUG check (which is probably optimized out) or not,
and dropped it for now to get the performance fix in more quickly..

René
