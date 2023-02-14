Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CF0C61DA4
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 21:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjBNV7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 16:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBNV7M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 16:59:12 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E96583F2
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 13:59:12 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id b5so18429720plz.5
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 13:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m0hJSQwZOM3VaJswj/+1xq/DGP6iw0TlQadnO1MO91M=;
        b=fXMcrWhTZr4JX+vANLvPQfKEsPybpHAVDMWusf9VGMlzPU3pdFq1F4iYbCEbJ9J+qu
         Z70V8XVzNU90Hjy4knDEaErNkRxsOzugGZ3N2llt9TXbuYUZfhS9a7cjCDbY3WbbuUJI
         +DIvicIChHB5cpG+m/OLrWCXkoa3lJU0ApcHm9HkQ1ZDrz6WdZn3oB57o7C8o1vL8a3X
         hdcDuMEm239zzQfM71NgV0f4N17uYjCkQrfnBJt2TamY7FvP0irCyr9VKlJBznWMYwzp
         NfdXwiS8yVJS/iD6tTl/Nn49cgVu5PaBeEqlV8sdkiWbthND9rLoiR29jiNQbDN2IfA4
         jebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m0hJSQwZOM3VaJswj/+1xq/DGP6iw0TlQadnO1MO91M=;
        b=TDutinUxGWYze1b0PHtnr1LXZjIRTxK60VGecMt7N/lEeQNyGUo3gvaCKBxa1ackzG
         nYdaK57+Zobv65kj95Sg4iSE0rDOFHC4SyjDOxCmvWCCreVp/1rwl4rsGnVkv524PoIg
         GXhX4srZlr8kKeoqHg/tmlMIhof1P0ze4ZGdLVkd3zfEHANa+TbX7JsSlLvzTqVw2sbk
         YhdvghbycOUrSAHqsBe6mjucdvDoAHzO69kXTDxeMIpV3C58nqHxxAlm+aLTOT2MWZXy
         O5PVUUXM864tC4eHtlnrqn79v1KjbfPha8sJVnuoKAGxzLkRcVtpTYV/J6rNbvDe1PgH
         gf6A==
X-Gm-Message-State: AO0yUKWWbTxFaQ6hZfLSCw24X/qHBkluQ2pGURQqNxRabZLtCZPGwQp+
        rDXrJVFVTRqgSaWFb1l6wcM=
X-Google-Smtp-Source: AK7set+llMdWHXt4hToDUmvyaZ2853aba61WZ2uR7WCIyEHcbMso1gmiL+ODnzZTyxDg6UdW+akEJw==
X-Received: by 2002:a05:6a20:7fa8:b0:bc:35cc:34b7 with SMTP id d40-20020a056a207fa800b000bc35cc34b7mr4748728pzj.36.1676411951604;
        Tue, 14 Feb 2023 13:59:11 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id v25-20020a62a519000000b005809d382016sm10198284pfm.74.2023.02.14.13.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 13:59:11 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] leak fix: cache_put_path
References: <20230213182134.2173280-1-calvinwan@google.com>
        <20230213182134.2173280-2-calvinwan@google.com>
        <xmqqk00lbc8k.fsf@gitster.g>
        <CAFySSZBAXCGTEhTK+rpLaZz4_RhdEDV5e5QewUwN-LHgSOTe2g@mail.gmail.com>
        <xmqqa61g550j.fsf@gitster.g>
        <CAFySSZD9BZA9Qa5Z5KQymkowB9YtasUnNMehtA1feg43UsfwFw@mail.gmail.com>
Date:   Tue, 14 Feb 2023 13:59:11 -0800
In-Reply-To: <CAFySSZD9BZA9Qa5Z5KQymkowB9YtasUnNMehtA1feg43UsfwFw@mail.gmail.com>
        (Calvin Wan's message of "Tue, 14 Feb 2023 13:39:48 -0800")
Message-ID: <xmqqilg352og.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> If you look at t4027-diff-submodule.sh:git diff HEAD with dirty submodule
> (work tree, refs match) [.gitmodules], it's two different submodules
> pointing to the same path (or more precisely a second submodule is
> manually added to .gitmodules with a path to the first submodule). This
> is a setup that is not expected to happen commonly in real life so
> updating this test makes sense to me.

Thanks for double checking.  If it is a configuration that is an
error, then we would want to notice it eventually (probably outside
the scope of this series), and before that happens, I agree that
modifying the test to avoid such an errnoneous scenario would be a
very good idea---otherwise we'd be pretending that such a scenario
is a supported configuration somehow and misleading developers and
users.

Thanks.

