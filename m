Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297E2C77B7E
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 06:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjFAG0i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 02:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjFAG0W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 02:26:22 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25017119
        for <git@vger.kernel.org>; Wed, 31 May 2023 23:26:20 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3f6b34d2fdcso3482691cf.1
        for <git@vger.kernel.org>; Wed, 31 May 2023 23:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685600779; x=1688192779;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S4FzthS066PEKj00YGEd0oeMdL01F9qYsqBO2DP+paw=;
        b=QtJVdN2WBS0MsgvTiR+DtkRvXleYHiHx7xSRLwXhF+raM10hwUPgHsRNn9k/z6q5hy
         7vu4/ID00BiVJJtwRgushQyvCec3z+pKBUb2uKnHGKUuK8YG2F5Q0DrjsSFXgvwaIOTn
         Os9HatU8aF71E34wI+H5DV4KcH9C63KZY+wmtcJvqVCQCfablFwQAvJb5fYVDfbpWgv/
         RghejTMYg7Y3b/0C17beic1lq10c3/SvJmbZZevDXikAzvsB0P8dBK5d+2ZD3vTQDdW0
         fbJmnBEMG4wosmX7H355xVhcd2BYYDFVeeI+KET9S8POX3NZgwIZrOUJppF6Zjz0yZ15
         A5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685600779; x=1688192779;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S4FzthS066PEKj00YGEd0oeMdL01F9qYsqBO2DP+paw=;
        b=koHgZd6rAOgqKGSugaeMt5/jW8Hg7TkbmzMq4qE5rEcBEru+lD9gg4OHgWIjqWQS2S
         k1+z1bWu5/9fwLHKwg1ZDNcUbc5BFcnDz05oj8rYkdZvCtJGUhBUltLAVZ8fh4zKDVOI
         kWu1JtyKtFG8KxVwDIQTqYp1IpE4DOKPUDBiuz/X1McesPAdT1WltEQ1OHipR45PxZp8
         m8aKOxDY4qv/jZjyOwQw1ehMoRW4ONdv5dlE0SLOQV94ZlQj0h9CVxPc5Uu/f5BMZHC9
         IU/9MGKhEN6NZ3pCWCNS31qn47LXsRzR6mqHX53zvsGcaBqOXF723xXlRBgNp2Ir6/Al
         de8w==
X-Gm-Message-State: AC+VfDxFjxF9jwH1dZuSByLzjGuNiJ/VPp6aUA9tUcUFrtFhDjC4l3Oc
        WNHRceOO3u0UuxVCB1cLqBlkk3Oxtr6xNA==
X-Google-Smtp-Source: ACHHUZ5RKU4ysojIJQNKQxuBmbk7EUfxA6konjR31f+G3yIjGf9dfZmjzJCur4Zi1KRIGrhIPhzunQ==
X-Received: by 2002:a05:622a:8c:b0:3f5:434c:3506 with SMTP id o12-20020a05622a008c00b003f5434c3506mr10026467qtw.11.1685600779121;
        Wed, 31 May 2023 23:26:19 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id e12-20020a63ee0c000000b00502e7115cbdsm2351142pgi.51.2023.05.31.23.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 23:26:18 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Siddharth Singh <siddhartth@google.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] Unit tests for khash.h
References: <20230531155142.3359886-1-siddhartth@google.com>
        <ZHfLwpX7nNVjBvE5@nand.local>
Date:   Thu, 01 Jun 2023 15:26:18 +0900
In-Reply-To: <ZHfLwpX7nNVjBvE5@nand.local> (Taylor Blau's message of "Wed, 31
        May 2023 18:35:46 -0400")
Message-ID: <xmqqr0qvbsvp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Hi Siddharth,
>
> On Wed, May 31, 2023 at 05:51:41PM +0200, Siddharth Singh wrote:
>> This RFC patch adds unit tests for khash.h. It uses the C TAP harness
>> to illustrate the test cases [1]. This is not intended to be a
>> complete implementation. The purpose of this patch to get your
>> thoughts on the unit test content, not the test framework itself.
>
> Thanks for working on this, and for opening the discussion up. I took
> only a brief look through the actual changes. But I think the much more
> interesting discussion is on the approach, so I'll refrain from
> commenting on the tests themselves.
>
> I am somewhat skeptical of this as a productive direction, primarily
> because khash already has tests [1] that exercise its functionality. I'm
> not necessarily opposed to (light) testing of oid_set, oid_map, and
> oid_pos, which are khash structures, but declared by Git.

Yes, as a fairly isolated and supposedly well tested piece of code,
using khash as a guinea pig for the technology demonstration of C
TAP harness they propose to use would be an excellent choice, and I
found the request not to talk about the harness quite odd.  It felt
almost pointless.

The "main()" did illustrate a few things people found problematic
with the harness, among which having to declare plan(9) upfront.  An
obvious disregard of the coding guidelines did not help well,
either.  Overall, I am not impressed.

Thanks.
