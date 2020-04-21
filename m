Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949B1C54FC9
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 18:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7825920735
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 18:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/al+wgy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbgDUSH4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgDUSH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 14:07:56 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26A9C0610D5
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 11:07:55 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 198so11878143lfo.7
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 11:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=vWHXSrftlwMSDoJnQW/azPoDdq5FN10P6niEJVF4i9I=;
        b=j/al+wgydFlJh6Af1rDevMu4LMZwdgCMVf9/025j/gozNwIMQk1voTf8XsdH1MJzUQ
         IMcOMDpS6chgQV9SIAi6TM0QnJj3AK49EL9ytSnDIi1Tm8TCgAWMQjb8DPj0lYMR2lp4
         7FW253iCe7+scsXKe/LzbOz19J0a0l+/zI7kh7zwQyI94lMPPPcM4z6ENuCYD4802g+u
         MrNEgj7KIQQEnW0xu5/s5lGvEWH7FAQQNw5HckSq9+OYXd96QJHDx0OGzzSlLLgSUHIk
         kxGWFUB2WF7zVc4knrxJmnOGCSoqq0oRgteTfqekdkyvh9Oog+jTmQel0sUX5Vp5oeby
         RJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vWHXSrftlwMSDoJnQW/azPoDdq5FN10P6niEJVF4i9I=;
        b=fmMraSkl/7Ky5AAnEAbeVO4xwVs26Ua2UzDtjLjQDZ89Qpx3BmD5VrMWsutc0C3ts/
         lUU+nVGqvKKFMVe9YsXJiwQuS153QtTQyq0r2DZYWG3VylWXMNcJLa2ffEuXK5W3D4oY
         /dX6Vadd854ngU/mDxOwGtMBOckyVNICi7FiO7MM9o0aS72cbqYaaV8Daa5e21OKIgY8
         9B54YdIAgY+5cUpenBDkWccDHNEWBtsMYQxTaMefNG3nzziNB5k0iFKcPYFZsTQ6i72C
         gj5hS2pms5vGvslukiunIjO/3cCmC5fsE9+4ibqwyZ7QhH7TXWeGOFZwEsABeXiFEwpP
         coDg==
X-Gm-Message-State: AGi0PuZva7r0ekbMvtkE157ZZiI7Sv9IT4UKqfII6Sw0EJaQBTf6CdXd
        SBoX38UMWq4R7fvZlN742DjEqPc++Js48ysSvFg46blRlgw=
X-Google-Smtp-Source: APiQypIELJFvvsZftHBcBJikFFZYC9veZ4/Mdzby9TI9ZGp19LaHaLg6BB0gvIFtQ+8/7EBwUdckZcApONAKtHLhZoM=
X-Received: by 2002:a19:c607:: with SMTP id w7mr14566961lff.32.1587492473337;
 Tue, 21 Apr 2020 11:07:53 -0700 (PDT)
MIME-Version: 1.0
From:   Mikhail Strelnikov <mikhail.strelnikov@gmail.com>
Date:   Tue, 21 Apr 2020 21:07:42 +0300
Message-ID: <CAAihzVJTN5V3o_aFeUuJH_8+nqZrKHJww3vFQ9K5W0DtbeM14w@mail.gmail.com>
Subject: Multiple pushurls, different 'objects\info\packs'
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have a repo with two pushurls configured like this:


C:\folder\1>git init --bare
Initialized empty Git repository in C:/folder/1/

C:\folder\2>git init --bare
Initialized empty Git repository in C:/folder/2/

C:\folder\w>git init
Initialized empty Git repository in C:/folder/w/.git/

C:\folder\w>git add work.txt

C:\folder\w>git commit -m "Initial commit"
[master (root-commit) 1b314f3] Initial commit
1 file changed, 1 insertion(+)
create mode 100644 work.txt

C:\folder\w>git remote add origin C:\folder\1

C:\folder\w>git remote set-url origin --push --add C:\folder\1

C:\folder\w>git remote set-url origin --push --add C:\folder\2

C:\folder\w>git push --set-upstream origin master


I would expect those two folders (C:\folder\1 and C:\folder\2) to
contain exactly the same bytes. And they did for quite some time. But
now there is a difference in 'objects\info\packs' (and some of
objects\pack\pack-*.idx/pack are also different).

(all the commits are the same in both and all my data is also the same
and 'fast-export --all' yields the same result)

I'd like to know what might have caused this nondeterminism and if
there is something to do to prevent that.

(my current version of git is 2.25.0.windows.1, but I guess this
divergence happened several versions back)

Thanks.
