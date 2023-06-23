Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C39EB64D7
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 13:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjFWNSx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 09:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjFWNSk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 09:18:40 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88105213A
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 06:18:39 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-57012b2973eso5380067b3.2
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 06:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1687526318; x=1690118318;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qTi1QzSbme7S+08ONk/sXHbqoFHVhFVApFgJymSjdcg=;
        b=fZyOaBndz8NjifwMxLVy4TDfGmSM6cmbf8J1Unf1k75X3oH+DyyAI59fGccDTbMu+v
         S4dx/jL1tL34Glq9+Kzb+xUiOmB0nkEPxNsEKB9Sii300Ma8fkCucZyPAo20zI8+uaWT
         gKPZWBAkAC+/9Gelyy9TtLPeU9ebHW5SVRc9rN6ZxcQNa4zukEXt7WXDR70Wof367lh8
         cOsq2rdy9w/JICT0oHLnkXtHgF0oneoH8lcEtD4Wwz8lQCJ0bJNP12lt46/c3wHImHmT
         rbJ+pVlJmEDZg5z/B5Mm82lZK2/vuGSm5bO/JMWQT8WMrgiM/uF9xIPkMXYvQgOpMpRn
         Gbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687526319; x=1690118319;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qTi1QzSbme7S+08ONk/sXHbqoFHVhFVApFgJymSjdcg=;
        b=KlG4kQk4Nzcd63oDg8XIK/GuzaaF1RPwDig96uws+zZzXHs8hOA10tnPWpZ1Y7PODa
         XReGWa63ImKQneFUN0biHRxczV6k5U0xvw6EbITnpXD/8Vb6sfNsu7LMlwswc0yuPw/g
         Y1K0A/c45AQGalH6w1nePp2+Y+tXPOA3Lg23bnjIqyqXzItwHuTjlkkf0CX5gns3PXGc
         aR39R/25n3foKLfBiMS56sFlNqMLDI1vGGcIUuBRoiFDzrP5ZG9q1Fazk1L7mJt0T5q2
         TH7XcVX/S9ZqR5MLbi8ZtYQaSjO7jfWZJHHEoxqT8gvAOlX8YEYA+AD8r+1L4FHPLrWU
         yttQ==
X-Gm-Message-State: AC+VfDylIrk3cGgOdJQ0hKVQBBQWvoPpAFrYJv2NpDQxZF/Bv8BcdSL3
        xh8Wy5pOMwH3WObhxBNk/GJ1
X-Google-Smtp-Source: ACHHUZ4skMERFzUB7mVSut0HgqotjYH/4Pas16fpncWgi02lsBCDB94bOvLAcezKWDZCmS0cpWdmxQ==
X-Received: by 2002:a0d:d611:0:b0:56c:b6ef:c91e with SMTP id y17-20020a0dd611000000b0056cb6efc91emr20638329ywd.26.1687526318692;
        Fri, 23 Jun 2023 06:18:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:ed06:4a41:daac:5b11? ([2600:1700:e72:80a0:ed06:4a41:daac:5b11])
        by smtp.gmail.com with ESMTPSA id l64-20020a0dc943000000b0055a7c2375dfsm2390307ywd.101.2023.06.23.06.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 06:18:38 -0700 (PDT)
Message-ID: <6510d9ec-2dc6-223d-3578-c6b05bc08f3c@github.com>
Date:   Fri, 23 Jun 2023 09:18:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 0/4] Changed path filter hash fix and version bump
Content-Language: en-US
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <20230622222756.2046051-1-jonathantanmy@google.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20230622222756.2046051-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/22/2023 6:27 PM, Jonathan Tan wrote:

> It looks like we can't avoid writing both versions (we need to write
> version 1 so that we can reuse existing Bloom filters when writing, if
> the repo has version 1 Bloom filters) so a config that tells us which to
> write sounds doable. I'll take a look.

I don't fully understand what you're saying here.

We need to be able to write both versions (not simultaneously, but
toggled via config) so we can roll out this change carefully instead
of suddenly due to the Git executable changing.

But we don't need to be able to write version 1 just so we can reuse
version 1 filters. In fact, we should be able to upgrade to version 2
if the config points at that, but we should _not_ re-use the filters
in that case.

This does present an interesting challenge for the upgrade: we have
the commitGraph.maxNewFilters option to limit the amount of new filters
we write at a given time. When shifting to version 2, we will start
from scratch, so that could have some effect. I will consider how to
handle this, perhaps by raising the number temporarily.

Thanks,
-Stolee
