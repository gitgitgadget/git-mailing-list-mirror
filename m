Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF795C77B7C
	for <git@archiver.kernel.org>; Wed, 10 May 2023 19:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjEJTSU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 15:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEJTSS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 15:18:18 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FBF5255
        for <git@vger.kernel.org>; Wed, 10 May 2023 12:18:16 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6439df6c268so4721870b3a.0
        for <git@vger.kernel.org>; Wed, 10 May 2023 12:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683746296; x=1686338296;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VumnZ/ffsToY39/O8QNNh5l7Ndzb56+FjvGdua7NH78=;
        b=kfl26MZVrtD9+aJXGWPW+mUm4j7pMqxYrNSJahDRsfrjHPV2XB8WC39B09hJjSwayL
         yWEsH3sioXB2y1BrVSzEuGIbfPSA8Uy67CiiT2qh3VKOKPUP/JO2tLk0WHN4SzCTTlZn
         SU8dU8wIMYbctuAPEimvQVq3O1zX99lxQeCSu04mzHB6PNfWRikOL6Vw+lICGShtuwsa
         y8TD/ze8QkMty37nODN/clIZJBuKl9U7Af+8jQthVmORZKn4VG3hWL1w5vsutevJByEo
         rKJjvlo4Avtw3Fhfkh8AfmlHFbWWwkQKV6OVyOSoLde1+FRdWRKYZCCAtjHR2CH4NIcv
         EiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683746296; x=1686338296;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VumnZ/ffsToY39/O8QNNh5l7Ndzb56+FjvGdua7NH78=;
        b=i2AMTuK/qlXUQnoklsW8d1eH94YWTXRbM7UWyfhMqOb6ZaJLuInENtlyg+taSmO7lW
         AE4k1x7VX9v8Zw5IdONtnifmoj1yxnxui0XFlLDDlGAV9fe5H5qYHD+WMFL/YYtm3BT6
         dgrlPXe3Fv4UwOi0Adh3W0E4BkCSNP5vI5SkzNBaO17QLsE5ys4kXOtyHSpzqTz0QANa
         lxhnP4Vdb5KkPqnPWFowYn6RJXl8Wr9b75qERf2zebRceZZ5muUZ373eEPAJQybmMBdQ
         95FJACpPuEl6nVsQJnF6HBORXqo7GJVvyXJ8bk98VZBY3bkHCfSwIafNvDIGL6bXhgOP
         Ylcw==
X-Gm-Message-State: AC+VfDwmlI1XhROBHdHRD5ahIhJTunz9t9Euld4+mX4OHItGJRH1JLgf
        d+vZlt3eukp/6MRZ4PQmZC4=
X-Google-Smtp-Source: ACHHUZ5sJWQiLZjO+Psa7Mh7cSXt/Nf7WULMDVsgxCKyr5G+fnCMn2thBO/wR04/6fc1gwcX7iPqcA==
X-Received: by 2002:a05:6a00:2401:b0:63b:5501:6795 with SMTP id z1-20020a056a00240100b0063b55016795mr23910863pfh.24.1683746296300;
        Wed, 10 May 2023 12:18:16 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id c19-20020a62e813000000b0063b806b111csm3836180pfi.169.2023.05.10.12.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 12:18:15 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, christian.couder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] merge-tree: load default git config
References: <pull.1530.git.1683745654800.gitgitgadget@gmail.com>
Date:   Wed, 10 May 2023 12:18:15 -0700
In-Reply-To: <pull.1530.git.1683745654800.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Wed, 10 May 2023 19:07:34
        +0000")
Message-ID: <xmqqsfc43si0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     This patch was reviewed on the Git security list, but the impact seemed
>     limited to Git forges using merge-ort to create merge commits. The
>     forges represented on the list have deployed versions of this patch and
>     thus are no longer vulnerable.

Let's queue directly on 'next' (unlike 'master', where we want to
merge only commits that had exposure in 'next' for a week or so,
there is no formal requirement for topics to enter 'next' before
spending any time in 'seen') and fast-track to 'master', as I've
seen it already reviewed adequately over there.

Thanks.
