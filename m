Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21F32201A4
	for <e@80x24.org>; Tue, 16 May 2017 06:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbdEPGmI (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 02:42:08 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34866 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750931AbdEPGmH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 02:42:07 -0400
Received: by mail-pg0-f67.google.com with SMTP id i63so20225105pgd.2
        for <git@vger.kernel.org>; Mon, 15 May 2017 23:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6blt+90oAD1MjV55cGHaf7VaVt1gCqg45/RbLayZ0xM=;
        b=tsxBKgns6op57S+zrYAqD5th/Uwl7dmKYa0MQLHYqLE1S5haz9QNhxpBlKDIVq4BhD
         fY7mevOtGMzfT76RvCH/sloaEOBlvr1NZU/pRUXAzLPihwyGJHBOvYmImMtUDXvSXW7w
         WLbDWk91amrVDp23WaMN6v/SC+EgWLBpO7dG4KOsQb8mTGPvSy7sr/mXzkVl3xUVIFpH
         y0aVs/ODCDFt6Env6Z4kqgzB2h+4Gz7mK8XAXjYZ83aB30GcG1PfmlRwaqJb7EJLIW3m
         UK0PTP0latE9ytMKqv9h3bq6XOWEdIlS6SYaNyqh14xQqM//N1xoLItp9pL8/37GJc0F
         w2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6blt+90oAD1MjV55cGHaf7VaVt1gCqg45/RbLayZ0xM=;
        b=rCP3NLb3C8BSS5UVkYP95Oypl8iyqp7PONMDQ+j3/kh/m1STvgEBa+BRIb52jvO9rK
         myFmbTedXJ6I2VpqykaJGjiO0A4VWz9lvgohiI/USRaKNc7ym0DcKOa9R4N+yi0AbEZk
         wU+Qn8+izawmZaCTjsTJx2kz7tJHF2hQlk16TIUdLMBWpwDzyZOlNUpggxR6qxQEmQUw
         4JXy3xOhU+Xc9TdIvMEF0bt6vZd+18qgLRWtbg59o/zZyvH6PBO5vLaKNw8aOqlOyoi4
         TgkHFq9sZyRJ2Ui6z0c4QMA8saj9H1Mu4SfrxjYYmoBINMC4YhsgZLhfkE+sGFXnAz6s
         Y8Xw==
X-Gm-Message-State: AODbwcAG+pID2RDBttYVxqzuFK7LBG/6qzZ3TXz4TtX3rtZwrCKmGqv3
        mObl/VEAds4bzA==
X-Received: by 10.98.193.65 with SMTP id i62mr10287660pfg.134.1494916927156;
        Mon, 15 May 2017 23:42:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8dc7:ff72:325b:10d7])
        by smtp.gmail.com with ESMTPSA id p68sm21171590pga.6.2017.05.15.23.42.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 23:42:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brian Malehorn <bmalehorn@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] interpret-trailers: obey scissors lines
References: <xmqq7f1iwxxd.fsf@gitster.mtv.corp.google.com>
        <20170516060649.29110-1-bmalehorn@gmail.com>
Date:   Tue, 16 May 2017 15:42:05 +0900
In-Reply-To: <20170516060649.29110-1-bmalehorn@gmail.com> (Brian Malehorn's
        message of "Mon, 15 May 2017 23:06:48 -0700")
Message-ID: <xmqqlgpx1ewy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brian Malehorn <bmalehorn@gmail.com> writes:

>> The mention of "'commit -v -s' works that way, too" was my attempt
>> to justify why it is OK to make this change unconditionally to
>> intepret-trailers, but I am still not 100% convinced with that
>> reasoning (or your original log message) that it is a safe thing to
>> do.  It is not like its sole purpose is to serve as GIT_EDITOR for
>> the "git commit" command.
>
> Yup, this is a heuristic and it will sometimes hit false.  But a far
> more grievous heuristic is ignoring all lines that begin with '#', yet
> we do that anyway for its convenience in editing commit messages.  Since
> we already *partially* honor commit message syntax in
> interpret-trailers, we might as well *completely* honor it by parsing
> cut lines as well.  At least, that's my reasoning.

I was primarily wondering if we want to protect this behind an
option to "interpret-trailers", instead of making this change
unconditionally.  But your above reasoning makes sense to me.

Thanks.
