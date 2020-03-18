Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08548C4332B
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 20:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF05D20775
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 20:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="au0WFe2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgCRUwu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:52:50 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:33250 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgCRUwu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 16:52:50 -0400
Received: by mail-wr1-f43.google.com with SMTP id a25so225174wrd.0
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 13:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=m5gIhfsrlBQuavdwGp8IMn/ZwCOiS2SCQsYCIX8/3hM=;
        b=au0WFe2nBOJvmfePf+HR4Vs5Xhnykw+/my0rLLq3sYEng+ouQEGJOuevIoVB/ZeJX9
         KAhN1cp1EMBYQVodyrxMH9CgXNRK6g9LwZovf+uj8eDDHX0K3lDkETtXLorTNRWmFjc8
         /X5qFUUijuHZVdTOYRei5ApsogzXA4MIN2OOAVRxLJcrJRLFsuh/1XhBZmOHQNUbkEOH
         hvkNVA2yA8YpFkQ+g2dPtzjFdO3pg0617mq0qfsRIKnEyvvZrV1/V17vsa4fKBxbINh3
         QKTh+pKS7buVGR22raX3wJ6Y3+66lGGga2v4iZoCqpoRANCsvik+iCYBrHbuVPZ0QRkc
         izjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=m5gIhfsrlBQuavdwGp8IMn/ZwCOiS2SCQsYCIX8/3hM=;
        b=CZ6ABd3Ypg7I6dit2oFneqoPM6vAt+x7NQC5fApvJXnZodOSXAw1mX6vOYvKR37v8m
         Js2IXuh8mx4nQfjHiw1lOSNGI0oV32hD3pc1o8WlJUjmDtTem4bW1svDPHSnusLymlCN
         WN6sx8Ukfh33mNmRSkF0C67d/bijiR4LWQaN+981xSnPy1P1p5ibUZEWFQXvR8KzbkXX
         KEylO3vIj9umSGJQ4LBeZx2662CV5WO8fG18Hbc3PsLcpwnoJC/RVMCSL280lTM1mzWl
         ZWvjIJWs4iz5tyYGYH3RgmTXSIKIxugyQkRl9we4Hj98NT0Yz3rx9U60RCB6DolkD0Pk
         3TvQ==
X-Gm-Message-State: ANhLgQ2Y+HLtsdo+EHiU14nM0eqBV1+unIew4C3nCp5VMWXqnqRI0P++
        kXUfDCVDEDhY6iRpy38rdYfK6YBI++0=
X-Google-Smtp-Source: ADFU+vu442B5Q7+6UlDeViWWOz1JMjA3DOgjvhrpEOF9HunamgUshUHtU3bYGBykx1Cu8rCZSarzdQ==
X-Received: by 2002:adf:84c2:: with SMTP id 60mr7671663wrg.399.1584564768315;
        Wed, 18 Mar 2020 13:52:48 -0700 (PDT)
Received: from ?IPv6:2a02:a210:ca2:9c00:299a:790d:ef4b:8b42? ([2a02:a210:ca2:9c00:299a:790d:ef4b:8b42])
        by smtp.gmail.com with ESMTPSA id w11sm12460wrv.86.2020.03.18.13.52.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2020 13:52:47 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: Broken Git-diff on master
From:   Son Luong Ngoc <sluongng@gmail.com>
In-Reply-To: <20BFEDB4-738A-4DD7-9316-8DE73999C633@gmail.com>
Date:   Wed, 18 Mar 2020 21:52:46 +0100
Cc:     Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D9C96648-26E1-46AE-AD79-123754371B30@gmail.com>
References: <20BFEDB4-738A-4DD7-9316-8DE73999C633@gmail.com>
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ah, how embarrassing, I forgot about --no-index.
Please ignore, sorry for the noise :(

> On Mar 18, 2020, at 21:41, Son Luong Ngoc <sluongng@gmail.com> wrote:
>=20
> Hey folks,
>=20
> I am testing out the latest changes in master =
be8661a3286c67a5d4088f4226cbd7f8b76544b0 and observe the following
>=20
>> mkdir test
>> cd test
>> echo a > a
>> echo b > b
>> git diff a b | cat
> diff --git a/a b/b
> index 7898192..6178079 100644
> --- a/a
> +++ b/b
> @@ -1 +1 @@
> -a
> +b
>> git init
>> git diff a b | cat
>> GIT_TRACE2_PERF=3D1 git diff a b | cat
> 21:38:36.615653 common-main.c:48             | d0 | main               =
      | version      |     |           |           |              | =
2.26.0.rc2.27.gbe8661a328
> 21:38:36.616258 common-main.c:49             | d0 | main               =
      | start        |     |  0.004075 |           |              | git =
diff a b
> 21:38:36.616307 git.c:440                    | d0 | main               =
      | cmd_name     |     |           |           |              | diff =
(diff)
> 21:38:36.616696 repository.c:130             | d0 | main               =
      | def_repo     | r1  |           |           |              | =
worktree:/Users/sluongngoc/work/some-dir/test
> 21:38:36.617589 read-cache.c:2303            | d0 | main               =
      | region_enter | r1  |  0.005408 |           | index        | =
label:do_read_index .git/index
> 21:38:36.617615 read-cache.c:2308            | d0 | main               =
      | region_leave | r1  |  0.005435 |  0.000027 | index        | =
label:do_read_index .git/index
> 21:38:36.617656 git.c:674                    | d0 | main               =
      | exit         |     |  0.005476 |           |              | =
code:0
> 21:38:36.617668 trace2/tr2_tgt_perf.c:213    | d0 | main               =
      | atexit       |     |  0.005489 |           |              | =
code:0
>=20
>> git version
> git version 2.26.0.rc2.27.gbe8661a328
>=20
> I think git-diff is broken. Hope that this get address before 2.26.0 =
come out.
>=20
> Cheers,
> Son Luong.

