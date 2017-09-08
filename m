Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DAFD1FADE
	for <e@80x24.org>; Fri,  8 Sep 2017 22:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753009AbdIHWGn (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 18:06:43 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:38286 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752130AbdIHWGm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2017 18:06:42 -0400
Received: by mail-lf0-f51.google.com with SMTP id q132so8235779lfe.5
        for <git@vger.kernel.org>; Fri, 08 Sep 2017 15:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aerotech.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DRbLtU+R04pR34GbA+kbpcKovkMPs+yKhdSp7Id8ass=;
        b=C6PgUusO16pJdq6fR2k6taVfq43HnY5hFD14Ft+Bi2FZ60TQERH2znFPWpLrG9rjcp
         ZPOe74a/A3QAOKA0ZqSCGq+BhhceUMrbSEnra8D1TRxfj2Lj9iMRaMTOKUCxsgBCsoB6
         tiHnUfy8hjzngeWMCO5BbmXjt1Eed5v4wbWpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DRbLtU+R04pR34GbA+kbpcKovkMPs+yKhdSp7Id8ass=;
        b=NcgKNokOiER3yOaH/Fgy7aqEZ3xsxYemaIBcO5onc2GZ5fXoUyd6Q/pHnZ5+7G3zP0
         +WCinJIQ65rFhruYK/t+xHObn5L+3acpHB0cB82pJ1edKcfFUnntZfB5TeT11oqOgSPM
         l0HpIMvdN39NXQiXv9eS2jJ+ohDFVpbCOBDHHhDrQJSWrUEjZqlSFBDZW4DkjMBJyBza
         +rHzINdB9GKAbJcvnkfSMr91an410wzXDMlGtbN7r1EbzKYCAc1C4gXwcEn/ZwZbH2oa
         qzMW09CZeE/hT0P7ekdgz0Z+NDnmw+0b3kqly/HZLUEGqVWJSeNIVp6pSP8bzEp2vGIT
         j1qA==
X-Gm-Message-State: AHPjjUjsIAp7LKmX8vhk0bkiG7aHKq5BbBvsgik5UmKQxCvk2+5/t5G6
        GLAPmpwwzpkJgcb/xXPW0dHzewXGqZMJlOlBqQ==
X-Google-Smtp-Source: AOwi7QDU4VlQYkhtU1C9iUwPd+q1TyKgTzYdYLLXHoEBYJSvEvv3X+ucz+oOi3VlOF54Yj5PSGoSjO037L9roxDkzwc=
X-Received: by 10.46.31.10 with SMTP id f10mr1640856ljf.38.1504908400816; Fri,
 08 Sep 2017 15:06:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.46.87.73 with HTTP; Fri, 8 Sep 2017 15:06:00 -0700 (PDT)
In-Reply-To: <xmqqa8260y7g.fsf@gitster.mtv.corp.google.com>
References: <20170907144111.7488-1-rkabus@aerotech.com> <xmqqa8260y7g.fsf@gitster.mtv.corp.google.com>
From:   Ross Kabus <rkabus@aerotech.com>
Date:   Fri, 8 Sep 2017 18:06:00 -0400
Message-ID: <CAEVs+zYrKxX0S9LMoBLB3vqG5n3PuMGMCehipbpCmFA7dW95qw@mail.gmail.com>
Subject: Re: [PATCH] commit-tree: don't append a newline with -F
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 7, 2017 at 9:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
>     commit-tree: do not complete line in -F input
>
>     "git commit-tree -F <file>", unlike "cat <file> | git
>     commit-tree" (i.e. feeding the same contents from the standard
>     input), added a missing final newline when the input ended in an
>     incomplete line.
>
>     Correct this inconsistency by leaving the incomplete line as-is,
>     as erring on the side of not touching the input is preferrable
>     and expected for a plumbing command like "commit-tree".

That all makes sense to me and is clearer too, I like this change.
Do I need to resubmit the patch or will you just use that text instead?
