Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EEEC2D0CD
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 11:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0648A206D7
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 11:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJGOsGgN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfLRLJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 06:09:35 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35314 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfLRLJe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 06:09:34 -0500
Received: by mail-ed1-f66.google.com with SMTP id f8so1325447edv.2
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 03:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fUmEsiElKhDKhlT3SfLGEU08rVbAl9ZDdGZHeDZ/yRc=;
        b=lJGOsGgNI9bcJitbUT6Ffx141acMG/RXmKwIu1GoB2s/t8YojQU5g7tdoxiS5Bj4wK
         1PusTHZV6vl4bfhe3PZU2tGaUozC80w3klWLeC7K74mMB2u+0ea8K6Q2BilerfgWJEC0
         Irq+ZDKKP+frNKbkk/QfDoaLTFBZU/u/o0AIyR/Vq7AFdDvInt0BMoDKA8V9SPxjViTL
         ywTPoxRRe0iwWJaSYegS27/IQ5E+Aq2E7OPbt4gcWQmGkk6KAUuEPG0Iqb0RrjIhjoq7
         MUJBEZjtQQtbHpIYYH0ociVY43NvVZD2M40Z1Lf8CLBq+Zpt0oFVXF5CyqJPwxKqF84f
         t0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fUmEsiElKhDKhlT3SfLGEU08rVbAl9ZDdGZHeDZ/yRc=;
        b=ltKUa/xBiUx89c93P1QGFrQBI6age+q+8GRoL038DiZG2USrVv1fwszvf19xrXS96Y
         lez/RZEzfLQOqziS4rlJv3G9BGFbOjd0cgVRLb5O8sQXS6revhNTyZiV7BPwAm1QvIIX
         Z1IBczksJpgFTj8cTh7nbPU8rD19NCfWLy9KnMArdFGwviMYBCB+T5m+QY5mvD6aal3R
         /UkERX/ZIKiwMPlMerwP1Qe+WPjQiZtXcxyVFZh17/C3NkYntrwDLkVvhifbfYvhSEZu
         cZsYdvb6eVte+GCkXxFBvTCZdl0hAeEtS9ZipMJmLsUrOCqvCQJD8yUdiaYMgHkK7wOV
         wsgg==
X-Gm-Message-State: APjAAAWpEnQsHjLmasBXOxkU81uInPpUBOIBXOp0AqeBLBE8Yup78gRp
        +pP3mZINsVhNZ/RK1VDe4y4=
X-Google-Smtp-Source: APXvYqw4l1YMwmzmn1/fYByd1TthcsvoaGIXQuP46uFX7clD/MYkzGluZNiFWh9sy6sm0WKlhHlNLw==
X-Received: by 2002:aa7:d897:: with SMTP id u23mr1619991edq.50.1576667373077;
        Wed, 18 Dec 2019 03:09:33 -0800 (PST)
Received: from szeder.dev (x4db36940.dyn.telefonica.de. [77.179.105.64])
        by smtp.gmail.com with ESMTPSA id w12sm22509edq.94.2019.12.18.03.09.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 03:09:32 -0800 (PST)
Date:   Wed, 18 Dec 2019 12:09:29 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH 2/2] Documentation/git-log: mention that line-log regex
 must match in starting revision
Message-ID: <20191218110929.GB8609@szeder.dev>
References: <pull.494.git.1576559263.gitgitgadget@gmail.com>
 <4ea4eeae0c1e23221012855168bf6640be93fd4f.1576559263.git.gitgitgadget@gmail.com>
 <1d033204-80fd-25f8-3a80-0cb641953139@gmail.com>
 <xmqq5zieizrb.fsf@gitster-ct.c.googlers.com>
 <147443E8-EA04-45D2-B3BC-D879A5FFECDC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <147443E8-EA04-45D2-B3BC-D879A5FFECDC@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 17, 2019 at 10:28:37PM -0500, Philippe Blain wrote:
> 
> > Le 17 déc. 2019 à 13:16, Junio C Hamano <gitster@pobox.com> a écrit :
> > Even when you specify <start> or <end> as a line number, they must
> > exist in the starting revision or it would be a fatal error.  If we
> > are clarifying with this patch for completeness, I think we should
> > also mention it together.  
> Thanks for the feedback. I did some tests : 

I'll swap the order of your first two tests:

>     git log -L 300,2000000085:Documentation/git-log.txt 
> errors out:
>     fatal: file Documentation/git-log.txt has only 239 lines

Here the entire line range is outside of the file, so there is not
much we can do about it, but error out.

An alternative would be to treat it as an empty line range and then
don't show any commits but exit silently, but I think that would be
confusing ("why didn't I get any output?!"), and telling the user
what's wrong is better ("Ah, ok, I mistyped 192 as 912").

>     git log -L 73,2000000085:Documentation/git-log.txt
> does not error and shows the history from line 73 to the end of the file.

Here there is an overlap between the given line range and the file
(lines 73-239), so we have two possibilities:

  - be strict and error out saying that the <end> doesn't make sense.

  - be lax about it, and interpret the <end> as the end of file.  This
    allows for cases like "I want line log from here to the end of
    file, but instead of finding out the exact number of lines in the
    file I'll just say 999999 that is surely larger than the file, and
    you shall do what I mean".

Those who implemented the line-log feature chose the latter.  I think
it's the better choice.

> But 
>     git log -L 300,-2000000085:Documentation/git-log.txt
> does not error out and shows the history for the whole file. Also,
>     git log -L 1,-2000000085:Documentation/git-log.txt
> does not error out and gives the history for the first line.

These are a variant of the previous case, with the difference that
because of the '-' in <end> it is not an absolute line number but
relative, and is interpreted as that many lines before <start> (i.e.
in this case <start> actually means the end of the line range).

I think the same argument can be made about <end> pointing past the
beginning of the file, though, arguably, it's not as useful, because
the first line as always 1, and '-L 123,-99999' is more keystrokes
than '-L 1,123'.

> So I think that it’s really only regex that must match...
