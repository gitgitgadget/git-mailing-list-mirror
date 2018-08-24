Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32A101F404
	for <e@80x24.org>; Fri, 24 Aug 2018 18:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbeHXWQY (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 18:16:24 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:46958 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeHXWQY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 18:16:24 -0400
Received: by mail-io0-f195.google.com with SMTP id y12-v6so7893053ioj.13
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 11:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f5vbjgLbVjHpCw4Ry4afXt1jnKWdrO0guvG387Hc0YY=;
        b=TZ6tUQRPFqBgb1mAhcygFef0fh0RD9PmXVRij7g4sMME5wwggGUm4eq79wiXLyKnop
         qfnyaMq9AJm+yJqkOYuanKCVJ90oc4N/IptxFGAAkAgZ+KPOsv0BA0C10kGDqpscaCBz
         kCt6E4FoIjfNtv2JxaqN49RA4av/Cm2XjIMAvgCPnUMn8AXi3Qn1dnU6GZCUjkh6ztEH
         7MFbQ7gi3fCnuVpKHuX4gUAdneX648gQ+pXi0qN1aQ6dhjyO6CN8NEIn84o0fU7j/kVt
         LRUKDT1O/F4/yPOZV1EmcS2ovPgOWPgJN3KiqmU0f7My9a5NWMZKOaHp5OqdEfFQZm9S
         oXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f5vbjgLbVjHpCw4Ry4afXt1jnKWdrO0guvG387Hc0YY=;
        b=cvOLGEuJl5qk8Pzvu5O249D4/ITH/WJ3QQI9huuqJIUdHHHbLBANdlx9KmyIRV1gnK
         NsEEvF31oMswGDQjKL8/JIkvD5CHDNG64bUeUfqp07PkZFHmiwAfgC+bTTYMIo49LbRR
         PWAHSn1LxuBcL2Ym9DvDfCtdSOn9exB0bvoO1DZnRL7Qg23CToUMvPWEuhb3qURJfKYd
         qFGd+b6EBVfKwhKL7Y49MaDQDaMNoHS1BBEi0ZrVdD+Bi7tLBJ7CvwHKS28y3GwOM2Z1
         WGpNCIDealLiNBrybVe69/CrHy2vSjV95DnniCm5l1jxT2yTyIUb51pp1nuzW5Rk3I0O
         SLCA==
X-Gm-Message-State: APzg51CLNJ9N9vxBCLUjayzXJhTSEA9B6INkK7MAls0HMhQidCjjeYUi
        cSFpqsVRm+x+cm9IwWiehRSNaenPgF8tgZRjwNQ=
X-Google-Smtp-Source: ANB0VdZXSW0QKpRU66lQr9IS+qtMDblSgi3XdlHAxNjmqeuQfTQi8OBxLQCVbCoErtdhCpStkIK0MeXKo3xzMFcDZMA=
X-Received: by 2002:a6b:8fd0:: with SMTP id r199-v6mr2191240iod.118.1535136035790;
 Fri, 24 Aug 2018 11:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180823154053.20212-1-benpeart@microsoft.com> <CAGZ79kbXfPPvcQ1rnUdiOqWs5wC2qccGCnf8DvCVnp8QV126MA@mail.gmail.com>
In-Reply-To: <CAGZ79kbXfPPvcQ1rnUdiOqWs5wC2qccGCnf8DvCVnp8QV126MA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 24 Aug 2018 20:40:09 +0200
Message-ID: <CACsJy8Cnxz0w0g53Gb=_iXEdbSUFgssTozfxea0H52mWJ-RmTg@mail.gmail.com>
Subject: Re: [PATCH v1] read-cache: speed up index load through parallelization
To:     Stefan Beller <sbeller@google.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 23, 2018 at 7:33 PM Stefan Beller <sbeller@google.com> wrote:
> > +core.fastIndex::
> > +       Enable parallel index loading
> > ++
> > +This can speed up operations like 'git diff' and 'git status' especially
> > +when the index is very large.  When enabled, Git will do the index
> > +loading from the on disk format to the in-memory format in parallel.
> > +Defaults to true.
>
> "fast" is a non-descriptive word as we try to be fast in any operation?
> Maybe core.parallelIndexReading as that just describes what it
> turns on/off, without second guessing its effects?

Another option is index.threads (the "index" section currently only
has one item, index.version). The value could be the same as
grep.threads or pack.threads.

(and if you're thinking about parallelizing write as well but it
should be tuned differently, then perhaps index.readThreads, but I
don't think we need to go that far)
-- 
Duy
