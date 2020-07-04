Return-Path: <SRS0=Nv7C=AP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40314C433DF
	for <git@archiver.kernel.org>; Sat,  4 Jul 2020 15:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13268208D5
	for <git@archiver.kernel.org>; Sat,  4 Jul 2020 15:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFNmswpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgGDPjl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jul 2020 11:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbgGDPjk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jul 2020 11:39:40 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C95C061794
        for <git@vger.kernel.org>; Sat,  4 Jul 2020 08:39:40 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id w19so2995227ply.9
        for <git@vger.kernel.org>; Sat, 04 Jul 2020 08:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CsBwNuOJO1TBz8KzN6VHgEsCcct2TtQ5OqvTenQIfWk=;
        b=AFNmswpT9XdG3NduR17qCk8i9HVc0M0CO07SWUahy479vLhrKeKJJuoBH9yKXdE9qb
         mXDlU0anf/SxpxE7emEnYr/BJeIHm69tQw0v3XmyGdEiIXoiaeAob+X8IEcWjodO2jCn
         IXYTuMxt6+kJo52FhI/x8Lkbi2j69htkgOPz5D19l4uQU9XgKDcKmfRY0yDgMqmSgiYO
         5UCafVYRDsa31xhOSh8PwpA6WM+qoAS8SeTEjsY0Ldw7GFCEommOVReDmRu8TU8NQi7I
         yqKlV/PvVqJXeY98xs7zWHXIzsNx3mrF/zaQ2offZZzYKNfy+LcLe31hP3SLTt+kHR75
         FUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CsBwNuOJO1TBz8KzN6VHgEsCcct2TtQ5OqvTenQIfWk=;
        b=AQOlyB/je+aQs1cxxlIohPQtG4kM+l1UYSfS4vufQMKzBgjn7UzauxPkAxYue0/6wR
         tYysyJXcE4ejzRDDNjsThw0GS5HXlYxsc6a8/D1Hq+TIKfJ1cH81bHU+4aOd5+JlzC5s
         wstZaWNKY15djgv8YTLx+bW+ZCI2BsmwpnnQ54qcIq1rkBwnTrSg3II/zwr0uEF1iiAB
         uR3GJGXl9QwxQVUd/IJA1jRfTLH2XN8zXt+YpbHN98gWLOAfV6uVlHyio8plVhPEigkI
         Dqm2TfNDBaaGyk2RzIAQSDmyuai/6a9pOqfpmUSWdZdfzgkzyrN3HuRjntNI8+wCkuvB
         z0Nw==
X-Gm-Message-State: AOAM533SmXrmNMj2RcUF4cly5CtGcygA/1V7Mo+m94xZG4t8nauUo2KI
        4ZKf/dj4fy3ecwk28tMjCZ4=
X-Google-Smtp-Source: ABdhPJzwGNPjsTxVwc/sja2WUH37Nf9cV9/fWeVUIt9lPkmQ/+DPS2TrMwyd8kCEeowOZ9koWplAEQ==
X-Received: by 2002:a17:90a:240a:: with SMTP id h10mr26056025pje.225.1593877180231;
        Sat, 04 Jul 2020 08:39:40 -0700 (PDT)
Received: from localhost ([2402:800:6375:9968:2644:616c:71ad:c7e6])
        by smtp.gmail.com with ESMTPSA id e6sm7176195pfh.176.2020.07.04.08.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 08:39:39 -0700 (PDT)
Date:   Sat, 4 Jul 2020 22:39:37 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>, git@vger.kernel.org,
        christian.couder@gmail.com, gitster@pobox.com,
        liu.denton@gmail.com, kaartic.sivaraam@gmail.com,
        Johannes.Schindelin@gmx.de, pclouds@gmail.com
Subject: Re: [PATCH 1/4] submodule: amend extra line feed between callback
 struct and macro
Message-ID: <20200704153917.GD4087@danh.dev>
References: <20200702192409.21865-1-shouryashukla.oo@gmail.com>
 <20200702192409.21865-2-shouryashukla.oo@gmail.com>
 <nycvar.QRO.7.76.6.2007031653570.50@tvgsbejvaqbjf.bet>
 <8a36a3cd-02a3-f4fa-7b86-0d4884c88449@iee.email>
 <20200704152104.GA45598@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200704152104.GA45598@konoha>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-07-04 20:51:04+0530, Shourya Shukla <shouryashukla.oo@gmail.com> wrote:
> On 03/07 04:37, Philip Oakley wrote:
> > 
> > Suggestion...
> > 
> > On 03/07/2020 15:57, Johannes Schindelin wrote:
> > > Maybe a native reader can suggest something that flows a bit easier? I am
> > > not a native English speaker, but I'd prefer something along those lines:
> > >
> > > 	Many `submodule--helper` subcommands follow the convention a
> > s/convention a/convention that a/    feels nicer for me
> 
> I did not get this one. Are you asking to replace "convention" with "a"
> only?

He probably meant put "that" between "convention" and "a"
Pull ed/vi/sed out and that try this command on that line :)

	s/convention a/convention that a/


-- 
Danh
