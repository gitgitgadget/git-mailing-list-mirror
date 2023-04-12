Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B8DC77B6E
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 19:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjDLT0g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 15:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjDLT0e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 15:26:34 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD80A6185
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 12:26:33 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id h24-20020a17090a9c1800b002404be7920aso12686084pjp.5
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 12:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681327593; x=1683919593;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GkC5g3Udc9KlfJQ6Ed3HUFQnnaueiwWYQ/7oYgr6NIc=;
        b=bRelGRpmiyvt5BbSCbqAwiXyk+iP4qWaZHii1/wLXrUi5mhub2n9Yci3rvCrKlEXhR
         X2xq8fZxheLl8Hn5bwaUZmmQ9GdImI/RQFrKem9u6YD/im09eKKPM2tIELPfN+7b26BW
         uovbVT8OU4O/rp+mB4i3GWtSs4WwQZXJ5LA0avohjuS9ME60bLVpY2qJmpKJ4lp5vQi2
         jJcv2WHBqtlQ+ObGY6LNQb/L7Dd5jJq2sAOQkHkjom1IvJiMBb5BtbVXclT7fRsO9ko0
         1Zsxd2sFvRQNr0tgTmbidpWC3zmAbIWTdBeG3nIjWvpQCQp4J70Fmp7Ygb5SomxZ3mQx
         RXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681327593; x=1683919593;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GkC5g3Udc9KlfJQ6Ed3HUFQnnaueiwWYQ/7oYgr6NIc=;
        b=Iv24xqQBO1Suk1/e3Ss1ViSOqFQgn1F38l1CTO8LgJAMvwej0fFWCl0uHcdDfBJjr8
         3Grm0DxClotx6JKmcRNj8UOjH40sAmg+GaMBTU6grCwmD/haIDCKzLwnb9xSWQtPQRRB
         BBbLlZbvowVryA4/NCR06FVoP2sOht/EcQ/HFnxfjfd1rVfpbxC/BAqlw/LBqzRlnaxP
         H3ygvzw9Un0OEWiyNERDJFIhojFJY+PGQRecDP12tNIc0ceji6CVaWoifACe/bVy7pzB
         RK3pKZyZ1GAFEc8at8jxTMwvn3qACAt44BHJfh3X8sTnaGn98XAUoByJxMBAU294l2Is
         6AXA==
X-Gm-Message-State: AAQBX9cqqfVXrvlr65xMJYyVIr0nmO+c9Cq5jwoUHOu/zrrIBTX8Rcej
        w7KyJWGPXb+ix8J202MrviM=
X-Google-Smtp-Source: AKy350aCOeDOGBmi3hIynIHLFSBnzvj/8ZJ5wMcpHjgQW1okV5kqGde44Fs/yF3yihXdc39WEDqnSg==
X-Received: by 2002:a05:6a20:bf28:b0:eb:f7d2:565 with SMTP id gc40-20020a056a20bf2800b000ebf7d20565mr1540729pzb.29.1681327593088;
        Wed, 12 Apr 2023 12:26:33 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id n21-20020aa78a55000000b00638f5b2d34fsm5705086pfa.32.2023.04.12.12.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 12:26:32 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Markus Heidelberg <markus.heidelberg@web.de>, git@vger.kernel.org
Subject: Re: [filter-repo PATCH] convert-svnexternals: fix parsing of
 wrongly transformed SVN revisions
References: <20230412134119.28257-1-markus.heidelberg@web.de>
        <CABPp-BH1172tfZn5i0PvNm6Fw5OObKEKCqT1gjTr+hux86TexQ@mail.gmail.com>
Date:   Wed, 12 Apr 2023 12:26:32 -0700
In-Reply-To: <CABPp-BH1172tfZn5i0PvNm6Fw5OObKEKCqT1gjTr+hux86TexQ@mail.gmail.com>
        (Elijah Newren's message of "Wed, 12 Apr 2023 08:45:04 -0700")
Message-ID: <xmqqbkjs9a1j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Thanks for sending this in!  Applied.

It may work around the issue, but sounds like it is SubGit that
needs fixing, at least seeing the problem description from the
sideline.
