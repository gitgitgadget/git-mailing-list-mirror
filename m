Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C51C433FE
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 16:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiKXQb6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 11:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiKXQb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 11:31:56 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0139016FB2F
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 08:31:55 -0800 (PST)
Received: (qmail 27233 invoked by uid 109); 24 Nov 2022 16:31:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Nov 2022 16:31:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28687 invoked by uid 111); 24 Nov 2022 16:31:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Nov 2022 11:31:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Nov 2022 11:31:54 -0500
From:   Jeff King <peff@peff.net>
To:     Yoichi Nakayama <yoichi.nakayama@gmail.com>
Cc:     Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v4 2/2] git-jump: invoke emacs/emacsclient
Message-ID: <Y3+cepfUpi0vm7yM@coredump.intra.peff.net>
References: <pull.1423.v3.git.1669033620.gitgitgadget@gmail.com>
 <pull.1423.v4.git.1669126703.gitgitgadget@gmail.com>
 <2f0bffb484beccf58f2440ed5e2c04a1ba26e6c3.1669126703.git.gitgitgadget@gmail.com>
 <Y30a0ulfxyE7dnYi@coredump.intra.peff.net>
 <CAF5D8-vSsBsdiA8SiDgqUFkL9_3N-v+psVxj-AcibOB88gxWfA@mail.gmail.com>
 <Y37EPdUkBhsSPmRD@coredump.intra.peff.net>
 <CAF5D8-u14grTa9cUo=ge8TVRKNYtVHWhFHDW8yYD9gD8=f0Byg@mail.gmail.com>
 <CAF5D8-vXK81U_n06u=p=B9urTWyQ5+fN8_w9FeCWQOv1xen07Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAF5D8-vXK81U_n06u=p=B9urTWyQ5+fN8_w9FeCWQOv1xen07Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 24, 2022 at 09:58:04PM +0900, Yoichi Nakayama wrote:

> > The original vim version used the notation \$1 instead of $1.
> > I'm worried that the emacs version might need the backslash.
> > What does the backslash mean? Is it necessary?
> 
> I found the answer myself. The backslash is to leave the
> evaluation of the argument to the 'eval' execution.
> And another question arose. Why do we use eval?
> What is the difference from running it directly like below?
>     $editor -q $1

The value of $editor is not a single program name, but is itself a shell
command. So you could imagine:

  git config core.editor "some_command --with --args"

or even more complicated shell hackery. From within Git, we'd run it as:

  sh -c "some_command --with --args"

but when you are in a shell already, "eval" is a more efficient way of
doing the same.

-Peff
