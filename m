Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD57C43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 14:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 260F9206D4
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 14:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="gSJISSWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgIROQT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 10:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIROQT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 10:16:19 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E19C0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 07:16:18 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id p15so2920176qvk.5
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 07:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OtjUg6yyah5wt1Vyd2UHe0001S3jNWNsZhT8KDd1SKs=;
        b=gSJISSWuY1N7pO5p4qauGXtrwXzE8rFOQqG/WOiT8ncHCKspB9snASU1yYJ2tfGCTR
         hS0W3fw/7aCs6WRjThEBtsOW3mOH8AFolTgkjfFkJSpdJpfXMClKATPENwI6/zEh1ZCE
         Tw+7j760Ghnx7/K1sJQyEYqNXvMY1VGIHDLLXsuq86TAHbN5fj+7uovaPw6Y6IFKskWj
         EwttcyxI+n8BxPF3YllspFTDcS62a/Jk7OCjK3g1l3g+lxCaSZjVRgi2BBT9abtbOnHp
         ZGehmMKYX8H42mGfmV6BkBZ8dW2z7uEnh8Lpy/+PuQmFPopUrf1ej0m53kcou8OnkhK2
         UbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OtjUg6yyah5wt1Vyd2UHe0001S3jNWNsZhT8KDd1SKs=;
        b=Fh4EnupEI8YzSM6F/bIkidXLXo6iZIoi6GrrawCe2y9DhFhYWNdRR+Wh4CgTXJi5jO
         StPUTYmYTPHr6B+YqZMbFqLhhwRXjSsSwhjJ/XG54cDTCXsbbWk0fy/G2a6nZsi4J2uU
         j8BouqEjQ5CMeNCQ5iS/MtL/a+17SZHR+IDXl564yveEsLO9nnlhZQmdjWPlIgd/P/2M
         2B6mq3MO6K14cx30r9r95/WNjtkgV41vkdGFTK0jqKENMjPPozy2vQk4Cf39swHfAPmW
         2LrKw0ADvl9VZaRbgaE/s2hEoLlh3zClhtKN8FbeHSg3CM22LnWuDUF+lGue8+h7GWNi
         UGUw==
X-Gm-Message-State: AOAM532YiQXyBjZ2HCPmwtomGcmNViWL6OA+UOzqAyoNEb3VQsViL+bn
        q96AZzngq4ZUYwKeKl1KqyelZQ==
X-Google-Smtp-Source: ABdhPJzZnkxm7SVUYoFqpavKA/T48C5lp7cuaSzzFwoAC1eXM8dGs2ys5MrhmDFfs4mrQQuo9EQ1AA==
X-Received: by 2002:ad4:52e3:: with SMTP id p3mr16615337qvu.42.1600438577911;
        Fri, 18 Sep 2020 07:16:17 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:2003:d617:ca70:4fd1])
        by smtp.gmail.com with ESMTPSA id x49sm2229899qtc.94.2020.09.18.07.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 07:16:17 -0700 (PDT)
Date:   Fri, 18 Sep 2020 10:16:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/4] builtin/rev-parse: learn --null-oid
Message-ID: <20200918141614.GC1602321@nand.local>
References: <cover.1600427894.git.liu.denton@gmail.com>
 <004f2e4c92918a7a4e452d49e98ef15f1c5ac545.1600427894.git.liu.denton@gmail.com>
 <20200918141125.GB1602321@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200918141125.GB1602321@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 18, 2020 at 10:11:25AM -0400, Taylor Blau wrote:
> Hi Denton,
>
> On Fri, Sep 18, 2020 at 04:19:03AM -0700, Denton Liu wrote:
> > When a user needed the null OID for scripting purposes, it used to be
> > very easy: hardcode 40 zeros. However, since Git started supporting
> > SHA-256, this assumption became false which may break some scripts.
> > Allow users to fix their broken scripts by providing users with a
> > hash-agnostic method of obtaining the null OID.
>
> I have not been very involved in the hash transition, so please take my
> comments with a grain of salt (and if they are misplaced, feel free to
> ignore them).

Same disclaimer above applies here, too ;-). There are a number of spots
in the test suite that reference 'ZERO_OID', as well as OIDs for the
empty tree and blob. Maybe the definition of those could be updated to
use any new flags you do/don't introduce?

I'd be just as happy if that were to occur in a different series than
this, since I don't want to hold you up by adding a bunch of new things
to your list.

In either case, I think '--zero-oid' makes more sense than '--null-oid'
(and it matches the tests that are already written). The pair
'--zero-oid' and '--empty-oid=<type>' make sense to me.

Thanks,
Taylor
