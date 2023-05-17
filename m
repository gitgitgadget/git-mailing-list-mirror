Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96EBC77B75
	for <git@archiver.kernel.org>; Wed, 17 May 2023 17:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjEQR6e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 13:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjEQR6d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 13:58:33 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F90271C
        for <git@vger.kernel.org>; Wed, 17 May 2023 10:58:30 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-559f1819c5dso12499807b3.0
        for <git@vger.kernel.org>; Wed, 17 May 2023 10:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684346310; x=1686938310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L+4RRe9Hct0iPhf+xOa9LNKSJyQSjXxWaMjkyElawH4=;
        b=boOjFShk4rMxBVdgXPl0YNzCGFh8PAayYMj1tD3VhEMyyfLtEFqTW+z4C5amjuLpe+
         JIS2CWdsmKGvPIgrQo9EKlnBQaraWxrsPBfAxmH+P8WKSAw86BMe/jTj15A/VY5ZvH5G
         G0fI41nFJ3B4QDGyJ76+nnnxrnLWGmbOWQeaxsekqqNpM4hS0SRAn32I1Jv1IXGWd7Sn
         2erkS9be5GkTBBf7+fj5NpoTX55P9pwA1zdqfET64njayK8tG4qu3yEWotSvueNHOkm5
         Rw7hbPJ3Pw8AVrhFi9RF3thnB2mhwGZj7Z5+d3UPn9SbCIqKaDzIDSYSvas/AP65qfM7
         Kqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684346310; x=1686938310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+4RRe9Hct0iPhf+xOa9LNKSJyQSjXxWaMjkyElawH4=;
        b=TkytQJZVHd/dcZnOswNhYHBOBGHKYpzcd208hoSLNzCt7904bi99+tz7PyO2X8YPyk
         pSuEoBghC41cbisAyWtDhOlhNJkjXPFeW8JZ68cgCu6yETL/zTiUczcI/0NaV40gr9iP
         6B9OxodOJCawaOdnJI/7WPRpgp45EbK/eQwZcWQQZxlTHHsWsKt2/i8UjJiNqNCwImo8
         Iw7kZDlbS4YEccDj8LWXi5EDXRdl3eY6juQQM/i1JKF9rDwQIqvsu5blECca0fKJw5vp
         ajxCaec0TQttQQqxIKNHvWkkuRIpas3gUKGMDOTY84/fGXsPl0/Cm9D8hT9BanY0s13D
         90Dg==
X-Gm-Message-State: AC+VfDxAkA1WeuO79jpJtMYFUTJtygXrlag867hhuWJ/8W9u/a2VChan
        Xni/wigtU/FLUjyai4Ar1Vp+6IsceA+x0NIInBq+Gg==
X-Google-Smtp-Source: ACHHUZ4Zn2XdgcRu9S1wI5NzW6RQJ/LGkSntOVyrFb1UgfR+w86F6YCK6PVTOVR81JnPprYs7OmApg==
X-Received: by 2002:a0d:dc86:0:b0:560:befc:6682 with SMTP id f128-20020a0ddc86000000b00560befc6682mr23200700ywe.42.1684346309760;
        Wed, 17 May 2023 10:58:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v135-20020a81488d000000b0054fbadd96c4sm796923ywa.126.2023.05.17.10.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:58:29 -0700 (PDT)
Date:   Wed, 17 May 2023 13:58:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Hesse <list@eworm.de>, git@vger.kernel.org,
        Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] imap-send: include strbuf.h
Message-ID: <ZGUVvjG+xou3w8YW@nand.local>
References: <20230517070632.71884-1-list@eworm.de>
 <xmqqwn17q7ou.fsf@gitster.g>
 <ZGT6fEZFumAsZnxu@nand.local>
 <ZGT/eK6+IKlCM6Sg@nand.local>
 <xmqqcz2yrjbe.fsf@gitster.g>
 <xmqq8rdmrixc.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8rdmrixc.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2023 at 10:01:35AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> >>         if ! gcc -I $(pwd) -E $f | grep -q 'struct strbuf {'
> > ...
> > What does the above prove, more than what your regular compilation
> > that does not fail, tells us?
>
> It is actually worse than that, isn't it?  This does not even use
> the definition in the config.mak.uname, so it is not even matching
> your build environment.
>
> I am uncomfortable to use this as an explanation of what due
> diligence we did to convince ourselves that this fix should cover
> all similar issues.  Perhaps I am grossly misunderstanding what your
> investigation did?

Oof, yes, you are right:

    diff -u \
      <(gcc -I . -E imap-send.c) \
      <(gcc -DNO_CURL=1 -I . -E imap-send.c)

How *should* we test this?

Thanks,
Taylor
