Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF3EC433F5
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 19:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242449AbiAJTWw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 14:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiAJTWv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 14:22:51 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF13C06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 11:22:51 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s127-20020a252c85000000b0060be2b7b8e9so29244676ybs.8
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 11:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RTAYEfSmbkMnvHzk4qXzvBuuOwbW3bZaAT//zmtru6o=;
        b=DUf8g0DuKWyMFacc5ou+SyrKbZ0e/2SaGCYY1SIT2F8JuIImg8jhxAW8CxPB7nHfXO
         sBorxJ+2vLIr6tdFFiHNK1nPhsKFma+uXY25j/IKtCn+RnETmznRNUgV30mE9grIR4EU
         YjGcpqxuJTAZH45ajpi0zHED6NYi1apccmncu4HziksdLT9uqHOwqNFn5w+TqCvgF3Hn
         8vS+X1QFounXuPeI4m9I1EHl8cysRRJ9v+N0vxqw86laL6mXG1YU8kdLxamdLkSMq3xk
         GY2EqHMngl+6f4e8p+qFBFKjLfp9xyZ3loKccNMClYKokQM6VAGrhKNIF6UlscL+of0I
         AOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RTAYEfSmbkMnvHzk4qXzvBuuOwbW3bZaAT//zmtru6o=;
        b=28YT/IiQR3URa7X95XowxCJKIzkfxYnIE9w1ZvlTYu/W0wDXRgQ1uldSt1rL7cCc6Y
         U82x9aXxK6Co7S4UI6kcgPw9rKELAFHdmDMzRRTRm6svLRUlnZsfJdL6F8EzPtFk7/GM
         yA/v14+cDpvDcVcCHjSc57FzQ7oGK/wi7KRorzcwgeUl9ibYL3N9BKj5xsPsEeG2IIFG
         HZfcSCPiHWuSq5xfnv9m39N5PwmACX5uWlWJcKSIFuAry+QATUrllCKEYFxi6FMHh/2O
         WqagIYFgZaiDpoig6UcsFBvSRBDuViObig2o3P044E+UV3ziz78LYjMZ4lKf62lq1bDt
         K5Zw==
X-Gm-Message-State: AOAM531+vnjHWr/eKyozG8UwMSzfvhaU2V8vtPDqD22vvW5GkU67LY3r
        mVIRBHI+s80J3JqhIxf+oPWNY60ZCPUSk+m42WSs
X-Google-Smtp-Source: ABdhPJxjWqdUZsbzlPwq0H+20KH49sFcFWtcGkMF6++2KaNs9dSnMC+fHDxKbk9BbULFaqWbX2wtXiyNKwotPB76+Lo2
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:6c55:: with SMTP id
 h82mr1570109ybc.214.1641842570630; Mon, 10 Jan 2022 11:22:50 -0800 (PST)
Date:   Mon, 10 Jan 2022 11:22:46 -0800
In-Reply-To: <CABPp-BFLNqLuJ8o_6YZDYgd=Ft+wc9EjBPX+RRzwAdASKSW2bw@mail.gmail.com>
Message-Id: <20220110192246.1124991-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CABPp-BFLNqLuJ8o_6YZDYgd=Ft+wc9EjBPX+RRzwAdASKSW2bw@mail.gmail.com>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
Subject: Re: [PATCH v7 0/2] Conditional config includes based on remote URL
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, chooglen@google.com,
        gitster@pobox.com, stolee@gmail.com, Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:
> On Wed, Dec 15, 2021 at 7:25 AM Jonathan Tan <jonathantanmy@google.com> wrote:
> >
> > Thanks, everyone, for your comments. I've followed Glen's code
> > suggestion and Junio's documentation suggestion, as you can see in the
> > range-diff.
> 
> So, the basic idea is, in a setting like Google's, you can have users
> install additional files on their system out-of-band, and have the
> users specify a simple line in their configuration to make use of
> those additional files -- or portions thereof.  It's a way of easily
> providing potentially large blocks of pre-vetted configuration for
> users.
> 
> Seems to make sense.  (and I've read over the code lightly, so feel
> free to take this as an Acked-by.)

Thanks.

> But can I back up and comment on a bigger picture item?
> 
> This mechanism requires somehow getting additional files to the user
> separately; projects that span companies (git.git, linux.git, etc.)
> won't likely be able to make use of this.

Yes, they would also need to use a separate mechanism in addition to
Git.

> Scalar also has a mechanism for providing potentially large blocks of
> pre-vetted configuration for users.  It does so as part of a new
> top-level command.  And it does so with a very opinionated set of
> values that are not configurable.  Thus, while I'd like to use it,
> they use a configuration option that would break things badly at my
> $DAYJOB.  (Too many gradle plugins using jgit, which doesn't
> understand index.version=4 and will blow up with a very suboptimal
> error message when they see it.)  And, it's very specific to scalar;
> we probably don't want to add a new toplevel command everytime someone
> wants common configuration to be easily grabbed by some user.

Do you have more information on this? The closest thing I've seen is
"Scalar Config" under "Modifying Configuration Values" in [1], which
seems to be more about bundling additional tools (which may change
config, of course).

Unless you're referring to the config bundled in the Scalar tool itself,
in which case this patch set seems orthogonal and potentially
complementary - I was envisioning config being provided by a package
manager package, but Scalar could provide some too for users to use at
their own discretion.

[1] https://github.com/microsoft/git/blob/7a514b4c2d5df7fdd2f66f048010d8ddcb412d0b/contrib/scalar/docs/troubleshooting.md

> It would be nice if we could find some more generic solution.
> Granted, I can't think of any, and I don't think this comment should
> block this particular series (nor the scalar one), but I am worrying a
> little bit that we're getting multiple completely different solutions
> for the same general problem, and each brings caveats big enough to
> preclude many (most?) potential users.  I don't know what to do about
> that, especially since configuration that is too easy to propagate
> comes with big security problems, but I wanted to at least raise the
> issue and hope others have good ideas.  If nothing else, I want to
> raise awareness to avoid proliferation of similar
> pre-vetted-configuration-deployment mechanisms.  I'm CC'ing a couple
> scalar folks as well for that point.

That's a good point. As Glen said [2], it seems like transmitting config
itself (or, at least, hooks) through Git is something that we (the Git
project) don't want to do, so I have been working from the basis that
Git should just make use of config/hooks delivered through a non-Git
mechanism, and not deliver the config/hooks itself.

[2] https://lore.kernel.org/git/kl6lee5w5nng.fsf@chooglen-macbookpro.roam.corp.google.com/
