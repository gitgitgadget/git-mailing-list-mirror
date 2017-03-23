Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CF6820958
	for <e@80x24.org>; Thu, 23 Mar 2017 23:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755860AbdCWXLI (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 19:11:08 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34235 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752008AbdCWXLH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 19:11:07 -0400
Received: by mail-pg0-f45.google.com with SMTP id 21so97572955pgg.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 16:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2TJxBsV6dr6tWMfww48sta2trwLds6Fhw03vTKBbrks=;
        b=imnhikso7xpMQiDYu1J1CqSiqgTL2agiSqN5fkqo+DTUYDouej+L0bSqwfpgyKxLFS
         Ub4TajiBLaK1FXeApbWxkEQzrc9ntRiJT/uyTUHVag//LCTeZYnNmInGGzYlRVp8FWW1
         utX8dGGW6OePS0SW2fHbKT+FIZtRawfA34PDabRHsnxjsX/pgWewRoK3jAxqxOC7lzh2
         5IVHcXP33mKU5DLFOaOkF2JOavJsdI+Bxdj7UMjRVDMTCbs4Zv98uCYNE6Bs+h24UHO6
         SA/soh5vi1QPs4Q3h+KYofksPBlswBfC/56nl953WE9eDnzhgt6CJludihGCAcDjSb4X
         Pvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2TJxBsV6dr6tWMfww48sta2trwLds6Fhw03vTKBbrks=;
        b=dxhm8BvgcrBUga3/92X0SAcdgzDA59w/F3QqIpPQYnKgcp3RVLRy5CbQT515KRCig2
         jBckRmF/5k50APbraWfIDSGP5wVG4L+NoGuopz6cAnoNoVbolGsUAgwvBcFtGsNk+SN4
         IFjQ9k91Oc17hwHrP21ekIoZ+cfuJ2QnKICr5hapiqN6iWCbBK9M7uE1D8CJO5gZOXB2
         yU0bwsshylPDoeUM+JxOqMIjPwvMPM2ol9/eETIreGB4ypVmNQHz9PohmF6BEpHmMzON
         4cWsR0PFemOIMRwnXLUg7VLzvAXXQaR2AhAo9uVxEhyliBwJc+oLp0riJ5+f29rHfQGa
         tPNw==
X-Gm-Message-State: AFeK/H2J4Lfx9Mj97BZpHJUVFiaEWWIxvB8GuhgstXf2sfcNz8IgJuDjKgdf82G6APIYNYF8++vnkeyDin3m8n0Q
X-Received: by 10.98.20.8 with SMTP id 8mr5798822pfu.10.1490310665840; Thu, 23
 Mar 2017 16:11:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.161 with HTTP; Thu, 23 Mar 2017 16:11:05 -0700 (PDT)
In-Reply-To: <CAGZ79kYPdGVBUnTgGyiBB5ApC9eS14p7n1QjEWApSrmF38t9Rw@mail.gmail.com>
References: <CAGZ79kZP6JhgcFQ5+Ytc6LexpA7C4EwR-7C0QZkiWhfrRCpd6g@mail.gmail.com>
 <20170323223338.32274-1-sbeller@google.com> <20170323223338.32274-3-sbeller@google.com>
 <20170323225019.GD20794@aiede.mtv.corp.google.com> <CAGZ79kYPdGVBUnTgGyiBB5ApC9eS14p7n1QjEWApSrmF38t9Rw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 23 Mar 2017 16:11:05 -0700
Message-ID: <CAGZ79kYkqgY8n=C2ms8rsaRz9iZ66p_YXDfm9tR=MymuH-HHPw@mail.gmail.com>
Subject: Re: [PATCH 2/7] submodule.c: convert is_submodule_modified to use strbuf_getwholeline_fd
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 4:04 PM, Stefan Beller <sbeller@google.com> wrote:
>
> We could have had closing before the child finished before as well:
> * the first read happens with strbuf_read(&buf, cp.out, 1024);

The 1024 is only a hint. So it actually reads the output in full.

So I guess I'll come up with a test for SIGPIPE, then.
