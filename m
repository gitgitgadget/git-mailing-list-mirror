Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91B0320404
	for <e@80x24.org>; Tue, 10 Oct 2017 13:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755981AbdJJNLS (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 09:11:18 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:50849 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755272AbdJJNLR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 09:11:17 -0400
Received: by mail-qt0-f172.google.com with SMTP id f15so50955912qtf.7
        for <git@vger.kernel.org>; Tue, 10 Oct 2017 06:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jwPLVqr9wOrgsoYERnvcz2oN5FwTCLO2vPYK2H9mv2o=;
        b=tfbfiHfGv7Yewq9QB4aH+j4UxFlg5FyqtbNz37826tNmJH0pwqiD0YFBWn4Vleyo/f
         OH7b1sYaSEWQtpV+n+tHnp3T1tA2G7XdcpaLFGhKFGWKZbLlYvv2Smww/PWIzf4h8C1p
         ugwp1+Fz3BLYPDTAZHScdVhK1ae6nsQau1tdZ4YtLOiTpa+QJ7zEvKWZj+y4sK36DYZQ
         q+8GtI51cw2Ov049rzUskoRjoIG3ONpnWgSkSoe91IC4OT5I6+Bn9ZOnqiLQef/Q+mPJ
         asvhhogM3DvJwUNfrSVcppL3FJpGBgVMIiFSpzFP7ygOi0J7r6MLoiPCC65K2ygMDKas
         vxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jwPLVqr9wOrgsoYERnvcz2oN5FwTCLO2vPYK2H9mv2o=;
        b=J2AIUtgHjVWEzCjIxZCUMYO7wVyLC7epdjUg+FWk3aywI9lBqD3C6Axu9T9mGmJNzV
         x13ck07SZ/tM/zQ1mjGc3cxsvW8BFC6JoZoAK2JK2Yo3UwiEW4htIoN9MZrQRteBgBMV
         6scyGfWZ9k8Zmh7OAPLb0kASSHWGjsP/gRIV3dS31dcmA54Y3NzxhK88CwYboA5EVu94
         98IV8W+ruf5l3DwW4TdvpySsUBevitRNrNur9c8SnvFf4fSKwFPD6Aj0gMcFITW5qASJ
         CO8VHCO5jYAXaNdJyIDwueFifrcVG8fRQLA8Fm3XKo93G3xxSQrY/G3JjQVNKV16uVs1
         F0Hg==
X-Gm-Message-State: AMCzsaV7+Qcn7mxv0g5sAbo1R7oVYXrRJ5EZss8nMyugbQl/Xg/zELcs
        CBMDbWBeUSP8RHUYogoXLQQ=
X-Google-Smtp-Source: ABhQp+QYh3eMZ9RlHX7nFnLIjKqSJVlOw/6EPirYhz4PJ3sJaCdL/IyDwEfsTDq54QEbAMZg9YjsBQ==
X-Received: by 10.55.119.70 with SMTP id s67mr724162qkc.294.1507641076766;
        Tue, 10 Oct 2017 06:11:16 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010::7cc])
        by smtp.gmail.com with ESMTPSA id w20sm6252696qkb.95.2017.10.10.06.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Oct 2017 06:11:16 -0700 (PDT)
Subject: Re: [PATCH v4 4/4] sha1_name: minimize OID comparisons during
 disambiguation
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        ramsay@ramsayjones.plus.com, sbeller@google.com
References: <20171008184942.69444-1-dstolee@microsoft.com>
 <20171008184942.69444-5-dstolee@microsoft.com>
 <20171009134933.vmba67adelqbkx4y@sigill.intra.peff.net>
 <338aab6a-1181-d740-1bf2-2ac86749a6b2@gmail.com>
 <20171010123634.3hdqxpo6mbl6jhbx@sigill.intra.peff.net>
 <xmqqbmlfp3eh.fsf@gitster.mtv.corp.google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f9add2c3-5499-085e-e433-799427dda6d8@gmail.com>
Date:   Tue, 10 Oct 2017 09:11:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqbmlfp3eh.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10/2017 8:56 AM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
>> OK, I think that makes more sense. But note the p->num_objects thing I
>> mentioned. If I do:
>>
>>    git pack-objects .git/objects/pack/pack </dev/null
>>
>> then I have a pack with zero objects, which I think we'd similarly want
>> to return early from. I.e., I think we need:
>>
>>    if (p->num_objects)
>> 	return;
>>
>> Technically that also covers open_pack_index() failure, too, but that's
>> a subtlety I don't think we should rely on.
> True.  I notice that the early part of the two functions look almost
> identical.  Do we need error condition handling for the other one,
> too?

I prefer to fix the problem in all code clones when they cause review 
friction, so I'll send a fifth commit showing just the diff for these 
packfile issues in sha1_name.c. See patch below.

Should open_pack_index() return a non-zero status if the packfile is 
empty? Or, is there a meaningful reason to have empty packfiles?

Thanks,
-Stolee


diff --git a/sha1_name.c b/sha1_name.c
index 49ba67955..9f8a33e82 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -153,7 +153,9 @@ static void unique_in_pack(struct packed_git *p,
         uint32_t num, last, i, first = 0;
         const struct object_id *current = NULL;

-       open_pack_index(p);
+       if (open_pack_index(p) || !p->num_objects)
+               return;
+
         num = p->num_objects;
         last = num;
         while (first < last) {
@@ -513,7 +515,9 @@ static void find_abbrev_len_for_pack(struct 
packed_git *p,
         uint32_t num, last, first = 0;
         struct object_id oid;

-       open_pack_index(p);
+       if (open_pack_index(p) || !p->num_objects)
+               return;
+
         num = p->num_objects;
         last = num;
         while (first < last) {

