Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F31D2023D
	for <e@80x24.org>; Wed, 24 May 2017 07:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938720AbdEXHVP (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 03:21:15 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33311 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935622AbdEXHVM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 03:21:12 -0400
Received: by mail-pf0-f194.google.com with SMTP id f27so31996385pfe.0
        for <git@vger.kernel.org>; Wed, 24 May 2017 00:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uuYhEGSSAiaFfqSlyOEOC9v+BkGV3hRFidFNI/J9iQk=;
        b=fMSrutUbpFrOEMqCFwrq6h0jVM0Pq0gV6jSuxs3cgsfK2AK7GidkwMlyjpHhxYTu3G
         BOoaaavjVpMkutrzI68k71rUD2FARKpGXRKR6/Wvt5rjEFllUxGcBk+bj1LNHcxEzt0R
         zav5i39tCKBFLYM1251+fq53YM/Do0IyW0chYEjGPvHlFSGLYgxfmtaYLt1vn0Cr6RrD
         X/UWQU1uImYzpJKAQSxihp0sqEKjfnRlRImdSOwp1SKQCNXm8bBqNcFGiCkwi3Ke2Pzz
         XVO5W2V8FaJ9ym1pV/BPyEpLgawuo4qN2yo09R3YAqcFsXS6m1tH8HcKM2kXou4X0W7V
         b97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uuYhEGSSAiaFfqSlyOEOC9v+BkGV3hRFidFNI/J9iQk=;
        b=RatFhYORQhNXB0yHDurDpIVpjolhR/lggiKGMy1zyXzGt2QBF8wvqKGXfAR2CFQTeC
         jTsQgxY+hFCtHg0AYHU8E/AyLIzDRF3Wb7jh6y126m6jWxUt1j65j3wRUjDA0WfegfVj
         KasjDbbprv3QOqPmTr05JCCuXniu9pOKdtqAsBl4IbJo/jgByIusMJRoHcBy7gxgQiCg
         Kra9BtJB7GoHw5kJlv1yxK33BjJh20Sj6gmXwYqsfhw/LfQG7sBDBk/FEKgz84TTqQhw
         q9OMdxGeN7TiN3i9xru+vCQEF9nd4zaSzW42E1DeUZ0w3svAhy5u90IIhhcKg+a4v/bH
         8KmQ==
X-Gm-Message-State: AODbwcCfm9u2Ek1gJpyCzx510+bBTMvQxz2n3KPqSRCgzEcHZ3DE7QlG
        JY4j67AGmLrL3g==
X-Received: by 10.99.121.67 with SMTP id u64mr36966050pgc.230.1495610467035;
        Wed, 24 May 2017 00:21:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:167:7063:293b:a24d])
        by smtp.gmail.com with ESMTPSA id o10sm4752436pge.67.2017.05.24.00.21.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 May 2017 00:21:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH v2 25/25] cache_ref_iterator_begin(): avoid priming unneeded directories
References: <cover.1495460199.git.mhagger@alum.mit.edu>
        <0d6a608a62026352c1496239bab02122f123f2e1.1495460199.git.mhagger@alum.mit.edu>
        <20170523194519.luhuej3rerzb57t7@sigill.intra.peff.net>
        <33ffee8b-22da-ced4-95c6-ab68d4557f1d@alum.mit.edu>
Date:   Wed, 24 May 2017 16:21:05 +0900
In-Reply-To: <33ffee8b-22da-ced4-95c6-ab68d4557f1d@alum.mit.edu> (Michael
        Haggerty's message of "Wed, 24 May 2017 09:17:20 +0200")
Message-ID: <xmqqwp96g1pa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Junio, if a reroll is not needed for other reasons, would you mind
> squashing this into the last patch of my series?

Will do, but won't happen until morning in Tokyo.  I've just
finished today's integration cycle.

Thanks.
