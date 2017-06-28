Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99ADF2023D
	for <e@80x24.org>; Wed, 28 Jun 2017 20:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751612AbdF1U6n (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 16:58:43 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:32987 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751526AbdF1U6m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 16:58:42 -0400
Received: by mail-pg0-f53.google.com with SMTP id f127so37302738pgc.0
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 13:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SAzASVUzYPEiBjspaeob9E1/8c9a+i4Y/7cAv9ktk3w=;
        b=rnG0mE+bH65dAqXPaxVUa2lCGz5G7ulja7rEOITo/plW/nwSNeMTEqfScSUiirIt3L
         jwiMpaebDX53JW/O2JRDskI6PC4jT2rsnW3QwV2+evlgrtmr+dK9waG1sMAi0xtWPHWY
         A8ygAvyQ7/WrnL4o4Bh/PG+1oD89RT3VDh5gOy8Htq8Lit7a81QihxcigYL0jHgMEa4r
         vbB21xrjeUb4mS1MpuMRdKTrSaiD9NKg6agMnhrrq+AS1QAiFqcyBNGsr+NPbtVgnQ58
         +7Vz6qspLLsbR0lUmnx+W/t5COTN4Ya0JD2i6T5/L2OH8dKMX5zEKwP6r0nxvZSqW6sl
         +ncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SAzASVUzYPEiBjspaeob9E1/8c9a+i4Y/7cAv9ktk3w=;
        b=l+ibNoE8gcAkPtb1XJzE9uOMkbUAmfcyNOedzagK6MKfknMOjGAhKhsx68YzCb+r6B
         PbD2EGqAoFHt1Z7JtOtBCP0pIxYMZCBbLHixd9LGlCo+Is+1m32/fnEBV0EzMzj6MiVH
         0rITEXhcYIJLD0UAopoKSi5kCvIQ7mKvPIqH/yfj6+OZ7RKEeqAPaEkVog66uD4Qb9F/
         AXQXRfiYoU0f3iIHdCNHCmdoof0ismmcHSpFRmB6KhBjotxA8pWXXOQmVy3i3Cn25kqq
         D6CS2/tBHchpftvLZEbFAl+VlGGdRvQxeNOLGtze/EyyTl5kokO2bOJd/CVrnEFdjEZ/
         9rVQ==
X-Gm-Message-State: AKS2vOyVMujurIlW/eU+rCmlOzsyl6500ic9DTqIL5k/0jvUSBwbJCXx
        otRblrBWClB6viMsbpE=
X-Received: by 10.98.163.203 with SMTP id q72mr12520119pfl.97.1498683521482;
        Wed, 28 Jun 2017 13:58:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88a2:2d61:9b86:f64d])
        by smtp.gmail.com with ESMTPSA id d24sm7318286pfk.43.2017.06.28.13.58.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 28 Jun 2017 13:58:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] submodule--helper: do not call utf8_fprintf() unnecessarily
References: <xmqq1sq3x2xz.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbvncDoSuj8AF_rdDoEzavdzEaLxqr7NXi1_eCLNt01Kg@mail.gmail.com>
Date:   Wed, 28 Jun 2017 13:58:39 -0700
In-Reply-To: <CAGZ79kbvncDoSuj8AF_rdDoEzavdzEaLxqr7NXi1_eCLNt01Kg@mail.gmail.com>
        (Stefan Beller's message of "Wed, 28 Jun 2017 13:44:08 -0700")
Message-ID: <xmqqwp7vvngg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Wed, Jun 28, 2017 at 1:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> The helper function utf8_fprintf(fp, ...) has exactly the same
>> effect to the output stream fp as fprintf(fp, ...) does, and the
>> only difference is that its return value counts in display columns
>> consumed (assuming that the payload is encoded in UTF-8), as opposed
>> to number of bytes.
>>
>> There is no reason to call it unless the caller cares about its
>> return value.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>
>>  * The helper was introduced at c0821965 ("Add utf8_fprintf helper
>>    that returns correct number of columns", 2013-02-09), which also
>>    taught the help text output from the parse_options API to use it
>>    to align columns.  These original callers naturally do use the
>>    returned value and left alone by this fix, which corrects all the
>>    later callers that misuses it.
>>
>
> The patch looks correct.

Thanks.  I had a small voice back in my head telling me that I may
have misread the code and this patch breaks things, which you
cleared up for me ;-)
