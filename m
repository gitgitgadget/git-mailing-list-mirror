Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A58CC4363D
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 23:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C12320BED
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 23:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lTQxWtNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgIWXUe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 19:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgIWXUd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 19:20:33 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A46C0613CE
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 16:20:33 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id f10so908266plo.20
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 16:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=9o9CEGfHk199Cft6ehyMlF1IDQkhkq/UZPzdAMbvxTA=;
        b=lTQxWtNYUnXBFEhwv7ieZkhpBDvPjdzSaaAwQ5Ifky1gXZvXcKW1X8b1tIj2B2QZEm
         9MZhZGXSLKDK1Rq7RWnHC74SUtV0hGjRUXkvJx6YYfzshK1WR0PBxNIaJ2raYeXM4fdU
         7dMNLEojpIwbfgmTZs0WIqSqq+Mugf8WU8Q6LquJ+5hRwpMLvYJsxMWMRph4KWDg/01e
         MUj0xJ0V86zfKqnzqRgIFilq+1uRf9GoHJNcFLKRtylKCGaKxZHEPaTWNGx+TVy5WAA4
         siE9RoJ4lvoa0iyMxw/6bBeK3BJmJVeyEOQ3Ew6vxwTBMwMBjx6ou9xQgNRyYlFN3c63
         IL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9o9CEGfHk199Cft6ehyMlF1IDQkhkq/UZPzdAMbvxTA=;
        b=pa7NGob05eDyUzl85oImX6W8FLAwY+gTibiyBzs6ux2hsxVF9kBvtDPenhEqKQmDJu
         3fDDYpdGxW/5rsayYLBpQVmQ+S4JggVqDqdwzQpvI2FO5eG8CIFjcaZ/i1CgqdocuEwT
         4Rr85h+VGLvW+lE8yhkL0y8/7jDewRD6uw7HWPVrgtc8UdZgNa1aWdjy4VcS61mq7UTn
         2MNsSVWe+4EEh7hG0Nu7DbUgJPiiyTX5jkh/QhZOPqeEZK/5m/kIyFbuDtyXudvYsaS0
         bE7Lr1kXjfXZ7DnjpTbilCcDFeVE57p4wC8+41G8vwrFUR4rhIRiOc8AZ3iJOEVsHqNJ
         C/BQ==
X-Gm-Message-State: AOAM530kg1nUopAUBMVws8SIZutTLAh/bBL5sjYRWsIWQu/7cv9kJfwv
        ekQGp9okegzuZ4AsGvkce8YjZBsxWZyzbitd+5lv
X-Google-Smtp-Source: ABdhPJwz5q7BfLj9HDkhHp5VENeWkiuUfzjiO0dlDZ5CsYBPtW3BCc8X9dWCvUkFWtft/+unBfzd8GsRHBxuOIMvWeOL
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:bf46:b029:d1:f387:d225 with
 SMTP id u6-20020a170902bf46b02900d1f387d225mr1868069pls.74.1600903233134;
 Wed, 23 Sep 2020 16:20:33 -0700 (PDT)
Date:   Wed, 23 Sep 2020 16:20:31 -0700
In-Reply-To: <20200909004939.1942347-8-emilyshaffer@google.com>
Message-Id: <20200923232031.1283731-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200909004939.1942347-8-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: Re: [PATCH v4 7/9] hook: replace run-command.h:find_hook
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +int hook_exists(const char *hookname)
> +{
> +	const char *value = NULL;
> +	struct strbuf hook_key = STRBUF_INIT;
> +	strbuf_addf(&hook_key, "hook.%s.command", hookname);
> +
> +	return (!git_config_get_value(hook_key.buf, &value)) || !!find_hook(hookname);
> +}

I was surprised that this didn't share code with hook_list. Upon further
thought, hook_list might be expensive if hooks are present, but if we
can cache results, I think it's worth it. A caller that calls this
function usually will run hooks if they are present, so it's not wasted
work to construct the hook list.
