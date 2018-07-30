Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACA911F597
	for <e@80x24.org>; Mon, 30 Jul 2018 19:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbeG3Umh (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 16:42:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35379 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730125AbeG3Umh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 16:42:37 -0400
Received: by mail-pf1-f194.google.com with SMTP id q7-v6so4937948pff.2
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 12:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J1Q5Beezc1kzy35GaM89aGFRoCVYh+A/o/Mr2x0rj18=;
        b=ovsIT8WY+sOjIteOXIlEjKMBOizwuchwgmsmtRqxyu4NZKGwDsGwqVbzhKZsAJwXJ0
         qAnzk6a1zrEV64DrX1Hnof1L0iGzd+mcEl93hsaquANnJsz3+vTjxGKFXxk3ZK7BuYcH
         FvewvtOWdISKLcF7pJ7qkQ17F6Ijc7OB85STuv0efTcCb+ETihCI18q5vFUEYgApcIkA
         jpitjx1UVJluv1Llxiv9cKAB/gfS5Wja8gi0GMpcRb5oF/xVmztUtpCrhuB77QuRMUlu
         ymoRgY+vScByG/Jy+SnZeMIPlI83tBR7Z4K3j6X+IxhCp+GF4OIVVjnxlxDvu0MPAklS
         CGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J1Q5Beezc1kzy35GaM89aGFRoCVYh+A/o/Mr2x0rj18=;
        b=qdPkOQTSYe33JrRl4ci6LMGd8R5NcHd6iaIhav9vHBr/M0apm2E0+pqsa9aZm6Uw/l
         ZBF3hEtR7L4ZpBXGKhk0tG/3SbGEx6i2SQxAr19yFIXyb9xgla2jwqt2x7phiKwofJvH
         2v5ub6MeLBFT6eOIbg0K0KmqZrA4y1YfY5Q9k0oCEPKvtC3DFN4Z+qTxwsTeFDxh6pyc
         ds0ElcKMYKKHvF2I9ZhmMUiqRJvtXNsNwH+sqW22ml0tnvoRNCLda/Hg5ITcfD2mAtQv
         YRxDvfKWCZx+W6THO2BfJM0eW3slgYuc9trbIuRTe1M3flJUK4++15UwiE/NlQxUijCt
         aSvQ==
X-Gm-Message-State: AOUpUlFZbrWds1XIitZp9JxN/bXMKaDInB2lOfl2/DDjwTMlMFPdH86p
        tlqgaFm2IVgF87TG8ciDOAc=
X-Google-Smtp-Source: AAOMgpep0b/2hLEMeT01DdhX4pUSIn0OJXt2gdWe5GdNEO4sj+LLVakyTsdzhBKkpWiIFvkmHUY5kA==
X-Received: by 2002:a63:195e:: with SMTP id 30-v6mr17321084pgz.192.1532977573994;
        Mon, 30 Jul 2018 12:06:13 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 16-v6sm18315831pfp.6.2018.07.30.12.06.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 12:06:13 -0700 (PDT)
Date:   Mon, 30 Jul 2018 12:06:12 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: [PATCH 0/2] subtree: fix &&-chain and simplify tests (Re: [PATCH v2
 01/10] t/test-lib: teach --chain-lint to detect broken &&-chains in
 subshells)
Message-ID: <20180730190612.GB156463@aiede.svl.corp.google.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180711064642.6933-1-sunshine@sunshineco.com>
 <20180711064642.6933-2-sunshine@sunshineco.com>
 <20180730181356.GA156463@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730181356.GA156463@aiede.svl.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(resetting cc list)
Jonathan Nieder wrote:

> This is causing contrib/subtree tests to fail for me: running "make -C
> contrib/subtree test" produces
[...]
> 	error: bug in the test script: broken &&-chain or run-away HERE-DOC:
[...]
> Ugly quoting, useless use of "cat", etc, aside, I don't think it's
> missing any &&.  Hints?

Turns out it was missing a && too. :)

These patches are against "master".  Ideally this would have come
before es/chain-lint-in-subshell.  Since this is contrib/, I'm okay
with losing bisectability and having it come after, though.

Thoughts of all kinds welcome.

Jonathan Nieder (2):
  subtree: add missing && to &&-chain
  subtree: simplify preparation of expected results

 contrib/subtree/t/t7900-subtree.sh | 121 ++++++++---------------------
 1 file changed, 31 insertions(+), 90 deletions(-)
