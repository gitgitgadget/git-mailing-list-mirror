Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BBEC432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 13:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09252207FD
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 13:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXzz5vDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfKYNbU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:31:20 -0500
Received: from mail-vs1-f42.google.com ([209.85.217.42]:44540 "EHLO
        mail-vs1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfKYNbT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 08:31:19 -0500
Received: by mail-vs1-f42.google.com with SMTP id p6so4821275vsj.11
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 05:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=fq1oAWo/rwMmw7y3Li2mrhm8zl6/zlPKq1kGeGt9ZxU=;
        b=YXzz5vDzeKPaimqdrIUFh0wuwgY7naIA8jcoqyOGNo/Jym1HidK1HXGg2M0K6sCCaN
         cZdt7LaAVTp/wxcQC/PbKEqgxILYT4UinMVqlZLaaBiZgctifMYQFntChSlOo815zmC1
         EbpirCVsQu9uDcdVZ+/cg0e46IbCde9Bd3DGV2474T+0AAskcTKeD4z9qPpbDnf91sf0
         RYE2HWnOlhkFt10m4FdvvaPpjl2BGSt7uxDBNm4WjA+wB21py8EJFOcfn0+mQiwxDGTU
         xTubhxDVWRfnaGDs33wjcQRcAKz7UyK96+hqwaF72OLJSSsoT6wk4ZLfcWwskOAeQlmH
         H2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=fq1oAWo/rwMmw7y3Li2mrhm8zl6/zlPKq1kGeGt9ZxU=;
        b=snbfMCMMl8pwpMo7pcK9v4KLywDDvyCLoWe8vGywt9zwErIWatZzEjexsO7LkNjzTs
         0RQDSVN63IyOhJlnLoSdPVhkrYODaFyAa3T9in702EoZ5PjUw5iPSGFPFQW9HvXRRPoG
         QzMC2vIoCOtJ0/BuTi1OEUN54Kx7nn2Xtly4C+aCru8d8XT2ZfA5So3tfeX8fYSqARKh
         Td9u3u2CvnJE9BvU1Jj89jEyqLucQ1OxwKHS57lnpiRfR+cg4RJqzits0hx+2/bum0xo
         2vxADt1mb8lRYRWDQAtdXEpEcqE67dpRUZcnwffOPyTd2sz6E5y6QQSaFB8EMv3U9DX0
         hWTQ==
X-Gm-Message-State: APjAAAXdUnViV8gbupSTyv21/LbDCKIjW1KVBlxBvnXiQGetI8NQJTS9
        08DjFj8xs0Zdsw04gBKJgDIwJL7uFYlcnbEpNS/SeZQy
X-Google-Smtp-Source: APXvYqy45/5eaIWrNICd+O/yPQ3pcTuhFonU/Suh40zdVTJcwTet1HZXXhdf5m//8QFwNFO1YCMeCLsUsxaWUXSwyNc=
X-Received: by 2002:a05:6102:11a:: with SMTP id z26mr2436107vsq.87.1574688676915;
 Mon, 25 Nov 2019 05:31:16 -0800 (PST)
MIME-Version: 1.0
From:   Robert Blenis <rblenis@gmail.com>
Date:   Mon, 25 Nov 2019 08:31:06 -0500
Message-ID: <CAPbTjvcPCZG---tkyQW8dCd5=LYhGmhpYg5MQSX5BPr+HEG2jw@mail.gmail.com>
Subject: git rebase with rebase-merges option creates bad ref names
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

using command 'git rebase -i -r DEST' fails with "error: refusing to
update ref with bad name 'refs/rewritten/Release-170-1020-Rev-D.'"
git is taking the commit message and turning it into a reference name
that is not valid (because of the period in the message)! This
requires a bunch of manual editing of the todo list. git version
2.24.0
Thank you,
Robert Blenis
