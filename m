Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60EDC77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 19:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237983AbjELTbz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 15:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjELTby (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 15:31:54 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148B27DA2
        for <git@vger.kernel.org>; Fri, 12 May 2023 12:31:54 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6436e075166so7817106b3a.0
        for <git@vger.kernel.org>; Fri, 12 May 2023 12:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683919913; x=1686511913;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CYTyQa+xKO+OmWdGMfmwyDgWL1mpkqGj2DlfmcoGy7g=;
        b=RpDSY8jxgKXib3N2xTE8RtULB+XZmOC3P91XH3yQ2Rf3I7KlqX+RrOwGZjHq+ZJ20j
         3V7K3xQzo/Cy+jPWhLKPRN5Z2245cnSLX9Z5wzJgyh+HghCqNtbAXInYaC0pEz6hQRR0
         m1jA+uXWo3l/wnSKVFWQ3aPxfpF01vEYYD8imlKJclSznb7co9z6QDyY0YnxmH+vOedh
         ihcy4FEt5kwn2ghGX0H/eD69anJwECBlt3vLdeJQRScEGlrA7yQGRLmRRLK7syGswaTX
         UNuk23o92OizjSEJqaWvtoWRA8JXniyuTZmjMdnflNMdX+SjgQA1IY13Kax85p0VX+tx
         CnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683919913; x=1686511913;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CYTyQa+xKO+OmWdGMfmwyDgWL1mpkqGj2DlfmcoGy7g=;
        b=GOK40tYmN79K2xgJmb7vd/F+YAGR9zTBzxynTJiEdP5TYYvoCX1EyrewPTBDmKNQlS
         8AoRGQ0/6jtmmk0WvI5u+3yuzfPE1eJSdtZvriZWgs1E/wJq0S+uD2dejGR+rlrukZe3
         +tnFvXJfe4Bu1DTz6u9P5rjxTrlDf0hc3L+YGAcHEKyteZ3tFtiS+psCHNoqBTgoYrze
         b6a6B1hXP1rgcE4csXe4emCVW/eTHeu1U8TRUATIA6vbANO4K4tx/0ZVS5CAkmU1LDsD
         I6rjbtzVdcDZFSYjeaiKi4ErY+jPdAlsgdayQTnfDo5rjiLfR7+g6rcos6ZOQpSKX6UZ
         QezQ==
X-Gm-Message-State: AC+VfDwffylxzxFgFjOX7so1h9Dh0N7yfkkfEfLoIO17EOfQxyKGK+Sb
        nzO7d7izzxZmrS1OyFxDTGGBY+1KHLU=
X-Google-Smtp-Source: ACHHUZ6hb69ANZECppuboBwBGDTvsSU9UZ5jHib3Y3NkD8aMx+I8nN3nINT7hVnijaxKyMS48VYO6A==
X-Received: by 2002:a17:902:fa0f:b0:1a9:8ff5:af43 with SMTP id la15-20020a170902fa0f00b001a98ff5af43mr23725042plb.18.1683919913501;
        Fri, 12 May 2023 12:31:53 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902b78500b001a6c58e95d7sm8292135pls.269.2023.05.12.12.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 12:31:52 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        newren@gmail.com, peff@peff.net, sunshine@sunshineco.com
Subject: Re: [PATCH v5 7/7] strbuf: remove global variable
References: <20230511194446.1492907-1-calvinwan@google.com>
        <20230511194822.1493798-7-calvinwan@google.com>
        <c9e22e51-4e4a-b692-edfd-1f3bc7ee7da9@gmail.com>
Date:   Fri, 12 May 2023 12:31:52 -0700
In-Reply-To: <c9e22e51-4e4a-b692-edfd-1f3bc7ee7da9@gmail.com> (Phillip Wood's
        message of "Fri, 12 May 2023 15:53:03 +0100")
Message-ID: <xmqqr0rlpcrb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Calvin
>
> On 11/05/2023 20:48, Calvin Wan wrote:
>> As a library that only interacts with other primitives, strbuf should
>> not utilize the comment_line_char global variable within its
>> functions. Therefore, add an additional parameter for functions that use
>> comment_line_char and refactor callers to pass it in instead.
>> strbuf_stripspace() removes the skip_comments boolean and checks if
>> comment_line_char is a non-NULL character to determine whether to skip
>> comments or not.
>
> Thanks for re-rolling, I agree with Eric's comments but would be happy
> if this was merged as-is.

Thanks for reviewing.
