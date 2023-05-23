Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866C8C77B7A
	for <git@archiver.kernel.org>; Tue, 23 May 2023 04:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjEWEil (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 May 2023 00:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjEWEij (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2023 00:38:39 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F808109
        for <git@vger.kernel.org>; Mon, 22 May 2023 21:38:39 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2532d6c7ef2so3153997a91.0
        for <git@vger.kernel.org>; Mon, 22 May 2023 21:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684816718; x=1687408718;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jSvLECGQPqWVIBo9NvFm8gkUUs4qTrBU+6nW9coOnVI=;
        b=pQifdHTzl2xPvuSLmoRga8sdfdSOBpxczpc45qEFHLHURknFPPqdcH9C1S3ADqKi2X
         ZSJr9aAkUNpBZaqH3GvBhTbiZQKZA/q90C9XSKWEZadXXkvpGVBIpYYYaFULcA0zCnSD
         zEDDx821PulzZ8nSZEORIQNn94tX/T6JQ51yWZ1sAzKnKFC8HQ40s5pKRcxcqtmSsMAG
         zIzZdkMaMQnM3aiwqYmctnBcgB6fiDeLJbnskBDA7jLZKDrW+G7z02Ne5zVq7p1moOAS
         buwCryd3mToJzSEUXJZXfEhnOiuseSFYNYjynuUWQZ9Fr6JyPgZo0J3TaxTWKNRyUqtx
         xPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684816718; x=1687408718;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jSvLECGQPqWVIBo9NvFm8gkUUs4qTrBU+6nW9coOnVI=;
        b=AaWD3TRMESiAQMimf5Ogq+IMfvJyXeK+InUDlGT2BPObeasVZsf57xbbt2we1PUG7n
         i8Kk2rA144t+TPFPdRCL12cbVTv9V/FcWVw7W6TXNJpNb6hrn1js0goZG4MXWWueQ3qV
         LiPcrRkjM+/SzGRQ+NloV0RPM3VpTjXsxzejNiZYfPkaYKNaJwptjSQvC2SruExBRPX3
         yIAdmULdrrw7yHLRY7H8+vDBj7llcmElhCVjHiVHjHr/OhcWCLtx+zxKu18FE/F9bRU2
         o/0fVr1McVN0FsyjlOBbqkxJ5ObgXNFKve3zmIcsW6ffEkkGEcXuplZLaMEAtY6AGtWU
         aCWA==
X-Gm-Message-State: AC+VfDws92yOnFuYpHVgX0Jq0Fz6kr8w1K3gM7Siw7kprTv+ZOe4iWU8
        vSBMcO2F3JDcGP6YaQBIoBQTLZaXiI4=
X-Google-Smtp-Source: ACHHUZ4ccuoDeEdcV2RN1qmdCJRxsoBnqwaFHgpYdw9oPdqXox1WXuodDtEDG5IH7oR5hYdjy0a2kQ==
X-Received: by 2002:a17:90b:100e:b0:250:a2e0:e034 with SMTP id gm14-20020a17090b100e00b00250a2e0e034mr18147802pjb.5.1684816718382;
        Mon, 22 May 2023 21:38:38 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id ge23-20020a17090b0e1700b0024de0de6ec8sm4931249pjb.17.2023.05.22.21.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 21:38:37 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org,
        derrickstolee@github.com
Subject: Re: [PATCH v2] diff-tree: integrate with sparse index
References: <20230515191836.674234-1-cheskaqiqi@gmail.com>
        <20230518154454.475487-1-cheskaqiqi@gmail.com>
        <2a2b7223-bb5d-65f9-95bb-9be45d329c87@github.com>
Date:   Tue, 23 May 2023 13:38:37 +0900
In-Reply-To: <2a2b7223-bb5d-65f9-95bb-9be45d329c87@github.com> (Victoria Dye's
        message of "Mon, 22 May 2023 12:07:23 -0700")
Message-ID: <xmqqy1lfirw2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> Shuqi Liang wrote:
>> Change since v1:
>> 
>> * Update commit message.
>> * Use existing test repo to simplify the test.
>> * Add test to ensure index won't expand regardless of 'diff-tree' a file
>> inside or outside the cone
>
> Thanks for these updates! This version looks ready for 'next' to me.

Thanks, both.  Will do so (when I get back to the keyboard---I am on
half-vacation).

