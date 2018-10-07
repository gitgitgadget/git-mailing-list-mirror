Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59C4E1F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 00:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbeJGH6b (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 03:58:31 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:46807 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbeJGH6b (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 03:58:31 -0400
Received: by mail-wr1-f41.google.com with SMTP id a2-v6so9986779wrc.13
        for <git@vger.kernel.org>; Sat, 06 Oct 2018 17:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Szeo8LhuWZ0viukDsIEhNcCFQkSGKkVJjLVEgsMW330=;
        b=Rm29wOJOYz2HfR3/i+Y0toNYhABNbLhNphM74RhGkBFhYH3yDyMX0MbLH/YOthhRvE
         jdIumo0kwFP8/3lvI9z4E4zkabyOpTFJRk8XqHZFoXJu5aBBF8vSRK9CrmeO+7PA6gPh
         a2wY7yU8iFYRAZggJCtJgiMbUwz7p835DxrNy7DST+28/ZCnq5qpRB8A3IISB1mWRZpv
         /ggbrhO00IGXeFMAQK1rTBtOECNyxBKxllZBJ//ugXrlCdj9ReweKW1NZtFTVwAwNQ7g
         PleWVU02PR7TB0XYkSJEydv2YmsJB9Vnv1v40OcgMl0fyL8tQoQD65BthcAy7GQ67kZE
         L2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Szeo8LhuWZ0viukDsIEhNcCFQkSGKkVJjLVEgsMW330=;
        b=K7UwdJwSZQbLkfURtfyj/vx7qlsI1BTotX4ReKSlK2MEYYIf8KGqt69ueLgk7s+EQf
         e5UqIreF5vzdo5LDTaR/wKwyOU0lgGsaiaUyYg0LwF1y/tDCJ9s2v0j+0k6WlHlZ7GQm
         /MBr3MmM+LAsNba6dqPZnBdOJbtdb6zoXzgX36vSQZngcnrVhSp3yJ+FMSa3mXxVSalx
         ZzW7qBm0pfExjqqaYdaVUNHmT410UJwJ+1I9zHJc1MdTjjYyZ7g+h8QAGDmTCQWw76ks
         5GOSSt1xI/vH9q4qNahM5aeVCY5vlU8vbAwXnpmUpFms0a0c6FFqJ5zA8h28VBk3zmjK
         KIcg==
X-Gm-Message-State: ABuFfogWcMh1zLzZq6LHom3i8jWwTAq2CL1zn7ViIZW2XpLho9n4zKZq
        6HtBjAkl2p8aSuJkPXG1XqA=
X-Google-Smtp-Source: ACcGV61XCPjXYGpheo6s9+/45mj0m5Bkf/A6y5gl61SUUiYBHszVel6e+3h73nPEwr90fTX5eQsM/g==
X-Received: by 2002:adf:8206:: with SMTP id 6-v6mr12162812wrb.160.1538873590046;
        Sat, 06 Oct 2018 17:53:10 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 4-v6sm5879634wmt.16.2018.10.06.17.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Oct 2018 17:53:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>
Subject: Re: [RFC PATCH v2 2/4] transport: do not list refs if possible
References: <20180925225355.74237-1-jonathantanmy@google.com>
        <cover.1538075680.git.jonathantanmy@google.com>
        <61ad64245470e51cb97988e0f2f5ea76c9e2276c.1538075680.git.jonathantanmy@google.com>
        <CAGZ79kbN9Yu3sSrE+jxKFQyqRVM1eEvqoHCn3Y283biu-R6smw@mail.gmail.com>
Date:   Sun, 07 Oct 2018 09:53:08 +0900
In-Reply-To: <CAGZ79kbN9Yu3sSrE+jxKFQyqRVM1eEvqoHCn3Y283biu-R6smw@mail.gmail.com>
        (Stefan Beller's message of "Thu, 27 Sep 2018 14:38:42 -0700")
Message-ID: <xmqq8t3avaq3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Thu, Sep 27, 2018 at 12:24 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
>>
>> +test_expect_success 'when dynamically fetching missing object, do not list refs' '
>> +       cat trace &&
>
> leftover debug cat?

It does look that way.
