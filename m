Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D27791F453
	for <e@80x24.org>; Wed, 24 Oct 2018 09:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbeJXR3X (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 13:29:23 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39569 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbeJXR3W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 13:29:22 -0400
Received: by mail-ot1-f68.google.com with SMTP id a18so4267624otl.6
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 02:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oU36tkJbmKdyLXg+qk9wnxDD2dCVPR1gKpmpgXMdvNQ=;
        b=hPKg9hBTL1IvhYna5lc1soiFWEDcDwn9sHM5u/arS8u21B/h47PKq8o/L5TwNhcjuZ
         H71UTmTjWMAojwpOvS5lTNV8SlecCoRd+hrbUFONcE/Jwr36aP+uCeDM06mGc5SqGZwJ
         hzayDSB3uishUsqPRlbAQxRC9y/WArkeypyP3bFJMrHKNg4j82iZWMXsB2bRpbIv4pe7
         mUUT0nk19c3hTcBSzu+wzoKuL0pfoA0T+kO2+KwQVdw67QREdpnQzlpRMISdU360sIAz
         n+QEEfLefeHmcH9vjWDOzGknWlrDn0tUP7wYi/oHcpq5+P/bVlOCvDc+55uQUoPouZEm
         ydUw==
X-Gm-Message-State: AGRZ1gIQJTPpYyAXmGKKINFzjKxzUCEnRKJYR3B2C0N597PVKaTBPhyz
        Au7LNQoG3Vn8oM2KxPrf6TioBisXL5y/I8lBBg0gaA==
X-Google-Smtp-Source: AJdET5dY3eSrtRK/o9vd70xjq8PAgscVGBz0gqBkAkTnrxExmyoUv5oJwumu8ucurHF0qiT/z6Vl8WrJonWDIDVeRbg=
X-Received: by 2002:a9d:55cb:: with SMTP id z11mr1030826oti.190.1540371726698;
 Wed, 24 Oct 2018 02:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20181023191758.15138-1-agruenba@redhat.com> <xmqqefcgotbk.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqefcgotbk.fsf@gitster-ct.c.googlers.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 24 Oct 2018 11:01:54 +0200
Message-ID: <CAHc6FU6YLeTBU02k-Md7+H5kJDq2RXZmAXMaq8ZkiuSmZFXbwQ@mail.gmail.com>
Subject: Re: [PATCH] Clear --exclude list after 'git rev-parse --all'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 24 Oct 2018 at 06:35, Junio C Hamano <gitster@pobox.com> wrote:
> Andreas Gruenbacher <agruenba@redhat.com> writes:
>
> > Commit [1] added the --exclude option to revision.c.  The --all,
> > --branches, --tags, --remotes, and --glob options clear the exclude
> > list.  Shortly therafter, commit [2] added the same to 'git rev-parse',
> > but without clearing the exclude list for the --all option.  Fix that.
> >
> > [1] e7b432c52 ("revision: introduce --exclude=<glob> to tame wildcards", 2013-08-30)
> > [2] 9dc01bf06 ("rev-parse: introduce --exclude=<glob> to tame wildcards", 2013-11-01)
> >
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > ---
> >  builtin/rev-parse.c | 1 +
> >  1 file changed, 1 insertion(+)
>
> All other glob options do show_reference with for_each_ref_in() and
> then calls clear_ref_exclusion(), and logically the patch makes
> sense.
>
> What is the "problem" this patch fixes, though?  Is it easy to add a
> new test to t/6018-rev-list-glob.sh to demonstrate that "--glob" (or
> whatever that clears exclusion list without this patch) works
> correctly but "--all" misbehaves without this change?

The test suite doesn't cover clearing the exclusion list for any of
those rev-parse options and I also didn't write such a test case. I
ran into this inconsistency during code review.

Andreas
