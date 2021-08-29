Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754F4C432BE
	for <git@archiver.kernel.org>; Sun, 29 Aug 2021 09:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4075B60F38
	for <git@archiver.kernel.org>; Sun, 29 Aug 2021 09:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbhH2JQm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Aug 2021 05:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbhH2JQm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Aug 2021 05:16:42 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C76C061575
        for <git@vger.kernel.org>; Sun, 29 Aug 2021 02:15:50 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u9so17601350wrg.8
        for <git@vger.kernel.org>; Sun, 29 Aug 2021 02:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tOPCkHxgCD2Y/xQNxgy4umc1NE8uqH/6Zha7OIqm4sY=;
        b=B2ilS05FssEllXuK7zKEGTVlJFKtLSoqi9AhADoTlmcwZ0eeWv/28hT+Fb0q893Hn8
         UcQpiz6PBBjaHPYgwO+EryfjCB10ZJcy9oXHFJnJV5LpgTOCC+LYa/82CB04p7j5mdkt
         m/mi1ZkhPu8IvyIxmCxKnv6WSnpMc8qcLM67SG+w7+mtsWHmuMOB4edMQJUf/9rJzefb
         XBKDIbLEH5yMwCceH7r2ZbxVkFxK3lPNMBm6NW8CditupBjayzBboxSxjqA0wU9r+0K/
         ckRY72PG0G7IT0FZKGtNPX31SYolpH4NZbcliqs1gp+0IEqRHTizHkt0+hBc4t+5sG0R
         LeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tOPCkHxgCD2Y/xQNxgy4umc1NE8uqH/6Zha7OIqm4sY=;
        b=eL3Mio4a1XlwQBAhzjStKolsUuQZ6EG8RD1Cwz6jLjHW+Hwxc53CvkJ+v8imDPxMo7
         Ml0IbGKcZap6KjrkLeI0Pd0MSnqWwBn3whvFw2ahG/EIexQOGZus0XNDwhfCcxiiW4wD
         s78u7TwlMVNjCHbzyAWUVGBFAPji7fs4mvE02brBuSjeUg3/QVZGylpE1htfazhos7HT
         ZOt/+iWZn1R8BEd+9041uOTF6M+8dsUwnlXN3nZj1CzMf5u4UGN74H2m824zYF0DPylW
         W8+GlgT45L7mIZ1FAUpKpqyWCPJQF44yi075ppeEuCJC0m1GrmlFGfsLai4nuBNJxqEu
         bOBw==
X-Gm-Message-State: AOAM532I9U75cwHg35hZ+X+8eJr1rHmUYT6cszOPPKkpXOUc/ZXAUlu8
        5JMy37wSqbo3k+7X4G1eDOQ=
X-Google-Smtp-Source: ABdhPJzmcwLsMYPHTpWhN/II/587mKT5iSnAWUXdtRR7vB2Zc43l4mBOlxPtMsVQRFasJJDCsnDYaQ==
X-Received: by 2002:adf:e809:: with SMTP id o9mr20032439wrm.425.1630228548713;
        Sun, 29 Aug 2021 02:15:48 -0700 (PDT)
Received: from szeder.dev (84-236-78-211.pool.digikabel.hu. [84.236.78.211])
        by smtp.gmail.com with ESMTPSA id q195sm10740167wme.37.2021.08.29.02.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 02:15:48 -0700 (PDT)
Date:   Sun, 29 Aug 2021 11:15:46 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] test-lib: set GIT_CEILING_DIRECTORIES to protect the
 surrounding repository
Message-ID: <20210829091546.GH2257957@szeder.dev>
References: <20210828121329.1971762-1-szeder.dev@gmail.com>
 <CAPUEspg43gxRiVydtaYdM06ObQGYUVn6oThjg1VTR+EfsxRVjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPUEspg43gxRiVydtaYdM06ObQGYUVn6oThjg1VTR+EfsxRVjA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 28, 2021 at 12:56:24PM -0700, Carlo Arenas wrote:
> On Sat, Aug 28, 2021 at 5:15 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index abcfbed6d6..a1e0182c2f 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -1343,7 +1343,8 @@ fi
> >  GIT_TEMPLATE_DIR="$GIT_BUILD_DIR"/templates/blt
> >  GIT_CONFIG_NOSYSTEM=1
> >  GIT_ATTR_NOSYSTEM=1
> > -export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_ATTR_NOSYSTEM
> > +GIT_CEILING_DIRECTORIES="$GIT_BUILD_DIR"
> 
> this wouldn't work as expected with --root and would be IMHO safer
> anyway if using instead
> 
>   GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/.."

Thanks, I completely forgot about '--root'.

