Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C67071F453
	for <e@80x24.org>; Tue, 22 Jan 2019 21:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfAVVqE (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 16:46:04 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42277 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfAVVqE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 16:46:04 -0500
Received: by mail-lf1-f68.google.com with SMTP id l10so32299lfh.9
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 13:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lm5HEqshLwRM1eBa7UFHoTEdBow9z3iPjArXjM0dLSc=;
        b=JhAuBo8x1+OPvqMGdTm2x0FjOTIPoFv2u27UMeJFsuDzaT9mAFh5FnS6NUfhSbCPHU
         M/xbHv8VrZtPzwafAo2lSwKnR+1/k1MEcivLRwbsgeaFMPhUjBNRDLFy+G05ZteirHAa
         30EsbXaT5Ko0hI4ZIBmU4iO6LYJRFKxQbxQ90ZKDqNcuKN73Fx58AcPmnXDVMSaShRBl
         GzvyUn7W8oksKZqlX+q5srK/9/Bb8q1oyfoiwcs9L6WdejEQJAnZGaDUaneOL/O4N0g5
         xXbSB1KO75gjKTY2PZ/kLwT6/Sr4qiv3JSamhxUFqqwsz6HPI01JAGO1/Nb3SI1+u+2o
         IEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lm5HEqshLwRM1eBa7UFHoTEdBow9z3iPjArXjM0dLSc=;
        b=bLJxlWeauBM1xxT7DZLO65ZgrSHNTG++bjaDKlTH3PYAAc1+ncV3eWUV0yega0xtMX
         bmzgDauPxCWoCoQ13wlQR+JMWwmay8AYl3Yu0pDCGqIyBzGRxVKlPTSAmzy4nf7rRz+e
         QsDS9nxKY25/Sl5c1Tj6yLiNdw8TdMc53isan+kGl/FshiCBzXS2CAB3mY4kZg1uXPvV
         sq59EF8uV+AK2kEGHlR7QFtFaa6XXWBY7GFHwQSV0SUYjOZ+2jsOPAR8iI9ZSSuzWcaJ
         N0YFS+rWZAYgTa8l1XVHlTl4ZVvPtKpZky9GPHXcYW2i6Voy3ygvmnYdU3M59WKx5ZGl
         85Og==
X-Gm-Message-State: AJcUukdlrfUAsnsjGoetPW+9La9cBFKzx2JZ+RTRtUp1/fzSZLjU+1Nu
        8cXysCEgHMePn69Xp23+goHxUC9w
X-Google-Smtp-Source: ALg8bN7gqSZrg1LE5gUBp/S+KLUU/sUJSTmJcI7JsgrH0oEEjWT/Pl0/JDu21f8dp+n/094/i83T4g==
X-Received: by 2002:a19:be16:: with SMTP id o22mr21762504lff.22.1548193561952;
        Tue, 22 Jan 2019 13:46:01 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id k3-v6sm188706lja.8.2019.01.22.13.46.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 13:46:01 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 0/2] setup: fix memory leaks with `struct repository_format`
Date:   Tue, 22 Jan 2019 22:45:46 +0100
Message-Id: <cover.1548186510.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.1.98.gecbdaf0899
In-Reply-To: <CAN0heSq0Nb-WdhDFpdwgjUMrkJNbviAtietn=B5nJg-rDgcR_g@mail.gmail.com>
References: <CAN0heSq0Nb-WdhDFpdwgjUMrkJNbviAtietn=B5nJg-rDgcR_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 22 Jan 2019 at 14:34, Martin Ågren <martin.agren@gmail.com> wrote:
>
> On Tue, 22 Jan 2019 at 08:07, Jeff King <peff@peff.net> wrote:
>
> > For the record, I can live with it either way. There are so many funky
> > little setup corner cases in the code already, and we don't even really
> > have a real-world case to dissect at this point. So the right thing may
> > also just be to finish this patch series as quickly as possible and move
> > on to something more useful. :)
>
> I rebased the "something like this?" into this series yesterday and I
> think the end result is better, but also that the way there is clearer,
> mostly because this patch is then gone. I wanted to double-check it
> tonight and submit it. I'll do that tonight.

Here's that reroll. I now reset the entire struct in the error path of
`clear_...()`. Thus, the user that is reading `repo_fmt.hash_algo`
despite not being supposed to, can keep reading it, now knowing that the
value has a default value.

I also expanded on the documentation a little to point out that we'll
reset to the default struct state if we don't find any
"core.repositoryformatversion".

Martin

Martin Ågren (2):
  setup: free old value before setting `work_tree`
  setup: fix memory leaks with `struct repository_format`

 cache.h           | 27 ++++++++++++++++++++++++---
 builtin/init-db.c |  3 ++-
 repository.c      |  3 ++-
 setup.c           | 33 +++++++++++++++++++++------------
 worktree.c        |  4 +++-
 5 files changed, 52 insertions(+), 18 deletions(-)

-- 
2.20.1.98.gecbdaf0899

