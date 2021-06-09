Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D37C48BCF
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 18:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A11B610C7
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 18:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhFISSP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 14:18:15 -0400
Received: from mail-pj1-f74.google.com ([209.85.216.74]:57949 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhFISSP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 14:18:15 -0400
Received: by mail-pj1-f74.google.com with SMTP id om12-20020a17090b3a8cb029016a4ee7d56fso1830373pjb.7
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 11:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sqCozxzDtnlRRJCFJxx2UR/4h1feC1ABxGaGoUZ2mMg=;
        b=OvH0hqEHfX5Kb+myuty6ECoLSYTGgaN8qrWhAn3oKJDna+CvF9yykFiu97zXUV0p7A
         /GXBDHedQU0pRTpgU5tjyPB5Y0a6nR2U9Z40WXlZYs6WMAlBMxxqUAF9xArxtjVmtVx1
         TNdOLWZPBHrP5rUUQfeJBze0jIMjs3Szug2pYHbc5q7R93bUxoHi7hf2GgfX2pQ4pIam
         daocsqFF3kr++ABjlam1A1sVH3DaIcgnZwHKGpbPWNZ3hRg3F/biAuePD+GTi085vJAO
         1t7kUUG93MaATMS5j+bCZlYwZJzOlrJiS1cgESF4hq7nkVgcBx1P6lNCUt6QkJ3eWGU8
         QryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sqCozxzDtnlRRJCFJxx2UR/4h1feC1ABxGaGoUZ2mMg=;
        b=I3Ge5L9xBYRlW7kGvuYSAS7FuLpdGL/TCx31YcdcFa3ist3vi+DnA8Ne8o7vDeZ88/
         BrIUq8iERDds2NguKJzO/LGje9wZhDxeu5u5sNcDD6iW+dV9Eksvw/guMvg90QMCDQD4
         6YpJbG9uhwHVnC3zZc20BIBqDkLJpzfMBYArflQWKI6BmY5U57Kgbb5+N9M98EJeYfj/
         vBj449QibpJwiwPfjduQ7dpCt/aTZYL+1AjLdvufwNzxuItRTVTu50H0+WjNGj1V/FGc
         DRKakcRXcbqPkuHgY5giSFWcYM9a3B+Epf9V06d1GlNv7QQqnFCZrNBAmD/RkvDy66my
         jQbQ==
X-Gm-Message-State: AOAM532UOE0op/t5tO+QTiQgiBd1eLnxcSrgEESAkWj7Irw4sRxoQsdQ
        kCzcLH7ziNHLUAOaVHNdz/xCPXjTDLmmy1vZ1Kb3
X-Google-Smtp-Source: ABdhPJxOryxF/1d6uHv8T3dBdndS0sOsCntBLkIynzpe71KfFHUepqjhqOZzzLt1Idz4XqooPRf2aJ7jPALiM5Mwog4u
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:a393:: with SMTP id
 x19mr104648pjp.1.1623262509251; Wed, 09 Jun 2021 11:15:09 -0700 (PDT)
Date:   Wed,  9 Jun 2021 11:15:07 -0700
In-Reply-To: <xmqqo8cfk3nk.fsf@gitster.g>
Message-Id: <20210609181507.2400682-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqo8cfk3nk.fsf@gitster.g>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: Re: [PATCH v2 3/4] run-command: move envvar-resetting function
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, me@ttaylorr.com,
        newren@gmail.com, emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > As for the config pairs, they are currently being
> > passed through - do you have a situation in mind in which they should
> > not be passed through?
> 
> Wasn't the GIT_CONFIG_KEY/VALUE meant as a moral equivalent of the
> GIT_CONFIG_PARAMETERS for those scripts that do not want to bother
> following the quoting rules of the single parameter approach?
> 
> I do not see why we should filter configuration variables passed via
> one mechanism and let variables passed via the other machanism
> through.  That feels inconsistent (I suspect that there may already
> be inconsistencies introduced when GIT_CONFIG_KEY/VALUE mechanism
> was added, though).

Yes, I think you're right. The filter was added in 14111fc492 ("git:
submodule honor -c credential.* from command line", 2016-03-01) (letting
a sanitized version of GIT_CONFIG_PARAMETERS through) and took its
present form in 89044baa8b ("submodule: stop sanitizing config options",
2016-05-06) (removing the sanitization). GIT_CONFIG_KEY/VALUE was only
added in d8d77153ea ("config: allow specifying config entries via envvar
pairs", 2021-01-15).

Reading the commit messages of these commits, I agree that
GIT_CONFIG_KEY/VALUE should be treated the same way as
GIT_CONFIG_PARAMETERS. In particular, 14111fc492 mentioned passing
credentials as the reason for the feature, and in d8d77153ea, the
ability to pass secrets without exposing them to a user running "ps" was
one of the motivating reasons. I'll add a commit changing this before
this commit.
