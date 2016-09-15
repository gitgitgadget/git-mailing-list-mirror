Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EDBD1FCA9
	for <e@80x24.org>; Thu, 15 Sep 2016 05:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755693AbcIOFBI (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 01:01:08 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:35666 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751075AbcIOFBH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 01:01:07 -0400
Received: by mail-vk0-f51.google.com with SMTP id h134so10233278vkd.2
        for <git@vger.kernel.org>; Wed, 14 Sep 2016 22:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=w1lSDH9rd9JwVks+mxtrILlBnwrrp6m62+8MhSpbN/E=;
        b=fI3QwSgzHPFq6mmXbCx3BNmD4L65FhFybPly4sAdtuRvgZzh+BPibecP8ZPqnhNxl1
         xHpqtD0zIlSUGaP3cBBMjCmDpy2RJv1xy1cTuxpKcuZzw7JCT68j5YOkmCsdFjCyv/JC
         9xYikpp5qfEO8r14i2gjOZihOH5tPrHQjJA6lW0OKL12vaUhzy1xrv1r5ntXxWJs8dZn
         hiED6E1HeaaqO4s/M+VKELWdOzvpQoByKCLJ1XH3pRyoY9K24VnpOHb2O9oJvyqaJ+qC
         AGFYGwG5UC3p8+SRTpZoTn+tisd4V5vQ3Erodq+uyWLcrHkj4dLla/UUOMuSJK3jUZP2
         Zeew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=w1lSDH9rd9JwVks+mxtrILlBnwrrp6m62+8MhSpbN/E=;
        b=P0GWOAdDFWk0Z6ESSCdxhNqI0+KzRRJ2cvACWVq3WbHqKrkr1myu1lJYp+ipRUeno9
         LurYGmk+Inz5uxZ+HN04MP7i5ROKVBfm1LQVhWVxAetcQMFxnYSkw96QAREVWpCrrAn8
         ZFBwil9xgCXnCaywKz480Ad8aIkFkqBd4BbDV8h99NXvfh0KyEqy5VC9AfWI81z8ab3M
         cI7dCbvbtEd1XiRQOnqFoKtDMQGWQSkFnXUwTZ3U9rEmlFDImIriIVjEkfu2C58BMH6l
         Ait97qxGrcJg0Gx4i23r+k0+QmLxmIG9pocLp87Fh7nYOf0lxFuhdF4xxQWkUgo41x8e
         MJmQ==
X-Gm-Message-State: AE9vXwMfJ+KOcI24fPoRwyYXBlQlv9/miyDzTM27nykx8QXpXwSlg3FQC4rEzQvDMEYL9+yYpdR5T+dysMJe0A==
X-Received: by 10.31.65.22 with SMTP id o22mr1435544vka.3.1473915666736; Wed,
 14 Sep 2016 22:01:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.254.74 with HTTP; Wed, 14 Sep 2016 22:01:05 -0700 (PDT)
From:   Aviv Eyal <avivey@gmail.com>
Date:   Wed, 14 Sep 2016 22:01:05 -0700
Message-ID: <CAGHT48L2s_nf-oSGPKrOB7uo5UAkCScNh+Ju5xH1dE5DFVnHwA@mail.gmail.com>
Subject: git add --intent-to-add silently creates empty commits
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I think this is an unintended behavior, but I might be wrong:

Using `git add -N` allows creating of empty commits:


git init test && cd test
echo text > file
git add --intent-to-add file
git commit -m 'Empty commit'
echo $?                                    # prints 0
git log -1 -p --format='' HEAD | wc -l     # prints 0
git status -s                              # prints `AM file`


I'd expect `git commit` to error out instead of producing an empty commit.

I've seen this with git 2.8.1 and 2.10.0.129.g35f6318

Thanks,
Aviv
