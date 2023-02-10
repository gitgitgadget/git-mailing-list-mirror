Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAAEC64EC7
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 22:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBJW43 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 17:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBJW42 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 17:56:28 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA27426586
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 14:56:27 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id z1so8142365plg.6
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 14:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+705lqn8JG6cpg3OZgz8IPNzi5HylsMoaynpTyB+go=;
        b=aewRC09qITVhSzjTRj9xJo90mqbUAXR+FmtkSI6bfQKuVlDCW0x3sBhXnjKvnfZyzx
         64IZeBsFDbZTODLlfbv/x+pVlC8YbrgMPxxOL+5JweRzR6jeAstDoQWBnadiWWP90WgR
         VKqgMJcu7uP9Zo6AKiwRGzf6xHUoRH3rGcomuaMWdWRaHVfWEsECadgithShmwHfIRy/
         +P+pJD/q31Ip4os//hrbZdCCWb6/PgrtQQGzvAIzriNy/6KS8L+tYn0R54SXOq0t1uK2
         PLmYcYtB44GM19Fxl4bGRz6WHxFDZHqGsgg8dGNQ+gL7rmrt8GpNZknu/mzpXdKiPm9B
         R2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j+705lqn8JG6cpg3OZgz8IPNzi5HylsMoaynpTyB+go=;
        b=diAymLoFtg66TDC3OK5/K+AVjy9XZNwHaFE/IHW8uCgMxEij30aIlkQeoO+xDQ3Tfq
         2YK32Rb1wzCL6U8vwzSALZpj+U5jkcndrlvnHGCJ0CqXWLJdfVRhbnlMxCTV25poUJaC
         SKYAbItavng3uKQ1VFuQlpR0YFwZrsyKwfsBwAjCkqfj6+EGRd6Gas1e8cbjdaxkadhw
         XOdqxkqQPDosIEIiJT8/fk6DSPiWlfmHMdQwsByfRrDewaThmZx0wNJ2jgvunIJBdtyp
         PTJzCvJN+LlQZTxqASUzkI+po+803vP10LCftLi5oAx1FPAn8KtEDmp896+8P2WwGlwP
         jxsg==
X-Gm-Message-State: AO0yUKVs3T/4UQ2++kaQ0H+DCnx/W4rYcmdNkxoqYYwxSgN6P4OVA7jd
        0B5sjLT68+tOoI3OTtuwU9AYRuBMaWI=
X-Google-Smtp-Source: AK7set8Hf7A6gwo26Ub33/Io9nP4AwmM3JtdF9s3Rn6c0iDPphoS2eNASTNGi+aJ0Dj+e3pBfp/e9Q==
X-Received: by 2002:a17:902:db0a:b0:199:15bb:8320 with SMTP id m10-20020a170902db0a00b0019915bb8320mr18143939plx.31.1676069787213;
        Fri, 10 Feb 2023 14:56:27 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709029b8e00b00198e6409d17sm3831350plp.116.2023.02.10.14.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 14:56:26 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [RFC] fetch: support hideRefs to speed up connectivity checks
References: <20230209122857.M669733@dcvr>
Date:   Fri, 10 Feb 2023 14:56:26 -0800
In-Reply-To: <20230209122857.M669733@dcvr> (Eric Wong's message of "Thu, 9 Feb
        2023 12:28:57 +0000")
Message-ID: <xmqq1qmxgmed.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Not sure if this is the right way to go about this...
> If it's close, maybe --exclude-hidden=fetch can be supported.

Yeah, why not.

I however notice error handling in the codepath that deals with
"--exclude-hidden" is  a bit sloppy.

refs.c::parse_hide_refs_config() is nice enough to diagnose a
malformed transfer.hiderefs configuration as an error by returning
-1, and revision.c::hide_refs_config() propagates such an error up,
but revision.c::exclude_hidden_refs() ignores the error from
git_config(), and revision.c::handle_revision_pseudo_opt() ignores
any error from exclude_hidden_refs() anyway.

We may want to tighten it a bit before (ab)using the option in more
contexts.

Thanks.
