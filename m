Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505CBC77B75
	for <git@archiver.kernel.org>; Wed,  3 May 2023 19:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjECTYj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 15:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjECTYi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 15:24:38 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3515659F1
        for <git@vger.kernel.org>; Wed,  3 May 2023 12:24:34 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ab1b79d3a7so9490705ad.3
        for <git@vger.kernel.org>; Wed, 03 May 2023 12:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683141873; x=1685733873;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ay/Tw4LDIKVf+QzM8Efdj/+uCaoljV/RADX61ySS+I=;
        b=f35SivyiSy23g77HeibPvBL07EuYv2DwiFxpHfj4XjC6uAIh/270Umzu1BozhcQ6zo
         j3ywfHngLc4NrFbTRti0p63X1LFFLUB0hKkbqCuiWiGdpJ8KH2jgCTzKrphB54Sm3zwr
         tg2ymjvZtRISQyy9zZWY1gaWAzPABhN6FVTuEJ8B6kjbeYf0V+BLVZEp+PZDIk/WHrMb
         BOlP6+TQYOLHaFKkzUnqsoY807YHHPxc9iME86ftbQPb5f1wZppnLoDG3Jnx/fmt80Ma
         MQ9m4YvakAhaB/n5VYCouaOeRW/r7SbcZFEJ3gwXdjKbJuI/zBvk+95dytQZtosM4bCE
         SwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683141873; x=1685733873;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/ay/Tw4LDIKVf+QzM8Efdj/+uCaoljV/RADX61ySS+I=;
        b=d8wxx97kAO1CWk8+iZ11W6ZSQHGSLTZYGeRgXXI+GeUVv5mreIjhAg6oN+3VYVQAqf
         f59hOfFWJNg4scRoSExo+ormlsA//5DxLqo05ea2U5coIIjxYC8PC5leTNEAHBEdGUwa
         xzymYIXcMzUYVHz11qW6ShgBha/o14BrKYCnvsT3hU7HYNkP7I3Vj36dp8i1W6TGRiCF
         yQQwpJHN1GLLwH9fKrMyP8Ah0YIITbgwUURAaI3v4FZ/b0FlYG9ZeRlDeZjtKkpFvHgc
         MkbZ65wYlFRq17cp2WxYwlItPTHXot7UnyQx34vo+bFlFaDlg4PvWTjedBzPmkAJ5IrU
         qFDw==
X-Gm-Message-State: AC+VfDxz/wZIJlZZa/dUvHpJdK62ikIM95b2Kl9XOkS2V8gRU8emm8rg
        AXZU7/T9qxtsyr3CaE82/fU=
X-Google-Smtp-Source: ACHHUZ6ASHYQzTZ4pZhVqrVfrFyDDtmxlNElnsITokkUpZXUf0o9AVZ3lXCbNM1lHbhh6VlOffG/0w==
X-Received: by 2002:a17:902:f551:b0:1ab:bfb:4b6e with SMTP id h17-20020a170902f55100b001ab0bfb4b6emr1268534plf.31.1683141873478;
        Wed, 03 May 2023 12:24:33 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903245000b001ab1cdb41d6sm1783590pls.235.2023.05.03.12.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 12:24:33 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com, peff@peff.net
Subject: Re: [PATCH v2 7/7] strbuf: remove environment variables
References: <20230503184849.1809304-1-calvinwan@google.com>
        <20230503185031.1810078-7-calvinwan@google.com>
Date:   Wed, 03 May 2023 12:24:32 -0700
In-Reply-To: <20230503185031.1810078-7-calvinwan@google.com> (Calvin Wan's
        message of "Wed, 3 May 2023 18:50:31 +0000")
Message-ID: <xmqqednxqkun.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> As a library that only interacts with other primitives, strbuf should
> not directly access environment variables within its

"environment variables" is a misnomer, as there is no getenv()
removed by this patch.

    strbuf: stop depending on global 'comment_line_char'

or something is what you meant, I think.  This patch is about only
one single variable, not about many environment variables, right?

> functions. Therefore, add an additional variable to function signatures

These things that are enclosed in a pair of () after the function
definition are usually called parameters.

> for functions that use an environment variable and refactor callers to
> pass in the environment variable.

Likewise.

> -				strbuf_commented_addf(&buf, _(tag_template), tag, comment_line_char);
> +				strbuf_commented_addf(&buf, comment_line_char,
> +				      _(tag_template), tag,comment_line_char);

Style?
