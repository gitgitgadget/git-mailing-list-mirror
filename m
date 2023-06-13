Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B47CEB64D7
	for <git@archiver.kernel.org>; Tue, 13 Jun 2023 23:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241232AbjFMXpP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 19:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241824AbjFMXo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 19:44:57 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAF0268F
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 16:43:12 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b3a82c8887so33076095ad.2
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 16:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686699726; x=1689291726;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YVq2DkToaGZEWOi+LPk0WKhRzaeIF5tx3B4+wdYuh2Q=;
        b=O8tk1Q2XXp5FqHbzcJs5FzaPm0+pLjSpapMfW7bKhkyquTWyVsSuM31ugsJVsPf1Aj
         5ZPI+M6oywTdmW6mpgETXmA/uaLSFGcK1khNVk179jVbhNnjR6Z6IboUqhswfORJ3fWq
         QeoOLixiI5KCUZ7wdlVwFVQIdZkAvlCXWG7wCqMOoOB+YOaT/8MUyu3DAHySchn4DEmS
         V8bB7664b7AAFwbEstyM6/gYtQMFcqTjjk7WpDg9gk0sKSXtktFCqkSQ8v34ZbsLvxU9
         HR17lZd+lnzARoUeMZYVyHRyOGhC4rE00/Yumvlp9k8mGkibPDd/o1iTYDGQ5tFv4Pu6
         hfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686699726; x=1689291726;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YVq2DkToaGZEWOi+LPk0WKhRzaeIF5tx3B4+wdYuh2Q=;
        b=J2eppdabvGLOLIEuRQP7/e4+ygx143FKVUrkjL1J0t4GoCjs3G576ZCrSPCHoQNH95
         qQBwO4rXnr+SK9FWmjygsMz7alxK5IiehilImoTX/ZSEG5/5Oesc5/VE7RIWIIeewTmb
         SfVK2134z33CxiTjj1RckYiTPKd/bnKRkFLO/a+vYW9k36SCPA2Ua4gxBSBoJoV9Cfl9
         jXXOMumOGlJsPF3qIlEw9E+zTRqYVloaKAYXRrB4VE1oPMgucPTBwkaE+6/oxUjJOOxu
         YVg12JfsO1EprJqCN7ELHPr8+1H651H6JRDGRHaZUCmdghYemEMSDc54Lg9Fs7SG/gnw
         Y1/w==
X-Gm-Message-State: AC+VfDwpTHD9uKj/37ZuShc7tlou67mw/8ploc1goHBXQViNXRPVnJZW
        bXCHHVdcJfzK0Pq2IeXSH6Rd7pibmes=
X-Google-Smtp-Source: ACHHUZ4ihZE3C08nT/ekctG+OP/cwkTIOT8LSoLfyslnlWAffoS1+oT8c63zcA5UlpNtzy79uoDVFw==
X-Received: by 2002:a17:902:e84a:b0:1ae:6a3:d058 with SMTP id t10-20020a170902e84a00b001ae06a3d058mr12550652plg.36.1686699726493;
        Tue, 13 Jun 2023 16:42:06 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id i4-20020a170902c94400b001b0457705e8sm10809389pla.140.2023.06.13.16.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 16:42:06 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 07/16] refs: plumb `exclude_patterns` argument
 throughout
References: <cover.1683581621.git.me@ttaylorr.com>
        <cover.1686134440.git.me@ttaylorr.com>
        <c4fe9a1893c15c5aae4d3f305b248d0c3ac55222.1686134440.git.me@ttaylorr.com>
Date:   Tue, 13 Jun 2023 16:42:05 -0700
In-Reply-To: <c4fe9a1893c15c5aae4d3f305b248d0c3ac55222.1686134440.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 7 Jun 2023 06:41:23 -0400")
Message-ID: <xmqqsfav2alu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> diff --git a/ls-refs.c b/ls-refs.c
> index f385938b64..6f490b2d9c 100644
> --- a/ls-refs.c
> +++ b/ls-refs.c
> @@ -193,7 +193,7 @@ int ls_refs(struct repository *r, struct packet_reader *request)
>  		strvec_push(&data.prefixes, "");
>  	refs_for_each_fullref_in_prefixes(get_main_ref_store(r),
>  					  get_git_namespace(), data.prefixes.v,
> -					  send_ref, &data);
> +					  NULL, send_ref, &data);

OK.

> diff --git a/ref-filter.c b/ref-filter.c
> index d44418efb7..717c3c4bcf 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2209,12 +2209,13 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
>  
>  	if (!filter->name_patterns[0]) {
>  		/* no patterns; we have to look at everything */
> -		return for_each_fullref_in("", cb, cb_data);
> +		return refs_for_each_fullref_in(get_main_ref_store(the_repository),
> +						 "", NULL, cb, cb_data);
>  	}

Is this merely "while at it", or was there a reason why refs_*
variant must be used here?  It is curious that we do not teach the
exclude_patterns to some functions like for_each_fullref_in() while
adding exclude_patterns to others, making the API surface uneven.

