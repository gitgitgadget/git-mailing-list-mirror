Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6A941F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 09:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbfACJbl (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 04:31:41 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43114 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfACJbl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 04:31:41 -0500
Received: by mail-qt1-f196.google.com with SMTP id i7so36222016qtj.10
        for <git@vger.kernel.org>; Thu, 03 Jan 2019 01:31:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hDuJc7Sbl5evH0ivqHWdK4X3C840Qk9WfysmpJxXltc=;
        b=TfWvQzAi5TuMgvnoCAu1hn3bpUV746TF/oDdX49jEm6OygGNkvMSSgajbn42oHPpvh
         867k/M2/8XSKy3I4Vpri98bbCOH/quYpJUvmuV3vC7hCol8hBJUt9Tm51eJy0zWBOaPY
         Ok1wuBSToMldmQwseKSe8eBHXCybeveRxXLHJXG2d2LjV1eOI0XVGSemkK4gvANrziwo
         m+AzdZTqPV6xBfjaJ7H6dpkhabN7lW45DU2Q2DXAsa6MOzqpmhDnltMfJsDg5sPZ3oMl
         cdNQKFeQ2GNBMgBc8/uJ1+8FmZcbygw0q5g2l4wKDs2XDow+TfTTCVQOnFlSup1fDwCI
         CZ5g==
X-Gm-Message-State: AJcUukcJ2pg2vycw6bQ+tR6zDAImFnyezycy402MzXS1I7Ge/mqzX8W3
        zBmOlZA8umqtqe1cMqXdo6gyuLn0DRfFqrEqp3L5tpvN
X-Google-Smtp-Source: ALg8bN5qEJDiyqiLdqYk0EW4q7/okAz/kmzZtcNSUmsGio3bNcNRCe+8VjkIDvzqqPsVXNHxw5h9mXqP/owXuxtlmCI=
X-Received: by 2002:a0c:981b:: with SMTP id c27mr47375666qvd.184.1546507899351;
 Thu, 03 Jan 2019 01:31:39 -0800 (PST)
MIME-Version: 1.0
References: <20181220145931.GB27361@sigill.intra.peff.net> <20181224084756.49952-1-nbelakovski@gmail.com>
 <20181224084756.49952-2-nbelakovski@gmail.com> <20190103054043.GG20047@sigill.intra.peff.net>
In-Reply-To: <20190103054043.GG20047@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 3 Jan 2019 04:31:29 -0500
Message-ID: <CAPig+cQfjQBW-pAb1w92CVD3a4juRrkpnvwHsVM50xtUeSnf8g@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] ref-filter: add worktreepath atom
To:     Jeff King <peff@peff.net>
Cc:     Nickolai Belakovski <nbelakovski@gmail.com>,
        Git List <git@vger.kernel.org>,
        Rafael Ascensao <rafa.almas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 3, 2019 at 12:40 AM Jeff King <peff@peff.net> wrote:
> On Mon, Dec 24, 2018 at 12:47:54AM -0800, nbelakovski@gmail.com wrote:
> > +test_expect_success 'validate worktree atom' '
> > +     {
> > +     echo master: $PWD &&
> > +     echo master_worktree: $PWD/worktree_dir &&
> > +     echo side: not checked out
> > +     } > expect &&
>
> Minor style nit: use "} >expect" without the extra space.

An interpolating here-doc would be even more natural:

    cat >expect <-EOF &&
    master: $(pwd)
    master_worktree: $(pwd)/worktree_dir
    side: not checked out
    EOF

> This checks the actual directories. Good. I can never remember the rules
> for when to use $PWD versus $(pwd) on Windows. We may run afoul of the
> distinction here.

As I understand it, this is exactly a case in which you would need to
use $(pwd); namely, when coming up with an "expect" value. t/README
talks about it.
