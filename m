Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6706E201A7
	for <e@80x24.org>; Fri, 12 May 2017 06:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755562AbdELGBj (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 02:01:39 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33341 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752929AbdELGBj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 02:01:39 -0400
Received: by mail-pf0-f193.google.com with SMTP id a23so5850488pfe.0
        for <git@vger.kernel.org>; Thu, 11 May 2017 23:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qZMgYCGmD2+ELUs2Ce+68AlQrp2sgzFPeyy1nSlL5GM=;
        b=iLYlCMLjW5nwp/OJKbPB/vpM6Lt2FT/sQKIVgPnpBmx8itm8ELYHD49s963P76kmm1
         np4wY3HutwfvkHxeX/RCpprHVw/p46OaYN2e8JtycLmA4lcdohteMrjSNLNuneeoozzV
         0WePgNYN56BCFFzTW5MSLeTDuypsOlg24uQT9QGTpRQvNR8dyJsXzhRSdjmVV4UQRlqu
         uE2YfUfp3Sm4APcS3fC2sdO7R/CsuBk2DoGX0CjhkZGXTREuF76YxJovawNNQu3UWaGT
         u0puRl9+qcNCPaA723h/05K+FJPBH2IolFZgw1H3WdYadEZyAtTZ0Wztwi8u8nzpczne
         b0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qZMgYCGmD2+ELUs2Ce+68AlQrp2sgzFPeyy1nSlL5GM=;
        b=nvvFY024qlhmPaVtsGmng7woeKIDO2+JcPJIV2A7ne5kOwoY/WUaBC2sd5q3/3XDwM
         Ufil574zs1AwgjRGzhXAJoc+YzUNXB3LRss4rqRI50TUyw9aup84BCQqlFyeITTnwjl/
         zawVxOZNaqfYXdADurtZbho1BIGUGLi1TgkaQR1fVymstnu7rScGKeZIZ+CwXIQPcGoO
         4B1A9jNVfJsLuoXD0vrUvzTsYpy4kbqLnotGLb7RqFnj9q45MaQ28vxcTr8tYtsLp8+6
         5lE1hxY1A4SPwDg9bs8tOlToAq4lnlU8D2M9NiBfzn/8cOM4jbNJVTckfbQgMxOLDd9I
         uKOw==
X-Gm-Message-State: AODbwcC2p71jWDnurwCsSjsnnVggejYP9y+TA1+gMSSNnupwj0tNiRcO
        u90tdpzc7vf5jQ==
X-Received: by 10.98.79.28 with SMTP id d28mr2659588pfb.56.1494568898401;
        Thu, 11 May 2017 23:01:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:954c:c08b:c855:8b7f])
        by smtp.gmail.com with ESMTPSA id t17sm3312529pfj.61.2017.05.11.23.01.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 23:01:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH v5] fetch-pack: always allow fetching of literal SHA1s
References: <20170509182042.28389-1-jonathantanmy@google.com>
        <20170511223054.25239-1-jonathantanmy@google.com>
        <20170511224639.GC21723@aiede.svl.corp.google.com>
Date:   Fri, 12 May 2017 15:01:35 +0900
In-Reply-To: <20170511224639.GC21723@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Thu, 11 May 2017 15:46:39 -0700")
Message-ID: <xmqq37ca7gw0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> +static void add_refs_to_oidset(struct oidset *oids, struct ref *refs)
>> +{
>> +	for (; refs; refs = refs->next)
>> +		oidset_insert(oids, &refs->old_oid);
>> +}
>> +
>> +static int tip_oids_contain(struct oidset *tip_oids,
>> +			    struct ref *unmatched, struct ref *newlist,
>> +			    const struct object_id *id)
>> +{
>> +	if (!tip_oids->map.cmpfn) {
>
> This feels like a layering violation.  Could it be e.g. a static inline
> function oidset_is_initialized in oidset.h?

Surely it does.

Also, tip_oids_contain() uses unmatched and newlist only on the
first call, but the internal API this patch establishes gives an
illusion (confusion) that updating unmatched and newlist while
making repeated to calls to this function may affect the outcome of
tip_oids_contain() function.  In fact, doesn't the loop that calls
this function extend "newlist" by extending the list at its tail?

