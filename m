Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A99EC47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 20:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01874613D7
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 20:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhFCUYu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 16:24:50 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:36823 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCUYt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 16:24:49 -0400
Received: by mail-pf1-f178.google.com with SMTP id c12so5802195pfl.3
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 13:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j5BUSKPbaX2jXo0M0vJykNOEfHXlT8oKNTZcjJCkLFo=;
        b=c2mlA0mrB3z9wWW/JA6HFaOiYK7W9XWm6PnuOGgCq3n7DBIsS+GNVGkNHawYHdhZ2P
         BbTDnR1uDyaU3FY0BodnamI9jMRKGDNOZeZjYQUQzPmFpQZIcUT+d42AlEuziqZd7Yq7
         /U3ni63S0c9hRhn94o3KMUR6jOLsHl0ELWICk+qIQkiE8bLUZhRdcxtB46h4YwkLfFwz
         HyJUbsKx8Y6N2dUP7kk6e7fFGmoN/T6fhDA1q0mtSUz1zBFX0V5dC1ZvmIx4RAxg5xGh
         xAkbJel/lOhjcGSkQy2ULJ9JbBF9Vt6eQvisi9XDJHavY1eyN2thJJzr2Dc0upIl7W99
         yPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j5BUSKPbaX2jXo0M0vJykNOEfHXlT8oKNTZcjJCkLFo=;
        b=ZQ2SU72Q2Ek9byctnK75lF4qqrpzI4He/p5uVps9CvERdezYPbExtlq6NePi+Lnq0n
         1opm/GjgRba86YhUZ35z7V9+x0k61uhmbkjgx78kqxmQvUDo3gjLLFPEmKc6A5X9XOC9
         4wlnOO5F3uYH4lZPy2lrkUCbbU3unqZu/4aJzq14gcnGPabC6/dbLSNm1CHYevTeTCFN
         mNz1y59DPYmoPHDWwL5qi99CvxcYFSdajtmvIUgeB6GwjVK4g0PQox0q8q4N5LQ7VrLv
         dOrAh/mNIVtx9EtHtMugtLniO+judC7uIkBzqxOtd4z2rzTi2B0+HfVMaCcT4hhxLX9Q
         aIqg==
X-Gm-Message-State: AOAM530JxIAFMapVA9/H4kUkYKtCWFyKaGmt3X3z8whC8gqsJiCjQIPT
        MVlgNXrtYq8vc2tn4WfuQzMPhf1bpKiRg4nOzNgHIw==
X-Google-Smtp-Source: ABdhPJyzxIB8Kg5FmErlBUFIplQ+NY4psKcjWEY1a71RQ/Fa1DfkojbZMR0PljyTgrvZneZis5M/70cdY39oB1ZCqt4=
X-Received: by 2002:a62:2987:0:b029:2de:b564:648d with SMTP id
 p129-20020a6229870000b02902deb564648dmr827176pfp.48.1622751724464; Thu, 03
 Jun 2021 13:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <002701d757d8$1a8d9dc0$4fa8d940$@nexbridge.com>
 <YLfc2+Te7Y3UY+Sm@nand.local> <YLfgy94sbmStC0mR@coredump.intra.peff.net>
 <20210602201150.GA29388@dcvr> <YLfmo8kl0URnGgp5@coredump.intra.peff.net>
In-Reply-To: <YLfmo8kl0URnGgp5@coredump.intra.peff.net>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Thu, 3 Jun 2021 13:21:52 -0700
Message-ID: <CAGyf7-G=B+S6m9mifjOCFKGfEx69zzdOoCr03ckK7fJZrNEGtg@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.32.0-rc3 - t5300 Still Broken on NonStop ia64/x86
To:     Jeff King <peff@peff.net>
Cc:     Eric Wong <e@80x24.org>, Taylor Blau <me@ttaylorr.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 2, 2021 at 1:14 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, Jun 02, 2021 at 08:11:50PM +0000, Eric Wong wrote:
>
> > Jeff King <peff@peff.net> wrote:
> > > And so when he gets this error:
> > >
> > >   fatal: fsync error on '.git/objects/pack/tmp_pack_NkPgqN': Interrupted system call
> > >
> > > presumably we were in fsync() when the signal arrived, and unlike most
> > > other platforms, the call needs to be restarted manually (even though we
> > > set up the signal with SA_RESTART). I'm not sure if this violates POSIX
> > > or not (I couldn't find a definitive answer to the set of interruptible
> > > functions in the standard). But either way, the workaround is probably
> > > something like:
> >
> > "man 3posix fsync" says EINTR is allowed ("manpages-posix-dev"
> > package in Debian non-free).
>
> Ah, thanks. Linux's fsync(3) doesn't mention it, and nor does it appear
> in the discussion of interruptible calls in signals(7). So I was looking
> for a POSIX equivalent of that signals manpage but couldn't find one. :)
>
> > >   #ifdef FSYNC_NEEDS_RESTART
> >
> > The wrapper should apply to all platforms.  NFS (and presumably
> > other network FSes) can be mounted with interrupts enabled.
>
> I don't mind that, as the wrapper is pretty low-cost (and one less
> Makefile knob is nice). If it's widespread, though, I find it curious
> that nobody has run into it before now.

I was dealing with a similar issue[1] recently, albeit not in the Git
codebase but rather with Java. My issue was with epoll_wait, rather
than fsync, which is documented on signal(7) as not restartable even
with SA_RESTART. That led me to this[2] little bit of code inside the
JVM:
#define RESTARTABLE(_cmd, _result) do { \
  do { \
    _result = _cmd; \
  } while((_result == -1) && (errno == EINTR)); \
} while(0)

which they use like this[3]:
RESTARTABLE(epoll_wait(epfd, events, numfds, -1), res);

Not sure what the Git maintainers' view on macros is, but if there
wasn't going to be a Makefile knob perhaps something similar might
make sense as a reusable construct. Of course, it's unclear how often
Git might _need_ such a thing; given this doesn't seem to come up
much, perhaps that's a sign such a macro would end up a waste of
effort. Anyway, just thought I'd share because I was looking at
something similar.

[1] https://github.com/brettwooldridge/NuProcess/issues/124
[2] https://github.com/JetBrains/jdk8u_jdk/blob/94318f9185757cc33d2b8d527d36be26ac6b7582/src/solaris/native/sun/nio/ch/nio_util.h#L33-L37
[3] https://github.com/JetBrains/jdk8u_jdk/blob/94318f9185757cc33d2b8d527d36be26ac6b7582/src/solaris/native/sun/nio/ch/EPoll.c#L92

>
> -Peff
