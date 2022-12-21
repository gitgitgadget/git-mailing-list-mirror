Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88059C4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 21:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbiLUVNa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Dec 2022 16:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiLUVN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2022 16:13:27 -0500
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8927C21C
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 13:13:26 -0800 (PST)
Received: by mail-pf1-f173.google.com with SMTP id 130so11545426pfu.8
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 13:13:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N2O5PbD/oIeAzvC8ibYobG6f5MQAS7m4+hKNXYe3r1g=;
        b=jAIp8lAEkA5njAqzr4EHnmCrOqAeL6OLdGiHtN7nVX54kN7sCFvdubAddKvIabiUyn
         +lmjJb0I0/B8Tvesg686FKirMjj7v6PUhg6NjqrQjIAp1y9rEragl4shyLJoiA3si3Mb
         fx9BhN1GXL4LrPpABbV8RqbXiXsRkqOVHGC6r2/9GYOybOj88F9C9EKWOXzM+3gugORP
         HWgDsmYEmFM/vLfSgLBEtMkHtdnfcitC1xmQhdG4rj33lyus3TyUvFyTWt0ECJUc7fCe
         wJAQCgtw2tV2DTH7ZoGgRYMmIgVGjGW000TdV85RFj/cqBWedgq46qHDrA8HswO+5kyl
         X/jA==
X-Gm-Message-State: AFqh2kp/OfqeUpozRTlQnE9Xy1ZXDaqW02PxDgX59LKryricAF+kP0HA
        hZLLOWZ3FFC0Uh10dGvWMTI2/Nai4Xrxi6WZIy8=
X-Google-Smtp-Source: AMrXdXvNOE8hvtNk2DNYXJKe/czZn5wQltmjPX25tq3YU787zETe++Yyw7zvPbJDkoqKaanoZ3VG8lp5PQUtGrEW4sU=
X-Received: by 2002:a63:a12:0:b0:478:fbfd:5278 with SMTP id
 18-20020a630a12000000b00478fbfd5278mr156524pgk.268.1671657205960; Wed, 21 Dec
 2022 13:13:25 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671630304.git.karthik.188@gmail.com> <a161dbdf8b70354716d0bfeccc707c242c7f33a1.1671630304.git.karthik.188@gmail.com>
 <cc2e5f1e-8f53-ad83-1f5d-ae910ab60c53@dunelm.org.uk>
In-Reply-To: <cc2e5f1e-8f53-ad83-1f5d-ae910ab60c53@dunelm.org.uk>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 21 Dec 2022 16:13:14 -0500
Message-ID: <CAPig+cTHJzHsUum0RnyCcqxj1qhxJR9EcKRjoShCznQ_oXYHOA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] attr: add flag `--revision` to work with revisions
To:     phillip.wood@dunelm.org.uk
Cc:     Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
        Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 21, 2022 at 3:58 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> On 21/12/2022 13:47, Karthik Nayak wrote:
> > Since we use a tree-ish object, the user can pass "--revision
> > HEAD:subdirectory" and all the attributes will be looked up as if
> > subdirectory was the root directory of the repository.
>
> We should be clear in the documentation and option help that --revision
> takes a tree-ish (i.e. --revision=<tree-ish>). Maybe calling the option
> --tree would be clearer.

If that's the case, shouldn't this be called --source (or some
variation thereof) for consistency[1] with git-restore?

[1]: https://lore.kernel.org/git/CAPig+cT_xz3m-3kkL_Scf0opNXkikU94kSF46VO8KHkNMWbGzg@mail.gmail.com/

> > +attr_check_revision () {
> > +     path="$1" expect="$2" revision="$3" git_opts="$4" &&
>
> Is that line valid posix shell? I know it works with local (which is not
> in posix) but is it allowed for global variables?

This is fine as-is; it's POSIX.
