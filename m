Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 830EB1F609
	for <e@80x24.org>; Mon, 27 May 2019 12:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfE0MdS (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 08:33:18 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40523 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbfE0MdN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 May 2019 08:33:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id 15so15661882wmg.5
        for <git@vger.kernel.org>; Mon, 27 May 2019 05:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2A04f9HaZNMB40s7FDmagBXi4VteUjR4wwzslZJ6poM=;
        b=Ws4Gyuh2B1T3nl1ciNr9ODt1vj6a0v1pSsxC85P5RTZN+bPhDEaR9cr2g23k+HTHd/
         b2yprspflbZGDaMOYYgBxn962aYWtxjUJoIHyHgZa7LcjjNICtQ40v3MfpzvN/FxtzBX
         lYOt6nqFS5EhME2gM2fHY5xK6pY2iAS3vEMuwQgNe8UFb6wp4cL1LUfmTrYoVudh+BUz
         Y/yvJQqE2NrbdkYIgOqk+QmxLB0agulAeH4FkN9uZaV8AXsvW+7LRgzFbBSg28n/SpO9
         zYYpgjxUJsyixXNdg2ox0ksb5auA/PcKZ78/ZH5Et8oVD+9YeqoGP5XyM8UA7UDkuW7X
         RJ7g==
X-Gm-Message-State: APjAAAVTvK72qyrOHHYp62ggz6WwNenwG1KOUhwRV5nkhdkwzM3QlC++
        L6pFeZgf2bDUKCSnner/rSzjnQ==
X-Google-Smtp-Source: APXvYqyfyZiyQXGV6PqCF7c2IO5JUIC3+A6dAwpVyQH6lHro05CRPOzIynwiJ5C8FTv8HcDWWnAu7A==
X-Received: by 2002:a7b:c943:: with SMTP id i3mr9080617wml.128.1558960391360;
        Mon, 27 May 2019 05:33:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c92d:f9e8:f150:3553? ([2001:b07:6468:f312:c92d:f9e8:f150:3553])
        by smtp.gmail.com with ESMTPSA id s13sm12469362wmh.31.2019.05.27.05.33.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 05:33:10 -0700 (PDT)
Subject: Re: [RFC/PATCH] refs: tone down the dwimmery in refname_match() for
 {heads,tags,remotes}/*
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
References: <CAHk-=wgzKzAwS=_ySikL1f=Gr62YXL_WXGh82wZKMOvzJ9+2VA@mail.gmail.com>
 <20190526225445.21618-1-avarab@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5c9ce55c-2c3a-fce0-d6e3-dfe5f8fc9b01@redhat.com>
Date:   Mon, 27 May 2019 14:33:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190526225445.21618-1-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/05/19 00:54, Ævar Arnfjörð Bjarmason wrote:
> This resulted in a case[1] where someone on LKML did:
> 
>     git push kvm +HEAD:tags/for-linus
> 
> Which would have created a new "tags/for-linus" branch in their "kvm"
> repository, except because they happened to have an existing
> "refs/tags/for-linus" reference we pushed there instead, and replaced
> an annotated tag with a lightweight tag.

Actually, I would not be surprised even if "git push foo
someref:tags/foo" _always_ created a lightweight tag (i.e. push to
refs/tags/foo).

In my opinion, the bug is that "git request-pull" should warn if the tag
is lightweight remotely but not locally, and possibly even vice versa.
Here is a simple testcase:

  # setup "local" repo
  mkdir -p testdir/a
  cd testdir/a
  git init
  echo a > test
  git add test
  git commit -minitial

  # setup "remote" repo
  git clone --bare . ../b

  # setup "local" tag
  echo b >> test
  git commit -msecond test
  git tag -mtag tag1

  # create remote lightweight tag and prepare a pull request
  git push ../b HEAD:refs/tags/tag1
  git request-pull HEAD^ ../b tags/tag1

Paolo
