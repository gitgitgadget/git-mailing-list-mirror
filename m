Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 993DA1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 23:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbfAHXjb (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 18:39:31 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37283 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfAHXjb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 18:39:31 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so6217671wmd.2
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 15:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=famZ4YQsOe3pO8OwPoshPAt6AEZptVWgSnqwjPe6jbU=;
        b=tHzP5xmcKdPOlYRg83HZr7aNNhOA5RcMzjDWyY6146VdVp207etnhsyXhwWCXTNidP
         5+sLF07Yhl59YojiogsJsHq2tb/F7x2pdvSqROXV+uQjB6Z9b9ZWVoMhy3rMexDuJvDL
         nh8AU6aD/uzE6Xmdbs95q2ynrS5+hcsuc8VpmMsF9W4wygTqM/yYsczxhTIgA01lAFIL
         wiNG1nJxztCz0NC5nnzbAPQcQGT2VXVZnB/GSC8IEarD5du5FGuSJzoWiCJeyxz7EZXH
         uswlcm34n87vxXJn5d2RHaqwcfIn51eJQZLzFNm9rW8qrkVrHucp0EJNuXD/riRk5SDi
         uA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=famZ4YQsOe3pO8OwPoshPAt6AEZptVWgSnqwjPe6jbU=;
        b=RD+lq0V5yWDTsBhnJ32CiYP2iaS7qEJnbM6qTslggeZaEg4d2sv2auNRc3hrLLW+q0
         PaPbvOttVt7TPfAKhZl76XV5pkbMBj+NH3KW6eDZdTIkqLfr4MVl/qbbBTsUuzsYEKeB
         C9Ekxw0/TFSK09XVjppyhDnpFCiLRMznlqyGLK5sbr8DjzaiQp/n8yKuUJxHRba+5NE0
         Hw3Rk1kk3WuPmIYIVEx8FQAUycXVpURLAWPKRyf/PpwD5VLUZDMcUBUr9ZGmoilBaJaL
         FPgc+Gecw+0Bld2WJWEBaetvXyvImxtYxteoPjOf3wI4ehhYlDTqg2dgQ2ir42SjZPzY
         AcBg==
X-Gm-Message-State: AJcUukcrgmVAcNpoovTZOD/eWX8lXLES9pSJd/lxhGYP4ITd7iUUq38h
        Gr0xepzX5JQfGCsziOQHJDA=
X-Google-Smtp-Source: ALg8bN6cJ4kd/nI4snaNmW5RmDve5ZpnbjjiEgQAwRbCqXoSqBEx/r91I9FaDfpgCRxRWMBWwoCJNA==
X-Received: by 2002:a1c:68d7:: with SMTP id d206mr3143141wmc.43.1546990769196;
        Tue, 08 Jan 2019 15:39:29 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 199sm13824788wmh.21.2019.01.08.15.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 15:39:28 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     matvore@google.com, git@vger.kernel.org, sbeller@google.com,
        git@jeffhostetler.com, jeffhost@microsoft.com, peff@peff.net,
        stefanbeller@gmail.com, pclouds@gmail.com
Subject: Re: [PATCH v2 1/2] list-objects-filter: teach tree:# how to handle >0
References: <20181210234030.176178-2-matvore@google.com>
        <20190108015631.22727-1-jonathantanmy@google.com>
Date:   Tue, 08 Jan 2019 15:39:28 -0800
In-Reply-To: <20190108015631.22727-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Mon, 7 Jan 2019 17:56:31 -0800")
Message-ID: <xmqqbm4q4t3j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> +static void filter_trees_free(void *filter_data) {
>> +	struct filter_trees_depth_data* d = filter_data;
>> +	oidmap_free(&d->seen_at_depth, 1);
>> +	free(d);
>> +}
>
> Check for NULL-ness of filter_data too, to match the usual behavior of
> free functions.

Also, the asterisk sticks to the variable, not type, i.e.

	struct filter_trees_depth_data *d = filter_data;

