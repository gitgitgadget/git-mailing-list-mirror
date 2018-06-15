Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 455B51F403
	for <e@80x24.org>; Fri, 15 Jun 2018 19:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966328AbeFOTo3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 15:44:29 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38610 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966316AbeFOTo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 15:44:26 -0400
Received: by mail-wr0-f196.google.com with SMTP id e18-v6so10977527wrs.5
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 12:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=z7ubvsjhIvuPYe+p3XRZYgMAOiHTr747/37L2IHt+yA=;
        b=YxnKYg6RiQTZUoHyZS0H7YHZ0SKef7yumk1mVZ/nLMPrZqLDZPBK8oEaSjcMhwiiHj
         Clx5weJFQK0FMB/3pw0GuoHxTC1alwBQDEAdvDEusleKgLkVcTf/VehDmD4IEJnphcyh
         15eLxpdbpk6guSyzTE5S2b5U8JR37jcf5jOY50fhV3k/jABXxPNql9LkccbnY2c4qryY
         g9QL7ZKLHBFkFf3dE9VjiyWG6jlq7ax5UKFYpmfQ26mz9P+FUuqJ3klruWcnP3vB+rog
         LjK/MJ3cGTXiQ8T4ODcz+Xx+94S8c+GYdrxv6UW/ihqc73xRLODhwnI0dD64rOYQR0sO
         H+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=z7ubvsjhIvuPYe+p3XRZYgMAOiHTr747/37L2IHt+yA=;
        b=IRorJoCRx+EugdxvCqXOVlH7+2v8qPXiq+ZpCn/YcniUojj3U4bOc+Z+am+xxu2Lz3
         pEF2ILyBnSc1H8JHYaoCHpJTwDVcoXOT/pedq5aGYsjjuyhv6HATauxn8DcRSaBa2IOp
         KLSfPaiNHHQ2d2leR1+PzIh87F6VjINFuFVhyn0AHOOhLX4XT0M9p2RexmzMzM1Xw9uN
         lRguWnH7uNw1YgVaagvHR1KsPXvI9BNRzNzDkBdkSp6etJrtxLq/S9l8BGVIe0KiArtc
         FNGezIrxH932HJmC8XHYX5HaE5LYRnrh0YugprmYlyafD5GRVLUWhh246UWUbwekaV/I
         30dQ==
X-Gm-Message-State: APt69E29Wg1lGrqIDZE9E7RQ5XkoczR2Mj8g7B6wyv2MV0Sn8XS50PFf
        whmY85wSn6A07hwFIuU5468=
X-Google-Smtp-Source: ADUXVKL6nCeSXpHrySqrpo+s8jCKgjiRUTjAQtpUyWSLWLg5b2a7c+nOz/aHBRKFYDMpBCEKVukbWA==
X-Received: by 2002:adf:b86b:: with SMTP id u40-v6mr2742573wrf.162.1529091864547;
        Fri, 15 Jun 2018 12:44:24 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o9-v6sm8664840wrn.73.2018.06.15.12.44.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 12:44:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Luat Nguyen <root@l4w.io>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] ewah_read_mmap: bounds-check mmap reads
References: <20180615032850.GA23241@sigill.intra.peff.net>
        <20180615033112.GA20390@sigill.intra.peff.net>
        <xmqqsh5o0yl5.fsf@gitster-ct.c.googlers.com>
        <20180615172656.GB3067@sigill.intra.peff.net>
Date:   Fri, 15 Jun 2018 12:44:23 -0700
In-Reply-To: <20180615172656.GB3067@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 15 Jun 2018 13:26:56 -0400")
Message-ID: <xmqqsh5nzvfs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jun 15, 2018 at 10:05:42AM -0700, Junio C Hamano wrote:
>
>> > -	memcpy(self->buffer, ptr, self->buffer_size * sizeof(eword_t));
>> > -	ptr += self->buffer_size * sizeof(eword_t);
>> 
>> 
>> > +	data_len = st_mult(self->buffer_size, sizeof(eword_t));
>> 
>> This is a faithful conversion from the original, but I somehow would
>> have appreciated if the latter were not sizeof(eword_t) but rather
>> sizeof(self->buffer_size[0]), especially as I wondered ...
>
> I actually thought about going the _other_ way. The sizeof(eword_t) is
> not something we can change, but is actually decided by the on-disk
> format.  So I wondered if this should be much more clearly "hey, this is
> 8 bytes". Possibly with an assert(sizeof(*self->buffer_size) == 8).

Hmph, that's a thought.
