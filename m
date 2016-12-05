Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD1DF1FC96
	for <e@80x24.org>; Mon,  5 Dec 2016 20:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751161AbcLEUOf (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 15:14:35 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:33747 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751437AbcLEUOd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 15:14:33 -0500
Received: by mail-qt0-f172.google.com with SMTP id p16so325019977qta.0
        for <git@vger.kernel.org>; Mon, 05 Dec 2016 12:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8ohbtuc91xugLW4xikByk6jdE3i1ymR51FujAw0Dh5k=;
        b=QniilJNZEd+RNHY0UZU3JUBuNgaJpp2NUCsiH/s4oHOBFu490dOI1HlnkL27DEpJSM
         zTEADIhNdoMLj5MpiIccYeTQ4xFBksax1agsccQzLG+e47bTy9bP4wZBHPN0R/SBTqYG
         93CgGVP6pKTbi2Fs1x06ygDizHoDr/WGkGHq6oTnhcTtsrz8l5eMNOcdtddRg9AamgP6
         fhW8vzKMIw4I80bJBNtd8H3bU6yfcUgmSCQyvAE/SsKlisxZa4OdTX6S/GoscmtGOuLA
         Byku37IR6m4uEBiVhyxCa74ylOAP7RTJimRyYcKNus2x5/1WxNt69MmSLmNAAhx1X4qd
         hddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8ohbtuc91xugLW4xikByk6jdE3i1ymR51FujAw0Dh5k=;
        b=iMdMdrt0e2KVYgEuusRYRUU8IV+wea5L1Gznfif3/Kb1WoPK2Z9b1QLBhU45apxULW
         pq0/sXz0W9VHsi/F1DhbMc3AvEfatj8YKoQlY03Iz0lEXAu4ZkRjL2lMiExFKH+xG8Dx
         oGLZSOop2LQ8yPhJW6NkCIIhPQes2FQlQ3+5VB2o8pG4fcjNtCLFQIrbtymmF/BSmL0l
         sCsWSRNCBveB1Fx51PmqMJt+1aioCm80IWMj4PUcRtbmvi8hSq4d6ryMIvo+4zCMU+8R
         f4BqhOPcF+EAUMjlVHN5COgyzl+7GHizklNY6+pyXrxst5v5i0xBMx+efg5927XqFImA
         QW9A==
X-Gm-Message-State: AKaTC02fBwW7v49P1ra4bKvzZpELsPsa7JSooviKLY3UM2+qSfNWehDECFIiv91GN5Ilnue9kbw9PJ8EyS+tpxBk
X-Received: by 10.200.37.221 with SMTP id f29mr57199867qtf.123.1480968856765;
 Mon, 05 Dec 2016 12:14:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Mon, 5 Dec 2016 12:14:16 -0800 (PST)
In-Reply-To: <1480964316-99305-2-git-send-email-bmwill@google.com>
References: <1480964316-99305-1-git-send-email-bmwill@google.com> <1480964316-99305-2-git-send-email-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Dec 2016 12:14:16 -0800
Message-ID: <CAGZ79katWewdwU3ZDYDj-QZEeersx9XDPZuTdMJG_u_62YwMsg@mail.gmail.com>
Subject: Re: [PATCH] real_path: make real_path thread-safe
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  static const char *real_path_internal(const char *path, int die_on_error)
>  {
> -       static struct strbuf sb = STRBUF_INIT;
> +       static struct strbuf resolved = STRBUF_INIT;

Also by having this static here, it is not quite thread safe, yet.

By removing the static here we cannot do the early cheap check as:

>         /* We've already done it */
> -       if (path == sb.buf)
> +       if (path == resolved.buf)
>                 return path;

I wonder how often we run into this case; are there some callers explicitly
relying on real_path_internal being cheap for repeated calls?
(Maybe run the test suite with this early return instrumented? Not sure how
to assess the impact of removing the cheap out return optimization)

The long tail (i.e. the actual functionality) should actually be
faster, I'd imagine
as we do less than with using chdir.

Thanks,
Stefan
