Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EEDC433EF
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 07:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbiAVH67 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 02:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbiAVH67 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 02:58:59 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CA1C06173B
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 23:58:58 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id j23so41604911edp.5
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 23:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SchlN926Igm8WUqhMj4oIu9HT2BMjpB8vet0f+kIHSc=;
        b=SR37+ohxIbGvwqBn8wA4m+3q2omx8+Q/O5YARwj39dbNpOTlIlbVkRCSW4CVoJ8/KG
         yNFRgRlCVlagYFE/XutJbBTRQv+1mcPT2UWQcYLBmKil5Ceq+K65KR3Yqpay2PXR3r5B
         Ma8xBijtQZDtXM1HEk0OoPgXkJf2wo+I4LRyi9pkUafaCt7hKDzp1/5auH+tMgqsIbK5
         76Esii004CYz2SXPZj7eoR6TbeXYIKh2uYVTtP9n3ZtyNOOPRxNo9Rew9mfHRTf7LUCy
         VO+z3SRwv+D0H8droHwGUUgqbnzcfOYQo4r/osdZA/oIwU0nj52wa5zCf3dA224J0qyV
         /TCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SchlN926Igm8WUqhMj4oIu9HT2BMjpB8vet0f+kIHSc=;
        b=HWBnY5YLiD83XeCTEdrGDgWBUSrFJ2oSqkQTh46KmPcKTTVonsm0S3Ko85h8mYj/YX
         gbbM8tRoPg5bPbLc+c1SmMjM3sRu9x0MgBqNJftG3UnhE8buMAkvFmKrRnjrbcXvWI3q
         aHet6qEteLvAcLd4R3TdNaU/s5DCPPdWCqrGJsqS+anGptUWCzXifm8QOqU8f944vq/b
         u3ncoRuS+IrmQ/e0vKorvP1UUM9bE0EZ6W0Au8LqKuu4NHADyM59zJ5uabmBgxae4STJ
         lvCkhZlNAf3YJMq5oLRacBuoAQbOwtYRg8Grl07nLU8CGtEQ6ZYx3B/rpsHZIrleU950
         orqg==
X-Gm-Message-State: AOAM532iUiWXvaz+oGu14ChsaC+vTAeG4oUuBZYXOkfCVKhOoqiAxDg4
        y3KvVG3tKgO8TDEzW27wwag=
X-Google-Smtp-Source: ABdhPJyktmSf7SxIFEgQZ6Yh6W8UgdQph59m6tKU55C6ihy3MMNlf/RM8oApYfGs9klJKY80+77Gpw==
X-Received: by 2002:a05:6402:22b3:: with SMTP id cx19mr7437607edb.37.1642838336820;
        Fri, 21 Jan 2022 23:58:56 -0800 (PST)
Received: from szeder.dev (94-21-146-14.pool.digikabel.hu. [94.21.146.14])
        by smtp.gmail.com with ESMTPSA id n6sm3459296edy.87.2022.01.21.23.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 23:58:56 -0800 (PST)
Date:   Sat, 22 Jan 2022 08:58:51 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com, stolee@gmail.com
Subject: Re: [PATCH] sparse-checkout: create leading directory
Message-ID: <20220122075851.GA1718@szeder.dev>
References: <20220120185548.3648549-1-jonathantanmy@google.com>
 <220120.86mtjqks1b.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220120.86mtjqks1b.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 20, 2022 at 10:30:03PM +0100, Ævar Arnfjörð Bjarmason wrote:
> > diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> > index 42776984fe..dba0737599 100755
> > --- a/t/t1091-sparse-checkout-builtin.sh
> > +++ b/t/t1091-sparse-checkout-builtin.sh
> > @@ -79,6 +79,13 @@ test_expect_success 'git sparse-checkout init' '
> >  	check_files repo a
> >  '
> >  
> > +test_expect_success 'git sparse-checkout init in empty repo' '
> > +	test_when_finished rm -rf empty-repo blank-template &&
> > +	mkdir blank-template &&
> > +	git init --template=blank-template empty-repo &&
> > +	git -C empty-repo sparse-checkout init
> > +'
> > +
> >  test_expect_success 'git sparse-checkout list after init' '
> >  	git -C repo sparse-checkout list >actual &&
> >  	cat >expect <<-\EOF &&
> 
> You're using an overly verbose way to say "no templates, please". You
> can squash this in, i.e. --template= is an explicitly supported way to
> do that.

It would be even more expressive to use 'git init --no-template', but,
alas, that doesn't work:

  $ git init --no-template /tmp/foo
  Initialized empty Git repository in /tmp/foo/.git/
  $ ls /tmp/foo/.git
  branches  config  description  HEAD  hooks  info  objects  refs

