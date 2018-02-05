Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB56C1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 20:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750999AbeBEUCM (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 15:02:12 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35674 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbeBEUCK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 15:02:10 -0500
Received: by mail-yw0-f194.google.com with SMTP id u21so19275439ywc.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 12:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tk4BJtr9XtBNHGYAiS4IKIzwMTZCKvUiRDumwz5ejj0=;
        b=oXc0EUVt9LHGIX9dvMhVKEpDiptTS/ebfyFBr9pNiZicWEs+YDF0TzaavTXTVO+QMo
         YgreCvzIMgbX+7QSjkdBHcvzJEj3HfmyXedyTnLpFokYTKOL+mkmOpE+5gSIU8L3jNUw
         lzjAcPAl6y+hlLkzM/BjltgnBobCYyZ5b7gLdrEgAEmTi3cKjhpXFYZUNSc/qanroQSY
         MjRsydQlSF1Sbarek7KDYTTOBCIF1VzM6zjZN+fd7HuQQKonoCpl21GphSMk3AFYOa3Q
         t8M8Iqssd2zhjx5+kAL4mnWB1PEvE9jGsD2lAwByvtHlNNld2OViDACahGozf+0C//uC
         +dsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tk4BJtr9XtBNHGYAiS4IKIzwMTZCKvUiRDumwz5ejj0=;
        b=JV6diNDgsQwd9VxIFpUCHAcp/bW/wn9+9ME4Ve2wNkxLK/nNWRpKnS59qHJKg0vNZk
         pWnrEqwhGCDbJ6pUBz2eDPbHILIdFv2AVhp3t/Lcr8o3NXC6/HKxnYd0apcCFZPuwluQ
         tv/MfOgaZAf1pK6lLz+lb6+2aF9TiGPDm/6+l9q6c/WeUmgO32sMym5imxWLK84Y7Rn3
         iGbgkOKVD6hKeWFUIFGtTKgCXAluZxTx+EKYtKEV/MHUmKCUFP8qLwn4aXw/VfX/MX9W
         US4240CkpkomuJCTrY78oivveUuMCB0mL35hZVYcGWaZINBEa5a63Mqsc7PqQHRp194u
         pm+Q==
X-Gm-Message-State: AKwxytei81UZdC04Q9ZbUWf3wjfrFz9Cn0oH0m5OAmII4vsA8fSwY4BS
        mbjEwpGSBXzCoP0qCQuRKdJjPGv24fDv1IHz65MyZw==
X-Google-Smtp-Source: AH8x226sE13gnUE2CAFMsYI6Ry9l/PTyNWglWVjnZ5Of/Fol7+JnRtwAic2pNl9r4azjppl4CkOU13h73bviPD0iimo=
X-Received: by 10.129.86.139 with SMTP id k133mr31263455ywb.253.1517860930092;
 Mon, 05 Feb 2018 12:02:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Mon, 5 Feb 2018 12:02:09 -0800 (PST)
In-Reply-To: <20180130232533.25846-22-newren@gmail.com>
References: <20180130232533.25846-1-newren@gmail.com> <20180130232533.25846-22-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Feb 2018 12:02:09 -0800
Message-ID: <CAGZ79kYsyWdW+D_5xx4fiqOXyAQZdS5cYGHUhcqB1MKCNf9drQ@mail.gmail.com>
Subject: Re: [PATCH v7 21/31] merge-recursive: add a new hashmap for storing
 file collisions
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 30, 2018 at 3:25 PM, Elijah Newren <newren@gmail.com> wrote:
> Directory renames with the ability to merge directories opens up the
> possibility of add/add/add/.../add conflicts, if each of the N
> directories being merged into one target directory all had a file with
> the same name.  We need a way to check for and report on such
> collisions; this hashmap will be used for this purpose.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---

The same comment on compiling applies here.
Nice to review, but it may not compile due to unused functions
that a strict compiler may not be happy about.
