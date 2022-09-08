Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7FBC54EE9
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 17:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiIHR7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 13:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiIHR7e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 13:59:34 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA5795A9
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 10:59:30 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id b23so2139268pfp.9
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 10:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=5uDBiFf1cNekBwL9K2692Jq8LLl+gXOHcTG7a4b7IC8=;
        b=C9xWrZgdIBCBDN1K//rhXsDCofrs6o5GDsAuy0R9EoiRCK/GOfWFCjNwphyrSWk9sv
         zR+0wBeyYry1SGKo3ZnJW319i7eeZM+vv39FYgmVp6sP13YD7WZSTTfkIvGiQaLbSVYP
         ACv3HjztJrtyJ2bDhtflPvN6AmxHZOfHZwZph447kPvJf+tchprm4gGyPsTqzcSW0FCe
         YUEo8MDzciP6+d/jIhwxUOa3LGVidKEw9Ph4ywyG9TEr2Qed5ei6MfC0EO523p2aw0DD
         0VL0f6/dbmQTWJC/UENmM/+GTRo+pHdxe0qFPfd9CDTn1F2HHQrdUicH/O7PAFgLpRM8
         BMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=5uDBiFf1cNekBwL9K2692Jq8LLl+gXOHcTG7a4b7IC8=;
        b=Fx/sWjKra2IDyAaz0w9frY4xuxplNzmoU0shgwuf9GPjTZ3VAkyI/oqr/Nz5q4Tuw+
         bXG2EoNdkMIKcwS3JPoFx6yxgsNjrlRe6djqjgTPvmwoGy3jku84vNOdiZdZYE4Gjllo
         kT4G7Q4w/MNBFAZVGvSjdzH62LCsOa4qDfFKnvyPWmAd8s5BI+bFChl8Ljd4aH5M1Ytj
         x0Re9RI5wSXOS1u7IIwNC0TRtpE7lFjXvRXLwR7MFkfES3hUigj/t+GFqMu1TXTDjASF
         93ep6z9q3xKtmK68xsV7YfzL8Zr2ns9zSGAMMlAd7Wu5k0vm9bg6oSbQpbzE38DPXGBr
         YnOQ==
X-Gm-Message-State: ACgBeo2Nn3DS2PVdijs0LDYCNQL2rniboDItelCXv27pDH4uYRlhbB6q
        ezXnv15KjXCyr+JtfILVj9k=
X-Google-Smtp-Source: AA6agR7G3XTQqG4XNR4YzxzCta9e5vacH+LDBQ44ilzgZRV5Q+dUaYHLbLXqJa2hXimKlQyiDOpHmQ==
X-Received: by 2002:aa7:888d:0:b0:538:328b:2ffb with SMTP id z13-20020aa7888d000000b00538328b2ffbmr10109939pfe.82.1662659970142;
        Thu, 08 Sep 2022 10:59:30 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id o6-20020a170902d4c600b00177f25f8ab3sm520642plg.89.2022.09.08.10.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 10:59:29 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     derrickstolee@github.com, vdye@github.com, git@vger.kernel.org
Subject: Re: [PATCH v5 3/3] builtin/grep.c: walking tree instead of
 expanding index with --sparse
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
        <20220908001854.206789-1-shaoxuan.yuan02@gmail.com>
        <20220908001854.206789-4-shaoxuan.yuan02@gmail.com>
Date:   Thu, 08 Sep 2022 10:59:28 -0700
In-Reply-To: <20220908001854.206789-4-shaoxuan.yuan02@gmail.com> (Shaoxuan
        Yuan's message of "Wed, 7 Sep 2022 17:18:54 -0700")
Message-ID: <xmqqczc5rblr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> writes:

> +
> +	/*
> +	 * NEEDSWORK: when reading a submodule, the sparsity settings in the
> +	 * superproject are incorrectly forgotten or misused. For example:
> +	 *
> +	 * 1. "command_requires_full_index"
> +	 * 	When this setting is turned on for `grep`, only the superproject
> +	 *	knows it. All the submodules are read with their own configs
> +	 *	and get prepare_repo_settings()'d. Therefore, these submodules
> +	 *	"forget" the sparse-index feature switch. As a result, the index
> +	 *	of these submodules are expanded unexpectedly.

Is this fundamental, or is it just this version of the patch is
incomplete in that it still does not propagate the bit from
the_repository->settings to submodule's settings?  Should a change
to propagate the bit be included for this topic to be complete?

To put it another way, when grep with this version of the patch
recurses into a submodule, does it work correctly even without
flipping command_requires_full_index on in the "struct repository"
instance for the submodule?  If so, then the NEEDSWORK above may be
just performance issue.  If it behaves incorrectly, then it means
we cannot safely make "git grep" aware of sparse index yet.  It is
hard to tell which one you meant in the above.

I think the same question needs to be asked for other points
(omitted from quoting) in this list.

Thanks.
