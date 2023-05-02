Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FE5C77B73
	for <git@archiver.kernel.org>; Tue,  2 May 2023 19:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjEBTEj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 15:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEBTEi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 15:04:38 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562EEDC
        for <git@vger.kernel.org>; Tue,  2 May 2023 12:04:37 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-546dad86345so3024642eaf.0
        for <git@vger.kernel.org>; Tue, 02 May 2023 12:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683054276; x=1685646276;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8zya3aWURCnRkgR5NLaYiOBlcr6crVCp9Z1GWFyrng=;
        b=nnywvauVUdnOrP/yeXTGOcQ6ZHpmXVrbRT8Q7QvOYx9LFFADaNHIK+epOt9u2d8lyH
         QV22SBHmILej2ZcN6zwa2Bf+rNSJ4v8HUBRZJtBP3OEADatq/Jtvh81/Cc7Ecy0UEI0y
         bt+BQjhnXWoLcV5+qbzyKANpAj/rbgYLxQKDQVcw/3rKavrlFNL+eQC9VxzIP2IquILF
         UJlhZF9N+ia/000cJyZK+fA8cfsQcq7D5cCy08ebcLcB+7gAPRvXYwFqWzJIyJ9K4Ssl
         4D0kd2sUN48eqHRCDQ7AbCFuVb3GCxrIFDbbPtyMg27eR0AJ0lAQxV5euuJFP34icKXc
         hMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683054276; x=1685646276;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y8zya3aWURCnRkgR5NLaYiOBlcr6crVCp9Z1GWFyrng=;
        b=XxZJ8LAQXbVwTuQ5dvzOztQJjXUU7O0qcJ6I8IoMz1o/VlVYQGrXJizPdyfGXjewsn
         k3psasZOvB3Oyl5WxQT9Ds8v171k6WN9ZzIiro0qJQWLRbVah7B5BD76SLq1odyrMhM5
         OQRsjm3ubgYoTYGhk3ugzIhUeIZca4ejSLZOqOw/kYnjrMWfkGucvKXG0qkx+s8rjzAG
         9F9Z3jrAzu6Abc7DZ8851TgWQDcZBYrYE5x80ifGdu5Niiuf26rBiLLy0V8fIeavBQEv
         0wn0KxJ0FnQXCRo8zqJqvHdcP6Z0yMKrXX1yQ/yRwGUIT8WKDNdf21jO9xA3c+J4fHIV
         9JbA==
X-Gm-Message-State: AC+VfDyYNMVcTjLmVfE9J7EvhkA/6rTZNFC2RHWknn6qtRc2IcX+zg9T
        0pyD4b82YYbiXHoEbD8/EiM=
X-Google-Smtp-Source: ACHHUZ7EqVGOJEKP6YIWQCC6qYF4ep3UBNaFlAw9xM02twgwwVdujPh+khH5+VyZghSHmlM9ieSl4w==
X-Received: by 2002:a4a:ba1a:0:b0:545:3076:9e6b with SMTP id b26-20020a4aba1a000000b0054530769e6bmr8469940oop.6.1683054276648;
        Tue, 02 May 2023 12:04:36 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id k1-20020a4ae281000000b0051a6cb524b6sm1386441oot.2.2023.05.02.12.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 12:04:36 -0700 (PDT)
Date:   Tue, 02 May 2023 13:04:35 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <64515ec34592a_1ba2d29466@chronos.notmuch>
In-Reply-To: <xmqqttx1l3zp.fsf@gitster.g>
References: <20230426061606.1495646-1-oswald.buddenhagen@gmx.de>
 <xmqqttx1l3zp.fsf@gitster.g>
Subject: Re: [PATCH v2] send-email: prompt-dependent exit codes
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> Administrivia:
> 
>  * Marking the patch as "v2" is very good to signal that this is an
>    improved version of a previous effort.  It also is very good that
>    the difference from "v1" is summarized below the three-dash line.
> 
>  * When sending such a new iteration, it helps readers and reviewers
>    to make it a reply to the previous round.  You seem to be using
>    "git send-email" and giving the option
> 
>    --in-reply-to=20230323162234.995435-1-oswald.buddenhagen@gmx.de
> 
>    would have made this message a reply to the previous one.  Not
>    everybody will remember your previous attempt.

You can also use `git send-series` which does that for you, and also
sends the `git range-diff` automatically.

https://github.com/felipec/git-send-series

-- 
Felipe Contreras
