Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1306EC48BC2
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 22:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB6E8610A0
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 22:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhFWWRn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 18:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhFWWRb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 18:17:31 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F26C061141
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 15:11:55 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id nd37so6331332ejc.3
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 15:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=m4QguRf7LkZkADRk2riJ57hlh/09tLk9r1rflhkQQrs=;
        b=boaE072WztHRnuG2NGg5+1AALld9PKZ/pLyfDzWwAIHzLVf/HoDBJ7wPP6SItpoys/
         XKJz+M3pOl0aYVMSqeL7e0kxxOskyiVZ4gRdj06hgxQ01uHnh8AxrkrLEH4Q9A/cfQae
         8ayjX6zkjoSy5EM/w2f4eJBx3sDVBkerNMXwuMIxgKm2IPxY2yrZqrVmn0Sghy8bfPoR
         Xymgi1X8JyAXQMkIB8WQCFAy4y8TEhsCAgxUSarjZ5Pc8/HGGDBrY842X7ANYvBsJuPL
         TUX28eloRGy11H25PGryF4zpN7Uy5RV8INH4B4QBOaeOxOXGHYJX3XUOiaZQk24QDLtc
         /2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=m4QguRf7LkZkADRk2riJ57hlh/09tLk9r1rflhkQQrs=;
        b=Ig7ZJte+XZgJLyi8FlUW3AKQLHyqr6ZtzEzSjCRyK2S41goasMDBth7JDVQ1oOEbSF
         M79vSYaWSbpyR+DV+311cLRN3XJKPriuSc2O2/SPg1RkUTBW5/diLY3XPKB9M+tgqHY/
         gFcqo2+mlV5EJz2ZD+4pS+3G7+nglN0bMMb0snhyiGhrpm3iDjMBPz98hA91EgMDgjJY
         gp6+YPKtdRB8RF9OpdS4dnbtmIHha7w728WOgWGqK0f1FNrH03zgkkMrrV7e49qt1gWM
         MklRrNnDkun1y3OOemWN/pqyn3r9if24a6bwmn1Ds8T5yiA1m238tjT9/QVIkxZ1reb3
         pv8Q==
X-Gm-Message-State: AOAM533hrSqcBH7+JQKjYW/nDOy8s1DjG3ilN4JP/TfhDeF0tjY9jQ7c
        k4QHkavE0TIFQ1hq3QnpTjURko0rMQY=
X-Google-Smtp-Source: ABdhPJzwxSmnB4noVZn++eQP/N6Jt8w7NxxA1cknXYQxEZd+Twce01ejsIaIsD8Pmv2DEIAZBwF1tg==
X-Received: by 2002:a17:906:5d06:: with SMTP id g6mr2146210ejt.342.1624486314562;
        Wed, 23 Jun 2021 15:11:54 -0700 (PDT)
Received: from szeder.dev (94-21-146-91.pool.digikabel.hu. [94.21.146.91])
        by smtp.gmail.com with ESMTPSA id jx17sm387740ejc.60.2021.06.23.15.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 15:11:54 -0700 (PDT)
Date:   Thu, 24 Jun 2021 00:11:52 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 0/4] WIP/POC check isatty(2)-protected progress lines
Message-ID: <20210623221152.GF6312@szeder.dev>
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
 <20210623215736.8279-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210623215736.8279-1-szeder.dev@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 23, 2021 at 11:57:32PM +0200, SZEDER Gábor wrote:
> I just wanted to see whether it's possible to check all progress lines
> and whether it uncovers any more bugs; and the answer is yes to both.

Oh, and there is another one:

test_expect_success 'test' '
	git commit --allow-empty -m 1 &&
	git commit --allow-empty -m 2 &&
	git commit --allow-empty -m 3 &&
	GIT_PROGRESS_DELAY=0 \
	git commit-graph write --progress --reachable --split &&
	git commit --allow-empty -m 4 &&
	GIT_PROGRESS_DELAY=0 \
	git commit-graph write --progress --reachable --split
'

The last command's progress output ends with:

  Writing out commit graph in 5 passes:  80% (4/5), done.

This is because since 53035c4f0b (commit-graph write: add "Writing
out" progress output, 2019-01-19) we have assumed that the work done
while writing each chunk is proportional to the number of commits in
the graph, but with the arrival of split commit graphs and the BASE
chunk in 118bd57002 (commit-graph: add base graphs chunk, 2019-06-18)
that's not longer the case.

