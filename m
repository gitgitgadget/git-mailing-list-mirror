Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 226791F404
	for <e@80x24.org>; Fri, 16 Feb 2018 18:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162778AbeBPSGU (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 13:06:20 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39442 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161668AbeBPSGS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 13:06:18 -0500
Received: by mail-wr0-f196.google.com with SMTP id w77so3740337wrc.6
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 10:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+zlMVhi+HHMVNF12YXQJ7oBWsxUTfJ5YP2/bBuYvkns=;
        b=R2CsNCaV/U9LR3J0bMZUMxqObRO7H+BH/cJagIbZc4u/718l9yWfc4UTVzOvN2iNZ0
         bUidf03Kew3GdJYS+C6bz3Lajh0rVzIf6IxwNMZt0HIf3V7LoFs7V7gc0q4iYfiJOSMc
         tcJAbmcESkcg19isg4nq4xzI6XjKqiwPwOqG+SncdKMk9e5CSjA7QxNF+eB5W7UGZITL
         jwoEZomJsCFXMK3eDmnTRz0gcdCu8UCmWdbRBklKJVohSBNOPYuEgFCOybXtd+jDZGzN
         +pJF/T4nuSZqVptAQWx1y3Pc0W+gGxjR5v9bVDZNO7rarK70bZ0CTVVtWblH8Sl83t7D
         IW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+zlMVhi+HHMVNF12YXQJ7oBWsxUTfJ5YP2/bBuYvkns=;
        b=ahq8bKVP95F+kuZR1Fjmg3+h8jd+IhhwOgVOISdkn8NdZ0PMCi584ztTryAcXAvvdO
         MafCHrf2xpdvxKUjTAQ0y7aMHPzJTR/ah6JtoWwNHYgmnZmeHrrKOJDXnKRAbeKzsRYW
         Ciu32pcQbvRDtVD04lN1x7kSGaH9SYtAOCMrjB/x/1nvLWk7Bj7e4idCy/qSBH3krdIM
         YNPUvFO54ZKEXIQVU/Pg/oZhuCYDh9LvgKZw/E2B4olLdS1MCA3M/Dr5eGc3120WBmrk
         cNH4Ba3CGOw5UBFEfL6BUCFL+HxsMPoIDG3lb5Mb1LNN8Bz38oBCqoZJiGHCeoJyUk7i
         SE/g==
X-Gm-Message-State: APf1xPCOxgUcgFbq2/xbbRo89KxS5ih/lvIl/NwiNecBPTUOPZk+AE1k
        8N+71Kj0y3Me86CxBI5+Wid6Prcu
X-Google-Smtp-Source: AH8x225PQXlscbymEHYAMPlkStGNXUSpARSPE3YXdlqZkeXxC/2g1Rgg6E5zdurHEYfNap6xBLXXGg==
X-Received: by 10.223.139.11 with SMTP id n11mr6573879wra.91.1518804377311;
        Fri, 16 Feb 2018 10:06:17 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p1sm17854351wra.90.2018.02.16.10.06.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Feb 2018 10:06:16 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] merge: allow fast-forward when merging a tracked tag
References: <20180213080036.3bf3a908@canb.auug.org.au>
        <CA+55aFwM0vy+pw-Xv=gA19ULMwAXNPhdO3qR5A3hkMrZKJFNSQ@mail.gmail.com>
        <CA+55aFzxsNxgKD1uGZQCiib+=+wCMSa0=B+Ye3Zi-u6kpz8Vrg@mail.gmail.com>
        <xmqqfu65sx20.fsf@gitster-ct.c.googlers.com>
        <CA+55aFwTp8gg70sHXqOgR01Liv5c8nnfUP0yTdwpkh-rg+2EMA@mail.gmail.com>
        <xmqqzi4drczv.fsf@gitster-ct.c.googlers.com>
        <20180212222157.0a3bd472@vento.lan>
        <xmqqmv0crepg.fsf@gitster-ct.c.googlers.com>
        <CA+55aFxkYTeY9h=VHFXi=gbXsnsHCRMAVZ9=1_EsFGSqr0sj9g@mail.gmail.com>
        <xmqqfu63o2xv.fsf@gitster-ct.c.googlers.com>
        <xmqqy3jt7ty8.fsf_-_@gitster-ct.c.googlers.com>
        <CAPig+cSJKDH=_-hGZLpZUjC4WEyjMRAd2VPgo-Vd+sHpa4jQ-Q@mail.gmail.com>
Date:   Fri, 16 Feb 2018 10:06:16 -0800
In-Reply-To: <CAPig+cSJKDH=_-hGZLpZUjC4WEyjMRAd2VPgo-Vd+sHpa4jQ-Q@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 15 Feb 2018 18:34:19 -0500")
Message-ID: <xmqqa7w87qsn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +       tag_ref = xstrfmt("refs/tags/%s",
>> +                         ((struct tag *)merge_remote_util(commit)->obj)->tag);
>
> xstrfmt() allocates a new string...
>
>> +       if (!read_ref(tag_ref, &oid) &&
>> +           !oidcmp(&oid, &merge_remote_util(commit)->obj->oid))
>> +               return 0;
>
> ...which is leaked here...
>
>> +
>> +       /*
>> +        * Otherwise, we are playing an integrator's role, making a
>> +        * merge with a throw-away tag from a contributor with
>> +        * something like "git pull $contributor $signed_tag".
>> +        * We want to forbid such a merge from fast-forwarding
>> +        * by default; otherwise we would not keep the signature
>> +        * anywhere.
>> +        */
>> +       return 1;
>
> ...and here.

OK.  Thanks.
