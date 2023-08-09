Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C74DC001B0
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 21:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjHIVPx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 17:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjHIVPw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 17:15:52 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5C610DC
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 14:15:52 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-583fe10bb3cso3936527b3.2
        for <git@vger.kernel.org>; Wed, 09 Aug 2023 14:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691615751; x=1692220551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P2Rvq6VGsf30hoiaNX+WfZMfYxBVlt4MMsTZv6a0JQI=;
        b=rf4LLiau7XbTcw/k/AA/rrdRcLWi91Bm1Epvr27HWI62R/dXzzLAu8fs2nhcjmDNDc
         Ednk91ePf8Tede37dofJlaeF9uIHxjoZiJt6AJJphsR3VSlzXvYNZBeSgFdF/auBPKIO
         hUO5ECSFNz72f7POrZA2F4neW8zvILE/X+NgnPqZWR/iNKwaJLfMtPCcIvH0FU/XKDcK
         gU7KKqQ7qzbg++msX+8ct6z61oPTJ2atvZUHsdpeUASQ37RBk49fZsLH/sD8OG10obOO
         exapfKwcftJz6wq62Tyo8f8DnZix40QDQ+dIJHLlpcXhwIcUizmpMoadtEgxDGPQrn1F
         GkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691615751; x=1692220551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2Rvq6VGsf30hoiaNX+WfZMfYxBVlt4MMsTZv6a0JQI=;
        b=NuuTWf1+LYUZCQDfar6BXAuwdhj5nqJQz6WN7m1WBMLxhJgHwJ6EJzS5wFEXekDrey
         JflC6mVnnp4YWMp0L72DKeLs8JzNLVNJOj+5QMDySv+Eusf8DgJeTn91GKSdqxe2iT2n
         V6l1oUlILYqfOfvUK19Vx5s6qyefHsmRn66tBw+9bEb1gOYtbnHJQeVatdiHh9NNo02Z
         uu10WfqVLomuGJ+UAzGdZw31HXDBkDrmA6gc0wn+SpDlyg/b2jCP2MCe1uIWXldwrhXB
         1d8Wj1esoAB8QQdaErSG5aKsO1SKDcaTDOZnMJ4dtjJF+InR7Q4Gxt1QaEO3QJ4SLeTP
         ZB3Q==
X-Gm-Message-State: AOJu0Yxxp6XROKiUIwgwSLN82k6iMz3zs4dZwtwGx1JG4q/hgZ4IfE/u
        wcy0sT2o1a4ujtQM60pPtVD6qw==
X-Google-Smtp-Source: AGHT+IGKj1RMe5m1iCAPy+2L2+E2QhLjb6heajcu+dAF5J8cAm5AQh2HiBztXwEoIi+6Qz7moL1n6A==
X-Received: by 2002:a81:de54:0:b0:57a:897e:abce with SMTP id o20-20020a81de54000000b0057a897eabcemr545699ywl.7.1691615751282;
        Wed, 09 Aug 2023 14:15:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y74-20020a81a14d000000b0056d51c39c1fsm4160055ywg.23.2023.08.09.14.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 14:15:50 -0700 (PDT)
Date:   Wed, 9 Aug 2023 17:15:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 6/8] gc: add `gc.repackFilter` config option
Message-ID: <ZNQCBVXhGMhQcgu1@nand.local>
References: <20230705060812.2865188-1-christian.couder@gmail.com>
 <20230724085909.3831831-1-christian.couder@gmail.com>
 <20230724085909.3831831-7-christian.couder@gmail.com>
 <ZMBVzWoFQCUCSTwE@nand.local>
 <CAP8UFD1Z3O5Wf8D9dYZdgPuOWgo7NbQsHAWifkPUGE=Eo1U7EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD1Z3O5Wf8D9dYZdgPuOWgo7NbQsHAWifkPUGE=Eo1U7EQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 08, 2023 at 10:38:26AM +0200, Christian Couder wrote:
> > I may be missing something, but what happens if the user has configured
> > gc.repackFilter, but passes additional filters over the command-line
> > arguments? I'm not sure whether these should be AND'd with the existing
> > filters in config, or if they should reset them to zero, or something
> > else.
>
> `git gc` doesn't recognize `--filter=<...>` arguments, only `git
> repack` is being teached to recognize it in this patch series. So I
> don't see how there could be multiple such arguments on the command
> line when `git gc` is used.
>
> Also in version 4 `git repack` can be passed many such arguments
> anyway. So I think we are good.

Ah, thanks. Sorry for the misunderstanding :-).

> We could support multiple gc.repackFilter config options, but on the
> other hand using something like
> `combine:<filter1>+<filter2>+...<filterN>` should work, as the content
> of the option is passed as-is to the command line. So we can leave
> that improvement for later if people don't like the `combine:...` and
> are interested in it.

I agree. To me it seems like there are probably relatively few people
who would want to specify a multi-valued configuration directly when
they could just use the "combine" trick you suggest. In either case, I
agree that it can be done on top later.

Thanks,
Taylor
