Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80632E92725
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 18:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjJESOw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 14:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjJESOl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 14:14:41 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A307493
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 11:14:40 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-41811e7ac3dso6642461cf.2
        for <git@vger.kernel.org>; Thu, 05 Oct 2023 11:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696529680; x=1697134480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0GxGxFefI6YzCdqHbX8Q6Z/guxogi+Rnh4lBUdcbGrc=;
        b=056e1Y447as2oKxSO2wgPoCGFqRlTLR01pDHOIGtnqnC9EW6LB2MBOR3cc+6PWf8Au
         sAtvT7o0+46OVQXhJtwHtnaCXopUmBqFO7ON4vO1Pka+jbs5eBCujujmdg0h/fzrocJU
         iH2Q3y/f/04THXwfvuaCnytbKHe/+hQgvjiMePDTaVZTqs5Sp8toomsyRzyhPRM7bDCv
         vAxIAx3yZbM1EZlqqVNeANOWZIRICQu6gr+KcxuIDqtu47B/iisAqGluMiJDUaqpy8AJ
         XFBqAgYpQ2EAhTzfYjmZ9XfirYzXEm+7ihKWOXpyWJmT4zvka34WK1Uf+jQG5FwbbbPd
         YdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696529680; x=1697134480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GxGxFefI6YzCdqHbX8Q6Z/guxogi+Rnh4lBUdcbGrc=;
        b=tZD+kRk6gkbeUd53FwvepzakMJcUufWRk/XLJDmk0UB8al3lKRhMxxuIPFk+hI8R6P
         CyaPy9eixZTMywK3jiolyAYcnPF+IlDn0iTkYgxqI8NAJhvKk+KGfdJ3/eSUTO5OLtOT
         2yOybNWhboaM1AJN8lZsEQODEfawfl+iSZbXZ4K1Xr+4wGjLk9WeuIuH/LSuDd03/IE7
         Ww4N8hLkXXgQ14O8z4ThsOP7m8VTLVLBMFGssXXqIj1W2mnq9W0V6IjgIkK4z1Ke/KqC
         bh0PzDQFhVTlICi4BLORQNp1sDtZhJTWkGntbxRnWWwKzoH8pK5drdwNLKM0ZrSBcszF
         Y16Q==
X-Gm-Message-State: AOJu0YyV8Uo62/ZcNAIurMWK9jAgiDSOeIVMBnskY9KTn+uxE75ss4Vw
        nyFEZKTE7H+BBsRx087qCkGuoA==
X-Google-Smtp-Source: AGHT+IGraCI7Bd96TQbq38uK9eadbfxjZ7JyGTdwbMXPSC4tyqsT6vEX6EGSWmggPf1JQ1f/CeFO/w==
X-Received: by 2002:a05:622a:1887:b0:412:2f98:2b9b with SMTP id v7-20020a05622a188700b004122f982b9bmr7008685qtc.8.1696529679626;
        Thu, 05 Oct 2023 11:14:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 8-20020ac85648000000b00419792c1be7sm655405qtt.30.2023.10.05.11.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 11:14:39 -0700 (PDT)
Date:   Thu, 5 Oct 2023 14:14:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 25/32] pack-compat-map:  Add support for .compat files of
 a packfile
Message-ID: <ZR79DqE91z+6+ZSd@nand.local>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
 <20230908231049.2035003-25-ebiederm@xmission.com>
 <xmqqfs3li5ly.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfs3li5ly.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 10, 2023 at 11:30:49PM -0700, Junio C Hamano wrote:
> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>
> > diff --git a/pack-write.c b/pack-write.c
> > index b19ddf15b284..f22eea964f77 100644
> > --- a/pack-write.c
> > +++ b/pack-write.c
> > @@ -12,6 +12,7 @@
> >  #include "pack-revindex.h"
> >  #include "path.h"
> >  #include "strbuf.h"
> > +#include "object-file-convert.h"
> > ...
> > +/*
> > + * The *hash contains the pack content hash.
> > + * The objects array is passed in sorted.
> > + */
> > +const char *write_compat_map_file(const char *compat_map_name,
> > +				  struct pack_idx_entry **objects,
> > +				  int nr_objects, const unsigned char *hash)
>
> Include "pack-compat-map.h"; otherwise the compiler would complain
> for missing prototypes.

Likewise this is missing an entry in the .gitignore:

--- >8 ---
diff --git a/.gitignore b/.gitignore
index 5e56e471b3..7f5a93a6f6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -152,6 +152,7 @@
 /git-shortlog
 /git-show
 /git-show-branch
+/git-show-compat-map
 /git-show-index
 /git-show-ref
 /git-sparse-checkout
--- 8< ---

Thanks,
Taylor
