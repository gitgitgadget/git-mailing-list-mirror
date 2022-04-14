Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A23C433F5
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 09:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiDNKAH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 06:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiDNKAG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 06:00:06 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823B0120BE
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 02:57:41 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id lc2so8964773ejb.12
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 02:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x7mWm04cULY0H6w7dSwezek5nBWxdT0IrMGzz3YjzJU=;
        b=QGvT4w0UPpcvCcjdCKuz1GcrN0jIsNFRQxgyGzjDqmevddlNNfbBrLXY1iI/Rp5VvY
         +H7WYEZ5C44txwov0dHuwrafUmcj3RE/EDHyN+QF5NsyWjKm+8yyMEobg57oCnLbpbYu
         tvtVnEI8iumncwiko+N5KULP2NXrf94GztJ/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x7mWm04cULY0H6w7dSwezek5nBWxdT0IrMGzz3YjzJU=;
        b=SaxlQI/0lEzVE0qBHMRAT0ODsA8ZBMvd7OtbKYD5LAPvnTzYdKDDHQaY2OzbVXnd0t
         yOk7CDte43R4cHpiehogMOvHg34V3CR0gvZv/7aQWcpVjmhggt5m02f3gB5Ix3HASedo
         OrAg+FrTI0bf+Oy1PLgbu+hTDi2FdatF6/pHkVRiZ3PmbxuevPuXtfqacRRkzi0uPvbi
         DeEz2XJgEBk9D3a+BuHggs0ZB5LgcEXEIEp7VpF7pcbORkggSmd1H6R6TIcaJxwhCExl
         Y5cglb4zissLvwzOMsmx88m7NschdsBVi3t5GZfxyz3rUtjh88PMQ3G4RBlf4er55PPZ
         bB8A==
X-Gm-Message-State: AOAM5302GfYZiTLvtugjVlrkhnefRbEitbW9Ne3N2NWn836VBhZIGJiB
        7YzmsjFoMZIYdEqzRM91r4SrSZxfS0LnqD8GTyx/61psf8+a+oKzfUE=
X-Google-Smtp-Source: ABdhPJwoySQ40Z6RJvJW52pBGMJ9R0dJgGXYORJRKsUhvtZ42uNC89IhnipTscunMK70tXzC29DUQEaiav8BFpe/uP4=
X-Received: by 2002:a17:907:1c9a:b0:6e8:da0a:f788 with SMTP id
 nb26-20020a1709071c9a00b006e8da0af788mr1602665ejc.170.1649930259894; Thu, 14
 Apr 2022 02:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1206.git.1649670174972.gitgitgadget@gmail.com>
 <pull.1206.v2.git.1649831069578.gitgitgadget@gmail.com> <20220413214109.48097ac1@ado-tr.dyn.home.arpa>
In-Reply-To: <20220413214109.48097ac1@ado-tr.dyn.home.arpa>
From:   Tao Klerks <tao@klerks.biz>
Date:   Thu, 14 Apr 2022 11:57:29 +0200
Message-ID: <CAPMMpoiXNKNnARhJ2n+nzOj==-27YA68OvMmUyYnSaoLbfE4xw@mail.gmail.com>
Subject: Re: [PATCH v2] [RFC] git-p4: improve encoding handling to support
 inconsistent encodings
To:     Andrew Oakley <andrew@adoakley.name>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 13, 2022 at 10:41 PM Andrew Oakley <andrew@adoakley.name> wrote=
:
>
> On Wed, 13 Apr 2022 06:24:29 +0000
> "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> wrote:
> > Make the changelist-description- and user-fullname-handling code
> > python-runtime-agnostic, introducing three "strategies" selectable via
> > config:
> > - 'legacy', behaving as previously under python2,
> > - 'strict', behaving as previously under python3, and
> > - 'fallback', favoring utf-8 but supporting a secondary encoding when
> > utf-8 decoding fails, and finally replacing remaining unmappable
> > bytes.
>
> I was thinking about making the config option be a list of encodings to
> try.  So the options you've given map something like this:
> - "legacy" -> "raw"
> - "strict" -> "utf8"
> - "fallback" -> "utf8 cp1252" (or whatever is configured)
>
> This doesn't handle the case of using a replacement character, but in
> reality I suspect that fallback encoding will always be a legacy 8bit
> codec anyway.
>
> I think what you've proposed is fine too, I'm not sure what would end
> up being easier to understand.

I'm not sure I understand the proposal... Specifically, I don't
understand how "raw" would work in that scheme.

In "my" current scheme, there is a big difference between "legacy" and
the other two strategies: the legacy strategy reads "raw", but also
*writes* "raw".

The other schemes read whatever encoding, and then write utf-8. In the
case of strict, that actually works out the same as "raw", as long as
the input bytes were valid utf-8 (and otherwise nothing happens
anyway). In the case of fallback, that's a completely different
behavior to legacy's read-raw write-raw.

Is your proposal to independently specify the read encodings *and* the
write encoding, as separate parameters? That was actually my original
approach, but it turned out to, in my opinion, be harder to understand
(and implement :) )

>
> >      * Does it make sense to make "fallback" the default decoding
> > strategy in python3? This is definitely a change in behavior, but I
> > believe for the better; failing with "we defaulted to strict, but you
> > can run again with this other option if you want it to work" seems
> > unkind, only making sense if we thought fallback to cp1252 would be
> > wrong in a substantial proportion of cases...
>
> The only issue I can see with changing the default is that it might
> lead to a surprising loss of data for someone migrating to git.  Maybe
> print a warning the first time git-p4 encounters something that can't be
> decoded as UTF-8, but then continue with the fallback to cp1252?

Honestly, I'm not sure how much a warning does. In my perforce repo,
for example, any new warnings during the import would get drowned out
by the mac metadata ignoring warnings.

I understand and share the data loss concern.

As I just answered =C3=86var, I *think* I'd like to address the data loss
concern by escaping all x80+ bytes if something cannot be interpreted
even using the fallback encoding. In a commit message there could also
be a suffix explaining what happened, although I suspect that's
pointless complexity. The advantage of this approach is that it makes
it *possible* to reconstruct the original bytestream precisely, but
without creating badly-encoded git commit messages that need to be
skirted around.

>
> >      * Is it OK to duplicate the bulk of the testing code across
> >        t9835-git-p4-metadata-encoding-python2.sh and
> >        t9836-git-p4-metadata-encoding-python3.sh?
> >      * Is it OK to explicitly call "git-p4.py" in tests, rather than
> > the build output "git-p4", in order to be able to select the python
> >        runtime on a per-test basis? Is there a better approach?
>
> I tried to find a nicer way to do this and failed.

OK thx.

>
> >      * Is the naming of the strategies appropriate? Should the default
> >        python2 strategy be called something less opinionated, like
> >        "passthrough"?
>
> I think that "passthrough" or "raw" would be more descriptive names.
>

OK thx, I'll take "passthrough" as it feels slightly less positive
than "raw", for some reason that I can't put my finger on :)

> The changes to git-p4 itself look good to me.  I think that dealing
> with bytes more and strings less will be good going forward.

Thx for your feedback!
