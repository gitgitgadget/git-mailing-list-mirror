Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DADBC433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 20:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242208AbiAKUDh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 15:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242072AbiAKUDe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 15:03:34 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833AFC06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 12:03:34 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id jo14-20020a056214500e00b00411de582251so464620qvb.8
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 12:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PgrVPaDsdrDzInC+0U4wnoFDET0ehOb2iH2qQGzYPyo=;
        b=Jfp3Tl/sz2BNhYFPhtOTMbMkyaORx6Jby+9aNwyxIg+J8csaQ1PUYaIrm002kvZvpM
         XuzX2Vo3R437ds9ylNA6VPXYF8IPYgBnmrSbs1bDylVc++nevlrtqjyKmwRcruEWQlJ5
         VoiZeuzGRr0PuvP00igBqO6a5B/ifIKXxeG1qMhSb7YiDOyGwO0kaBShIPsDPBGFj2AJ
         0Ww2UigRZqkJbXGGeauzEecoQiKOTdDxxtShRpJE9zkked38tl7YiXvMv5cyvQ2el/ds
         aswm3sYsrRx7bNcryJPENHg+N7+qW0QWWC6Aec7LkudTTACaCii87E4uHKH3QGKZpE/d
         Jodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PgrVPaDsdrDzInC+0U4wnoFDET0ehOb2iH2qQGzYPyo=;
        b=aGZrw9xl3kvT762zZSUYHeKNCiiqtU1Gi4eXkJIm4BYeYZc5xv+iAXskHlCmQQ0Kb9
         C0fByZei3G4mLGZsrlydsKxt1IYkgzTYPxRk3LamMPotLSco4kZE1cf+TuzxUMHN5CHc
         PnZgBlufqMoFDDBibkVJqaCevnXu8Mzjet3NbjSlJzqJ7glo2/S4h6LyLQufBWQd04eu
         s4f4qW+xXk2+L47Z//Ot+PwPqDKnyA86+HhF43SROsZ9Vn6kqdTqON5TQHkOZ1NMmwlP
         HebIm9HL4YyqLnj/jnbKSqL7osWmPGI8GLD3cw561vX9/G85IvdGzRUo2m8naz9zHpcF
         cFEA==
X-Gm-Message-State: AOAM530eQVg0UKJkAA8YJi9pwRECMgG4/UnIC3xDjxqSeBmN0ZGbTPuo
        3Ch0zyw3+Wx5uU1rWpphWNXaTDSV1lBaT5L2IS3e
X-Google-Smtp-Source: ABdhPJyurK3cYwgK6JCXJIJhZD59pqlApwXTREYQtfC/N1RQF22wSml3azgYaghVO40dKbaGeosu9r5q5byklx7Q8qD+
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:ac8:7dd5:: with SMTP id
 c21mr5104076qte.345.1641931413656; Tue, 11 Jan 2022 12:03:33 -0800 (PST)
Date:   Tue, 11 Jan 2022 12:03:30 -0800
In-Reply-To: <kl6la6g2kwp5.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <20220111200330.23366-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <kl6la6g2kwp5.fsf@chooglen-macbookpro.roam.corp.google.com>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
Subject: Re: [PATCH v6 1/5] branch: move --set-upstream-to behavior to dwim_and_setup_tracking()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     chooglen@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, steadmon@google.com,
        emilyshaffer@google.com, avarab@gmail.com,
        levraiphilippeblain@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> >> @@ -401,7 +410,34 @@ void create_branch(struct repository *r,
> >>  
> >>  	if ((commit = lookup_commit_reference(r, &oid)) == NULL)
> >>  		die(_("Not a valid branch point: '%s'."), start_name);
> >> -	oidcpy(&oid, &commit->object.oid);
> >> +	if (out_real_ref)
> >> +		*out_real_ref = real_ref ? xstrdup(real_ref) : NULL;
> >
> > I think you can just write "*out_real_ref = real_ref; real_ref = NULL;"
> > here, and then not need to xstrdup.
> 
> Hm, you are right. The xstrdup was added because the original function
> calls FREE_AND_NULL(real_ref) and then checks if real_ref is NULL. But
> after the refactor, real_ref is not referenced after the
> FREE_AND_NULL(real_ref), so that call can be removed.
> 
> I intend to remove the xstrdup, though it will introduce a bit of noise
> because that block will no longer be moved wholesale.

Ah, thanks for watching out for the diff. I think in this case, we'll be
fine, since the xstrdup line is a new line ("xstrdup" only appears once
in the diff, here).
