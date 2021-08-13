Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A06C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 20:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 738EA60F91
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 20:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbhHMUj0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 16:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbhHMUjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 16:39:25 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A0CC061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 13:38:58 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j12-20020a17090aeb0c00b00179530520b3so1966069pjz.0
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 13:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eGzD1w5QT5Vz3/LDLqpIIrEZN2cqK0QCmnCnGJTemXs=;
        b=A8P/GWM5AOEZZs7AeN4iRpW4+FkNO8eX31V6DbjPRaXc05ZvKvFh5HavLwJEl1ba98
         x/Tv8QruN3YhPADukRSA3NqvjxQ9Y9yPJF39oG6bGnXmVEv6FEpHqKy55gvw2D80qlmr
         pnk2WZ2XSAr3Ax2j8GqnDHsDWoQacWMJj2C5uIv6tXBud5sZkBmuc0gZwC1pwFup0cx9
         TpquXcUlCy8eLHziFDTCGZ3RA8oWLGsy3rsYeffUCSJEPWCrWjaySrzOttS8RoXYoUJv
         LG5KfCzGcMfvjuaJdS7YAOKyj94uZ9ToOMEl9JwniQYn4YRWIPWKG0CbR+7PuBy1ezxm
         2gEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eGzD1w5QT5Vz3/LDLqpIIrEZN2cqK0QCmnCnGJTemXs=;
        b=Cw6Z1q9YXCPTftzgR6LEZ16HBNLWuA//WnRXN4zvv6ct0yr/lmgFHz/V07iG6Cu9YS
         kVFaEarJnRjRmR5HZ+TBJBP4PwRZjwbnt800Vw1p3aI5KXVHwByToqAAb0DE9VQp+AZ+
         otU07CCH14Zvmg/76LJ0gY+PK4L/UQnpxRS2vvvaL4+8OEBPeLA1k5yXJ7KpdP3x77R5
         uLG+yAiVmoyu4x7VawtD1St0y5oSnzI2LFDw+fT+XQoXftl01oJ68YDgchU4ZfkPi6we
         +5C6DiKkZd3mrvwT3prJrB4rpiZpzZK40xiaMdNvkTWjjXZJQIf0dDOdVNqT40VQeDrC
         xQsA==
X-Gm-Message-State: AOAM5301D4VaqkQwSww/vpJeUDEsXwAhDgF2/OHqjB+vRQUoKnxkJAYp
        Xl3UUkHlNFn56EoUYTmYPAocYN0zlgcKMQ==
X-Google-Smtp-Source: ABdhPJx9VcsOqKhtMK00WKekscQxTJFKzxGhzW7demFerHAOeoQkuQCIjaFIr4Jtw5p0anP4804ZoA==
X-Received: by 2002:a63:1d63:: with SMTP id d35mr3947948pgm.238.1628887137963;
        Fri, 13 Aug 2021 13:38:57 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:258f:eefb:8f2e:157])
        by smtp.gmail.com with ESMTPSA id ca7sm2604628pjb.11.2021.08.13.13.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 13:38:57 -0700 (PDT)
Date:   Fri, 13 Aug 2021 13:38:49 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Mahi Kolla via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Mahi Kolla <mahikolla@google.com>
Subject: Re: [PATCH v5] clone: set submodule.recurse=true if user enables
 feature.experimental flag
Message-ID: <YRbYWR+X8vSq8CYe@google.com>
References: <pull.1006.v4.git.1628536305810.gitgitgadget@gmail.com>
 <pull.1006.v5.git.1628736366133.gitgitgadget@gmail.com>
 <xmqqeeaz70ph.fsf@gitster.g>
 <YRW0pGXXWnY7C470@google.com>
 <xmqqpmuiynbs.fsf@gitster.g>
 <YRbU0uBxqinQ1EnE@google.com>
 <xmqqv949uly9.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv949uly9.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 13, 2021 at 01:30:22PM -0700, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > I think the right move, then, is to explore whether your suggestion in
> > https://lore.kernel.org/git/xmqqeeaxw28z.fsf%40gitster.g is appropriate
> > - I have the sense that it is, but I want to make sure to think it
> > through before I say so for sure. 
> 
> Not that one---it was a 40% tongue-in-cheek comment, and does not
> deserve to be called a suggestion.  

Ah well ;)

Anyway, I think it does not make sense, as behavior starts to change for
people who already cloned expecting not to recurse (Jonathan N says this
is the case for his Rust checkout, for example) - and apparently
'submodule.recurse=true' has some weird edge cases for commands which
are happy to run out-of-repo.

Mahi mentioned wanting to rework her commit to use a config besides
'feature.experimental' for this same behavior, so hopefully we will see
that change come through soon - but today is also the last day of her
internship, so we may not be so lucky.

 - Emily
