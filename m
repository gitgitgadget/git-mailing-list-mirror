Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B9AC7EE25
	for <git@archiver.kernel.org>; Thu,  8 Jun 2023 16:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjFHQYu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jun 2023 12:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbjFHQYh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2023 12:24:37 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B0235AB
        for <git@vger.kernel.org>; Thu,  8 Jun 2023 09:24:25 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-ba818eb96dcso842974276.0
        for <git@vger.kernel.org>; Thu, 08 Jun 2023 09:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1686241464; x=1688833464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Uu2BWGJAowbr6TVw3p9CGFuuKkX1jcRotYACStdQoc=;
        b=WrlIppztjA53vXKndVKhveBhxYME65AZ8BTYQHvMkk1beYbZjHbMhKk3Ygv13hZkbx
         wwJaF6iaGm7crak1sQslG1ybPScmK0iCPW0/nnTNHx5wChl8RlHw9Dhip82gkZZ7kS4X
         NuTbUEOu9w8XzTaWLa1xi87rvxCEOwv40QCiNGmwsLqPgsoWtlID0iyCawd6S1l8gGqU
         OjXy60W40qL74OTWn0rpRBkS5z9B8brBk5Km8KG6h9g3L+tcK72tiykTW3FUkDEV1DdP
         ze04iZzEzH38kWdeWA9qtPJlBOEsEaIdG/uT0QkoGBnp1HI4vmIwtpsO4cHAIz6KV6di
         Qd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686241464; x=1688833464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Uu2BWGJAowbr6TVw3p9CGFuuKkX1jcRotYACStdQoc=;
        b=YITeZRQCYyRHZD2muZYqkNfcGtjkozX95wiEg2QMSGSUN6SIonenknUtlggYzttby0
         KtWlGAobtCOhS13lVo2KZu4oRKMO0VJPCEYIFBodKKd7Xtzi4xy5TbAaeh10feaINdz8
         3JXm1sSCouTaTfvQL64azpqGFc0QWodIczla1VovktGdAjFRFwc1tG0MHT86N5Xl4EnB
         ADcR1TO0Bqy3O00Dco8hvZC5neT5WdVufz9vr25Cj6XbBK043tTRBb7oPTRE5MLcmrAj
         tjt7qpY5hbC9YeJWsapsZ77Og9xUIOB5XsZRBnZFuqRuYOdrY+QZSFHslXQn78I9vnF5
         w9pw==
X-Gm-Message-State: AC+VfDy2u5qS1gSXaaKeZw+fnoQ4tq5PnN1WDOTwgSEYtnMwx1UcUFBJ
        /KHvzQGleYpxTDv3fff3D5uPHn57fIbP9P6NKjLw/B9I
X-Google-Smtp-Source: ACHHUZ5rstC/2MhOUfcQF7VuP0JTMfZvKPM11n3FC9TabTMl5krgrFbbhGyEA4bJTdJ4QhQqlfEHSA==
X-Received: by 2002:a81:48d4:0:b0:561:e8e0:2e82 with SMTP id v203-20020a8148d4000000b00561e8e02e82mr155985ywa.30.1686241464146;
        Thu, 08 Jun 2023 09:24:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r67-20020a0dcf46000000b0055a931afe48sm25371ywd.8.2023.06.08.09.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:24:23 -0700 (PDT)
Date:   Thu, 8 Jun 2023 12:24:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] shortlog: introduce `--email-only` to only show
 emails
Message-ID: <ZIIAtO3kSaKkPqu8@nand.local>
References: <cover.1686178917.git.me@ttaylorr.com>
 <44179d28fa7676965a28734e20584d54b44e051b.1686178917.git.me@ttaylorr.com>
 <67c66cd7-fb6c-3fa0-82c8-0e778f377f96@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67c66cd7-fb6c-3fa0-82c8-0e778f377f96@kdbg.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 08, 2023 at 09:35:14AM +0200, Johannes Sixt wrote:
> A note from the peanut gallery: "--email-only" sounds like an option
> that affects the output of the command. But it does not (IIUC), there is
> no hint that it affects grouping and filtering. It is named too
> generically, IMHO. Can we not have the desired effect by specifying some
> token to one of the --group* options?

I had thought about the possibility of something like this since we (a)
already have lots of `%(trailer)`-related pretty formatting options, and
(b) support grouping by pretty formatted-commits with the
`--group=format:<format>` option I introduced via c112d8d9c2 (Merge
branch 'tb/shortlog-group', 2022-10-30).

Thanks,
Taylor
