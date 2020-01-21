Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0224C2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 11:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825D320882
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 11:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3ZGB8HT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbgAULvF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 06:51:05 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:43373 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgAULvF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 06:51:05 -0500
Received: by mail-io1-f67.google.com with SMTP id n21so2520314ioo.10
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 03:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=142VlxXhnzpws3uQPy1b0oSpILzddAmS2yDmzcRyVyM=;
        b=N3ZGB8HTItmY5dplPkb8/yvUXfo0rnuIiLstRZJh2Mzpw4sPquhX8hqsephVdR++PI
         ZsSucgqiux2gDOlJZo452i8G5WezAlupcWqZw8W9BrO8sQ8EbMkRVV6SKenDsljfmDqu
         rjen22jZ5wGEOMTRmYCAe/sEq+njClT813p2kYWufb6irg3v2ciLbJ5mrggHIAlou7u7
         e4+bJJB06YGXqUoVmy5mMt3SQRKKMFsaY+pM8bZEZKkm6OMpvs3beO1drnHGRPmnvCtC
         o3lGmydhx8BGvEN2KTnNAaHOwGmDdCa7PEjnK1erWuTB02EE1Z+mPyinNeXVtAiS8daY
         2gbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=142VlxXhnzpws3uQPy1b0oSpILzddAmS2yDmzcRyVyM=;
        b=A4E6vOU6H8nVGdgjdm6MevMog9Y/y64fKhstlEYn+8Hu/vcrN3nRkjV9EQwbtim+YJ
         Js3Oo8ouJp1/tayopiTATwnKQ22bhQ4tvW9XCNBCpikbK5bN2+yYZT1tfCOY6iyQuj8b
         VVZQ9pYOtmKDM7UCccPCHamGeSE2kJ649nplxypm6kfWd2bOYAIQLwX6NUasuBxriVsE
         OsI0LwdNdXf+5YWKmTPFK9JrAF5XsNGjvaWx62hMTUSlDWAOuQAcmuCK+9UZ8w695SQf
         cGbwiy/u2qywWSjZf+p2KeFUs9q5YTrJHhZ7SRxKSs6dcqC7KWMihysOtbczC8NJsfku
         QtAQ==
X-Gm-Message-State: APjAAAWHUtMfJu7JUzKML0z5RQaRc02uSB0bppL55ytbKAeaVXs2Zn/y
        h7spQ60QaIFE+CSWV+cuHP1O+g9QBMe3t9lMUMw=
X-Google-Smtp-Source: APXvYqymqLsxQQrauB+5gUB0f7hOJhum5KBERInRg5VFy5n7ZQPNL6n9MMrqH1viEI6y7ytFw20lgFC5M11dteCCfcA=
X-Received: by 2002:a02:c906:: with SMTP id t6mr2959736jao.75.1579607464503;
 Tue, 21 Jan 2020 03:51:04 -0800 (PST)
MIME-Version: 1.0
References: <CAFFaXsyVy-fU5c7teDbVCTdUXFTK0GQ=Fse5wSi2vMifyZxS9A@mail.gmail.com>
 <xmqqk15rf21d.fsf@gitster-ct.c.googlers.com> <CAFFaXsz9LEdegzxL8MhS+VfTs-wmWu+CGDjxjB4Xgj8+7nSHNQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2001171433180.46@tvgsbejvaqbjf.bet> <CAFFaXsyiLeNPCZ+Kn1x-+0pZf0FiPQR-k8qtooFrdG+VNfLq+g@mail.gmail.com>
 <nycvar.QRO.7.76.6.2001202232460.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2001202232460.46@tvgsbejvaqbjf.bet>
From:   Nirmal Khedkar <nirmalhk7@gmail.com>
Date:   Tue, 21 Jan 2020 17:20:28 +0530
Message-ID: <CAFFaXsxLd8duDPTE1H-zJiYnTVSB3pHCfBV+08Y4jLvCWR9kNw@mail.gmail.com>
Subject: Re: Facing error in git-imap-send while compiling Git
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Johannes!

