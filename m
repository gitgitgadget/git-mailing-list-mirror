Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FE341F462
	for <e@80x24.org>; Mon, 10 Jun 2019 16:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfFJQru (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 12:47:50 -0400
Received: from mail-it1-f172.google.com ([209.85.166.172]:54976 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfFJQru (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 12:47:50 -0400
Received: by mail-it1-f172.google.com with SMTP id m138so84585ita.4
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 09:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=ZuURcv6Zxz/MZb98sZRY2Y5Bdr2SBeSHH0uJ8iNGNuA=;
        b=sfwI7h4LWRSbC1bd26kRZG5cLaxuRefdq/+o//dBJcN6E7dZgZXwbxo8vMKkFy5WW9
         55qWKMfJCk8wKYTC8N/XZNkW+ovz3FWoTLhHGLyl8+wDUPAvUu+C9vzlw5zsIZKYZsXv
         78ykqlSkv80Zs+T7WrcSQz/LjlpJ6TaxkgFkEHaZFrvpIPF1dA2KaAlerOsfXrtyzCWI
         E/UOxnkfCrxFXij0fTuhUG2RwgIGWL+KiJlzwuTtLFMK3gejvue4rkU4cWRTdnwYWAYj
         RmO+3EeKy1MiSTVvWhpItkpUR9pl8lNq7SopoJV2b0hcRq/mRcFLGMA0TlzShqYpDy4i
         Y3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=ZuURcv6Zxz/MZb98sZRY2Y5Bdr2SBeSHH0uJ8iNGNuA=;
        b=IbNSpbcN0E+VVd+V0WRlIsST9cGOasGCHN0+V+3HcSaVwTzYz8M9qUEIjeae4M71D1
         XE//LrzZjT++PTClmI3RQhoGmCTKgcmE1Zd2OBAEjbVDk8awXSgjMfmCk4Pq7Cuf2Xrp
         Tcn3z+B7FvjOVoXslQbamWc0HJmr6YJ2xoZnhRG6Fj+Rt4VoCkeLK2vBSwuNY3sbDqd7
         avujjOuI0lziq+hzveMlHZHYTTdM+SWDAsU67fwiTtEDo24AzRNJQ0cBDCG9H8b6Og0m
         003Y5TtqJie5mKqS5sLxUZuEuJBrMcixzLlgZmYRJQg8NGhk6Qt+6hDr+dvwfRmYcctv
         Mr1Q==
X-Gm-Message-State: APjAAAVZ12YoYrp0ruvJgW50bbtlgBiRSYu6wV091oOHnU0FxsHq1klI
        OS/SWssozbIg1W6RV2wdxfHsCXFV8J/U0DgGKEsERx3PKcEP6w==
X-Google-Smtp-Source: APXvYqxT/jb1NUoQuy5sUqS2Zv2rdhfJBxTZF0rshK+5kaSWzPA2Z7hg1FANgBhtFpM+1a1Ybrv9Z+o+L+uhgMj9EU0=
X-Received: by 2002:a24:7401:: with SMTP id o1mr14173164itc.124.1560185269118;
 Mon, 10 Jun 2019 09:47:49 -0700 (PDT)
MIME-Version: 1.0
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 10 Jun 2019 13:47:38 -0300
Message-ID: <CAHd-oW5ifDZ_MmtmkuQt0FMpG74F=MZeUZ0yw7nq0xjOcwN-nA@mail.gmail.com>
Subject: [GSoC][RFC] New approach: improve threading at git-grep
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, everyone

I've been working on making the pack access code thread safe, as my
GSoC project[1]. I was working directly at sha1-file.c global states
targeting, in the far distance, to parallelize git-blame. But my
mentors and I decided to take a different path, as a better way to
continuous validate the work being done and be able to see small
continuous improvements: the idea is to focus on the object store call
chains originated at git-grep. Making them thread-safe, we should be
able to re-enable threading when greping blobs[2] and go refining
git-grep's locks along the way, for a better performance.

I just posted about the overall idea together with some analysis I've
made on git-grep, here:
https://matheustavares.gitlab.io/posts/week-4-a-different-approach
Please, let me know if you have any comments or suggestions.

Thanks,
Matheus

[1]: https://matheustavares.gitlab.io/assets/Matheus_Tavares_GSoC_Proposal.=
pdf
[2]: Disabled by 53b8d93 (=E2=80=9Cgrep: disable threading in non-worktree
case=E2=80=9D, 2011-12-12), because it was causing slowdowns
