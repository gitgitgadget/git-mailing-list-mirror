Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C96C6FA8F
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 22:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243983AbjHXW4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 18:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244043AbjHXW4p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 18:56:45 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0A01BFA
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 15:56:43 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59205f26e47so4387727b3.2
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 15:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692917803; x=1693522603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lfLCNc437Q6hMz/YlmrljAR4n2n152N3bdTQpRDI5Ys=;
        b=ESer49Ca9TAgf6VBdK+5ImR4eEKuL96MlK99VolguYssaayG0PTElby9Ib6FCNXr6u
         U33Ce4l7frM3gkHoBlUF2QRdWjPOHApGFb1CfGCPukz9EBZbnDNASgIyXRUccL/OZ7KV
         nCtar0K9U4kNMOKGhdM41Ud4fCJnzJYeupHiOmcAa/VMbVw2swYcAqoozZtWTJGyZX4j
         NLYUsyIHvLQGicwilkc1rYa/pc3UNPFOGDLmdWrNnm9GYH1l7VXXBwFTg/tPeif6yGpG
         //eSDMco9sxfzqZ7vm4hdZU0s0SaJyXCDh5QTIN9iw1jsgxnKCzu01kSnKn6mzmwmeIV
         XoKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692917803; x=1693522603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfLCNc437Q6hMz/YlmrljAR4n2n152N3bdTQpRDI5Ys=;
        b=Dy3OKW1jSM1H/8yV4JMh5iPn2del2CwD3c3Xz/kvzhHOIT8ZVkfkqdDafD7wpN9P0V
         WKknX/3LCcsMjMZpTXE5IOtf/+QEoq6I8ZUEfrIco4GNr8XUYicU6bl5dE0ez470npU4
         zUsTXGr2URdLF6d4z6fFqTsJQGB7e58za7dUzDXVjS4EQNZ8WDIpvWDcOt08fehKecWL
         XxDH3zhea6Z3ChsmDj50DB8vHPWGorUwy1ssczACddBrP+79WNBgmdpYmRo8+yYXFmfQ
         t4Xkwc4wTLM+Odow00o03Zyi+IbkG17GPr5WJ4VQbjlm5OyynfsU7AG4U7p8D3atWo0y
         ChXg==
X-Gm-Message-State: AOJu0YwMQFMhzv1A93uT7I01Ib9UEeAPWLH6RIs4KQWJ1TY6InfHRntF
        hamery9ticgNU/cYdvCpXGHgPYPjKZWKB1cP1tC4Ug==
X-Google-Smtp-Source: AGHT+IHPtXPWALGMoY7IO37iHLyTxr+625HL2BgCPC3k/ZHVXtSTCVcZeZ2PYxvU9kyqdIn3fTyixg==
X-Received: by 2002:a25:adc5:0:b0:d42:42f8:93c2 with SMTP id d5-20020a25adc5000000b00d4242f893c2mr16400247ybe.16.1692917802739;
        Thu, 24 Aug 2023 15:56:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n196-20020a2540cd000000b00d071631665fsm103011yba.59.2023.08.24.15.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 15:56:42 -0700 (PDT)
Date:   Thu, 24 Aug 2023 18:56:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Alexei Podtelezhnikov <apodtele@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: confused git diff -G
Message-ID: <ZOfgKQfqvef9FXZ6@nand.local>
References: <CAJU=AjWatV6A5Vx-yqRfG=yeUWxMvKocc4nTsdq58WHjaYFEzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJU=AjWatV6A5Vx-yqRfG=yeUWxMvKocc4nTsdq58WHjaYFEzw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 24, 2023 at 06:08:18PM -0400, Alexei Podtelezhnikov wrote:
> I find this sections of the docs confusing:
>
> git diff -G (https://git.kernel.org/pub/scm/git/git.git/tree/Documentation/diff-options.txt#n656)
>
>  I do not follow why the example talks about `git log -G` and commits.
> I see that thai file is included in git-log .txt but I do not
> understand how to use git  diff -G.

I agree that it can be somewhat confusing :-).

The linked section DIFFCORE-PICKAXE in gitdiffcore(7) may be helpful:

    DIFFCORE-PICKAXE: FOR DETECTING ADDITION/DELETION OF SPECIFIED STRING
           This transformation limits the set of filepairs to those that
           change specified strings between the preimage and the
           postimage in a certain way. -S<block of text> and -G<regular
           expression> options are used to specify different ways these
           strings are sought.

           [...]

           "-G<regular expression>" (mnemonic: grep) detects filepairs
           whose textual diff has an added or a deleted line that
           matches the given regular expression. This means that it will
           detect in-file (or what rename-detection considers the same
           file) moves, which is noise. The implementation runs diff
           twice and greps, and this can be quite expensive. To speed
           things up binary files without textconv filters will be
           ignored.

So if I have a setup like:

    $ git init repo
    $ git -C repo commit --allow-empty -m base
    $ for c in a b; do echo $c>repo/$c && git -C $repo add $c; done
    $ git -C repo commit -m changes

Then you can see `-G` has the effect of limiting the output of 'git
diff' to just those file(s) whose diff matches the regular expression
given to `-G`, like so:

    $ git -C repo diff --stat HEAD^
     a | 1 +
     b | 1 +
     2 files changed, 2 insertions(+)
    $ git -C repo diff --stat HEAD^ -G a
     a | 1 +
     1 file changed, 1 insertion(+)
    $ git -C repo diff --stat HEAD^ -G b
     b | 1 +
     1 file changed, 1 insertion(+)

(I'm using --stat here to keep the output brief, since the contents are
only important insomuch as files "a" and "b" match the regular
expressions "a" and "b", respectively).

Thanks,
Taylor
