Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D17C77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 19:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjECT03 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 15:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjECT01 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 15:26:27 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1984B5FDF
        for <git@vger.kernel.org>; Wed,  3 May 2023 12:26:27 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1aaff9c93a5so26249235ad.2
        for <git@vger.kernel.org>; Wed, 03 May 2023 12:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683141986; x=1685733986;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQJCthXlFvEQw7ytYCyf53kEZ+oWEBYdd3oGs7NsE5o=;
        b=VeORNFMzzWtIT/Wct0W6a5tGD9lMatHvTCxvmMOaG6qe7HOt3n5nGRHfslRDmJ+H3g
         cXm0WlRU+j4g5oalywSwYimEAWqT5rWs0gtAtWB076BoqG14yBcMBV1CjWNn1JR2GWHr
         wkzjSzhfFm68WyQkbmAnIs97Pka26u5StRCCwPi9ILwOpjyb7a7z05L9T3V1HJnq/XZp
         iwzz9uZX9bGyKkfh9RKLxSkSfPhyHYwJFJ+8BHf5uF1ME82dAmdYNw1fFB0UYVvCxVSr
         Y9Cdnvskc4eqh/RDqgvX62pjeGoQg5fXQxOg7TqisB+kIGxjaMEpndwmX5tH+UxTdfOO
         dMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683141986; x=1685733986;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SQJCthXlFvEQw7ytYCyf53kEZ+oWEBYdd3oGs7NsE5o=;
        b=La2/AJRSAzKbXCL9s7NwuAJiRPlwRug7TnRDIqrWE7ZI2f22AyTSZe1OkUIomRtOrV
         azrVRAI8Sdht8T7f9v+wdT6iFsBaAZKUPMu82yYyVnp7z0PzEuN05aUO73ekgSQWmnWw
         sWClqajDG+240YKMMdzAgC1CQUIkZF8d2gYAyFs7HZiG7cc0JWH+vyCyVSEtX9Bs/MgU
         lBZyg4IDqNBql2d14iEQJ7O5uXJxni+zx2uD4+mSqg8HFQJ7zpeo5U4fYprVV7Nvt06K
         KV7l8ytwEDeGg3UKIAL3XpAFXUPSHD0Rf32l03VUyelDHtWzveZqi7X4LMbRJtYwCNAw
         8UBA==
X-Gm-Message-State: AC+VfDxjv+a+nW062rTQUE3372wYQnTG4j4hPrH5tGwTWqAjwidRtmPi
        AUSfGS+/vUq+lxIkubhBo/Y=
X-Google-Smtp-Source: ACHHUZ7KYTPKbbHHpNVJnDCGDKcBpSX8831WzQ4rh9GUw/QrePQ0wToOhjgxF8N3DzNOSnlZYrgZxw==
X-Received: by 2002:a17:902:da8e:b0:1aa:f6f2:46b7 with SMTP id j14-20020a170902da8e00b001aaf6f246b7mr1414427plx.34.1683141986533;
        Wed, 03 May 2023 12:26:26 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902c08500b001aafdf8061dsm5402873pld.207.2023.05.03.12.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 12:26:25 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com, peff@peff.net
Subject: Re: [PATCH v2 6/7] strbuf: clarify dependency
References: <20230503184849.1809304-1-calvinwan@google.com>
        <20230503185031.1810078-6-calvinwan@google.com>
Date:   Wed, 03 May 2023 12:26:25 -0700
In-Reply-To: <20230503185031.1810078-6-calvinwan@google.com> (Calvin Wan's
        message of "Wed, 3 May 2023 18:50:30 +0000")
Message-ID: <xmqqa5ylqkri.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> refs.h was once needed but is no longer so as of 6bab74e7fb8 ("strbuf:
> move strbuf_branchname to sha1_name.c", 2010-11-06). strbuf.h was
> included thru refs.h, so removing refs.h requires strbuf.h to be added
> back.

OK.  Will queue.  Thanks.

>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> ---
>  strbuf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/strbuf.c b/strbuf.c
> index 178d75f250..d5978fee4e 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -3,7 +3,7 @@
>  #include "environment.h"
>  #include "gettext.h"
>  #include "hex.h"
> -#include "refs.h"
> +#include "strbuf.h"
>  #include "string-list.h"
>  #include "utf8.h"
>  #include "date.h"
