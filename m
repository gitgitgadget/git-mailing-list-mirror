Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3E2C433E0
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 05:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 543D52076A
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 05:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Auks6v29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgFHFuO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 01:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgFHFuN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 01:50:13 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CDBC08C5C3
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 22:50:13 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ga6so5288559pjb.1
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 22:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=80tR9XvDGVZqBW6DSoygkvsTesRwGdvrFLW+lnooHvs=;
        b=Auks6v29R+YDTphhmYWetM3IXCli4+eTw9ZbNYYa88F4SYtJaSyJW3vM+ecSv+mdzF
         B1RhdoNiLp0aqR87AxetNjvHM+cN4iOkyy0P3VE4fuCjMJ8zQYRWMNcpT9G5Fho1BS42
         4jO4P+VLx+9gSXjblU09FTTUqs01Qp7JmkjjBNlG/5qmayiUiYwGf7u4U+ofivdSX6vb
         A2t/xBw2eijvpd504qQXlPCKqIZpBRFyvkdkZ4RWmyS5sAyUJXBpSTe9CJGxCwNu0yAU
         JeyyaRUu2i69BPRizhArQsCYlMbdRVgd67+fsXUdTcsB9IenMYNp2RrXtoRBOrLFdPqD
         xStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=80tR9XvDGVZqBW6DSoygkvsTesRwGdvrFLW+lnooHvs=;
        b=XQmFkpXgA5Qtz4HwU3FLeaAeE7bIHw5jzrwxZsyMs8rA2hoPmKuDv+wuR7hSEq1SlP
         QDmxjJeydncuMPFac126aqlrG9T0DPjWAfOOBXZSEPCIdbzbMhrRaDFf+ZmWDao320Ib
         hZHBR+7YMjsye7JcdNegsKWGF+mQ0Y7l42knJULN4dEVyH7MgOlZ2JjknHT1AmVhjWqE
         5qGPEqC+cBIXi57H/+xHfsqwT1pHaOGNVgHbQXsOsjcdhoqKTDRlJgjXEnShcvVmbCQG
         0C2bgxRBofG2+X5PqmEasXIafxe4BypX+WvFfRUbKz5IXk7LeWNZrw8FjijmqLl6lWzF
         AtzA==
X-Gm-Message-State: AOAM532WsHIGtwLXCcX0MoJHYkmBfIjovy5m0AvfWCW9BNgcHRZNslGQ
        rWFQLrat+PzfKo+gjK/QQ30=
X-Google-Smtp-Source: ABdhPJxLYnD2BmNGZVeo3b2jKBQ9Funi+xXK+iXKtSQVewr4EDLh93MQvoaFVgBW6xhEgRr4nuRfOw==
X-Received: by 2002:a17:902:b286:: with SMTP id u6mr19153967plr.264.1591595412727;
        Sun, 07 Jun 2020 22:50:12 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:58e:925f:60d1:f386:43d2:4abb])
        by smtp.gmail.com with ESMTPSA id q68sm15149672pjc.30.2020.06.07.22.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 22:50:11 -0700 (PDT)
Date:   Mon, 8 Jun 2020 11:18:27 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     stolee@gmail.com, jnareb@gmail.com, git@vger.kernel.org
Subject: Re: [GSoC Patch 0/3] Move generation, graph_pos to a slab
Message-ID: <20200608054827.GA2054@Abhishek-Arch>
Reply-To: 20200607195347.GA8232@szeder.dev
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
 <b850637d-a7ca-e8f9-5009-657096ea2975@gmail.com>
 <20200607195347.GA8232@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200607195347.GA8232@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 07, 2020 at 09:53:47PM +0200, SZEDER Gábor wrote:
> On Thu, Jun 04, 2020 at 10:22:27AM -0400, Derrick Stolee wrote:
> > On 6/4/2020 3:27 AM, Abhishek Kumar wrote:
> > > The struct commit is used in many contexts. However, members generation
> > > and graph_pos are only used for commit-graph related operations and
> > > otherwise waste memory.
> > > 
> > > This wastage would have been more pronounced as transistion to
> > > generation number v2, which uses 64-bit generation number instead of
> > > current 32-bits.
> > 
> > Thanks! This is an important step, and will already improve
> > performance in subtle ways.
> 
> While the reduced memory footprint of each commit object might improve
> performance, accessing graph position and generation numbers in a
> commit-slab is more expensive than direct field accesses in 'struct
> commit' instances.  Consequently, these patches increase the runtime
> of 'git merge-base --is-ancestor HEAD~50000 HEAD' in the linux
> repository from 0.630s to 0.940s.
> 

Thank you for checking performance. Performance penalty was something we
had discussed here [1]. 

Caching the commit slab results in local variables helped wonderfully in v2 [2].
For example, the runtime of 'git merge-base --is-ancestor HEAD~50000 HEAD'
in the linux repository increased from 0.762 to 0.767s. Since this is a
change of <1%, it is *no longer* a performance regression in my opinion.

[1]: https://lore.kernel.org/git/9a15c7ba-8b55-099a-3c59-b5e7ff6124f6@gmail.com/
[2]: https://lore.kernel.org/git/20200607193237.699335-5-abhishekkumar8222@gmail.com/

> 
> > >  create mode 100644 contrib/coccinelle/generation.cocci
> > >  create mode 100644 contrib/coccinelle/graph_pos.cocci
> > 
> > I appreciate the Coccinelle scripts to help identify
> > automatic fixes for other topics in-flight. However,
> > I wonder if they would be better placed inside the
> > existing commit.cocci file?
> 
> We add Coccinelle scripts to avoid undesirable code patterns entering
> our code base.  That, however, is not the case here: this is a
> one-time conversion, and at the end of this series 'struct commit'
> won't have a 'generation' field anymore, so once it's merged the
> compiler will catch any new 'commit->generation' accesses.  Therefore
> I don't think that these Coccinelle scripts should be added at all.
> 

Alright, that makes sense to me. Will remove in a subsequent version.

Thanks
Abhishek
