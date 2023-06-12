Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1AEC7EE2F
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 17:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjFLRKP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 13:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjFLRJn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 13:09:43 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD27113
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 10:09:42 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b3c4c1fbd7so9650625ad.2
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 10:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686589781; x=1689181781;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQzaJ/WrNxdxEY7mXFTLrw6z0rBA/ChW0TSeY0Fd6tk=;
        b=c+Tbi1xdeA6LnYfgFk3kO6aYQa/3dTajlOwPlWChbXCkUUrJ/wyBNuze3dDq7B3ZTf
         DsCjWltSLswjrXcdISKt8MHV9vu1EiIuTWf6mmQ7L0jtM+RC8m8WzQAUZb5TSMB5JkPF
         K8mJ53MW/B9j4GOztM/OcRHrgLDVedFGVTY25VRezPpdruHC58G3z4Dk9eHw4BPm0HQD
         UxyHap08NRilCWg/GAbO8wa9Fs0PzPkQEOmM0Q3+ZRN8V5LePaSaE+9lnChDn0oVCz6j
         ZxQqLs0U4SSW5vbwWGOQqvbdtbziljw1CwK0C2eHWZEy2aZsdlwjdqdw81vT/hX9nsnu
         OMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686589781; x=1689181781;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sQzaJ/WrNxdxEY7mXFTLrw6z0rBA/ChW0TSeY0Fd6tk=;
        b=echrciO28QdYSjRCSuGJnLZS3vucnCjhj+nOubINA+UHHT/k0bkdoX/4wg1MT6Zlil
         HYNz9wTWngkN20VZV6SYpvGtM2lfKkTk3BFD/Fd4809t5WeaOMpz0VGER3PRMEA4MiQe
         efQoF0FGHbOwT0DLP/cLvVSbku2FKXFSBt+tbKlgUkrm8CLR7X+FZv1PHgb5gmJQQPKK
         WWetaexqCyMQs8y2dwM3d5hUcTWrZ+nfm+H8Zl10TfKEpycUFP4O7saJsu/llCcClLJ5
         t58Z54q28DdDRY2yc5Z/ds2YIEKvAl1U4NcB+geTgmg/gmRe1UcIOPpCiaT6PmfWINz1
         DDtA==
X-Gm-Message-State: AC+VfDx0NjwkwEtGF2XPCeo+oQTsYl0okcYAkWDRS2f8gVaK0a+l9TnH
        WByql7T4TK+BGaZqTcT7LGw6fqZdErI=
X-Google-Smtp-Source: ACHHUZ7NynZWSjxlgvvd+4bXC0ncBWjFzhGUP9o2MN0CxZsvK5rzWp/GHIuNSYKAaVNvjbzXFXKK6Q==
X-Received: by 2002:a17:903:41cd:b0:1b3:d5ec:673a with SMTP id u13-20020a17090341cd00b001b3d5ec673amr2031449ple.33.1686589781380;
        Mon, 12 Jun 2023 10:09:41 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id o15-20020a170902d4cf00b001b211283294sm8495360plg.163.2023.06.12.10.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 10:09:40 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2] add: check color.ui for interactive add
References: <pull.1541.git.1685994164018.gitgitgadget@gmail.com>
        <pull.1541.v2.git.1686061219078.gitgitgadget@gmail.com>
        <a76a91a0-cefe-807f-f1f6-4a277d724630@gmail.com>
Date:   Mon, 12 Jun 2023 10:09:40 -0700
In-Reply-To: <a76a91a0-cefe-807f-f1f6-4a277d724630@gmail.com> (Phillip Wood's
        message of "Wed, 7 Jun 2023 12:09:45 +0100")
Message-ID: <xmqqlegoboa3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>>       -+	*** Commands ***
>>       -+	  1: [s]tatus	  2: [u]pdate	  3: [r]evert	  4: [a]dd untracked
>>       -+	  5: [p]atch	  6: [d]iff	  7: [q]uit	  8: [h]elp
>>...
> ... The reason is that we're no-longer testing that we
> add "[]" around the text that would have been highlighted if color was
> enabled. That is with --color we print "1: status" with the "s"
> highlighted rather than "1: [s]tatus". So while the revised patch
> tests there is no color in the output, it does not test that we print
> the output correctly in that case.

Interesting.

My understanding was that the new test is about when coloring gets
triggered (namely, does the configuration variable set to false
disable the coloring?), and we had test coverage about how coloring
affects the output elsewhere (hence this one does not have to test
the same thing).


