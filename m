Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C99FC43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 19:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E178F20719
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 19:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vCzyqRbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgCZTRp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 15:17:45 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33155 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgCZTRp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 15:17:45 -0400
Received: by mail-ot1-f67.google.com with SMTP id 22so7181600otf.0
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 12:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5/RLRTAdY7BG4U43sHXi+SkN85SyE83fq+lRKxXAdrY=;
        b=vCzyqRbz2Rz/C2GwIakvphcHXe6VFEMo3FKy/wgOCCwX75faC/OJkmSiv0QAKOu731
         03uA0DCb+2dwWEcfNEpKfAshlQs+EpalPn7PImRsywhhz1Cr41z8qhjB/7kRD5W9lLVy
         7miqIP2ReW714xQdofXdHaV9j2X7dRVYCVomz2n8d9KXgeOd+OhtKucbW1k86AGNXeP1
         bKL6yO9g+VZ1C6AXtAzrSbN7UsL1G1n1fZ1aZiTTFWoK2WQQRbMsQoRnIb1NS3bTF8pS
         Tk0vbVPTyXvq09CH852tErcwWtvM+EjWTlt4otOLMunWWAfqrp+uFWyBI7/sRW/N016C
         R7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5/RLRTAdY7BG4U43sHXi+SkN85SyE83fq+lRKxXAdrY=;
        b=dHk+C8mRFeqJxOhMox7axfw5FEwXCaRgvzUvHnr4p3zsZUuHQuC7J67Frmq1wf6QU8
         xKk+3fHXyUuiAdVdrq1jEkVqUyz4+CbMIsgGH/7P4kBo8ERijVK9lHSAcWP0kLOjE4N/
         yDQVS2+rLR552A+DNf2siivYH4PysrdPa3j+G2V0tBeVQL3RxuD3ewQfxpHQjNxqvYhL
         yVcjHYKkHjm7S59yzksrDYjs0zgk6X3IN2xRWOZzYvs9022x/Wyv1TAbmR7kbqC9EVwl
         9Ahr3Rqd693JtfrU3O3wOtkc+cew/SHSKaCM66rAfIzBTjI9eIxjhpUp7YFjaOpUZdWm
         v+sg==
X-Gm-Message-State: ANhLgQ1DHNc2IpzsRCZqLzUxN9GsUMQsVTDxuXlrnpIBiZywBy1ycccW
        oYk3iLvXdsVSoBAaJl5jef1aGyYhgOT9cRfzHYCPc1tz
X-Google-Smtp-Source: ADFU+vvzr4Sft9eA6AyxaLqI71nBSabI9ewGSn2rK4C0RLB9Eq+lvF1MSKcX38DJ/OjcsgMJdDNOCdI6SUuNIYtVBGM=
X-Received: by 2002:a9d:6457:: with SMTP id m23mr1014928otl.162.1585250263828;
 Thu, 26 Mar 2020 12:17:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200318173051.25875-1-jonathantanmy@google.com> <20200326175033.35944-1-jonathantanmy@google.com>
In-Reply-To: <20200326175033.35944-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 26 Mar 2020 12:17:32 -0700
Message-ID: <CABPp-BHdacsWrD3Q1avCCNbt4MhwN5Tm_rY8HKHotJADJdPYxw@mail.gmail.com>
Subject: Re: [PATCH v2] rebase --merge: optionally skip upstreamed commits
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 26, 2020 at 10:50 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > New in V2: changed parameter name, used Taylor's commit message
> > suggestions, and used Elijah's documentation suggestions.
>
> I think the discussion has shifted away from whether this functionality
> is desirable (or desirable and we should implement this functionality
> without any CLI option) to the name and nature of the CLI option. Before
> I send out a new version, what do you think of using this name and
> documenting it this way:
>
>   --keep-cherry-pick=(always|never)::
>           Control rebase's behavior towards commits in the working
>           branch that are already present upstream, i.e. cherry-picks.
>   +
>   If 'never', these commits will be dropped. Because this necessitates
>   reading all upstream commits, this can be expensive in repos with a
>   large number of upstream commits that need to be read.
>   +
>   If 'always', all commits (including these) will be re-applied. This
>   allows rebase to forgo reading all upstream commits, potentially
>   improving performance.
>   +
>   The default is 'never'.
>   +
>   See also INCOMPATIBLE OPTIONS below.
>
> I've tried to use everyone's suggestions: Junio's suggestions to use the
> "keep" name (instead of "detect", so that we also communicate what we do
> with the result of our detection) and the non-boolean option (for
> extensibility later if we need it), and Elijah's suggestion to use
> "cherry-pick" instead of "duplicate". If this sounds good, I'll update
> the patch and send out a new version.

Sounds good to me.  Thanks!
