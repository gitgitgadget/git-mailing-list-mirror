Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6813DC4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 06:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 422A9611AF
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 06:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238574AbhHYGzU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 02:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbhHYGzU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 02:55:20 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041CEC061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 23:54:35 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id w68so20431882pfd.0
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 23:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=nWWryFHEuJVruxWJymTc0cV5eAP0Q/OKLKq9fTo6+jg=;
        b=dTVknbsRgUU2LD/arfqCw4bc8Y2sXsT5ubCILB+PO3eU+PEEQGO4+9Iak7wxRa9NIU
         4A5W3YWIUu4m7JKolFoWhfKRSzzdIKCeXokGRujDNIxAUecF6txYbRr1WczrIbNERkC6
         4a4a0mH1WNHDSBJJg4NPV7xwp2coUgiI5YAxRT7CwGuknr1Hgr5MijT9ncTPcgjN+Zkr
         2Z5YmhYe5hSs3DU5T/+nKTW5A2fFUWK5LOE5FKwx9OshutPGzPAxZqcw0qfLv3bYjKmj
         fVDRkT1TXW1pHPn9SISOCJPeDHB13ltAKXFk0lav5EUU0qmB1FeByexWfv7wFPyVTOut
         DqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=nWWryFHEuJVruxWJymTc0cV5eAP0Q/OKLKq9fTo6+jg=;
        b=iSdndzp1lS+ewo98tqbPNO05yUDphiSJyhxdSQcOvRP35B+XSie7HfeJhJP74hn2zb
         Tsns7HJAPYPjfq8lpzLM5W1pYq1Ayy+uKp2iDKI8Cqtb6uFge55MDobt4MQetCLJhE3B
         gJPRRW9nREqfb1EWPZflLZ47M2ZmX0UMuLeQSJ1jz2I1wuT2EelapdOT7tQSC1BIu89B
         cn4EaPTWi7rOWzNNrHLs5254FcbwwYCR5SP3GMfzs4pR/tS30AKmuw9GRXt/v5is725w
         sh+wJvw/fcOW/6tlD/H37XNFk7OC5O/B/5LauDIIALlo8VZ9YzEttxxMrj49YgPKAMWq
         GsXQ==
X-Gm-Message-State: AOAM530l4r5kVipWizWVGHksVNKkatzQRHFro7qnc8PSNA0yfWhuIULP
        Yb34LvYbq/jJ7gCrH3mG7WglvPsuXJ+X+UtBtQ==
X-Google-Smtp-Source: ABdhPJyNiP8+bAlHUZc/fLJqm8ZuFX97q0BPca3ks42JcVhKMJp+pYxd37sKDNmH93w2KKr3PTuWRklNUqQoSa5VASk=
X-Received: by 2002:a63:2214:: with SMTP id i20mr40156965pgi.131.1629874474564;
 Tue, 24 Aug 2021 23:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <CANXojcyX2uqAp5gLtfH8ffQFQBKkMoPqSzpDUnbFe0QBd5nJqg@mail.gmail.com>
 <YSXY4WoB+Z1aayz4@alpha>
In-Reply-To: <YSXY4WoB+Z1aayz4@alpha>
From:   Stef Bon <stefbon@gmail.com>
Date:   Wed, 25 Aug 2021 08:54:22 +0200
Message-ID: <CANXojcyVGp0aXySZswzFtmWL=q17bP5Zz4Si-Gxb0rgx4TNjAg@mail.gmail.com>
Subject: Re: Get tree of remote repository using custom ssh library.
To:     Kevin Daudt <me@ikke.info>, Stef Bon <stefbon@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Op wo 25 aug. 2021 om 07:45 schreef Kevin Daudt <me@ikke.info>:
>

Hello Kevin,

> >
>
> Hello Stef,
>
> Git has no way of knowing what repositories might exist on a
> given server. They might live everywhere, and git does not keep track of
> what repositories are created on a central location, so there is not
> central directory to query.
>

Ok.

> Besides that, services like github do not let you remotely browse
> repositories over SSH, they only allow you to run git-upload-pack /
> git-receive-pack or equivalent to handle the git protocol.
>
That is exactly what I want. I know git works with the git-upload-pack
and git-receive-pack methods. I think I had to be more precisely.
Now my issue is how do I have to call these, with what parameters to
achieve the listing of entries?
(git_tree and git_tree_entry for example?? I do not know)

Stef
