Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EEAC433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 23:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbhK2XIA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236216AbhK2XHP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 18:07:15 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8431C07E5C1
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 10:18:13 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id e12-20020aa7980c000000b0049fa3fc29d0so11253374pfl.10
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 10:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ylhWSJ08y4bAsrGui/OQzv9L/FEhyaKSlLNSciBLv/c=;
        b=LGdoBFqzQ9boRwHTIxZ8tULnZ2J5PL9gokz6XEhbCK9F/RbWWwu5jjETLRtqHIh/oU
         QIIl6dxqS8KwiiRDssIn84l9cAC9Cnam3HgFRqcgdEso5DmMBsxdAvmcSh/O5Aoo3pdi
         ED4mj5aBqCKuj0IvwQmP2OsXC6zMsbRqhTVgCOvfeN903soqW12VhWkFSRm+kbkehn8/
         Jy3cy6T9YXWfN8DfmNejxU6V/p/HWhJEUWcR6+o+C+02lm/B/kvIH2g+XdE/BIeNn8jD
         sVLBGk2SWAFgSZaROL59Cl87btbWC5GoG5wK24bcF1KNGvIq3P5twPOAtTowLqKC5VFY
         5gwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ylhWSJ08y4bAsrGui/OQzv9L/FEhyaKSlLNSciBLv/c=;
        b=B4tzaj8+3U7DW7f7fF6U2MITvSmDBPh4952KkgliGKvRkqwrMrbUlYMUS3jHh4x7X4
         A/ZeabS12pAKFjjMwZPoymDyYrXjKdMdb5UiXr8/yKExvL/bN7Uwa/jIQ96he2OCY9vj
         GAEvIuiFcpgbK22GG5xijUHDCH8C85HjLbQ2WnCtt5W8fcwNO7vOqXIsE7W9jaML6rDo
         pL1oeaWvwO2/efKeLPqK45+BH4jtIf1J+FvIEUbyFRSx1YLM3ehTcXboPdjEy+V4Fqty
         uXeuz9OpvGlbvFmVXotT7piHKk0Ha54cl7HdwJ2Knx6XIYW2qK+rZ5sBUBpXT6Q2ZaIf
         gJbg==
X-Gm-Message-State: AOAM530gRToeY88OqJehiSgMfUICw0ElcIMf5FjwUtDJ9EUNmCADteHg
        4cgrSS9105kBnCi45vusjTDE3dEBi4DkY3Cwtd+L
X-Google-Smtp-Source: ABdhPJwKJlH8QzjcvbGVcSKjjrX6LnPgd4ggjSz78RqDEYok7gyhseM6e2M6Er/effXzx5VpzjmYIpPfaHyj9PUndwzZ
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:9b8f:b0:142:7999:67fb with
 SMTP id y15-20020a1709029b8f00b00142799967fbmr25295493plp.24.1638209893153;
 Mon, 29 Nov 2021 10:18:13 -0800 (PST)
Date:   Mon, 29 Nov 2021 10:18:11 -0800
In-Reply-To: <xmqqtug3aco7.fsf@gitster.g>
Message-Id: <20211129181811.375318-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqtug3aco7.fsf@gitster.g>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: Re: [PATCH v3 2/2] config: include file if remote URL matches a glob
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        emilyshaffer@google.com, peff@peff.net, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Here is just a design level comment, without trying to outline the
> implementation in my head like I usually do before making any
> suggestion, but it strikes me somewhat sad that config.c needs to
> know specifically about "remote_url".
> 
> I wonder if this can be a more generalized framework that allows us
> to say "we introduce a new [includeIf] variant to get another file
> included only if some condition is met for the configuration
> variables we read without the includeIf directive", with variations
> of "condition" including
> 
>  - a literal X is among the values of multi-valued variable Y.
>  - a pattern X matches one of the values of multi-valued variable Y.
>  - a literal Y is the name of an existing configuration variable.
>  - a pattern Y matches the name of an existing configuration variable.
> 
> If that is done, I would imagine that the feature can become a thin
> specialization e.g. "there is an existing configuration variable
> whose name is 'remotes.https://github.com/janathantanmy/git.url'"
> 
> Perhaps I am dreaming?
> 
> Thanks.

I think that the hard part of this is how to present this to the end
user - right now, we just have one pattern of variable (remote.*.url,
where "*" is a wildcard) and one pattern of value with specific
properties (e.g. this is a glob, not a regular expression, and the
special value "**" is supported).

Once we figure that out, I would think that we could implement it in a
way similar to this patch. As for whether we should wait until the full
feature before merging any code that does includeIf based on a variable
(in order to avoid having code that would quickly be replaced by other
code), in this case, unless there is another use case for this, I think
we should proceed with the use case that we know about first
(conditional include of a file supplied by a remote repo administrator).
