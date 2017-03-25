Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6AFF1FC19
	for <e@80x24.org>; Sat, 25 Mar 2017 00:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935440AbdCYA0J (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 20:26:09 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36626 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934689AbdCYA0H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 20:26:07 -0400
Received: by mail-pf0-f182.google.com with SMTP id o126so2229992pfb.3
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 17:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ygq4d7MetFTKR1DTwxbCko1Ajr6S//jaI7YA96URli4=;
        b=dVeYFGHButjIrgIrSZaxe/VydCWZOb97a22WKTKgyYHGJK4REUUpesIoNqFiT2RP8Z
         Mfd3BU77PAaXepDztbLc/zufFIcns727eQoBQnALk+2zMKCq7Frx6w++Rq68lVOMgceA
         H13BuFQKOXhHC2ME5o1XdE+CMCwar16ykJh+k72W319SgbHp6svFSgxAAB1kYzP3G29S
         3U9Y3OWiiNP5pNrc8Fbe+5K3EW8OWkDBUMGZ0KtR9oR/ZgpPC6MuIlusPrLeMPRxf6ck
         /JEdbjGAmuuuz557PDSvhP/sDOZYvSHzklwb1rm1fBdagK6W8XGOccR3uWcpqm2/taSG
         iJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ygq4d7MetFTKR1DTwxbCko1Ajr6S//jaI7YA96URli4=;
        b=H4FfueZboXaB7k0VQ8o/KaoLA/HsQGlDgmvNlx96T/Gt48NwPuGkNWnrbnwrnNIWCz
         T/XBA/NYMMrMKGHujnamarpseC5dgc/iFo1AS5nB6EXDrtEbtN41wDR319nVpxUqJaS0
         ytd60YDVmdcu2hMBqqw0OGBN7dbZby1Xla0ukJviERhpSTFXelB1YGHKKdhwghQ3ehc3
         uYkpAw1IuOiSbdcCx+j5afP0DBow//YOJMtyoymWUO0omw/eJKpx+U1miVY/rhPTN8Ta
         4wTpgVWZYsa3gIp1KLjB3rjhscYTkkjRcPRIe0EX5y3XjQ6mmYQz1izxXjGqOjv/Fk/m
         ysNQ==
X-Gm-Message-State: AFeK/H3Pp8qpqEKIob3ruLWq524u/HMJYNbu76ZzegwLojT1imMwX5hARAsPKvIwEG4Jq+OxxcLoKZg60mOaRx26
X-Received: by 10.99.137.66 with SMTP id v63mr11971983pgd.183.1490401542477;
 Fri, 24 Mar 2017 17:25:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.161 with HTTP; Fri, 24 Mar 2017 17:25:42 -0700 (PDT)
In-Reply-To: <20170324233156.GL31294@aiede.mtv.corp.google.com>
References: <20170323223338.32274-7-sbeller@google.com> <20170324182902.19280-1-sbeller@google.com>
 <20170324182902.19280-8-sbeller@google.com> <20170324233156.GL31294@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 24 Mar 2017 17:25:42 -0700
Message-ID: <CAGZ79kaYSMoMEQ8y+xwLT65suva_DY3ZWKfKSeCPPu2hgtYt-w@mail.gmail.com>
Subject: Re: [PATCH 7/7] submodule.c: correctly handle nested submodules in is_submodule_modified
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2017 at 4:31 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Can this overflow the buffer?  Submodule state is supposed to be 4
> characters, so could do
>
>                         /*
>                          * T XY SSSS:
>                          * T = line type, XY = status, SSSS = submodule state
>                          */
>                         if (buf.len < 1 + 1 + 2 + 1 + 4)
>                                 die("BUG: invalid status --porcelain=2 line %s",
>                                     buf.buf);
>
>                         if (buf.buf[5] == 'S' && buf.buf[8] == 'U')
>                                 /* untracked file */
>                                 dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
>
>                         if (memcmp(buf.buf + 5, "S..U", 4))
>                                 /* other change */
>                                 dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;

good idea, will use.


>                 }
>
>> +                             /* nested submodule handling */
>> +                             if (buf.buf[6] == 'C' || buf.buf[7] == 'M')
>> +                                     dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
>> +                             if (buf.buf[8] == 'U')
>> +                                     dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
>> +                     } else
>> +                             dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
>> +             }
>
> I get lost in these cases. What does it mean if we see S..., for
> example?

That means there is a submodule with no new commits, no modified files
and no untracked files. ("Why did we even output this?", oh because of
it is in either 2 (moved) or because the hashes are different, i.e.
we already added the new HEAD of the submodule)

>
> Some tests covering these cases with --porcelain=2 and a brief mention
> in documentation may help.

ok, will do.
