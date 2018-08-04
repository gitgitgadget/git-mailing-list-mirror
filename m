Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 662961F597
	for <e@80x24.org>; Sat,  4 Aug 2018 21:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbeHDXtt (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 19:49:49 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:41132 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbeHDXtt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 19:49:49 -0400
Received: by mail-lj1-f173.google.com with SMTP id y17-v6so7643428ljy.8
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 14:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=KlTxHj5yGK8v7i7OSBGIzS2UyZ792EKmudxrnQ7Z0M4=;
        b=j7lYCu69uWCfcRofIef+y5DUfNWhQu/IvN8hSLK867MsBQ6FtSvT+5h+JSZJL2q/3C
         N+e+0Z7K5WWKxK5aOHgURCNKKPut1APQUonDlMwdXUKX7VvzVObYNST9tQvUnoRz3rpb
         7VYrGrFTzC2Ta5kXWB8IQ3qvJwVc0H2BNn/+LMlFlVisn1RWUQol9zE8//CBGjcflw0l
         9jC/zX18fdc82PRfwbYPAKc3b6wgu0xKyfwYrwTWmlazFch9l3/eITJvd9mgqrXyjyvQ
         nnqoLdEPDyzSPmy5qeRNTHpEPuv1zG3rafSdDKu+ZhZ17SMEYI0OqFQNAn18jnuk+SKA
         lECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=KlTxHj5yGK8v7i7OSBGIzS2UyZ792EKmudxrnQ7Z0M4=;
        b=c6iM7Cq/zCl9ExF28ZS1ZwTz6oMIk3bebQzLbJPgI4VUR1OXvsrQPat1p2VQ32Pol8
         fpfVEShcfzxLE+eBlLqQYfjyGlWVPxB7eSr+Vn/fpFfaz1++NGNUa5PVPlSYH5XV+2xP
         fPx/9cg7srMDXkpRH7dHoCBLxzzPAq8Q/93DXdtP0ngx+RYHjV/sv/D6Gai1m1hjofDP
         j+xahqMD7SVIkFqAp7GyUYCefyKNt0/8Ev50Imw2d5BTBWFhJSKZuQ313HblraBeT/bO
         nI4CYY0buMewalzWuoIsW7YSN8QsRelWgnIj9SdcdEIQc5l7+mNA/RiWU7vEnNSFb7lf
         DjoA==
X-Gm-Message-State: AOUpUlHs/cpJnvIXZOQ1umj1a3iPOYFn44/EFMCOVe4yplKfKRhhUDDX
        Mvc/Ezk86jKbmmILwzrMkNBz8n0VCFCrG8hnCVnLVZXt
X-Google-Smtp-Source: AAOMgpeJHT/GIrWMcKcSIDnu/tBelJYFmFIh4rflZ0kqUqFjW/fC7vKmAku/c7ONR7a9OQj9R5KfGUZMBAPuJ6myvPk=
X-Received: by 2002:a2e:3313:: with SMTP id d19-v6mr8389156ljc.25.1533419263113;
 Sat, 04 Aug 2018 14:47:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:4057:0:0:0:0:0 with HTTP; Sat, 4 Aug 2018 14:47:42 -0700 (PDT)
From:   Alexander Mills <alexander.d.mills@gmail.com>
Date:   Sat, 4 Aug 2018 14:47:42 -0700
Message-ID: <CA+KyZp4fxRfnPNozEtwgLPuFAnEsXCBPPubzNjv0wUMnBV_eww@mail.gmail.com>
Subject: concurrent access to multiple local git repos is error prone
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If I have multiple local git repos, and I run `git status -v` on them,
sometimes I don't get any stdout for the command. This is highly
reproducible.

I assume that access more than 1 git repo concurrently on a local
machine is not without errors. However this seems like a huge
limitation or design flaw.

Is my observation correct? Are there any plans to remove this limitation?

My use case - I create a lot of developer tools and more than once I
have hit this limitation...I have to create a queue with concurrency
of 1 to run commands on git repos. It's very strange and
counterintuitive to have to do this.


--=20
Alexander D. Mills
=C2=A1=C2=A1=C2=A1 New cell phone number: (415)730-1805 !!!
alexander.d.mills@gmail.com

www.linkedin.com/pub/alexander-mills/b/7a5/418/
