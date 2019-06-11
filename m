Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08C8B1F462
	for <e@80x24.org>; Tue, 11 Jun 2019 23:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404508AbfFKXUo (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 19:20:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37280 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390115AbfFKXUo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 19:20:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id v14so14805184wrr.4
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 16:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cJPdHPSR5wsitiH9j1AYpGAMtV8pcZMzYxmIK50ZBTE=;
        b=ermcG++9jq0pEUqjtZCFQfEsB4ZUUJgxfxxcDHUAj/T6i+VnjyGH/cvUOhDn93s8yb
         NJB43JMQuuA1koIBVgdRW1gDU2wA0iYQJKH8C6OW9dnr0AxOlqgQP1/5MsaVMcLU0s0t
         zsjQAQC91+Fnrc/ZJOpAqOatnoAEYkja1Hs29bJ0glDiiP44fmBTmvo5vdXNAGymW9Da
         dJ2qF3grIfOIiYd/hJmIt33IycR8drJV+L3lOJX+HPhWjFCR6/jqoRpu4s8DBkRVCdwm
         CR78PIF7UJVKnWXeRvI3FRjx9IET/jQyUpq0WHZnN4ftssr6jds2gtDJqfdTtT7Yr7LC
         J6hA==
X-Gm-Message-State: APjAAAVX+4FeJE/Klb/sBdE+AkZctqkEJQPDUpoWrvf8+RwzG042DQus
        eWpK9w27IMB0RFaiP0CF2gFtK+6liU0ATiQMcgE=
X-Google-Smtp-Source: APXvYqyd5YxFkC0tjXHiMComqoriZ9XLTBY2o6WNnFi/+l1APveSW79AuDQMchFqn456V4lFWQJDX6gtjIFxY1NqvyM=
X-Received: by 2002:adf:8b83:: with SMTP id o3mr48573144wra.278.1560295242392;
 Tue, 11 Jun 2019 16:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190609224400.41557-4-sandals@crustytoothpaste.net> <20190611230255.146381-1-jonathantanmy@google.com>
In-Reply-To: <20190611230255.146381-1-jonathantanmy@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 11 Jun 2019 19:20:31 -0400
Message-ID: <CAPig+cT-N6=-9CJR1ugQnrksy-Zfx7bqnppsEdpiX8qaG-7_Hg@mail.gmail.com>
Subject: Re: [PATCH 03/10] t1450: make hash size independent
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 11, 2019 at 7:03 PM Jonathan Tan <jonathantanmy@google.com> wrote:
> >  test_expect_success 'alternate objects are correctly blamed' '
> >       test_when_finished "rm -rf alt.git .git/objects/info/alternates" &&
> > +     path=$(test_oid numeric) &&
> > +     path=$(test_oid_to_path "$path") &&
>
> Double assignment to path?

I tripped over this, as well, when reading the patch, but if you look
closely, the second assignment is "refining" a value computed in first
assignment. It would have been clearer if written as:

    name=$(test_oid numeric) &&
    path=$(test_oid_to_path "$name") &&

or:

    path=$(test_oid_to_path $(test_oid numeric))
