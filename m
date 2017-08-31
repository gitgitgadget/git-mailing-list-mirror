Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02CC2208E4
	for <e@80x24.org>; Thu, 31 Aug 2017 17:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751858AbdHaRoa (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Aug 2017 13:44:30 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:36360 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751811AbdHaRoa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2017 13:44:30 -0400
Received: by mail-oi0-f45.google.com with SMTP id t75so2747414oie.3
        for <git@vger.kernel.org>; Thu, 31 Aug 2017 10:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=opVHHQcACajfB/3sXxi2JMAfEJ0Mt1tbDwshRU869Wk=;
        b=mu4oUEu9VKyjVI7DYYxSoUdVRPvQ/tYPdZmT/G/jJxCPZf4+MKYiTky2/G/nuRnDGK
         LCXtW72Uys9g1EqmPzNvnLZ9gVedq2xv0AGaeVZuyoLLpxUYqCfRKCZvgFXez6OoCqOx
         iGwF6ZrJdcojgqR7JgQYHkBHLz7W6l6hDmqwjlfgujT5bG3y5HT4I5Ld+Kl/QTCCXhCd
         uMIG+N5ebnpzLtVAAWHu/n8Ca3CVy8G8Px0f1TXDDSdw4WZSrJL16O+U1c/glQVYOAQ/
         VP85nlVAEqrhb4ImBpSMKZ1CBkb/IUIntN+oZPqMW5P3A6/+eOeQ0tc6l4JdFvPJPtPC
         bvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=opVHHQcACajfB/3sXxi2JMAfEJ0Mt1tbDwshRU869Wk=;
        b=GmD2mmEe2+Vap2eKRGBnw1ZcbpNm29X3JSUmUBJ1veMqPpzMWLWRum43hNtMeaYkhi
         icMmA4QlsPVzMHOAfF9tZwpktIqDiflSo9/WV4MQs5tympZFMR/1ayCV2tPe0hOkN8q3
         6SrJfCkY4+WhbotarOZHvvCTHFP54twPbYr8ZHLTN0udPr3i1kWF9Jlmu5TbTU6Ua/gD
         V7Zv76pmc4kvGrztpjM+jHQ8wLNJxmG2pgK7QO7yZZAJhDWWFawBZJ9kxzY5WPCJdEUv
         m9HPcnJ9y1saljOrRtrjpyefCr8KXFWWs/dmoWnY2NK3YMgwFvva9l97xH+SRtbKCwjy
         d0QQ==
X-Gm-Message-State: AHYfb5in4Gt4wjO+5R2SRaSwBZTFs5JSOmfMYrCAE2u9UrDqmtsEeWys
        zyTwOJ8BXH3Kq1VJe1EujfqSFgYRYn47
X-Google-Smtp-Source: ADKCNb5ImISHYmv1jUW0v5ypn8xOOFpU7igp77kvYACcah0v2Wn0gaXBJ8d6945igGEgjs2wd4tMiY7FzmSyW/DSy40=
X-Received: by 10.202.77.141 with SMTP id a135mr7201628oib.288.1504201469154;
 Thu, 31 Aug 2017 10:44:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.14.141 with HTTP; Thu, 31 Aug 2017 10:44:28 -0700 (PDT)
In-Reply-To: <20170830175005.20756-9-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de> <20170830175005.20756-9-l.s.r@web.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 31 Aug 2017 10:44:28 -0700
Message-ID: <CAGZ79kadsNTyChYScPEShqAm_TNuSfXS_N8xO3PccsgaDEF-bg@mail.gmail.com>
Subject: Re: [PATCH 08/34] connect: release strbuf on error return in git_connect()
To:     Rene Scharfe <l.s.r@web.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>         } else {
> +               struct strbuf cmd = STRBUF_INIT;
> +
...
>                 strbuf_addstr(&cmd, prog);
>                 strbuf_addch(&cmd, ' ');
>                 sq_quote_buf(&cmd, path);

...
>                 if (start_command(conn))
>                         die("unable to fork");
...
>                 strbuf_release(&cmd);

Here I reread the cover letter, your intent is only to fix memleaks
on non-die code paths. Ok. (unlike the grand vision of an
"always valgrind clean program")

Thanks,
Stefan
