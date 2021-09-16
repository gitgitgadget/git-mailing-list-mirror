Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78461C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A06F60F6E
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240714AbhIPWHC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 18:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240687AbhIPWHB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 18:07:01 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899F6C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 15:05:40 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id b5-20020a6541c5000000b002661347cfbcso6448085pgq.1
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 15:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Z5ZMaG5qruBAvaMqmUQfJbk2EHWPLlsAbCdbw9P6BPk=;
        b=eI1FaWzfjHGtxQze7Ze6Lo0HVm9OZbu36ElA3eK/1j1K0bmAsuw2njwl+r1O5zaaU2
         ca5UlsnFhBhhAAj+hibJl+71VsK/t3zUzIIb8ZF9YDg3Mo1EYAWjRW8garkCZJTTRY7z
         5fWIpGw2+SYxX1nwnm0ZI7UO4J+Cnz2IZZ1gam3PZFUGb+uGccQ2q0p1juNN2cYmsjCy
         Y5Y2BoQEv3//GjM/CGLh5UyTuqABsKf8Iko3SBVf5oB1UgX5X8VPyy5Fb0OI0CNAHxWv
         xB3/mPP0CWw7FOJq+Etau0qDx3RaYY41Qywx/H/OYqNj08noiWrK20nvoJdzLDIRqYZT
         xnsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Z5ZMaG5qruBAvaMqmUQfJbk2EHWPLlsAbCdbw9P6BPk=;
        b=KT+BuF2UQKRgkJ4wipOL/4p/Bx/ieRc435DGWKbm0JB3CsVuS124sF61VNtFemqqHa
         EqqCP4z4T9vXCFwm9jwEwI1lv7CRhfN3YOh+OWs/jwgcR16h8yDY4VEwL39mZPTLOS+3
         fn+lBj74fLL5juafz1snT3fePgrb7epGP8d2qpoGIj8fnu4O00IM8Sdct5zJFK9lqEg/
         aKF8WVp6P4iEWeDFVRmO4aG8oNYNkLSnLEVvsfGN9y+FRXwYwd2dDID2wDASm5iSBQ0Z
         /19DvkYaEDFritV1iL3TVzEzkDWdroo97Z9I+qZ+P1glb1mZv22CDsGyw4fmB7xAVFda
         PU5w==
X-Gm-Message-State: AOAM5333Ozz+Uq3MIlQp8FqA5sD8aeL1RuWpCuzYAbez92xuVI3ySP8u
        miUETVYQuW5J7iP8eSko50qB1zT6gwqTEZr5b6Kd
X-Google-Smtp-Source: ABdhPJwZnf6HLdni0RQtg3xyid+XmNiTKhjySePjQ7GRU86NN7AYFEUjMFn92XuoGVjmqXwZCsNaZO6hOelQR1/eDeqk
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:100b:: with SMTP id
 gm11mr233464pjb.0.1631829939749; Thu, 16 Sep 2021 15:05:39 -0700 (PDT)
Date:   Thu, 16 Sep 2021 15:05:36 -0700
In-Reply-To: <xmqqilz0rxpm.fsf@gitster.g>
Message-Id: <20210916220536.1107783-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqilz0rxpm.fsf@gitster.g>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: Re: [RFC PATCH 1/2] refs: make _advance() check struct repo, not flag
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, hanwen@google.com, chooglen@google.com,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Yes, the packed backend doesn't need to be a ref backend.
> 
> Sorry, I do not follow.  Do you mean we cannot have a version of Git
> that offers say a read-only access to the repository without any
> loose refs, with the default ref backend being the packed one?
> 
> Or do you mean that we can ignore such a hypothetical use case and
> could reimplement the files backend that can also understand the
> $GIT_DIR/packed-refs file directly without "deferring to another ref
> backend which is 'packed'"?

I meant the latter - more specifically, the files backend could defer to
functions that are not necessarily inside a struct ref_storage_be.
