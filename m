Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B4B320248
	for <e@80x24.org>; Mon,  1 Apr 2019 17:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732392AbfDAR0f (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 13:26:35 -0400
Received: from mail-vs1-f53.google.com ([209.85.217.53]:40237 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732173AbfDAR0c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 13:26:32 -0400
Received: by mail-vs1-f53.google.com with SMTP id f22so6013967vso.7
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 10:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=rPPclf8aMG7xeax+/cKkG+bld0ht3XxjNpFqm4rKILQ=;
        b=uU2GxVvcwkdN6JriAwUxtC9RdY9M5lpXzUgrVnQmsVOaAGEljtoYh6q75ek+hiUgmN
         5ll6Qh6lU4Nk9uLlRcYIm0K9PuzW1Mix5gocvwO+Cns2Zo15SAmm/Pav1B26nqWk9Otp
         BiajlhsVF7NImSVdlhmV/KFWJpCCBp+10qkdo9lRHu4qdOC1XplWQ6U1kP/GY4V5uj+w
         1lDAyfiOOSm2tEz+81BlD1phSJfUjNpxIwSTIm5W+xyik0FBeNgcIrrXpznw5nu+vwXA
         QZzZyQGYwy4/Ua3SRj1E+g9bebHJXXniJx04QOfbigN3dMXSNofC6b88WraJ5BgLPxya
         s8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rPPclf8aMG7xeax+/cKkG+bld0ht3XxjNpFqm4rKILQ=;
        b=tf0w/a36MasIEOWNyqk6Hvs8XdgZLJXwvGWJHGNLyhTbG/PMgL4+xSZYvoCZ9OflLV
         kDOlR/O0jZ1CtR/LboC/JQZRmrpks606ZeWV8r1mV0zmQ9MoaBoN7nnSXhoYFhgAWIP7
         PBH3ODDdWFnAcG0ZLqhTV1CTGILn10+MygjsCh/aVkzFtrZluPaSf4kzFVdhMdDuRQg8
         J7QfTL6Na2QCXBMhZwnTUG8Sa98jAmUqqiPe4byiA6Mo4+DwfqGEAqCPhOZhYWdcxD8N
         jE7lOfQ001Hw+Kh843NfN5yckKuQreo/FV2qtI8cbFWDP9JXG3JX2RAseqUWuTq24rle
         txRw==
X-Gm-Message-State: APjAAAUuLp//pqLHOdC1JToVBHim1501JhoPG28E9tHu87xUslz929qF
        qDYJ5RaObWoLfJdXRDZ+hHA09lSHRiY5p0mmjxL91omg
X-Google-Smtp-Source: APXvYqzGdbP0x/TeiqMAR+YA6QxY4QTCIOjP8mgiOYmSDxBlBYT/0v8n5+d2YnxlOjqUnNo6B6qp7hzQyN9JGCziJ7g=
X-Received: by 2002:a67:8010:: with SMTP id b16mr22440852vsd.189.1554139590683;
 Mon, 01 Apr 2019 10:26:30 -0700 (PDT)
MIME-Version: 1.0
From:   Sam Lee <skynare@gmail.com>
Date:   Mon, 1 Apr 2019 13:25:54 -0400
Message-ID: <CACrt3pyZ7XNHLfFM46qymLYft4+jXSU_HBD2Wk+cL6MSzryFhA@mail.gmail.com>
Subject: Reverting a range of commits with conflict
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Given:
    A-B-C-D-E (HEAD)
I want to create a single commit that reverts A-B-C

So, I execute:
    git revert --no-commit A~..C
which causes conflict (while reverting C, it seems).

I resolve conflicts and I continue:
    git revert --continue --no-commit
And, it complains:
    fatal: revert: --no-commit cannot be used with --continue

If I revert --continue without --no-commit:
    git revert --continue

It brings up EDITOR twice and I end up with two commits.
I can squash them. But, I don't know if this is a desired behavior.

Should I be able to revert --continue with --no-commit?
Should revert --continue remember that initial revert invocation was
with --no-commit option?

Thanks.
