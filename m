Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E879C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 18:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352512AbiCXSNN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 14:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347622AbiCXSNM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 14:13:12 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CD0B6E5E
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 11:11:40 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id x2so5584701plm.7
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 11:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ooXJOfrwrkO2lYJ/mnb19/GDvGH48mJLusTKIPtIeBE=;
        b=myNJ5yOrn0ULHoE+LJkAz7EPgS1hqgCEwikcRwd64y/vnG9KW4Jein+PIw5Hjkc+PI
         1Z9H/ElHjSAQbvGTJ7fLgFJFNjzNyWLI2OIMmLOItnYKO/oyGkvq4cpSAcQdwFfph0PI
         C7lGOgVY+7OdYN1/2GvzRcoewjKlYgtPZvVVxuSCaX1zGVzZVrdC7Eq0XO6r9IxAbI9u
         i0fE7C0M51iGb6Qu13TdybEaxAPOmYZcESLSw1EI7Zy2PLT8jxjWy/AoxbUsIDZ2kvyd
         Man9suycJbPSHyxTWGP4vfhmRgXzsNmPEaM2P+HoLufYI53OBzjzkvgBCOjwNGS03Mww
         IciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ooXJOfrwrkO2lYJ/mnb19/GDvGH48mJLusTKIPtIeBE=;
        b=DPfeh3QC/fmJTW1uAioUQSUv+3fnkNCuga1q3+uLQ4FQRc8G56lCXnvdsdB4iE062e
         m81MzpRV5uvItdY8WPPj8Hrkc4Vs788bCem4Oza7/N0q/28gyb2iGbqbW2Na77nOWJqe
         51zNVJFlpH56y64pBmx8yDo3xFar1PW/orNk9ufwxpoCz8tYQPz0umzibXUxME6jK4J2
         inGt6YCfWGvn+FJvyWKRZcO38LrHIzZpOmgN8+XRCslYcdlLykuJGcHMXDPnqKuVkq8b
         pms60T3JBxTYuUCyELxIXRR6F8yyYocC+Fy5IVYlqJil5cpRsxJSOLekqdK8UZaPVjVv
         mIJw==
X-Gm-Message-State: AOAM530vNn4d6Ec7Qrg6Ki0qg+A63WbYaJb0EkztIsNNQ5n3IGS17X08
        w+qZSFR/wCJhPwrg/85awzM=
X-Google-Smtp-Source: ABdhPJwvXeTXpTRIxDTSebY/rX4ex5LPGa6PdVaZP6IllVJCEJx0CKFa/hnfVTzbcDHOTxD3sY1rkg==
X-Received: by 2002:a17:903:246:b0:153:84fe:a9b0 with SMTP id j6-20020a170903024600b0015384fea9b0mr7135831plh.163.1648145499402;
        Thu, 24 Mar 2022 11:11:39 -0700 (PDT)
Received: from localhost.localdomain ([2409:4061:2ecf:fc24:fde0:e492:d7bc:85c2])
        by smtp.gmail.com with ESMTPSA id t2-20020a63a602000000b0038062a0bc6fsm3093611pge.67.2022.03.24.11.11.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 24 Mar 2022 11:11:38 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] test-lib-functions: fix test_subcommand_inexact
Date:   Thu, 24 Mar 2022 23:40:56 +0530
Message-Id: <20220324181056.53824-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <xmqqmthgu3e6.fsf@gitster.g>
References: <xmqqmthgu3e6.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:

> The result of doing #1 is still "inexact" but at that point it is
> unclear if we are being way too inexact to be useful.  If the
> looseness bothers us too much, we may decide that #1 is not worth
> doing.  But obviously the looseness did not bother us that much
> until last week, so probably an obvious #3, do nothing, letting the
> sleeping dog lie, might be what we want to do?

Personally, I would prefer #3 i.e. do nothing (even in the future; unless
it is removed all together). I also think that the current behaviour is not
"too inexact". Rather it would be too strict for `test_subcommand_inexact`
if we remove the ".*" thing here.

Inexact means that the line needs not to be exactly same - there may be
some words in between the desired words (in this case, any flags that come
between the desired sub-commands). The current behaviour (i.e. 
`local expr=$(printf '"%s".*' "$@")`) is justifying the name of the function.
Replacing ".*" with "," will therefore not work as the name of the function
suggests - it will rather work as `test_subcommand_starts_with`.

Only the `expr=${expr%,}.*" line needs to be changed, I think.

Thanks :)