On Tue, Jan 21, 2020 at 3:05 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi,
>
> On Tue, 21 Jan 2020, Nirmal Khedkar wrote:
>
> > On Fri, Jan 17, 2020 at 7:05 PM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > On Fri, 17 Jan 2020, Nirmal Khedkar wrote:
> > >
> > > > On Fri, Jan 17, 2020 at 4:21 AM Junio C Hamano <gitster@pobox.com> wrote:
> > > > >
> > > > > Perhaps the thread
> > > > >
> > > > >   https://lore.kernel.org/git/xmqqpnfv3tq4.fsf@gitster-ct.c.googlers.com
> > > > >
> > > > > may help?
> > > >
> > > > It did, to the extent that I now know why I'm facing these errors out
> > > > of the blue.
> > > >
> > > > I'm  not quite sure as to what am I supposed to do right now, should I
> > > > wait for Liam's patch to be merged,  or should I implement his fixes
> > > > locally or should I just downgrade my openssl?
> > > >
> > > > Liam's PR (#516 on GitGitGadget [1]) haven't yet passed all build
> > > > checks and I guess its still a work in progress. Nevertheless I've
> > > > tried implementing his fixes to imap-send.c, and the make still fails.
> > > > Am I missing something here?
> > >
> > > Speaking for myself, I am still waiting for
> > > https://public-inbox.org/git/xmqqpnfv3tq4.fsf@gitster-ct.c.googlers.com/
> > > to be addressed adequately. I think this is the main blocker.
> > >
> > > You could be that person who addresses this, as already 10 days went past
> > > without even so much as an acknowledgement of Junio's suggestion. Maybe
> > > you can make it work, and submit a fixed patch (You could take authorship
> > > and add a footer "Original-patch-by: Liam Huang <liamhuang0205@gmail.com>"
> > > because it is most likely a total rewrite of Liam's patch).
> > >
> > > Ciao,
> > > Johannes
> >
> > The OpenSSL version on my system is 1.1.1. I've tried implementing
> > Junio's suggestions, and it just doesn't work.
>
> Does the code otherwise compile cleanly with `make DEVELOPER=1`?
>
> > It gives me the same
> > error as it gave me earlier.
> >
>
> Those are linker errors, meaning that the symbols were not found in the
> libraries.
>
> If you build with `make V=1 DEVELOPER=1` you should see that
> `git-imap-send` links in OpenSSL via -lssl (and/or -lcrypto). Is this the
> case for you?

Doing "echo DEVELOPER=1 >config.mak" does not help in any way. I get
the same errors. Here's my diff, in case I have been making mistakes
all along.


---
diff --git a/imap-send.c b/imap-send.c
index 6c54d8c29d..73ed3bc287 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -42,6 +42,12 @@ typedef void *SSL;
 #define USE_CURL_DEFAULT 0
 #endif

+#if OPENSSL_VERSION_NUMBER < 0x10100000L
+    #define OPENSSL_sk_num(x) sk_GENERAL_NAME_num(x)
+    #define OPENSSL_sk_value(x,y) sk_GENERAL_NAME_value((x),(y))
+    #define OPENSSL_sk_pop_free(x,y) sk_GENERAL_NAME_pop_free((x),(y))
+#endif
+
 static int verbosity;
 static int use_curl = USE_CURL_DEFAULT;

@@ -59,6 +65,8 @@ static struct option imap_send_options[] = {
 #define DRV_BOX_BAD     -2
 #define DRV_STORE_BAD   -3
---

From my limited knowledge of OpenSSL libraries, I think the error has
more to do with 'SSL_library_init()' , which appears like a
constructor to the OpenSSL library. I found these emails regarding
"if" cases around this function. Please check out these patches:
1. Rosen Penev:
https://lore.kernel.org/git/20181227023548.396-1-rosenp@gmail.com/
2. eroen: https://lore.kernel.org/git/20170112104219.563497-1-git-scm@occam.eroen.eu/

Are the fixes made in these patches relevant here. Please let me know
if I'm going wrong.

Thanks!
Nirmal Khedkar
https://nirmalhk7.github.io
