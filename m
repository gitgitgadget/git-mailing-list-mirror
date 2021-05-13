Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E616DC433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 18:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A18C4613B5
	for <git@archiver.kernel.org>; Thu, 13 May 2021 18:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhEMS7z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 14:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhEMS7y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 14:59:54 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA86C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 11:58:44 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id s24-20020a4aead80000b02901fec6deb28aso5860765ooh.11
        for <git@vger.kernel.org>; Thu, 13 May 2021 11:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=vABL9beS6hLDlb9T33qRj94cTdDyY1uy4dgXDti65/s=;
        b=VYEv53lqt30Ca/EPxFWGXNCh9WavXEuHlmGyv4QOR29XUXJ/n6TUiEiKnhOp1DZcVc
         b7aMq4l6TT9I9WVNevyDSSzsp0TmYb4fduZFBLZA6L1DPeIstREKwKn274x0hKl1CjIi
         yLu84CViYw8NgLy709ZJxRsJIXiYl+oRxCiapZtvMmCBSUnujWEelMo1v/HVhQzZzF1d
         NQ/vt0zF6BKbdD1O6+euoc8TKlxB0WFXi+bBSn4fWxOdRmqE5BLx4IRhmLCspJElE4ft
         yiGghyRpktNyo4AljuRolXV+0v1EsdpWBOP+LBMDjezWRf+KGZQv2ddNxEwzhPap9BUv
         yvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=vABL9beS6hLDlb9T33qRj94cTdDyY1uy4dgXDti65/s=;
        b=B8Dx6Kk8z4Efys7394wIqdqh6ehCK5sISrOao++A/S5tpYHSmXF0vQyo8FD7GSuHRS
         feqOhfquMa20qNHDHcyoCP+NCYlOKpOAbBn98wVANw704iNn0dlRVNXvBv4O/FYleGEs
         G0HJFFXl5JprEl5LzkFsbb2E2XH15M7tiJCcmYvj5x2/5zlCylryfDwTuuNWblYebf7M
         g6huVBB/RO1m8ECEn+by2ULtDWAL70r+f5Qx7WKSUhMHbbPhM/AMfnVZuKBKqnJ8oHgO
         fUEc0xgphe6v8vEK+ffQkHtvZK5kUjnmnm1oWIG9FzIGD2ziUDus4r8HIZSkFlgzTrDg
         fFDw==
X-Gm-Message-State: AOAM533/xPi3qbWvMPY2HJ9y1EEB8mudmTSgCDh5rhBOmhiFYHMmTZnQ
        3xl2XkMoBTN3CgDAgs0Pzy4=
X-Google-Smtp-Source: ABdhPJyasUMweVGr3tKxIkXoIr6haFKCHzNuI6bXSSH1OO7uqFQjNsGX9Qx9aEYIYHMDhRWDlQSPhg==
X-Received: by 2002:a4a:e548:: with SMTP id s8mr33530182oot.63.1620932323399;
        Thu, 13 May 2021 11:58:43 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id d13sm765454oiw.6.2021.05.13.11.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 11:58:43 -0700 (PDT)
Date:   Thu, 13 May 2021 13:58:41 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <609d76e1ae327_42a0208bd@natae.notmuch>
In-Reply-To: <878s4islld.fsf@evledraar.gmail.com>
References: <20210512222803.508446-1-felipe.contreras@gmail.com>
 <20210512222803.508446-6-felipe.contreras@gmail.com>
 <878s4islld.fsf@evledraar.gmail.com>
Subject: Re: [PATCH 5/8] doc: remove redundant rm
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Wed, May 12 2021, Felipe Contreras wrote:
> =

> > It's not clear what it was supposed to achieve.
> =

> It seems this used to make sense around 7b8a74f39cb (Documentation:
> Replace @@GIT_VERSION@@ in documentation, 2007-03-25), but at some poin=
t
> (I didn't look further) we refactored that and kept the "rm".

Actually it came later: 50cff52f1a (When generating manpages, delete
outdated targets first., 2007-08-02).

I'm not sure we should complicate the Makefile just because somebody
made the mistake of doing 'sudo make doc' a long time. Especially since
other rules don't have this.

  sudo make doc
  touch GIT-ASCIIDOCFLAGS
  make doc

Fails here already.

  asciidoc: FAILED: api-merge.txt: line 2: unexpected error:
  asciidoc: ------------------------------------------------------------
  Traceback (most recent call last):
    File "/usr/bin/asciidoc", line 6247, in asciidoc
      writer.open(outfile, reader.bom)
    File "/usr/bin/asciidoc", line 4633, in open
      self.f =3D open(fname, 'w+', encoding=3D'utf-8', newline=3D"")
  PermissionError: [Errno 13] Permission denied: '.../Documentation/techn=
ical/api-merge.html'

-- =

Felipe Contreras=
