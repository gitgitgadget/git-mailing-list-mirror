Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD49C48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 13:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF32461357
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 13:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhFKNpw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 09:45:52 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:36441 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhFKNpv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 09:45:51 -0400
Received: by mail-oi1-f176.google.com with SMTP id r16so5505220oiw.3
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 06:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=66p1/F78TsiivcQYTS5DPjzz3dydWBeO2Bc4fh1w/yo=;
        b=KIqIMgemqkkfdtGuy2P9dqoMwJXkji3ZGQKmaWz6yfDq9rYcKPzTwuFR/5KQ+qHJYB
         kEB6YvcgyYg+qiR+PKA5KQUiwyqS83r4iOOv6piFFNnmRoP9ZicFHyLtmnfttuqIQn8c
         KeGVA+Rs6mQGPpQtZvpdLM4+9v10ek2ZBCFrL7j5t44jeiJbJhcozUftwjK0Jxcgu0n/
         Y/c/3n6IMIOpUzys8PS8NpRr2HuW8VwhStIiTh3tFWarG2RyLbEo4swPvMgkcdz2TH1t
         SPbINJYfFZTd2z7hl2pxLGlUhIJ4nkdQzUFl0M4R5X9o3AFESiwhVeW+LlPS0ZLuN1nJ
         pn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=66p1/F78TsiivcQYTS5DPjzz3dydWBeO2Bc4fh1w/yo=;
        b=mYSHXcOsAgJmcigiJ9BkswDbrVbmCZxHNs7/vOgbru32n694Isq1TPo4dNr3nvJ+bs
         47/60bx/3IJpOnoMaxaErfiWnnALXkOXG0oUm9Egu/pmVNOfy9n9iTBEvUmeQC6rBzMq
         pWo7Y/1kcJzmTLOlqVNKKx9+epFvEVNwaKHJB8oQKzsaViPQ0Nwk+umdBNKKo5h3lrk7
         udi4/vVVgc6pn4pfGU5UuWLBArchmOUmyPTeb7lnDq/bN0mEh3udxe/oYBmACaDl5OuE
         i1+2rrDqNAinnIdVl3vYo1zpXuJ0x9rPXmS6A9EEhFDmVOvQZCemrGFUAHqFjl3kX53r
         971g==
X-Gm-Message-State: AOAM530jqkx0IpFowxXWnKl4nERobscPtLusKLoAJrNIoJVflz7jcRJi
        kfqW68ch9EimeYCwvQx8utg=
X-Google-Smtp-Source: ABdhPJwRjAc22J98+HQpEy2RdT2e8Zg8M0WF5Svm1ToI9q+ycyRq01zPJwlm9jYj4R7bPvN1SVAQ/w==
X-Received: by 2002:aca:38c5:: with SMTP id f188mr2527266oia.36.1623418960396;
        Fri, 11 Jun 2021 06:42:40 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 22sm1292747otv.8.2021.06.11.06.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 06:42:39 -0700 (PDT)
Date:   Fri, 11 Jun 2021 08:42:38 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Message-ID: <60c3684eaf033_3ad920828@natae.notmuch>
In-Reply-To: <xmqq5yyl5buz.fsf@gitster.g>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-6-felipe.contreras@gmail.com>
 <3168eb15-25a6-a3eb-a498-8effa0c79855@gmail.com>
 <xmqq5yyl5buz.fsf@gitster.g>
Subject: Re: [PATCH 5/7] xdiff: rename XDL_MERGE_STYLE_DIFF3
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> > The subject would make more sense as 'xdiff: rename XDL_MERGE_DIFF3 to
> > XDL_MERGE_STYLE_DIFF3' rather than using the new name of the constant
> > alone.
> 
> True.

But why? When we look back in history few people would care what the
previous name of XDL_MERGE_STYLE_DIFF3 was, and if they do, they don't
necessarily need it in the title.

> >> If we don't specify we are talking about a style, XDL_MERGE_MINIMAL
> >> could be confused with a valid value instead of XDL_MERGE_DIFF3, which
> >> it isn't.
> >
> > I don't object to the rename but what is the source of the confusion
> > with XDL_MERGE_MINIMAL?
> 
> I do not see any confusion, either, but the current XDL_MERGE_DIFF3
> being a boolean

But it's not a boolean: git_xmerge_style is currently -1 by default.

> (i.e. if false, use the output style of the 'merge'
> command) and our lack of an enumeration constant for 'merge' means
> that a future addition of the third output style would require us to
> add XDL_MERGE_$STYLE for both the new style and the traditional
> 'merge' style.  And If we would end up with XDL_MERGE_DIFF3,
> XDL_MERGE_MERGE and XDL_MERGE_FOO for that third output style.

But can you put XDL_MERGE_FOO in xmp.level? Or XDL_MERGE_BAR in
xmp.style?

> The 'merge' one simply looks strange in that context.  And from that
> point of view, this change might be a good way to futureproof the
> codebase.

Yes.

-- 
Felipe Contreras
