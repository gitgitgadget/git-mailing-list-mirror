Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D6CE20A40
	for <e@80x24.org>; Tue,  5 Dec 2017 16:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751323AbdLEQSD (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 11:18:03 -0500
Received: from siwi.pair.com ([209.68.5.199]:45939 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751416AbdLEQSC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 11:18:02 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id A581A844D4;
        Tue,  5 Dec 2017 11:18:01 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5F912844C5;
        Tue,  5 Dec 2017 11:18:00 -0500 (EST)
Subject: Re: [PATCH v5 07/10] introduce fetch-object: fetch one promisor
 object
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20171121210720.21376-1-git@jeffhostetler.com>
 <20171121210720.21376-8-git@jeffhostetler.com>
 <CAP8UFD1dm4EJXU3VdgGMDawy3jCT20hHQXwZxvtwy7_eomz9Fw@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <9432313e-0def-61af-1706-03640379a810@jeffhostetler.com>
Date:   Tue, 5 Dec 2017 11:18:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD1dm4EJXU3VdgGMDawy3jCT20hHQXwZxvtwy7_eomz9Fw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/2/2017 3:33 PM, Christian Couder wrote:
> On Tue, Nov 21, 2017 at 10:07 PM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>> From: Jonathan Tan <jonathantanmy@google.com>
> 
>> +void fetch_object(const char *remote_name, const unsigned char *sha1)
>> +{
>> +       struct remote *remote;
>> +       struct transport *transport;
>> +       struct ref *ref;
>> +
>> +       remote = remote_get(remote_name);
>> +       if (!remote->url[0])
>> +               die(_("Remote with no URL"));
>> +       transport = transport_get(remote, remote->url[0]);
>> +
>> +       ref = alloc_ref(sha1_to_hex(sha1));
>> +       hashcpy(ref->old_oid.hash, sha1);
>> +       transport_set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
>> +       transport_set_option(transport, TRANS_OPT_NO_HAVES, "1");
>> +       transport_fetch_refs(transport, ref);
>> +}
> 
> I think it would be interesting to return what transport_fetch_refs()
> returns, so that a caller could know if an error happened.
> 

That might help the retry/found_packed loop mentioned
in your response on the next patch in this series.

I'll make a TODO item for this to investigate.

Thanks
Jeff
