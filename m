Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC27AC48BCD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 15:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD30B61285
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 15:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbhFIPgh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 11:36:37 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:45791 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238547AbhFIPgL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 11:36:11 -0400
Received: by mail-ot1-f48.google.com with SMTP id 6-20020a9d07860000b02903e83bf8f8fcso11288982oto.12
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 08:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=MAwA84iMrosPDtJGmeBomOqklBOx7QUOqz4rfXRocVQ=;
        b=eys9Lc54IHCxPj5fdIz1chtFrL2Q/lUpLDpVjk/xgXsNryVH8A04h9o0bepKYU8X7Y
         e0toebI4XsJN9m6LUPDCEZ7uXz/VxPvVpG6sFuuZGygjNJH9aL6ym4Fb8dx7ZrBhUMV+
         NOUbc19Rd9gXtXestCz6XBvZ0vGM1asCSN4HXrO+d845UA07qaiSstS93CUH1sz912Sb
         SLZdfNgy3Qhxc8z5ty2AyvBXWiH6NO1nWfV2npXM/CN9Jf4XK13CBTyCd/pXspvHHEKn
         g7yz+l180oow1aDawwX3P5HgS3wDsY9alxig9BIflwZCFpiTy+TXcIg6/qZB72hUmw42
         a/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=MAwA84iMrosPDtJGmeBomOqklBOx7QUOqz4rfXRocVQ=;
        b=rUSheU0X7t5kX8Myqacla2hNhfK7UqZAEnfyzP3X4JWZ/kKT7bCjVHinIE/XD8nTxk
         5s6hqgtGxb0Zv5UQhA+d5VfTs7dWm5aTOJK1uL2MWjX6BR8+ORPRjYVDA0SMKqXSfv4L
         FHTbJYcdm70j/c9SuC7Vefu96IWFBTLFPl6Bs2A2RSUw9kiaAv0QI+fnjYSzSO+qhJpv
         H+uAUR8qUuatEFL2wsijc/je+aWb5cy/HOsvRh8F3FvCqn7+uhzh1CBVWkwn9TkGjLyf
         Qq50PaHaKHVpMuGPnfZM3nIARt6iNTttzDMwLDhXPLau+SeCEpzfI4VHc3t6dYEfbm2b
         ALQw==
X-Gm-Message-State: AOAM533GsFejUt/m1+dfKPBxE2rmBNlXRxGLjWC1QEMyEHoe2+wnzepM
        Pj9ca9Jv05Jcq2hWv8RBckU=
X-Google-Smtp-Source: ABdhPJzg8YrxChm7P5C+GQi437HbMGjjrh9vvO02i/DAnGBWN1G1Gg4TWmzu8sc5OpaUx3s7+26M3A==
X-Received: by 2002:a9d:1791:: with SMTP id j17mr11771otj.366.1623252783284;
        Wed, 09 Jun 2021 08:33:03 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id t18sm52790otl.80.2021.06.09.08.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 08:33:02 -0700 (PDT)
Date:   Wed, 09 Jun 2021 10:33:01 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, stolee@gmail.com,
        jrnieder@gmail.com, emilyshaffer@google.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Message-ID: <60c0df2d91d27_efb208f5@natae.notmuch>
In-Reply-To: <fb7a7573782ae8ba3bc5341d6aaee704af88fdcf.1623246878.git.gitgitgadget@gmail.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
 <fb7a7573782ae8ba3bc5341d6aaee704af88fdcf.1623246878.git.gitgitgadget@gmail.com>
Subject: RE: [PATCH v2 1/4] Documentation: use singular they when appropriate
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> Replace these uses with "they/them" to ensure that these documentation
> examples apply to all potential users without exception.

This is not the main purpose of documentation.

The main purpose is to convey useful information as accurately and
readably as possible.

> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -372,10 +372,10 @@ If you like, you can put extra tags at the end:
>    the patch attempts to fix.
>  . `Acked-by:` says that the person who is more familiar with the area
>    the patch attempts to modify liked the patch.
> -. `Reviewed-by:`, unlike the other tags, can only be offered by the
> -  reviewer and means that she is completely satisfied that the patch
> -  is ready for application.  It is usually offered only after a
> -  detailed review.
> +. `Reviewed-by:`, unlike the other tags, can only be offered by a
> +  reviewer when they are completely satisfied with the patch.  It is
> +  offered only after reviews by reviewers who are known to be experts
> +  in the affected area by the community members.

This is convoluted, but at least doesn't sound wrong.

> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -2792,7 +2792,7 @@ A fast-forward looks something like this:
>  
>  In some cases it is possible that the new head will *not* actually be
>  a descendant of the old head.  For example, the developer may have
> -realized she made a serious mistake, and decided to backtrack,
> +realized they made a serious mistake, and decided to backtrack,

This suffers from the same problem "the reviewer" above did: it's
semantically singular. It doesn't sound grammatically right to many.

Another solution is to use an indefinite or generic noun: "they" -> "a".

  the developer may have realized a serious mistake was made

Of course it isn't a good style to use the passive voice, and we will be
counting on the reader assuming who made mistake. But at least it's
more grammatically correct than your version.

So far a step in the wrong direction.

-- 
Felipe Contreras
