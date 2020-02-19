Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AF3C35254
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 21:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3D4207FD
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 21:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5fADRYq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgBSVFo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 16:05:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46486 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726875AbgBSVFn (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 Feb 2020 16:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582146342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F81Ae24iBj7BBHVvyT6gFKI06FQDgXxKArlfu9irEqs=;
        b=G5fADRYqqdws5zqjQ7vuJGCaVIRnaxYHEACHuJb2sCS5SWwUmgpzfESRHb0N6I1ETq6VYu
        rf3Om8HXNPrBUGy7ptGN6d+0zFXFDVc9aiuyOMmWbF58Vhs/BsBOPxpuZA4HaVewE7nNYo
        KNP36MCXT8qZr54egB5BItPQddHtS/c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-BA_w-pszM8OrFgqnKxD3Kw-1; Wed, 19 Feb 2020 16:05:38 -0500
X-MC-Unique: BA_w-pszM8OrFgqnKxD3Kw-1
Received: by mail-wr1-f71.google.com with SMTP id s13so697800wrb.21
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 13:05:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F81Ae24iBj7BBHVvyT6gFKI06FQDgXxKArlfu9irEqs=;
        b=fAWxwK4ukQy1k1aPZbVC0PJ3ZmME6/8bDZU7nEC5oJQkJXE6EaNTBThFpK6SNy/HPC
         kW/BFA+kKvbBvasa1SMGdXGuiLZ0h93dL5d/BUlrz1I362Lx7T5p6ZKua5SaPxy03uBx
         RKwgRCbrt/sNpEhOEcbrZKb094VZ6b5/nlWoY7jNWj+Jsyisw6gobF15uXu9dN9aXxjl
         10l3BYuLLeEicnI3UQy1vt5VjKjpDo/ZoRW6qrK3i0gG4CzTFDwXuoGa7Cia5nBuQAWc
         6wE5WIEzllKlI9BpYskZoHckfhzq7niKZnzo9tY930wO1gfW/aI1jFx/GJdehcZaoaAv
         gBxw==
X-Gm-Message-State: APjAAAUVZu5weMI4nljj70HAh8GuzMSwU8nMar6i7eJkx35jcYVVGJ4u
        aY5maatQSw286mwBmE+mKadk8OmwL8VHRWC9SjUIyZNKYqHfHkyHW44lLvCz6XCiYTa38b25nKC
        wZdW1F4wya35Z
X-Received: by 2002:adf:a453:: with SMTP id e19mr36979267wra.305.1582146336989;
        Wed, 19 Feb 2020 13:05:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqxAlESHHBCK+lWql47oLYldFIJVAatkT5VF3jeIEsbPJgwoMbg40HbPYf+BteiWHCqUhvhdZQ==
X-Received: by 2002:adf:a453:: with SMTP id e19mr36979252wra.305.1582146336769;
        Wed, 19 Feb 2020 13:05:36 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:ec41:5e57:ff4d:8e51? ([2001:b07:6468:f312:ec41:5e57:ff4d:8e51])
        by smtp.gmail.com with ESMTPSA id f12sm1390148wmj.10.2020.02.19.13.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 13:05:36 -0800 (PST)
Subject: Re: [PATCH 2/4] am: convert "resume" variable to a struct
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, bfields@redhat.com
References: <20200219161352.13562-1-pbonzini@redhat.com>
 <20200219161352.13562-3-pbonzini@redhat.com>
 <xmqqv9o2e66q.fsf@gitster-ct.c.googlers.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a90410eb-b6e0-3077-0491-511c25a417f2@redhat.com>
Date:   Wed, 19 Feb 2020 22:05:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqv9o2e66q.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/02/20 20:19, Junio C Hamano wrote:
>> -	enum resume_mode resume = RESUME_FALSE;
>> +	struct resume_mode resume = { . mode = RESUME_FALSE };
> I do not think it makes a difference to compilers, but it seems that
> existing code spells this without SP between dot and the field name.

Yes, it's a typo.

Paolo

