Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109BBC33C9E
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 03:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34EF20721
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 03:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ayu0bPaT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbgBCD6W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Feb 2020 22:58:22 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36509 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgBCD6W (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Feb 2020 22:58:22 -0500
Received: by mail-pl1-f193.google.com with SMTP id a6so5294459plm.3
        for <git@vger.kernel.org>; Sun, 02 Feb 2020 19:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GrdqjUWxDr8WPPMuxl/jO+MUwFTyDwcq304UlBeJs1Y=;
        b=ayu0bPaTT3oCeSHDmfdjXo4JWBt+SNzjw6uB5Lml9gYVNXTHwZ5/1vZgZKT4MoVUMr
         A8zd4Nz5urJ6ikTPFF9tREM2nuiKedqtLQcKMtBOEJbvyYpy7029Bhk1+e3eUQmPfy67
         IM7oubD6Ykc+gAmMbJ6oKP09wAn3Wwtfat+YuA/LdYIQFm9vQHExXUKU14Hjqs7j1eXh
         GJSP336yTs5noijJqxzlSSAnKLSI+5XUfos6F7K1jiG88NeE8GpHSqrJa94vM6xb/Um7
         i6WnoIsIlCBdruhc/114nzFrASe4x5B5XEvWDiKmX2ceh1q0IJIGnvfgoLT/7N1BGv74
         I1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GrdqjUWxDr8WPPMuxl/jO+MUwFTyDwcq304UlBeJs1Y=;
        b=AD9wiuGz17U4O6NU9oFN7UAk7lQaAU5CtYwZ4EQzopWiCF+dTadwwMrwdlHjQNfJsF
         rDxtRsdlXj4BkCRfaihMtCywygFigekX+lE0IB3uUKPROWE+l3Rtlm4viaZXSWkAARru
         xCtFdvKeTdlRGcYrFOzZon7AI+8GsNHAqA4i+MpD6yeg+y/xWX59VXNo5do+7hrgyjUz
         xP4YRh42iNcE13Yb3bAzju3FHjObUgzfmcr0ZbbNfXZpfIVGnJjq17qVsHj+SenWIxnk
         Pn+txOzqnBdELjk10OEsSrdckqpFCZGHPiTV47KIZ58H0NylJ/AAaqd+01PoPu/qv3sw
         u+Pw==
X-Gm-Message-State: APjAAAUy4srWWYRPYlCMVgTClmpar91U1WJyIPJF/ZcPdwCiIwKv+v5A
        SgCU0ilEbfw+e5KzExpPoCbb+A==
X-Google-Smtp-Source: APXvYqx0FUlvTZyRpV5S5q/FjVgmnMQMEeOUYoVyTIua61hI2aJTCiuzymr/0g8PsR9/meslDLBSeQ==
X-Received: by 2002:a17:902:7b89:: with SMTP id w9mr22230591pll.46.1580702301153;
        Sun, 02 Feb 2020 19:58:21 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:ac09:c6e5:fcdd:b79b])
        by smtp.gmail.com with ESMTPSA id v10sm17494964pgk.24.2020.02.02.19.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 19:58:20 -0800 (PST)
Date:   Sun, 2 Feb 2020 19:58:19 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] commit-graph.h: store object directory in 'struct
 commit_graph'
Message-ID: <20200203035819.GA23625@syl.local>
References: <cover.1580424766.git.me@ttaylorr.com>
 <890e0e7136204f5ca47f0703f32b4adb99ad8d7e.1580424766.git.me@ttaylorr.com>
 <CAN0heSrrrWjBKnzjMfzEkTMVTge2AfVdwsp6D5Mx==5S8-ZLJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSrrrWjBKnzjMfzEkTMVTge2AfVdwsp6D5Mx==5S8-ZLJQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin,

Thanks for your review! Your comments were all quite helpful, and I
applied all of your suggested changes.

On Fri, Jan 31, 2020 at 07:52:02AM +0100, Martin Ågren wrote:
> On Fri, 31 Jan 2020 at 00:03, Taylor Blau <me@ttaylorr.com> wrote:
> > Instead of getting rid of the 'struct object_directory *', store that
> > insead of a 'char *odb' in 'struct commit_graph'. Once the 'struct
>
> s/insead/instead/

Typo. Thanks for noticing. I fixed this in my local copy of this branch.

> >         if (open_ok)
> >                 graph = load_commit_graph_one_fd_st(fd, &st);
> > -        else
> > -               graph = read_commit_graph_one(the_repository, opts.obj_dir);
> > +       else {
> > +               struct object_directory *odb;
> > +               if ((odb = find_odb(the_repository, opts.obj_dir)))
> > +                       graph = read_commit_graph_one(the_repository, odb);
> > +       }
>
> I'm a tiny bit allergic to this assignment-within-if. It's wrapped by
> another pair of parentheses, which both compilers and humans know to
> interpret as "trust me, this is not a mistake", but I still find this
> easier to read:
>
>   odb = find_odb(...);
>   if (odb)
>           ....

To be honest, I'm not such a fan of this style myself, but it seemed odd
to me to write:

  struct object_directory *odb;
  odb = ...;
  if (odb) {
  }

when we were really only trying to call 'find_odb()' and do something
with its result, but only if it was non-NULL. I counted 152 of these
assign-if's laying around with:

  $ git grep 'if ((.* =[^=]' | wc -l

but it seems like they are in poor style (as evidenced by your and
Junio's response later in the thread). So, I removed this and instead
promoted 'odb' to a local variable at the function level, since we
do that promotion anyway in a couple of patches later. This reduces the
churn, and avoids either an assign-if, or a define/assign/check.

> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
>
> > +#include "object-store.h"

No; this is a stray left over from some development on this branch. I'll
remove it.

> This is the only change in this file, which looks a bit odd. I haven't
> actually applied your patches, to be honest, but is this inclusion
> really needed?
>
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
>
> > +struct object_directory *find_odb(struct repository *r, const char *obj_dir)
>
> This doesn't look commit-graph related -- could/should it go somewhere
> else?

I'll respond in more complete detail further down in the thread, but the
short answer is "yes, this should go in builtin/commit-graph.c".

> > +{
> > +       struct object_directory *odb;
> > +       char *obj_dir_real = real_pathdup(obj_dir, 1);
> > +       int cmp = -1;
> > +
> > +       prepare_alt_odb(r);
> > +       for (odb = r->objects->odb; odb; odb = odb->next) {
> > +               cmp = strcmp(obj_dir_real, real_path(odb->path));
> > +               if (!cmp)
> > +                       break;
> > +       }
>
> At this point, either odb is NULL or cmp is zero. Those are the only two
> ways out of the loop.
>
> > +       free(obj_dir_real);
> > +
> > +       if (cmp)
> > +               odb = NULL;
>
> Meaning that this doesn't do much? If the most recent comparison failed,
> it's because we didn't find anything, so odb will be NULL.
>
> > +       return odb;
> > +}
>
> I think you could drop `cmp` and that final check, and write the loop
> body as "if (!strcmp(...)) break". You could also have an empty loop
> body, but I wouldn't go there -- I'd find that less readable. (Maybe
> that's just me.)

Thanks, I changed this to remove the 'cmp' check outside of the loop,
which I agree is unnecessary.

> Martin

Thanks,
Taylor
