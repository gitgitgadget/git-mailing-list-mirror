Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCCDC433E7
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 16:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0245206E7
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 16:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgIBQiU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:38:20 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45365 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgIBQiN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 12:38:13 -0400
Received: by mail-ed1-f68.google.com with SMTP id l17so5554811edq.12
        for <git@vger.kernel.org>; Wed, 02 Sep 2020 09:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5sbGL3mGfcDLDneBw3bC/WpSKdg+00jPtICN57tJmA4=;
        b=NUh2XsNb+jdFPsXe+p48UIkRyJG48AWX6YlXJFNbmbJ+h3IQTWIYcJoeRtHJHmfFNM
         dMuQ3ZHeLjo+UhJ6nuDlhVDWbsvwPZGFMok7RerDqIQs29lsVez0HyCyJFJIO0EnbCSx
         LSh5v2Qh8vLbjPBCKfY97e8Bx+G+eX7n7seJsXN5BHCD7G6sNrICbf0P1AvyaK+8KOuC
         W5mxu4smpzE9GfRywptWYeXqtBKmShYqTopzt1s0WwoHihOZ85/8ovaBG0W2RiPc85bG
         tUEUpOwjGVvNUlrlTZ5bC8rsSC9hthUqdCIx7y2KclepmPL6KcPdHY1xMXTNA2/2I7Tf
         oJcg==
X-Gm-Message-State: AOAM5338PlICMwtzNxP6REiYNBhlUoN0gNsCjGFIA6cd6By6veHAR7nD
        gHSENxZEo648advuIMPJmWe+jnEw0swyaa17ZvQ=
X-Google-Smtp-Source: ABdhPJwYVoguVc0MsQQJelJWLc7CpiQihl5YT3utNTaRuPr9LVcPxltMUOnGDwRf5HrlohrCkndT1YDBbn2YJV48c8c=
X-Received: by 2002:a05:6402:17ed:: with SMTP id t13mr910669edy.163.1599064691798;
 Wed, 02 Sep 2020 09:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599026986.git.matheus.bernardino@usp.br>
 <f53782f14c5f53da5d5537b369a810a94f9ce184.1599026986.git.matheus.bernardino@usp.br>
 <CAPig+cSLjMabeLgkg9N7+ZJ1jotbpJx0FAnjkpNSt0Lf+Q0wNQ@mail.gmail.com> <CAHd-oW5gk16=Tmhi_e43vVCufM9=zd8jtZJ_EFJVLmC4dJ06=w@mail.gmail.com>
In-Reply-To: <CAHd-oW5gk16=Tmhi_e43vVCufM9=zd8jtZJ_EFJVLmC4dJ06=w@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 2 Sep 2020 12:38:00 -0400
Message-ID: <CAPig+cSdAp=gaJ01MSxhxc+j=+OFkiPK7e6c960RZwUU22sKhQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] t1308-config-set: avoid false positives when using test-config
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 2, 2020 at 12:16 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
> With that said, I'm wondering now whether we should change the
> function's signature from:
>
> `check_config [expect_code <code>] <cmd> <key> <expected_value>`
>
> to:
>
> `check_config <cmd> <key> <expected_value>`
> `check_config expect_not_found <cmd> <key> <value>`
>
> The second form would then automatically expect exit code 1 and check
> stdout for the message 'Value not found for "<value>"'. With this we
> can avoid wrong uses of check_config to check an arbitrary error code
> without also checking stderr.

Yes, that seems more straightforward. In fact, at this point, you
could just have two distinct functions and eliminate the ugly
complexity of the existing check_config() implementation. Perhaps
something like this (typed in email):

    check_config () {
        test_tool config "$1" "$2" >actual &&
        shift && shift &&
        printf "%s\n" "$@" >expect &&
        test_cmp expect actual
    }

    check_not_found () {
        test_expect_code 1 test_tool config "$1" "$2" >actual &&
        echo "Value not found for \"$2\"" >expect &&
        test_cmp expect actual
    }
