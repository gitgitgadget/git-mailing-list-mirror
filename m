Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C497C63697
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 19:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E434920721
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 19:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q+vGa+3f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbgKWTkz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 14:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbgKWTky (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 14:40:54 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A1BC0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 11:40:54 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id t3so1368532pgi.11
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 11:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=phqemiZGWBZ4ZCIpAzEPRr14LQc2W0AmFzLZbkq+moo=;
        b=q+vGa+3fkvfSrMRd14x7WCrbPonHCnM6XW4leyJly6jC2qt1GWC/fFFrsBORPmIqmY
         NyPLOr7B8rXslD9iQy4q/pZpELlTUSbwKLjWF4/XJD3PU0v5lX9S6sLmAPam8vn1r8Hu
         8ZLZ1lplE3/tgAlSamGzyPBqgJFYOcpF4DNyX3TY2q63ZMfyc6z+DcxSUItpCDn3I7uR
         NcRKncIomDA3a8jXyMcrOrt42T4ktp/KtHK9GWTzYYHuT3IbeCkNmpz5WRl/ectAqrNP
         AAlEZaFLzcR1Qy/GzCEh4UYSW7C4Kk+t6pvpsylSv9HWWbPqfFwGJm5EeXK11ShzWuYt
         EuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=phqemiZGWBZ4ZCIpAzEPRr14LQc2W0AmFzLZbkq+moo=;
        b=dtRjDyEk/IhEwiKTb8nhsifQqtgJJ9qo0B+wjqWOS2AYPeXUMx4q9ueXpj+zAXukna
         xBM/BkOcs1PcA2kILD9rgjujFcQezfWpSwQOssgKZVRtHEWjZm3mHLr1fv/c8KKmBLiQ
         9Zx51m817uggHaY5Ku0x56+YGzf0MaOMLXoKX6dnC2MMoakeJowyszzDuBaYOWqKqrGi
         mm2DblK38yxCt3VcA9G0VJtbDfCoCr7gRa0DA5WCuvKs2HQSwHToRS0NJCsJBavPiwFQ
         EtRnFiLJ5qPt34BDCrwGV7VTDZ6nV6EnC1EqKTamlxQGg6uI6MEOeUk1J0s5lqlOhjWc
         U0mg==
X-Gm-Message-State: AOAM531qswVrKa6rxcuG+uQM6TBii22VL6sfvervhkC9Q6PWG/Fso40i
        ZmkMJQZdNQOa/zf2r9GSralbyLzAdZ6SzA==
X-Google-Smtp-Source: ABdhPJzswlGsPD/EHZYmQJFwQQPyMiJE5KhL6yJAocipSeG2sv/GzeJVAzJLBfaEY74VnqpL1lVdXQ==
X-Received: by 2002:aa7:9198:0:b029:18b:3835:3796 with SMTP id x24-20020aa791980000b029018b38353796mr871184pfa.9.1606160454029;
        Mon, 23 Nov 2020 11:40:54 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id s30sm11105349pgl.39.2020.11.23.11.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 11:40:53 -0800 (PST)
Date:   Mon, 23 Nov 2020 11:40:48 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 2/7] t1300: add test for --replace-all with value_regex
Message-ID: <20201123194048.GB499823@google.com>
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
 <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
 <829d0ccd8c6ae52e78eda52b15283867a0be673e.1606147507.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <829d0ccd8c6ae52e78eda52b15283867a0be673e.1606147507.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 04:05:02PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
> 
> The --replace-all option was added in 4ddba79d (git-config-set: add more
> options) but was not tested along with the 'value_regex' parameter.
> Since we will be updating this option to optionally treat 'value_regex'
> as a fixed string, let's add a test here that documents the current
> behavior.

I like the commit message and the diff a lot. Concise and complete,
explains when the problem came from. I don't think it even needs the
rationale about adding more options later - there's missing test
coverage and you're adding it. But it's useful to reviewers and a handy
step on the journey of this topic.

> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
