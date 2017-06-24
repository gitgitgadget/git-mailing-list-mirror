Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F22B20401
	for <e@80x24.org>; Sat, 24 Jun 2017 18:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754804AbdFXScm (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 14:32:42 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34213 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751355AbdFXScl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 14:32:41 -0400
Received: by mail-pg0-f53.google.com with SMTP id e187so33193251pgc.1
        for <git@vger.kernel.org>; Sat, 24 Jun 2017 11:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=qA8bC7ftFPgKBj/fNHsi0fQX0n3g+TxaHBm+wEg4TaY=;
        b=qIHQPiJIQh3U8yoCFUwByaRN7pZQUZ1qAwrw0H/iiqy+PbKXfeEiBXyWUo6kT74m8B
         GHIMNEPSviJzauTG4uesfUbxooIDYnToVCSz0RoxgoT0KlLnreP4gogkCOrVONCA5gqz
         ox24VJz9L9WcciOg7JvmskOFnrIdB/8R9OE9LpLOfiOLu84uZqON0erKuqr4Nz0pVPWr
         3r5hwc4rxf5NcChtuVZUg98QbAUncnzpAxgjTgW/fI8F40zJJsnPOZlLJlWH8rXrNo6n
         vawLvgOymEQpx/zr5HitQUEkvnkrygxogjW6H4DOGEdbu8jWAjP4p7cJq6MMcYCjoi2n
         5lHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=qA8bC7ftFPgKBj/fNHsi0fQX0n3g+TxaHBm+wEg4TaY=;
        b=a+D8u/+C7KfyM2qEXys05yFkGCtVuKhpi/dMfN9ksJbWtFZ+Ni7Lt4q5MPgUAS+PNi
         8iD+Gjw5I1QinVgB5KXochKoMye4P6W3GQe+calKHAXztijN3YOzprzUdXYjW56aeXfG
         +22BuOxBSCeuN/dh/cwoObjK6hkIIEXCU0U3QGZmp+CchYhRdYbqp0lt+4MQV+c0Ak1t
         XigWKigfQ6V8sKd65CuCTSiR6g+BALHhqs010FcsHqCO3GIT5H2Mo1oC+qAP0qQhL9Nh
         cr6ubSkDjJ5E6z3W3zkUHG0FAwz8BD71oL2GSEkSeDVjjnXT5V5Xechhw0OTwCCDKd4M
         J1Dg==
X-Gm-Message-State: AKS2vOwhRayELjvwny0qytRCDbAdnbOFwtHiPh3e56/w5Oca2mWYaL0b
        Muhq2Wvphb9elQ==
X-Received: by 10.84.224.206 with SMTP id k14mr15525522pln.72.1498329160607;
        Sat, 24 Jun 2017 11:32:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:c3f:f54c:5646:5c2e])
        by smtp.gmail.com with ESMTPSA id m68sm8769427pfi.12.2017.06.24.11.32.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 24 Jun 2017 11:32:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Simon Ruderich <simon@ruderich.org>
Subject: Re: [PATCH v2] die(): stop hiding errors due to overzealous recursion guard
References: <87podz8v6v.fsf@gmail.com>
        <20170621204742.15722-1-avarab@gmail.com>
        <xmqq1sqdni1r.fsf@gitster.mtv.corp.google.com>
        <20170624123639.scagiuzqalfr72fz@sigill.intra.peff.net>
Date:   Sat, 24 Jun 2017 11:32:39 -0700
In-Reply-To: <20170624123639.scagiuzqalfr72fz@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 24 Jun 2017 08:36:39 -0400")
Message-ID: <xmqqbmpd9qyg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> One case I'd be worried about would be that the race is so bad that
>> die-is-recursing-builtin never returns 0 even once.  Everybody will
>> just say "recursing" and die, without giving any useful information.
>
> I was trying to think how that would happen. If nobody's actually
> recursing indefinitely, then the value in theory peaks at the number of
> threads (modulo the fact that we're modifying a variable from multiple
> threads without any locking; I'm not sure how reasonable it is to assume
> in practice that sheared writes may cause us to lose an increment but
> not to put nonsense in to the variable). If they are, then one thread
> may increment it to 1024 before another thread gets a chance to say
> anything. But in that case, the recursion-die is our expected outcome.
>
> Anyway, it might be reasonable to protect the counter with a mutex.
> Like:
> ...
> To be honest, I'm not sure if it's worth giving it much more time,
> though. I'd be fine with Ævar's patch as-is.

The scenario I had in mind was three or more threads simultaneously
dying, each incrementing dying counter by one and before any of them
have a chance to say "called many times, error or racy threaded
death!", because they all observe three (or more).  

But I was incorrectly reading the code---in that case, as long as
dying is small enough, we'll return 0 and let at least one of the
caller give a chance to give a message that came in "err" from their
invocations of die()'s.

So I do not think it is worth worrying about too deeply.

Thanks.
