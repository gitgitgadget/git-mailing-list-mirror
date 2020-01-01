Return-Path: <SRS0=Tp/o=2W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A6BC2D0DE
	for <git@archiver.kernel.org>; Wed,  1 Jan 2020 08:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9BFF206DB
	for <git@archiver.kernel.org>; Wed,  1 Jan 2020 08:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfR6ZZG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgAAIYs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jan 2020 03:24:48 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:41693 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgAAIYr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jan 2020 03:24:47 -0500
Received: by mail-qv1-f68.google.com with SMTP id x1so14011225qvr.8
        for <git@vger.kernel.org>; Wed, 01 Jan 2020 00:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nOEp07m8yOLEBNJi0zt/HnM39vzVcar/KjGhPX/XFg8=;
        b=MfR6ZZG3XeFi6CPhz331eXZcoumMAZROOJB4Ckl/KuF4ybg4938aG9cpNWBWmlvp6H
         OC5SYfC+qDlUwl5DE2G1kTTYzZ8+ytJ4E4hwmpGmcjETbjoQD5b4hqsblHAkUQrUYn8+
         tYsbNJSugLpzafLhrK0uJc/Zd6qTfaIc/5q4i7Ky3m3b2HrlCp+j/tIvQAttErYRmhti
         1ht7yJpgI4lhQYbISz/s5LSyJQqy4ZaXWpcRWfiPPK6/Zvd4pGDB2hTtLINNkAMoXcc4
         z3gv16eQQRjZleVrtNMJe0LdWOjLoAs0FuZ6/Kvhs8sjjBZH12dOZ9WU7Df26eJ6I8Eu
         Sgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nOEp07m8yOLEBNJi0zt/HnM39vzVcar/KjGhPX/XFg8=;
        b=r7vbaGtm1vScOB/p7annCbqBLjvu+xweSv7XLV43HBmHUoLdStQ1hqjninPNznTXnS
         tcAQxc5dblF84Uew4F2aQHbsII0CZnNjbQvyUCNmIbFo6m3S4CuTJej0F/gICURS7k0B
         UyMUmuZZ9V2ks0tdF+JybU6c2A8hQ+910km3blWnkdTrW4EOoamtUT/JRXaYFt9aG4Mt
         90Qi/YD3hdqiiSEfiyRfafqkUk9lvFtdyCT1l2kFebEAhG8Vt5SdoceuJCCYJf4/JR/S
         oW/5t11MJcjyVmKUOftx/LEf3dkiARN8B7Jj8UVkXPMATwuYR5XeWS0OrpYUImKWZEpn
         MlFg==
X-Gm-Message-State: APjAAAWFoikcdb9yGcQTUopv+IjXpCTAOXPTPO6lH3ZBopaBscRknih0
        rO2zu0TgZWL/qimMfhUxe3Y=
X-Google-Smtp-Source: APXvYqyxWfriAMJ2VLzywksCZNv3Vnq/daDg2DDNh9xV2PXWgGrE4iCvK1TWU1mhGMltH8Sem/7l1w==
X-Received: by 2002:a0c:fac7:: with SMTP id p7mr59076712qvo.46.1577867086661;
        Wed, 01 Jan 2020 00:24:46 -0800 (PST)
Received: from generichostname ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id z3sm2011297qtm.5.2020.01.01.00.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 00:24:45 -0800 (PST)
Date:   Wed, 1 Jan 2020 03:24:43 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jakub Narebski <jnareb@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 16/16] t4124: let sed open its own files
Message-ID: <20200101082443.GB5152@generichostname>
References: <cover.1577454401.git.liu.denton@gmail.com>
 <54315fecfe373d8020f2172b9b43e02c0dae137d.1577454401.git.liu.denton@gmail.com>
 <868smt2zqh.fsf@gmail.com>
 <xmqqfth1fl72.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqfth1fl72.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jakub and Junio,

On Mon, Dec 30, 2019 at 03:27:45PM -0800, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Denton Liu <liu.denton@gmail.com> writes:
> >
> >> In one case, we were using a redirection operator to feed input into
> >> sed. However, since sed is capable of opening its own files, make sed
> >> open its own files instead of redirecting input into it.
> >
> > Could you please write in the commit message what advantages does this
> > change bring?
> 
> A fair question.
> 
> My version of short answer is "nothing---it is not wrong to write it
> either way, and it is not worth the patch churn to rewrite it from
> one form to the other, once the script is written".

In one of my earliest contributions to Git, Gábor suggested that since
since 'head' and 'sed' can open its own input file, there's no need to
redirect its standard input[1].

I assumed that letting these programs open their own input was one of
those minor "style cleanup" things that was done such as removing
spaces after redirection operators, indenting compound command blocks,
etc. Whenever I've been cleaning tests up, if I noticed a `sed <` in the
area, I'd apply the transformation as a style cleanup.

I guess the only tangible benefit I can think of is that programs which
have a file open can optimise on the fact that they can perform random
access on the file whereas with stdin, only linear access is allowed. I
don't know enough about the internals of various seds to be able to
comment on whether any of them actually take advantage of this, however.

Anyway, if no one else feels strongly about this, I can drop this patch
and I'll stop doing this cleanup in the future.

Thanks,

Denton

[1]: https://lore.kernel.org/git/20190317130539.GA23160@szeder.dev/
