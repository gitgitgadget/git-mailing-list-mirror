Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5341BC433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3050161108
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbhDHXqd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 19:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbhDHXqc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 19:46:32 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1451CC061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 16:46:19 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id a85so2562094pfa.0
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 16:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0pUT1DZirdWrFydtDL6IbJjJMY9lG1sPZ81A1wc4IPE=;
        b=HWw0VzqMiA36McvFmh2PlLK/raXDZz08wSsRG7NKnSvsrSH9O/SPqyCjl7KxgMD3Ix
         Qh4imv2Vw0SlXkNFQvf0rsXE+7Jw+3j8a4Cd9q8Ch2uXglOwZVKIbwu5j/GIX5cS2j8L
         dpTlkehxMtkPGEjJYYICLDs2T7+UYiIbSrT3OfUCqsVT4IvAzf/1RCMET3qNHubT38rA
         Odr9jP0q9R6MSGl4VZZQR0ZU0llYkJ679ISXFkmxW26Qm7vj9ip7kgHP7ktXgVnLz4AX
         isX9cHI6F8YSfJONj7rBHF6UrBQ9+EutK/yRxE3RGHxQLExKd+56HGsqW0z4BaRsCWmn
         pX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0pUT1DZirdWrFydtDL6IbJjJMY9lG1sPZ81A1wc4IPE=;
        b=KvU0Pg5Txvhyzw7QXOpxohk2324z3EJGlkgs+fha6XpNwHkTB+ZXHBjETCvbQduTaA
         i2t3FZPsHe8B1djXfGo/nkWazvNOAZQchffksuLKulIb0VmQJCJD5d3PMYyte1XnvtM7
         zhnDAp9EmJCCRX9zh5pBYUax9L0NMF9rKbqsPtF+OLyyFco8gSVDFEDyLFd5I9viA2T2
         vku6KXAETW7ZhQuZ/owY/mXR0n1PbMpu/tGpAB/KvTcQt9/EhZRqGrOaG8WkMiqEHdPu
         QBKW/AKCKV+4G9uNz+GtAQybXkEcqTiKL4h9jEkkd7hOdfp+V14/xL4LcgMnsQAKItSv
         1xPQ==
X-Gm-Message-State: AOAM531x6Mtl5HZie2uS66xFUswfTEdD2jU6xq60AombwtADugN1EZdn
        j+q4OaSpmW1noGh3ge92wQ+ndPeugIxY+g==
X-Google-Smtp-Source: ABdhPJx1VnQSnU93JC+YTluyQBj9zpdBoVhqtiFFq99+WA0MXiPPqK9ef+X9gHvc4oA/TMqHmJn/lg==
X-Received: by 2002:aa7:9f0c:0:b029:241:d69c:6b6a with SMTP id g12-20020aa79f0c0000b0290241d69c6b6amr9684466pfr.37.1617925578339;
        Thu, 08 Apr 2021 16:46:18 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:34d1:6a8d:be3e:615f])
        by smtp.gmail.com with ESMTPSA id x19sm447952pfc.152.2021.04.08.16.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 16:46:17 -0700 (PDT)
Date:   Thu, 8 Apr 2021 16:46:12 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v8 37/37] docs: unify githooks and git-hook manpages
Message-ID: <YG+VxDvlov81PfK3@google.com>
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-38-emilyshaffer@google.com>
 <xmqq5z0y2540.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5z0y2540.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 06, 2021 at 07:36:15PM -0700, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > By showing the list of all hooks in 'git help hook' for users to refer
> > to, 'git help hook' becomes a one-stop shop for hook authorship. Since
> > some may still have muscle memory for 'git help githooks', though,
> > reference the 'git hook' commands and otherwise don't remove content.
> >
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> >  Documentation/git-hook.txt     |  11 +
> >  Documentation/githooks.txt     | 716 +--------------------------------
> >  Documentation/native-hooks.txt | 708 ++++++++++++++++++++++++++++++++
> >  3 files changed, 724 insertions(+), 711 deletions(-)
> >  create mode 100644 Documentation/native-hooks.txt
> 
> While this would be a very good move when this were the only topic
> juggling the hook related documentation, in the real world, it
> creates rather nasty "ouch, the original hooks document was updated,
> and we need to carry these changes over to the new native-hooks
> file" conflicts with multiple commits on different topics.
> 
> $ git log --oneline --no-merges es/config-hooks..seen Documentation/githooks.txt
> 2d4e48b8ee fsmonitor--daemon: man page and documentation
> 23c781f173 githooks.txt: clarify documentation on reference-transaction hook
> 5f308a89d8 githooks.txt: replace mentions of SHA-1 specific properties
> 7efc378205 doc: fix some typos
> 
> $ git log --oneline --no-merges ^master es/config-hooks..seen Documentation/githooks.txt
> 2d4e48b8ee fsmonitor--daemon: man page and documentation
> 
> As three of the four changes are already in master, it probably is a
> good idea to rebase this topic (and redo this step) to update the
> native-hooks.txt
> 
> I am not sure offhand how ready fsmonitor--daemon stuff is, but if
> it takes longer to stabilize than this topic, it might make sense to
> hold off the changes to githooks.txt in that topic, until this topic
> stabilizes enough to hit at least 'next', preferrably 'master', and
> then base that topic (or at least the documentation part of it) on
> the final shape of the native-hooks.txt.
> 
> Or better ideas?
> 
> Thanks.

I got bitten by this same issue with native-hooks.txt while addressing
comments, too. Another commenter suggested to not inline those hook
definitions into "git help hook" - so I plan to drop that part of this
patch. If it makes it easier for you, I think you could revert this last
commit; if we decide later that we want to have "git help hook" share
the hook definitions after all, I think we should do that separately and
as a quick change not stuck behind 36 other complicated patches.

 - Emily
