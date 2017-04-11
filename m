Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C65EE20970
	for <e@80x24.org>; Tue, 11 Apr 2017 17:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbdDKRaK (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 13:30:10 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36589 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbdDKRaI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 13:30:08 -0400
Received: by mail-pg0-f53.google.com with SMTP id g2so1714677pge.3
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 10:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xSdnZG8xKZdrnLE0v5oWt70r/3wZLh2DubOQP9jGWrM=;
        b=SJDvBeD/6dCln2ZIa2sgMErzkU1d7jcpDaqvBlQ0ct8Mo83rLpfoidP9h2Mn1uUZct
         Idm9GHZm4GNHHMrgFZsgwPA0Dnzdjt1V1JoBjrcNA3AGyqN73Zr0xz4V2LkwkRWoWMzT
         DsryA3MnkXLuLCxOpAsTj1LrfkAvkot7ApRV+qxVLI7E8615IM7SqThZdGWHVyl10O58
         9F0aQ5I4elD7GNuGFPNPoI9R6jCur1EJ6+A0Ni23WJzm2p4Wc98Wr2D/guG/TmoUehoo
         oPfUgQ5TLsqLzGCm1XPGrmajQ25MdbkRz55yoWe6KeE+SCdjE0kwpp5I11MZHOA8Atdx
         +FOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xSdnZG8xKZdrnLE0v5oWt70r/3wZLh2DubOQP9jGWrM=;
        b=CKJh+TJgMCG7v1COrD6+bPzSxJGXf665qnU1OBGzpgE2LS1R3TWlE9pnVTBTvAItor
         H7Rm6FwFLPjKYQpzjY2q+Bz51EbeyY4hfwwrg+k/gIyZ5oLDVQfB+ZPLaFwjOUkCTPF2
         ScuGBfU6br4ttZRZIaY1Rae/rReTAwnanLH5NDahIMa5/N5/tf5D5ba3PqxdiaVohFpM
         FGvzEISwogjM8b2VuCKug2inf1XLoXa9j5/mq6ML1qAnss+UXTnUK33axEJwAC8gxgE2
         sYbwKzUz7IL7uVEj7kfrTbRJTHI+UAduu1fpJ6Pl6ZeiJgfXM1bbWp7JZq1QEt34cnt0
         u5iw==
X-Gm-Message-State: AFeK/H0cMhZx8jAv/Y5np7jcTrv8NdbmkL/ZSOaHcCltsFQp63ebP6GHcroYSoZDK8BD0g==
X-Received: by 10.84.179.99 with SMTP id a90mr75304012plc.26.1491931807889;
        Tue, 11 Apr 2017 10:30:07 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:c434:5e79:6b7e:ed6b])
        by smtp.gmail.com with ESMTPSA id d1sm31803135pfa.5.2017.04.11.10.30.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 10:30:07 -0700 (PDT)
Date:   Tue, 11 Apr 2017 10:30:05 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/5] run-command: prepare child environment before forking
Message-ID: <20170411173005.GL8741@aiede.mtv.corp.google.com>
References: <20170410234919.34586-1-bmwill@google.com>
 <20170410234919.34586-5-bmwill@google.com>
 <20170411005816.GK8741@aiede.mtv.corp.google.com>
 <20170411172709.GE36152@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170411172709.GE36152@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:
> On 04/10, Jonathan Nieder wrote:

>> 	struct argv_array result = ARGV_ARRAY_INIT;
>> 	struct string_list mods = STRING_LIST_INIT_DUP;
>> 	struct strbuf key = STRBUF_INIT;
>> 	const char **p;
>> 
>> 	for (p = cmd_env; *p; p++) {
>> 		const char *equals = strchr(*p, '=');
>> 		if (equals) {
>> 			strbuf_reset(&key);
>> 			strbuf_add(&key, *p, equals - *p);
>> 			string_list_append(&mods, key.buf)->util = *p;
>> 		} else {
>> 			string_list_append(&mods, *p);
>> 		}
>> 	}
>> 	string_list_sort(&mods);
>> 
>> 	for (p = environ; *p; p++) {
>> 		struct string_list_item *item;
>> 		const char *equals = strchr(*p, '=');
>> 		if (!equals)
>> 			continue;
>> 		strbuf_reset(&key);
>> 		strbuf_add(&key, *p, equals - *p);
>> 		item = string_list_lookup(&mods, key.buf);
>> 
>> 		if (!item) /* no change */
>> 			argv_array_push(&result, *p);
>> 		else if (!item->util) /* unsetenv */
>> 			; /* skip */
>> 		else /* setenv */
>> 			argv_array_push(&result, item->util);
>> 	}
>> 
>> 	strbuf_release(&key);
>> 	string_list_clear(&mods);
>> 	return argv_array_detach(&result);
>
> This is probably still incomplete as I don't see how this accounts for
> entries in 'cmd_env' which are being added to the environment and not
> just replacing existing ones.

Yes, that's true.  This sample code is incomplete since it doesn't
handle those.

Jonathan
