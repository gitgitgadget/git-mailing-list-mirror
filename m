Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8691CC77B7A
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 07:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjFAHcK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 03:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjFAHcG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 03:32:06 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D181134
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 00:32:05 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-256931ec244so380183a91.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 00:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685604725; x=1688196725;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0eukgpNYeFPVTrkKj1IVB9GstKHh1YWH1o70t0a7C1Y=;
        b=DAtdDOYVjFDM1jJLIzr5F2A18AV8mn+oIlHWFje8K5Xo2ywagmdlyljYvCNpmv5wku
         Lu1AjnT4+JUBrLgOaJGng21kxN7wW1351VogVPpq0dmnCWNdSmV/Lu1jKHzG1tcmXjG8
         7LPcOgR/I1HA7ShOqS4rXC246lH1e0DDsxMBUsE5+SuK0nOpGzGCJeZ+Gcbx1/Sz9Ayw
         lynkWoyisxfO2BNH6oEHU9VwCmtNFlCVpzOzXGnhVvA4zZ4tYfUeWK8B90sGxKJWYgJH
         0LtjMylT7HgyLQC89UoCvp4YI7sbX5v02nxaQ3LoQO08pD/UUtkdR5Um/0tGqyfLVPcE
         pdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685604725; x=1688196725;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0eukgpNYeFPVTrkKj1IVB9GstKHh1YWH1o70t0a7C1Y=;
        b=WzJOMyL+uL4Hf8S0Tj/uzKqZv17apJ+CzKvYDYBrfvRfXnZDec0JFxeqNJz5BfDunn
         3BqbZctGgP9d2uetpXOsD5U/AeX8EzohPIvbvLPZRTEx5+P2LxSW0sMc9sSAIZUbzbP1
         9aUMsvcsXffyEqs9BEUK27zI6nvCIfP1VZTc0FqdSVz5jQ0CR4ObI08innyUHxTrCp+0
         DtPQjcFGClfrJzM/qvEfrOcAlpfwRLHAecXqRgjplZfY+wkihQjQRK9uLZVfGwOQwFPa
         UKASSJJ+UwQ1z72IDrGF4c9AVqd14tQhCNiF+hjgCviTAHBkH2f2hxwIzyzhfW7gYog+
         pJfA==
X-Gm-Message-State: AC+VfDzs6FNT0omt2d4jZMhcJ7tk6QeVR7dCLZPiovj8oWyiQzapxUAd
        leyPO7Nzyh4BnnvnO9mEHvA=
X-Google-Smtp-Source: ACHHUZ5x24ZdpdR25OWi9k3vW4kkc/2K08Uq3u5ScitWmTz/ogZS/coznfbNO9Nfz2mwYGriNMTgyQ==
X-Received: by 2002:a17:90b:398:b0:24d:ebfe:be93 with SMTP id ga24-20020a17090b039800b0024debfebe93mr8111306pjb.37.1685604724735;
        Thu, 01 Jun 2023 00:32:04 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id ft24-20020a17090b0f9800b0024e05b7ba8bsm745080pjb.25.2023.06.01.00.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 00:32:04 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>, Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/6] Document 'AUTO_MERGE' and more special refs
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
        <pull.1515.v2.git.1684783741.gitgitgadget@gmail.com>
        <CABPp-BH+vT_dEKUwn1M2D-FuCtF=hRM8OAFj9m1x6rkV97oEDA@mail.gmail.com>
Date:   Thu, 01 Jun 2023 16:32:04 +0900
In-Reply-To: <CABPp-BH+vT_dEKUwn1M2D-FuCtF=hRM8OAFj9m1x6rkV97oEDA@mail.gmail.com>
        (Elijah Newren's message of "Wed, 31 May 2023 23:18:22 -0700")
Message-ID: <xmqqwn0nab9n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I re-read the whole series.  It addresses all the things I brought up
> in v1 (except the bonus idea I threw out there about mentioning how
> AUTO_MERGE is related to --remerge-diff), and all the things I
> remember others bringing up as well.
>
> Reviewed-by: Elijah Newren <newren@gmail.com>
>
> Thanks for working on this!

Thanks.

The previous one I'd discard and replace with this one when opening
the tree for the next cycle.

