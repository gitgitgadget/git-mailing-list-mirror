Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FB6C43460
	for <git@archiver.kernel.org>; Wed, 19 May 2021 14:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C34760234
	for <git@archiver.kernel.org>; Wed, 19 May 2021 14:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243278AbhESOzK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 10:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241229AbhESOzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 10:55:09 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C129FC06175F
        for <git@vger.kernel.org>; Wed, 19 May 2021 07:53:49 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id v8so13002985qkv.1
        for <git@vger.kernel.org>; Wed, 19 May 2021 07:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AwMVnFlXRSWy8QanoX/MDscqTrPXkZ73rCrR2KIo7mg=;
        b=NEFkFUHqpAMSmT3eGQk34LpBYumW+CzNDGxYyRynyAZ9MPD6ng5wVUa6iKAPgR26b8
         9EuVxBL5nRWEz1zB8badWWdXCIb7xKHJjOQ0WBI7KMZxUv2o9qRxVeagSEJnGe0kYGii
         m9bZ3fu2fXqZUsp2fj45yXVTUQMEYuVC1EouJzTF8crh7FSrwk4WUXQIBY9fnkBF5pYO
         HAF0LswFJ35q8BsfkPA4cp7oH4/p9W/Rw+9xrMj23aT4SRiRMrKkp0RN8CjiPxkQNxg6
         on+NJGPBqXP0AC8rRg2vXqiv+1eE36Btge5YYnwbC+qqhNsoPP/I3KQf9eCylY6yZqSm
         v91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AwMVnFlXRSWy8QanoX/MDscqTrPXkZ73rCrR2KIo7mg=;
        b=KOmpqVVX09oDxQ4p2ULwsSq7haxNSVOjqNXDQlhDSQRE3J/Tj8epgXl+InIUqNt97R
         cwDxBjRL0NkKbs6aoLvVGI6wS/+QnK+FI6YfvXYrMRVuyInXH0PVbRMnt15T9X0FQQpc
         okGeX1oY5jA73c8m7H+zqhFvGLEsCALb1+iFQzx1TGSaCt7gzMUky1QQwCaz9UHISlXO
         N8pwe7WdDd6dHs9QXhSKATOGBJ91L0MkNll1CDsfbKFZNDNm4TRGKIcNJxtOVZ75GCoK
         hs1MIKTzONMBWGcezarCNAi0KxHym2wIu3KNmSR2SaqgFp+4dCQ1JvCCK+UfvN0WqnFF
         zehg==
X-Gm-Message-State: AOAM533IflVANWc7+13wDxgw9rESjpbYfsBL5L4HP8zS51fscLdeO2pL
        Pkgns+vCRK5Mr+QS7aw8Y8SpSLjKqDfzlw==
X-Google-Smtp-Source: ABdhPJzjfgb5mwOW77DRVcQcTWW6zBxX6HFsD6AuBnpXpZNH8XEyvV4gYo1v2dOyHmzpaSZdJfwc0Q==
X-Received: by 2002:a05:620a:2149:: with SMTP id m9mr13027306qkm.284.1621436028553;
        Wed, 19 May 2021 07:53:48 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:a1ee:38d:5766:9f4f? ([2600:1700:e72:80a0:a1ee:38d:5766:9f4f])
        by smtp.gmail.com with ESMTPSA id t203sm15161837qke.83.2021.05.19.07.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 07:53:48 -0700 (PDT)
Subject: Re: [PATCH 2/2] Revert "remote-curl: fall back to basic auth if
 Negotiate fails"
To:     Jeff King <peff@peff.net>
Cc:     Ben Humphreys <behumphreys@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christopher Schenk <christopher@cschenk.net>,
        git@vger.kernel.org
References: <YKNeJ+NKUbD5ixA9@coredump.intra.peff.net>
 <YKNeXq3JzxYWkxKl@coredump.intra.peff.net>
 <43035278-5742-607a-57bd-971685deece8@gmail.com>
 <YKUdRNH+uLBxAi+m@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f9a1a761-7536-c9b6-4837-d95e2e56a471@gmail.com>
Date:   Wed, 19 May 2021 10:53:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKUdRNH+uLBxAi+m@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/19/2021 10:14 AM, Jeff King wrote:
> On Wed, May 19, 2021 at 09:58:50AM -0400, Derrick Stolee wrote:
> 
>>> (Note that this isn't a pure revert; the previous commit added a test
>>> showing the regression, so we can now flip it to expect_success).
>>
>> Keeping the test is excellent, because it gives us a way to confirm
>> that a second attempt at a fix is at least as good as the first.
>>
>> The only thing that could improve this situation is to add a test
>> that checks the bug that the previous version introduced, so that
>> the next round doesn't repeat the mistake. That can be deferred
>> because it is more important that we get this fix in time for the
>> next release candidate.
> 
> Re-reading what I wrote, I think "the previous commit" may be ambiguous.
> The original commit which introduced the bug (and which we're reverting
> here) didn't include a test at all. In patch 1/2 of this series (what
> I'm calling "the previous commit"), I provided a test which shows the
> regression. And now this revert shows that we fixed it (by flipping from
> expect_failure to expect_success).
> 
> So I think I've already done what you're asking (if I understand it
> correctly).

Ah. For some reason my email client didn't thread your messages
together, so I saw this as a one-off patch (ignoring the 2/2 part
of the message, of course).

Thanks,
-Stolee
