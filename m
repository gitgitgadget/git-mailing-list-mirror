Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474ABC433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 22:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA0A6144A
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 22:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343558AbhDUWII (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 18:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343517AbhDUWIG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 18:08:06 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99921C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 15:07:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p9-20020a2574090000b02904e2cb6a90e7so17572647ybc.17
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 15:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3RyYLIkq2ePsBmt3HCOKu3OFaiwldVa8vdu3eT10GGo=;
        b=v8kEwoRJC+Y3VQYs1mgk8Q8As6x6yc3ll7XETVnzlQKgG0YSYynOu3VcQ8SVkwnkly
         zDkJ9+xqDIih0KA0TbWMe1LKOS13BKNoDBXGLk+0Vh/D7rV1rNZB1qaA+LvPjAIQf0o5
         cH0heSao4N6RWA5fgRNaLKmGY5frcJ4Tss5t8Y236Ltp5YGDRqAMC2u7pj/voL6U9Je5
         lHhw+tsx66zRNfJhObQyIHd0c0vP+0o4w2420JcJCRJSNGeyx9FmezjstGIP+fWjs6Be
         8Pib+gYLF4jZb0sjCqKKmCbqZzGgLP+OD4HLQGmParkS7v01IcnqQ1BMFGMle5IGhYzZ
         n9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3RyYLIkq2ePsBmt3HCOKu3OFaiwldVa8vdu3eT10GGo=;
        b=e6IVauQg3t6dvPbuAMNN8Y0hXvqs7BAuVos+QkXwHIMye8gJjGEwoOqnqvoc0Jc7pq
         U295/aArEdmVXPC+XTHxo1QBEU0E6GWhDukkuv57P25mR7QrRMS8dc+E5skBRWv/tlA6
         1MRrOK5El410FNzOkRfTERWV1H+1+fVI2tCOdvEDrKfpKd2gtkKneQGZvjlRc2oWnb8c
         FIRRH2/kqYUAfyHn46LNp0inGeNat5YENhA+ZNg99WZLxk0c6KwZX9JUOzM1WUnTf3tK
         Wb7Mg+uyRfWcWWJOCuXe4UCaAyAUrfEXlUp8pjkt4q0Di1O7Wu0jyYNXgKrmj/kHqK3E
         89AA==
X-Gm-Message-State: AOAM530K3sDciJkghDRX3vha5OnbOGVd/CUzqBEuQhPGdig8R8UGed0F
        lBVwvTZQjyBEqW9vE8wCfyhJnCt+Ot2FzgGIyafc
X-Google-Smtp-Source: ABdhPJyOjEXHNVw4cr2Vrvp7Ao7000YzFZpflEhyNKwk31uAx7JBkh2/VBBaAgzgI9DX8iyxo7y9fLK+I9wGNueM0Mu6
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:3b8f:: with SMTP id
 i137mr299288yba.16.1619042849814; Wed, 21 Apr 2021 15:07:29 -0700 (PDT)
Date:   Wed, 21 Apr 2021 15:07:28 -0700
In-Reply-To: <patch-3.8-22e7d9a3db-20210420T133218Z-avarab@gmail.com>
Message-Id: <20210421220728.1023248-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <patch-3.8-22e7d9a3db-20210420T133218Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: Re: [PATCH v2 3/8] object.c: add and use oid_is_type_or_die_msg() function
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
        peff@peff.net, me@ttaylorr.com, newren@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +char* oid_is_type_or_die_msg(const struct object_id *oid,
> +				   enum object_type want,
> +				   enum object_type *type)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	if (want == *type)
> +		BUG("call this just to get the message!");
> +	strbuf_addf(&sb, _(object_type_mismatch_msg), oid_to_hex(oid),
> +		    type_name(*type), type_name(want));
> +	return strbuf_detach(&sb, NULL);
> +}

It would be more convenient for the caller if this function also checks
want vs type and returns NULL if they match. That would also be more
consistent with the other functions, and the caller wouldn't need to
remember that this function only works if want and type are different.
