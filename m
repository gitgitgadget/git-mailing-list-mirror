Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B7B6200B9
	for <e@80x24.org>; Mon, 21 May 2018 14:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752673AbeEUOyz (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 10:54:55 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51661 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751682AbeEUOyy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 10:54:54 -0400
Received: by mail-wm0-f68.google.com with SMTP id j4-v6so25899264wme.1
        for <git@vger.kernel.org>; Mon, 21 May 2018 07:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m7lDFSEKHq8pcC/OQxZLtrbeqmJ4oNsgYH2q7F7mT2E=;
        b=Itx/A/WQ2K7wNLTWC1lcNV1A7Ra4t1vMNTAxpYHcFy6Xx6DC5xhN0Vvp2jCMvdzs7d
         NdJvAczL8RjfxEa82/YxwaejTRvr3rw7Xiq9usfoyCVgNxFhWMOIXJ7puZk0V1OigH1L
         ZbrSV2dVriiGofWKfU0/CVXoe7OVwwzScj3w0d70tlhXDQa1eZuzFRFHhGmhNZYmmryC
         fjVaaRxRwj2DH4NuzrPbPXws2/AGVSPCNc+VGlMyL131bVKTc2c678Zkth2rIeln/uZ6
         73lp5huS/1ZtlGYlAUeaCSDAKvh/4v+sjtwfKcHGiqxIrAS/BfQ8RzednxaXQjEEgHTy
         CKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m7lDFSEKHq8pcC/OQxZLtrbeqmJ4oNsgYH2q7F7mT2E=;
        b=UHdtTSU1h79QQ0kGG5pIDfxYh46q4TDM/OKvo5bcgNzrLmgDhZ6YtiABDe5ip4erI4
         r6mbrEBxl48+mrN4cWNrXZNSkJ4HrVZYwy2HvLFX+SCRD4E5lnLqaX9q22G16y7tougz
         AEVjabMKZBchQRjRc/vTOMTdmEi+hdCMx3iMsvZhoTT7/VHBmNW7nW4Gh79A0rNE3U8U
         c6MnJVtsEU0N0YUT3tgaCP6FBTakwlhUNr9rluuNn0LCY0TvGnzmKa6/jm0v7DOMF76p
         J4xRJmuf/c3cXH2CB1a32PH2o0gGZN5ditIkhHjeG85bzrakVozWZfVEEzitEFDb4ZRf
         T39Q==
X-Gm-Message-State: ALKqPweMHPQ92XQEVkcscSAsleb7NRqM7+gpf9AQ1piJPltaVsdu30Ve
        6Ney7+0EEeVwpag9IvLRrnw=
X-Google-Smtp-Source: AB8JxZoGVQlqE6eVDYFdvQzaoHVbM7eSeiBUYFdujfGnP5rTByBS+XdoMOOFJqqs3XSgXV4GT1YWew==
X-Received: by 2002:a1c:1f47:: with SMTP id f68-v6mr10135348wmf.4.1526914492974;
        Mon, 21 May 2018 07:54:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id b10-v6sm37627460wrn.42.2018.05.21.07.54.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 May 2018 07:54:51 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v5 0/4] unpack_trees_options: free messages when done
Date:   Mon, 21 May 2018 16:54:24 +0200
Message-Id: <cover.1526913784.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.840.g5d83f92caf
In-Reply-To: <xmqqr2m53leq.fsf@gitster-ct.c.googlers.com>
References: <xmqqr2m53leq.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21 May 2018 at 02:25, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> I have a feeling that argv_array might be a better fit for the
>> purpose of keeping track of to_free[] strings in the context of this
>> series.  Moving away from string_list would allow us to sidestep the
>> storage ownership issues the API has, and we do not need the .util
>> thing string_list gives us (which is one distinct advantage string_list
>> has over argv_array, if the application needs that feature).
>>
>> We would need to make _pushf() and friends return "const char *" if
>> we go that route to make the resulting API more useful, though.
>
> ... and redoing the 4/4 patch using argv_array_pushf() makes the
> result look like this, which does not look too bad.

Thanks to Jacob, Junio and Peff for comments on the previous iteration.

I've taken the six patches that Junio has queued and rebuilt the series
to get rid of the new and possibly bug-prone function that no-one uses
once the series is over.

That is, I've replaced the `string_list_appendf()`-patch with Junio's
`argv_push*()`-patch, then squashed Junio's "redoing the 4/4"-patch into
patch 4/4 -- with the exception of keeping the `memset(opts->msgs, ...)`
which I suspect was mistakenly dropped.

Again, thanks for all the helpful comments and patches pointing me in
the right direction.

Martin

Elijah Newren (1):
  merge-recursive: provide pair of `unpack_trees_{start,finish}()`

Junio C Hamano (1):
  argv-array: return the pushed string from argv_push*()

Martin Ågren (2):
  merge: setup `opts` later in `checkout_fast_forward()`
  unpack_trees_options: free messages when done

 argv-array.h       |  4 ++--
 unpack-trees.h     |  8 +++++++-
 argv-array.c       |  6 ++++--
 builtin/checkout.c |  1 +
 merge-recursive.c  | 30 ++++++++++++++++--------------
 merge.c            | 35 ++++++++++++++++++++---------------
 unpack-trees.c     | 17 ++++++++++++++---
 7 files changed, 64 insertions(+), 37 deletions(-)

-- 
2.17.0.840.g5d83f92caf

