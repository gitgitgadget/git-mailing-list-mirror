Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BCAC43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 16:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F5120757
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 16:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvQpYdE2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389510AbgDBQAc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:00:32 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:43058 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389294AbgDBQAc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 12:00:32 -0400
Received: by mail-qt1-f171.google.com with SMTP id a5so3659282qtw.10
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 09:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jCBbdamF+GUtIeDIBKYB3I35pCZYUTfNhNsLxhD3ujM=;
        b=QvQpYdE2jIAiURl6bJbEmtoT0BKYJHcYca9TOwHmXJ53EaJpF4iKu8poIySL5BcclQ
         QzS/caYBvpO6l6gs8AZmZF5nmCl4VE/lVf3SCgbOCgHZVShUUjceO9wrPuh/954elGJg
         /x02RcuBfq965Ih2ynlw8Lz0Zk9hLmKTLxxhlEGyDYc43F0m0TbHNWfkKN6AzPWB93+p
         kH8g9+85zlNBL0dxvAS2usVYduNOEfLZ3qiJoyBwxGR8b0S6rS+U8odZZHiytp223C3Z
         a3yU0yWWBehcst1qH2sWbgdp1ecURlYlBKSAsdlF13Z/kwrgJW0s+Fa5EttB5lStAc/W
         xYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jCBbdamF+GUtIeDIBKYB3I35pCZYUTfNhNsLxhD3ujM=;
        b=i9lXaDcnfJnDsuCO/oCNj2zc6D8pGknb1QemfkucRtt+YFCz3EwmaTN23at+3Zz5EM
         hRBS9FLIU6EsEbv5n/zsmjpiGHB56+IAT36pkzyiSIGjRmjwLyDNZzuKvmxMa1FCDVws
         R3DqBgUvzH7wrsCmGhlFddeMgePZ7xUILPQYY0AInywMeVOT+o2SmKYAF212bi4k5rl3
         v1yog75gB9+CgqmJAYs85LUqo8gbyMzKZx2SeUbcriIw/JC6pV7ryAE0ZD8HRqe0Tv0Z
         B9YyuQQ0uNWDfDj0iNj9d6+f4XuPN9R4vsKEZYs4731e+i6AtfV69RY9lSvuGOajGmdr
         Sc5Q==
X-Gm-Message-State: AGi0PuZ/mmTYBlFl5Nu5KRLupKUr5jgM2JUc7gM7Og6byqq8EBXRkhpt
        f+PLj19SUhREJH1wruYVX+Cx89+R
X-Google-Smtp-Source: APiQypLSdvK8bqdbbfKx1YO1zKAJrHta5zaeAs5OabCwybfdb5Sdi45YhR15vSo1YGaDB7vHD7ghLA==
X-Received: by 2002:aed:2402:: with SMTP id r2mr3678241qtc.131.1585843230864;
        Thu, 02 Apr 2020 09:00:30 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id s4sm4053548qte.36.2020.04.02.09.00.28
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Apr 2020 09:00:29 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: git rebase backend change: post-checkout hook is not ran by 'merge' backend
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <9945492E-1D97-4741-B999-F30CA561D4DE@gmail.com>
Date:   Thu, 2 Apr 2020 12:00:28 -0400
Cc:     Elijah Newren <newren@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FB0DFFB4-0E6B-4C1E-96AE-9869752BB50B@gmail.com>
References: <9945492E-1D97-4741-B999-F30CA561D4DE@gmail.com>
To:     git <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, the last rebase command is missing:

   $ echo "echo \"Running post-checkout hook\"" > =
.git/hooks/post-checkout
   $ git checkout -b <branch1> <commit2>
   $ git rebase upstream/master --apply
   First, rewinding head to replay your work on top of it...
   Running post-checkout hook
   Applying: <commit1>
   Applying: <commit2>
   $ git checkout -b <branch2> <commit2>
   $ git rebase upstream/master --merge
   Successfully rebased and updated refs/heads/<branch2>

> Le 2 avr. 2020 =C3=A0 11:57, Philippe Blain =
<levraiphilippeblain@gmail.com> a =C3=A9crit :
>=20
>    $ echo "echo \"Running post-checkout hook\"" > =
.git/hooks/post-checkout
>    $ git checkout -b <branch1> <commit2>
>    $ git rebase upstream/master --apply
>    First, rewinding head to replay your work on top of it...
>    Running post-checkout hook
>    Applying: <commit1>
>    Applying: <commit2>
>    $ git checkout -b <branch2> <commit2>
>    Successfully rebased and updated refs/heads/<branch2>

