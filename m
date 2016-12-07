Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A9251FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 22:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932972AbcLGWq0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 17:46:26 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33689 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932794AbcLGWqY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 17:46:24 -0500
Received: by mail-pg0-f44.google.com with SMTP id 3so166653558pgd.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 14:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L8+RPzAKaCW8v13vL0x9MJ2g9MS6zS5QFWAOOrymw9A=;
        b=BkSUiBPyTKe//Pot6YqJScZMc6xd0x+HDinWv4hF0KaXwMHEA6z5FIw8lJobRhBl3R
         3EcTDJ2o2LaW2zBznyScfrhdXKaoCwCbCshvR48dwjfBnGn+Fv3au6Nz5IAD+i4hUdp2
         q+W9zzdiuFnxgP1iE1ky3o/3bE4X31XzoigBQALWKlnyeff/n8nTcciX4AE0iF72eI/u
         DWRGoHNdV1o3h8uXNrvXePJ3QbzJkkHM1A+x0Pt5S6RZZ4ICUqzV7GqKGygGMBZXGSsL
         bNGnlLc8QDH8COpPSqUNSxTixVqKz4z4Ldb+ewxEGy3Nc5d5PD6M52cCrXmur5RQQ9zz
         zdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L8+RPzAKaCW8v13vL0x9MJ2g9MS6zS5QFWAOOrymw9A=;
        b=I8WrxYGYn7IMZrjzvwBLmWskRVaLFsMfmlE1SjvP3Q1oaBGMvu6NVRslxeuGJa6aOC
         eGwOpWonmgzG+kuEUpvDEJoymjwNd+HymxaNLUcQrDVPIjx0gAFslx3V7TLxRWHeEmm7
         k1PsmKBDQdjksCUnZ66dsSjJKti6AhIX+M/khQi8t0AGxnlcbMJe+XNcHw1qEqrVaPqv
         EkWAyfHWYYVSWHibL9F3BV1VCFgeYb7WCV01RgRaWVvPtSGJBOifcv9GoHn7yLaVv9ay
         TZB3gC3yb1hMFhT3XeiRlQnDfNekocf6pXwRoYmixluPeagRMA7oWFzQtKllwIWhD91T
         Oi5Q==
X-Gm-Message-State: AKaTC01uVMiwJRB2332fTaDW7ZV5h33H2aQN5bUl3FvsZBMQmAUAaAmgNFrg/SWflwh3bjjp
X-Received: by 10.99.114.2 with SMTP id n2mr125317751pgc.130.1481150778219;
        Wed, 07 Dec 2016 14:46:18 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:ccae:4719:31da:e07d])
        by smtp.gmail.com with ESMTPSA id p1sm45126476pgc.29.2016.12.07.14.46.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 14:46:17 -0800 (PST)
Date:   Wed, 7 Dec 2016 14:46:16 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/17] dir: convert fill_directory to use the pathspec
 struct interface
Message-ID: <20161207224616.GH116201@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481061106-117775-4-git-send-email-bmwill@google.com>
 <CACsJy8BsGVrUoFFFEqdLS-h4XYCkFg-gbx+BeWmGd8srupNWqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8BsGVrUoFFFEqdLS-h4XYCkFg-gbx+BeWmGd8srupNWqw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/07, Duy Nguyen wrote:
> On Wed, Dec 7, 2016 at 4:51 AM, Brandon Williams <bmwill@google.com> wrote:
> > Convert 'fill_directory()' to use the pathspec struct interface from
> > using the '_raw' entry in the pathspec struct.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  dir.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/dir.c b/dir.c
> > index 7df292b..8730a4f 100644
> > --- a/dir.c
> > +++ b/dir.c
> > @@ -188,7 +188,8 @@ int fill_directory(struct dir_struct *dir, const struct pathspec *pathspec)
> >         len = common_prefix_len(pathspec);
> >
> >         /* Read the directory and prune it */
> > -       read_directory(dir, pathspec->nr ? pathspec->_raw[0] : "", len, pathspec);
> > +       read_directory(dir, pathspec->nr ? pathspec->items[0].match : "",
> > +                      len, pathspec);
> 
> Or even better, use common_prefix()'s return value here. I took me a
> while to realize this code was not buggy. It is fine to just pick the
> first item because the first <len> characters of _all_ pathspec items
> must be the same. Something like this
> 
> prefix = common_prefix(..)
> read_directory(..., prefix, strlen(prefix), pathspec);
> 
> expresses it much better. Yeah one extra mem allocation, no big deal
> since fill_directory() is not called very often.

I didn't even notice that.  Now looking at this you're right that its
not immediately obvious that what's there is correct.  I'll change this.

> 
> >         return len;
> >  }
> >
> > --
> > 2.8.0.rc3.226.g39d4020
> >
> -- 
> Duy

-- 
Brandon Williams
