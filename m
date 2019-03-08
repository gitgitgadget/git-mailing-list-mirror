Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,GAPPY_SUBJECT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69C9D20248
	for <e@80x24.org>; Fri,  8 Mar 2019 09:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfCHJwN (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 04:52:13 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40315 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfCHJwM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 04:52:12 -0500
Received: by mail-wm1-f66.google.com with SMTP id g20so11736172wmh.5
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 01:52:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M7/uWKLaSIO+4nz+xjFON3/7ctLahdVHCeDVoSOL1rc=;
        b=EXs0erjxmWaZluJ8f2bLzyezZW2gL0nOhca+SLJobpLQdLNwYSV2VPQuv1OWkEiHnb
         aZErhO22rCzqOmPLB8ILyoqljAtdz24X+WtD3V88atGFhvq57JOcsdVheccf0WjRy30E
         tDaSbd7NeHhx3sChGnJFkuBe7g/wnKBjDi0rXEqGrp/NpJXZTfTYZvatG4PC8IWKbNll
         n8KSmCW1zuADvAs6SEfILowYoX812SGoUNt4ANoNps2qiIze/bbx+6+jKulGolwoB4VS
         sMqBUGNwD0IkI59Zm7JwHOFKzTtMcP3L9t7ChEHhx/Bdpr5UHVVUdOXOjfSMQ81Dtxr9
         1UhQ==
X-Gm-Message-State: APjAAAVQTRRCnB1ROX5MiEcilItmpUPNbJm1LRQK8mSbBkmKBWFVqyYJ
        ejQ/fh3daUzL0F4jhs8T1/oGSph2rAkmq9qdQYH2Bngz
X-Google-Smtp-Source: APXvYqyCghcDp2KFkbQTsCT2icWxHGIk9T6mjlLH6fJwKv1hFJeiZzSxoFQPZ3U3rjr25uVhoHD5Mq5TP8t7bOba/R8=
X-Received: by 2002:a1c:730d:: with SMTP id d13mr8461043wmb.37.1552038730901;
 Fri, 08 Mar 2019 01:52:10 -0800 (PST)
MIME-Version: 1.0
References: <CAPig+cR3b=jk4W=9SF4XJQyqAfFHiG8MduypD75RL1=T_qY0Hg@mail.gmail.com>
 <20190305142149.13671-1-rohit.ashiwal265@gmail.com> <CAPig+cT_YT-1=ymAYiTpjgRQEe8906Y6yyBU=XuP_wbw+ixxiQ@mail.gmail.com>
 <xmqq7edancws.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7edancws.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 8 Mar 2019 04:51:59 -0500
Message-ID: <CAPig+cQFMNFTMfMz5EnMZxnXGLWnKYZ5_=D3eiNsX24hdZSPRw@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2 3/3] t3600: use helpers to replace test -d/f/e/s <path>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 8, 2019 at 12:38 AM Junio C Hamano <gitster@pobox.com> wrote:
> An unrelated tangent, but what do you think of this patch?  In the
> context of testing "git rm", if foo is a dangling symbolic link,
> "git rm foo && test_path_is_missing foo" would need something like
> this to work correctly, I would think.
>
>  test_path_is_missing () {
> -       if test -e "$1"
> +       if test -e "$1" || test -L "$1"
>         then
>                 echo "Path exists:"
>                 ls -ld "$1"

Makes sense. Won't we also want:

    test_path_exists () {
    -    if ! test -e "$1"
    +   if ! test -e "$1" && ! test -L "$1"
       then
            echo "Path $1 doesn't exist. $2"

or something like that?
