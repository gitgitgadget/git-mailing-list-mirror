Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D342C636D6
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 18:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjBWSWQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 13:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjBWSWP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 13:22:15 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CC23B642
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 10:22:14 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id m6so14929485lfq.5
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 10:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xyXy4yBvOrPfJ5r9upj+re0STUgoL5wqL3tlO0RBQIA=;
        b=S8tPwc6cq/7oX6acFgw9tZY0lqJZ/EGLtEzXFDO4e9CFwB4dfuqW34VPLCRCJmiI0h
         CrJrd5tyD7KwdmfH8/5MSw6f96T9Ejq7P6+SH09AzcQ14CTLCzCtPpRo7BPhf/tr0VIM
         5fztwJ71NM30tTruNtw3P4Y3aqfRSWtLjyZphxxCPbiT5rtIeNjrfE4+ywzwqtwwmg6F
         Cd3eZ0A1hw3SVPLihVfSXqoh/dQJhl7B1lcRr9Bf3tluZYInp37BVqu/0DSALDXjH+z6
         7b2FVrrktWS5yxufSS2yjpoiXxj8dOgNXBm46oWkAn/LuQH0JPfjtYN2rJezVHOrylqM
         0GfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xyXy4yBvOrPfJ5r9upj+re0STUgoL5wqL3tlO0RBQIA=;
        b=jzJRfGOZb1jlOKaHpmrzHBxroNb9oIQAPkZL57PmixpG2MhLdISQTW/hF4z1bgIDaL
         7wpBWr1TX1ukHQ+jMKMUQ8SXRJGjP//uuvNlz38ap6Yt9JsQITZLm+vnjJIpM/6E0JY/
         82+ebG3icJ8O8ZD/cSRK31THlPing3bZRh+LOMaet+VUpk+sFhfiURZqTkLdbV7gyabA
         vbErFulCzY5n0SOApng+L4ryyAXXye7WU5IP5Tc63usQIj1LWDsNup7zHxgIvnxAlGcf
         opWTv3J1pcTMIRzH6Aff9qSKzHkxzC04Q2m7rSONk3ih98GNCdOA+4ZmW3+ipRnGiMG2
         egVg==
X-Gm-Message-State: AO0yUKXnJ/F4vO2v+4SY2kZ96/SnJcXutA9P2wcSl96m+hQ8SNEjDuVD
        Rj15uPZQiIO0IhmxoFUwQmdJ3ZWtO6lvqLZA5Vc=
X-Google-Smtp-Source: AK7set9LXLvdwhRTWhBpmXaMB6ptXtcwxh1yAD9jKtO3WuvGrrIJKV2u3i6Q9ZLXetNA9awSkRrnI1wCIfIkY+1IEGc=
X-Received: by 2002:ac2:5206:0:b0:4db:3501:5d66 with SMTP id
 a6-20020ac25206000000b004db35015d66mr4088843lfl.2.1677176532234; Thu, 23 Feb
 2023 10:22:12 -0800 (PST)
MIME-Version: 1.0
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
 <ec6f2518b9dddbaaaf101b0f87a2db377fef3c6b.1677139522.git.gitgitgadget@gmail.com>
 <536338b8-2189-04f3-7ed6-dbe640c73c9f@github.com>
In-Reply-To: <536338b8-2189-04f3-7ed6-dbe640c73c9f@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 23 Feb 2023 10:22:00 -0800
Message-ID: <CABPp-BGfX9S14_jW86KpK7sOy1NsfwQ-gOuwA-f0cGB=pMpYKg@mail.gmail.com>
Subject: Re: [PATCH 05/16] alloc.h: move ALLOC_GROW() functions from cache.h
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2023 at 6:06 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 2/23/2023 3:05 AM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > This allows us to replace includes of cache.h with includes
> > of the much smaller alloc.h in many places.
>
> > diff --git a/add-patch.c b/add-patch.c
> > index a86a92e1646..7fe6b66d866 100644
> > --- a/add-patch.c
> > +++ b/add-patch.c
> > @@ -1,5 +1,7 @@
> >  #include "cache.h"
> >  #include "add-interactive.h"
> > +#include "alloc.h"
> > +#include "gettext.h"
>
> I see here that you are not dropping cache.h, but are also adding
> gettext.h, too? Did you mean to replace cache.h with git-compat-util.h
> here, or will I see that change happen in a future patch?

Not intentional.  Often as I made changes, I also flipped cache.h to
git-compat-util.h manually, then found out what was missing and
started adding other headers.  Sometimes that worked, sometimes I
found that there was still more stuff directly in cache.h that was
needed.  When I backed out the change, I forgot to remove the
gettext.h inclusion.  (Though leaving it in doesn't hurt either, since
the file does clearly depend upon it.)

> > diff --git a/attr.c b/attr.c
> > index 1053dfcd4b6..657ee52229e 100644
> > --- a/attr.c
> > +++ b/attr.c
> > @@ -7,6 +7,7 @@
> >   */
> >
> >  #include "cache.h"
> > +#include "alloc.h"
>
> (Here's another example. Makes it more likely that this is on
> purpose in preparation for a full swap in the future. I'll
> stop mentioning this when I see it.)
>
> I also manually verified that the macros are an exact move
> from cache.h to alloc.h.

Yeah, since I moved code out of cache.h into alloc.h, and didn't make
cache.h depend upon alloc.h (because it really doesn't depend on it),
that means each file that does depend upon alloc.h needs to explicitly
include it.  I guess I could have made that more clear in the commit
message.
