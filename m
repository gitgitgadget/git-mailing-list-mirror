Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BB9C1F6A9
	for <e@80x24.org>; Fri,  4 Jan 2019 18:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfADSi5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 13:38:57 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40416 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfADSi5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 13:38:57 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so37407121wrt.7
        for <git@vger.kernel.org>; Fri, 04 Jan 2019 10:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=8Tzl1sPY1atO9BsPlqX36H/XiMfbLt/A3xn/LEOqHkM=;
        b=PNO6FKDr+eErhsgv3c/Ieo243uqMKffyKgkWKU3jSLzV/LTk7A5htVEXEwEa7t/Y6E
         /h+rAu9jtqlLfqXVQ0xsEEPT8iDcoiPTyWumgBUKlRUU32BatzjBu5skud6M531CrxxZ
         Jnh7g7B4r0ZaqTR7863vbXiPU/CWuHMNxsmOyZSGj9A5U719+T3XDK2t7j5eha5n0EVM
         RIFhuJaGy+tm20NqFoEucRdaaG863zGO45KxvsH6XkPNf96syUiKE1FMwB+u3+j+T8El
         RVB8AG0SIE6P1S8KR2FeCu+Srsi1XYTHosj3E2P5Am6lbCcdb5P9zyDaEC/6lInSvo/V
         airg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=8Tzl1sPY1atO9BsPlqX36H/XiMfbLt/A3xn/LEOqHkM=;
        b=Rd3VBEyHBY3lZox1M2uZUEyf7BgJgBXpowsE2V8i+cRwXrDmkKydGpDmnixXMcx/6l
         XNrt5T7sR6+A+98mjHCzGrpwbE6BYp4CHYLLgv3Jr3+Acxfq7ntpdAVmATYM1MzZqDo9
         a14Km2GtU4UhqcmbJPfEHi0o/h5Dz4W30i5tfL+NFfN+Bx17pGyyXj9gEU88OPEH4CqN
         Q0EGysgig2Ekh3tmK+QXsLsY/rzmGLKl8VRtm2/QNh/9lsfHWQyalrgXqKgmH8aE+xSl
         WBFgNMyHjn2cR23dXK/WqlYLs3Lmk59xmUKhsUIecrl3RjzJKDqrZKchhpBHxd6kd9X6
         rcdA==
X-Gm-Message-State: AJcUukft71DTJnmoCnJhlUNgP4JJWfGv/GdEySHgIFJXIqezxa1F9TNm
        Id0D/g42ZosJCnQ3nKrCphU=
X-Google-Smtp-Source: ALg8bN4/v2KbEnrI9l7PjY/mVVNNbF1e3xahU1OHKNEX7U0hU8o46ZrKE+aFlfbwPisbj30OHSVwRg==
X-Received: by 2002:adf:f703:: with SMTP id r3mr44731890wrp.93.1546627134928;
        Fri, 04 Jan 2019 10:38:54 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m4sm1475712wmc.3.2019.01.04.10.38.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 10:38:54 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/4] rebase: avoid double reflog entry when switching branches
References: <pull.24.git.gitgitgadget@gmail.com>
        <4c5f87b9dc245bf27785aa5559d4b35d87c4bcbf.1545398254.git.gitgitgadget@gmail.com>
Date:   Fri, 04 Jan 2019 10:38:54 -0800
Message-ID: <xmqqimz4cloh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When switching a branch *and* updating said branch to a different
> revision, let's avoid a double entry by first updating the branch and
> then adjusting the symbolic ref HEAD.

Ah, in the original sequence, HEAD is updated twice, leaving two
reflog entries for HEAD (and one for the underlying "switch_to"
branch by virtue of REF_UPDATE_VIA_HEAD).  In the new sequence,
update_ref() updates the underlying "switch_to" and then HEAD, so
we'd get one reflog entry for each of them.

Makes sense.  s/let's avoid a double entry/& in HEAD's reflog/ would
have avoided wasting reader's time who needlessly wondered where
that redundancy came from, though.

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/rebase.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index e1dfa74ca8..768bea0da8 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -438,10 +438,11 @@ static int reset_head(struct object_id *oid, const char *action,
>  				 detach_head ? REF_NO_DEREF : 0,
>  				 UPDATE_REFS_MSG_ON_ERR);
>  	else {
> -		ret = create_symref("HEAD", switch_to_branch, msg.buf);
> +		ret = update_ref(reflog_orig_head, switch_to_branch, oid,
> +				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
>  		if (!ret)
> -			ret = update_ref(reflog_head, "HEAD", oid, NULL, 0,
> -					 UPDATE_REFS_MSG_ON_ERR);
> +			ret = create_symref("HEAD", switch_to_branch,
> +					    reflog_head);
>  	}
>  
>  leave_reset_head:
