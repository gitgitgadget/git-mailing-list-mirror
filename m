Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B99591F403
	for <e@80x24.org>; Sat,  9 Jun 2018 09:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752821AbeFIJuS (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 05:50:18 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39189 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752272AbeFIJuR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 05:50:17 -0400
Received: by mail-wm0-f68.google.com with SMTP id p11-v6so7838825wmc.4
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 02:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mgg5641Ml28PTiRiXJqgGE5+d7B5IFyMYyqJsH76cPA=;
        b=nudYFP+WOxQq1h+Uz1zyeI4JJpMSgUHxmWlByElF9qaXe7u5s1VRRViwWAej+nBa+E
         Bp5pSEjLzc2aO1Ukl8AyUQ+I5NtnOncORAuaz6QTXdPNQXeO8EZjDc2g+umZhBNRQaGn
         VdsxGH8V/mVozNZUYYhDdfAr4zUUnkVxHRysZX68xdL9Zo9YnhlbsOqM2U8MCZgxreLR
         HaaikM3ZnUUWoUrdbjfizr0rIn0E73sQ7k9WCZ+7qvqlEzgJqE7FP/0pGC8u0KwCVIrZ
         WbHZt/S64e7HuVchIQ59HLXirKU5/IfsB/FfFwygZzZvo+o3XuWQrTILy9OoOpGxlj0X
         IsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mgg5641Ml28PTiRiXJqgGE5+d7B5IFyMYyqJsH76cPA=;
        b=TgVKBp0wxD1fOPfsUqqtplbgLMtF8B8zlci96bx+HTt7jr7f7oQukkUtAAn2RbvvxJ
         3Xxa8tOZ2D4hddsU6ybosHC7I/ipjy9AxThFgfy2BqaI1NXGzTBQQkmGip0N1wNP7Akf
         9zbfubBWgm1AVLZU1JDYdxvc+MkFPe5g87q1WcUXORIuFGpiKJwsd8rLQi3wLOqfPURr
         3vqNgBxn3OyGbijs1b9FdveWyNexBxlvnerRK5HCpJLRz1UygpaTze+yxj2izqPbjX4M
         nqLfxYZgM+32IK9kb6pVPkj7590QoXD4z7CN8fUu+JrtJeFaK2OfSj2o8BUr2TBzl5Os
         K1EA==
X-Gm-Message-State: APt69E3tD+5Th6eGXogLWm7wK32TLo3f1DhzviSxCfUUAN00oWgj82tS
        jgyBZWiMKHDZzgwkpPbsNL4=
X-Google-Smtp-Source: ADUXVKLY5zln+kcDIgNHoU4uqpkZN7i9dsD5n5Z7ObXWlSTvQ20zquiUn43kXYyOxiRV/T1aDkN/ig==
X-Received: by 2002:a1c:7501:: with SMTP id o1-v6mr694884wmc.133.1528537816582;
        Sat, 09 Jun 2018 02:50:16 -0700 (PDT)
Received: from localhost.localdomain (x4db10187.dyn.telefonica.de. [77.177.1.135])
        by smtp.gmail.com with ESMTPSA id b15-v6sm73587519wri.14.2018.06.09.02.50.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 Jun 2018 02:50:16 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] fsck: avoid looking at NULL blob->object
Date:   Sat,  9 Jun 2018 11:50:14 +0200
Message-Id: <20180609095014.17972-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.207.ga6211da864
In-Reply-To: <20180609093141.GB8942@sigill.intra.peff.net>
References: <20180609093028.GA8864@sigill.intra.peff.net> <20180609093141.GB8942@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +test_expect_success 'fsck detects non-blob .gitmodules' '
> +	git init non-blob &&
> +	(
> +		cd non-blob &&
> +
> +		# As above, make the funny tree directly to avoid index
> +		# restrictions.
> +		mkdir subdir &&
> +		cp ../.gitmodules subdir/file &&
> +		git add subdir/file &&
> +		git commit -m ok &&
> +		tree=$(git ls-tree HEAD | sed s/subdir/.gitmodules/ | git mktree) &&

And $tree won't be used here, either.

> +
> +		test_must_fail git fsck 2>output &&
> +		grep gitmodulesBlob output
> +	)
> +'
> +
>  test_done
> -- 
> 2.18.0.rc1.446.g4486251e51
> 
