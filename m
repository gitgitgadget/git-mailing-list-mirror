Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F95020D0C
	for <e@80x24.org>; Tue,  6 Jun 2017 00:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751276AbdFFAOw (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 20:14:52 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34139 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751266AbdFFAOw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 20:14:52 -0400
Received: by mail-pg0-f44.google.com with SMTP id v18so17563112pgb.1
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 17:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mF+Z8Hrru4sqwfm+ZcB07sEjutTRKdiBLSl0q/Iw1bg=;
        b=oR4FLEElfzjzdoJYk2ZZGj30k01dJVdbrKxHIbaEHiLDyygLwiiXaMdm+9tgcnq4yG
         YNneGV5ZRcicYb6aYEo6LHAonlMdtXsJ2FUcRM3pcKIkd+V1SP16jYRN58A1xAhzFr7X
         FUzyYQkII1Go/dL8xRuWM5SBayKFoPER+n2pyv9BSMOHnaSx8ZWcqRUtRsPSVg5gP2HV
         lBYDBMxNPAh/kUGmcfV+hooBeBgxalveDNJahSsYEaQHGE7PKKY9xq7T7zt1ekMMVcoQ
         fwfc0umew2FjFMaG3zHONZWSMvhpCe1GrbUus1kVPFc6YPjbp8EWkpb5FtzVd/OjxZVO
         CWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mF+Z8Hrru4sqwfm+ZcB07sEjutTRKdiBLSl0q/Iw1bg=;
        b=tRbefViLeQ1EEfUoAvQqFOZSqXBl0StVKPhiRy3ZtR1U3Wn5EHjzhV2y3iIqfLoDdR
         n/eqWgyK3951sGiLvYvCzWi1exhENe322xcS0XubmahRHW1e0RA0IrHfEKPeA0Mw7PV9
         ErM0JedHTTE2LL+Y2FGOXStAZGqqXfdYIIbtzNxXSaFBcvRcgN9HuMI7p4NVdiBFH2nw
         BOLcaAqXUqwUfVYvfM6ROTMQn26aVqaEX4Oi9DNy6xRdZ8q5X4d/DgI1KKoBqCsfpt+B
         5OFpk9AkGaOYygrwSRPCPK38GkO1EOalRORV2Qd9ebs1bd2EkIsSlA0AzhU/D/sW5Mlz
         wXkA==
X-Gm-Message-State: AODbwcA18oyXxKZ2uIJs91xgyS437UT89KI/BzWVWaDo+CsZqjaO3oNo
        00IgGYbLcrH30FgCCDA=
X-Received: by 10.98.64.93 with SMTP id n90mr22449452pfa.96.1496708091452;
        Mon, 05 Jun 2017 17:14:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:5d03:f5d1:882a:10e])
        by smtp.gmail.com with ESMTPSA id 6sm10200465pfh.57.2017.06.05.17.14.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 05 Jun 2017 17:14:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sahil Dua <sahildua2305@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC v4 3/3] branch: add copy branch feature implementation
References: <0102015c79fcbda0-2779b4ff-54ad-46f4-bef0-14eeb58338d4-000000@eu-west-1.amazonses.com>
        <0102015c79fcbe99-7e18cee7-d82d-4ab2-9d6a-ad7376a5ac27-000000@eu-west-1.amazonses.com>
        <CALiud+=qoSSSg_p2MXZEaVTGMhFW_FtirDJ2-FnmNh+U0yf0Gw@mail.gmail.com>
        <xmqqlgp69ds9.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 06 Jun 2017 09:14:49 +0900
In-Reply-To: <xmqqlgp69ds9.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 06 Jun 2017 09:10:30 +0900")
Message-ID: <xmqqh8zu9dl2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> When somebody says "I want to rename my current branch to X", it is
> clear that the person wants to end up being on a branch called X.
>
> To me, "I want to copy my current branch to Y" sounds more like "I
> want to create another Y that looks just like the current branch,
> but I want stay on my current branch".
>
> If you think copy makes @{-1} problematic, perhaps your copy is
> doing more than it should (e.g. switching the current branch at the
> same time, or something).

A related tangent.  Git does not assign any identity to a branch, so
"the branch we were previously on" goes strictly by name.  If you
are on branch X, switched to branch Y, and then renamed branch X
(which is not current) to branch Z, Git will still think that the
previous branch is X, so an attempt to switch back to @{-1} may do
unexpected things.
