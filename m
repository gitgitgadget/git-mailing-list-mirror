Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC71C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 17:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbiF3RnZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 13:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbiF3RnX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 13:43:23 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E5712756
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 10:43:21 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id o25so7961761ejm.3
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 10:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=zMNqDLF+Th+na5W45uVgvP1xyBjiDYDFc0VwO9Zez68=;
        b=HbJQW/hxU3OYOWS/E10tvp+PqIeJHTQQ03QWBJkQTpN25DcCwRwfSupYmCVX8TkfEn
         s44CdmDPg/J5/dKxYTs/4+fzBRLGIWtolJWAoKISDHBisPyDqiL+YBFbO4nueMpRxzVv
         QnuRjMJUO2OWXVRxqOdU8dkyscXOVM7V3B6BLqRE5fk/tdfxVivt+GHCOtepuEIYwJR8
         EVKXdcGnSpdRoEw/6mrfRQ9MXknE7ndytkFSWJGrCnWpbBbSvFTuzVAreNPcXnj8R9yc
         FqAatBCD868m/3y/MDJBxrkmg7le0oon/Idig7VmE9ipMqKoTqcWlHd/EUW6RipN8f/v
         UFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=zMNqDLF+Th+na5W45uVgvP1xyBjiDYDFc0VwO9Zez68=;
        b=kUz4QiRZIp9YydjIoDihhPqnfLPr0dNX2RGnoTioLI87xWaElaptBKU3sEAG9fhuqj
         5LFzyQPaUSB4J87/0F9kdmTMaaDwaAs6Bs3jRyFPweU9z5+Ckc5jnVTQNrwbLtKuk0jT
         ElzihzG5lOTPHlaJWjr73oeWq1jlZxuWbksoYRHNP46T/8uj4C2hoGC7QoLZr9+wsPVO
         SHCEDqTOav6zJ9lMkgHZfJwIBmgZb5JlScC2Wzfvx8H3Y69tqs8i7TmBwyfFo8LtmGXO
         Jj5tOOZRbnf/YG09fd43LGb6+X5YDqjgzS6gRAPtI/yVrfQB2dd2YZZvTIgonulkX58j
         fQng==
X-Gm-Message-State: AJIora8vJxhQ4ozxdvY2ZdgnvWKhKFSQZzAcxiirSLJ/twnnezJ4exJI
        WrK5FX4UgnP5uq+S+34zaKs=
X-Google-Smtp-Source: AGRyM1tF0Fj95szJNvzX3SNuELEq8yPASC1GCyGDF2DWWKIFS/OYCnbWgIAAzwZ40BNeYLbJlhShJA==
X-Received: by 2002:a17:907:7f05:b0:726:9770:77d6 with SMTP id qf5-20020a1709077f0500b00726977077d6mr10035922ejc.464.1656611000178;
        Thu, 30 Jun 2022 10:43:20 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id v18-20020a50a452000000b0043576d146f0sm13711141edb.54.2022.06.30.10.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 10:43:19 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o6yCE-002Q6u-Mq;
        Thu, 30 Jun 2022 19:43:18 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han Xin <hanxin.hx@bytedance.com>
Cc:     chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        jonathantanmy@google.com, me@ttaylorr.com,
        Junio C Hamano <gitster@pobox.com>, ps@pks.im,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: test name conflict + js/ci-github-workflow-markup regression (was:
 [PATCH v3 0/2] no lazy fetch in lookup_commit_in_graph())
Date:   Thu, 30 Jun 2022 19:37:13 +0200
References: <cover.1656044659.git.hanxin.hx@bytedance.com>
 <cover.1656381667.git.hanxin.hx@bytedance.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <cover.1656381667.git.hanxin.hx@bytedance.com>
Message-ID: <220630.86mtducaix.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 28 2022, Han Xin wrote:

>  t/t5329-no-lazy-fetch-with-commit-graph.sh | 53 ++++++++++++++++++++++

This fails "make test" since 5b92477f896 (builtin/gc.c: conditionally
avoid pruning objects via loose, 2022-05-20), i.e. we have another
t/t5329* test now.

Per $subject the CI output for this is now a bit cryptic, it lands you
on a failed run-build-and-test.sh step with:
	
	[...]
	=> Run tests
	cat: 't/test-results/*.exit': No such file or directory
	=== Failed test: * ===
	The full logs are in the 'print test failures' step below.
	See also the 'failed-tests-*' artifacts attached to this run.
	cat: 't/test-results/*.markup': No such file or directory
	Error: Process completed with exit code 1.

The last line of the suggested next step is then:

	Build job failed before the tests could have been run

Going earlier and expanding the "Run tests" step we can see the issue:
	
	duplicate test numbers: t5329
	make[1]: *** [Makefile:86: test-lint-duplicates] Error 1
	make[1]: *** Waiting for unfinished jobs....
	make[1]: Leaving directory '/home/runner/work/git/git/t'
	make: *** [Makefile:3065: test] Error 2
	+ res=2
	+ rm exit.status
	+ end_group
	+ test -n t
	+ set +x

Since the CI topic in $subject we've ran the "print failures" step
separately from the "make" invocation, and therefore have to guess at
why we fail, whereas before we'd get that output from "make" itself.

Johannes, is this something you can fix?

In any case, for this topic the fix is simple: The test needs to be
renamed for a re-roll,
