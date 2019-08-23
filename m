Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 506681F461
	for <e@80x24.org>; Fri, 23 Aug 2019 17:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388865AbfHWRT4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 13:19:56 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:45651 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732886AbfHWRT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 13:19:56 -0400
Received: by mail-oi1-f174.google.com with SMTP id v12so7554859oic.12
        for <git@vger.kernel.org>; Fri, 23 Aug 2019 10:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dakotahawkins.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=AXl47Jvc1f8y06cQ6kZcx0cknMavCx+bAPW+o+rghHs=;
        b=IzGNKDU3+wN3aVrJnDVoj/dyCXVSDr6evKj4vaz8fM2+rBOtxAF0z3QjdZ19u+GPIA
         f6ymKIQRttJTi2p9Etf3B37rZORD64hp0UoEiHmh1czQWQFC8GgmFwEJ1KiAj64O0Vb1
         Eg/EswWshEHCrnCgzfxY7TjFS2TT7lClBMBm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=AXl47Jvc1f8y06cQ6kZcx0cknMavCx+bAPW+o+rghHs=;
        b=E33NswqB/E9yqwSy71T+FsoUWiopzptqIzxnEHcum50Sl5nruHdMNuzZZXfk2pnft1
         brxIchYvV60kZ0EuWm1NjRn69BiLQ4Z8uVJVLFxsaj98ClNfl8yr7g6IjOT1DFU2mqFX
         eJ/gyMfsuFp/G2+hyJFGRtAgTaOghdKZqsvooJtJT7b/LNwXXH6Qwydxxw+peouhZIID
         7oyq8HAmMfeDMvG0U9z6cCiNn+V8prnNoynZaB9pc+cQNoQo/bABuD7kP51NSGXoVigg
         PSmsHImDT4lbDVvwTIEMq7zOyoF+XIhAnlT2EieTFmbvN3kIm85nDJBidYiPNABXkfxa
         A/QQ==
X-Gm-Message-State: APjAAAWu4tuR01vheFq6vTpvDLtvyCkGZiSYBm/f1HBaxQSCGjNEcxG2
        Y2AiNcllpd/j+7YQW3NSBzBN5NqBMgxHFSQ3ye61CZAO3uiNTg==
X-Google-Smtp-Source: APXvYqxkUaHelG5mizbPZYVE9YSYpllIxtseSXFBq9EA4DWTLe75yQYU1lrWZVHwXf+py3XbUs+oRGg6zVJZc+6yiEs=
X-Received: by 2002:aca:d8c3:: with SMTP id p186mr1156302oig.56.1566580794605;
 Fri, 23 Aug 2019 10:19:54 -0700 (PDT)
MIME-Version: 1.0
From:   Dakota Hawkins <dakota@dakotahawkins.com>
Date:   Fri, 23 Aug 2019 13:19:45 -0400
Message-ID: <CAHnyXxScGO6Eex_AEbgH=YFQ2yzY1hnXavyNMkiXbrccVUA=Ug@mail.gmail.com>
Subject: [RFC] Add config option corresponding to --rebase-merges
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'd like to work on a patch to add config options that correspond to
rebase's --rebase-merges flag.

In my workflow, while it's uncommon to encounter merge commits during
a rebase operation, when they are encountered I pretty much always
want this behavior. Since it's rare, I pretty much always forget to
ask for it, with interesting and confusing consequences.

If nobody has any opposition to the concept, the following are the
specific options and values that I think makes sense and covers the
existing functionality.

# New rebase.merges config that takes effect if set to true or cousins
+ rebase.merges=
+   true
+   cousins

# New cousins value for pull.rebase
pull.rebase=
+   cousins

# New pull.rebaseMerges config that takes effect if set to true or
# cousins. Intended to allow pull.rebase to be set to interactive.
+ pull.rebaseMerges=
+   true
+   cousins

# Corresponding additions for branch.<name> config
branch.<name>.rebase=
+   cousins
branch.<name>.rebaseMerges=
+   true
+   cousins

I'd like to get feedback on the idea and specific options proposed,
if only to avoid having to tweak them once they've been added.

Thanks,

Dakota Hawkins
