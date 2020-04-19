Return-Path: <SRS0=ylBF=6D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14E3C2BA19
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 02:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A984F21D7E
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 02:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sb+QccjS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgDSCsK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Apr 2020 22:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgDSCsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Apr 2020 22:48:09 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0F0C061A0C
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 19:48:09 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id g2so2609814plo.3
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 19:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mw4TiXdABJH9KumsD/fzlApexmESMmyHbIy3PZHvI/0=;
        b=sb+QccjS4BCO/pVei7zLaxXkczzUCmjOmbiYutLeWJgR6ujtHoHAonWVgNk4yczY+7
         MNgCI0FHCz/zf/8IZKqM11ugRYgN3prV6AJ4qOJcu50y8GNo/UhGHSjL4C5xIexruwne
         u6zxW1efosX74JLWyPYQRKUXIlFwW6ps2nzQME0APRUa64CrI1EbE13no8Pjx3UGN6Ol
         au5jm/DXbLCQC3drpNfqupfRJFQVsbtVYXMa5FGe4j0cW4uimsby5fT7Iz0FJ/JMnpbJ
         R+qMtXa2shOOfvNGQmJOOdL9A7X81aIJIJfOWZr+cCFzDMyIz7CMJJpeMKFeo9KdYEcJ
         J6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mw4TiXdABJH9KumsD/fzlApexmESMmyHbIy3PZHvI/0=;
        b=LhCHHwQOvDXIPhGVBjo9HfbTUWCgKx8x5EtKKPK04wY8cgbLYR6IWMb+qs2s4/S2BK
         ChAdMPASTR1wTD6VOs3wIux2QDINQs593rkQvOQ6b3s9X744C/nJKDt3Gs24ls6IYdlI
         SuZgRKdNndJ8IVDhHd5MQUMgqaQwIWQt+NpocI8uW3uHKXQV94ZL+vZ+DvSZLmmwlwtH
         +FwcRokmuij13QYtTaEVwWpiZCfyPzwLMpwTn15OH7s6Y1wPf3VluxR2RM7qm7h9sNKO
         CsrGLu79Ycl0yFNx6QWIUnGTmX7tOoFhBAMAlUUrJCEjv21rwY6F8aRxUX3wUF7I+q6x
         x1tg==
X-Gm-Message-State: AGi0PuZM25WucvzWG27CWfAGpQxJciuLGIf8Vt2qTuDiU/Kg4rvsN6w6
        0nudm+O+1hoXxaMQa8azrZs=
X-Google-Smtp-Source: APiQypKTXsF0Q4Iwl25S0UKbDHMBJZZQ1O5WMXl15lbwpTODe8YwF/nXoxI8mBzToSFx9kPHk87Y4g==
X-Received: by 2002:a17:90b:3851:: with SMTP id nl17mr13203656pjb.59.1587264488795;
        Sat, 18 Apr 2020 19:48:08 -0700 (PDT)
Received: from localhost ([2402:800:6374:5380:b9e1:93e1:68db:b9f6])
        by smtp.gmail.com with ESMTPSA id r10sm12255707pgh.23.2020.04.18.19.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 19:48:07 -0700 (PDT)
Date:   Sun, 19 Apr 2020 09:48:05 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] mailinfo.c::convert_to_utf8: reuse strlen info
Message-ID: <20200419024805.GC9169@danh.dev>
References: <20200418035449.9450-1-congdanhqx@gmail.com>
 <CAN0heSppn6BBX4V1T1qgKc4XP+8i6qbcEqd1_3NqWQtZJLaJww@mail.gmail.com>
 <xmqqk12ctmm1.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqk12ctmm1.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 2020-04-18 16:12:06-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Martin Ågren <martin.agren@gmail.com> writes:
> 
> > This is equivalent as long as `line->len` is equal to
> > `strlen(line->buf)`, which it will be (should be) because it's a
> > strbuf. Ok.
> 
> For the guarantee to hold true, line->buf[0..line->len] should not
> have any '\0' byte in it.  
> 
> This helper has two callers, but in either case, it needs to be
> prepared to work on output of decode_[bq]_segment().  Is there code
> anywhere that guarntees that the decoding won't stuff '\0' in the
> line?

- First caller: `decode_header`, we don't have such guarantee,
  The old code will discard everything after first NUL characters.
  I'm _not_ really familiar with email standard, does email allow
  UTF-16 (albeit in [bq]-encoded) in header? If yes, the current code
  is likely disallow it. The new code accidentally, accept
  [bq]-encoded-utf-16 header and reencode to utf-8 for commit.
  Yes, it's very likely only UTF-8, ISO-8859-1, some variant of
  ISO-2022 is used nowaday in email.
  *If* we would like to not exclude UTF-16, the new question is should
  we trust the length of newly converted utf-8 string.

- Second caller: `handle_commit_msg`: everything get interesting from
  here.

Get back to the question of trusting the length of newly converted
utf-8 string.

I _think_ we should,
because I _think_ there shouldn't be any discrimination against any
encoding (be it utf-8, ISO-8859-1, etc...),
the current code allows NUL character in utf-8 [bq]-encoded string
in this function (early return) and its caller,
and report an error later:

	error: a NUL byte in commit log message not allowed.

meanwhile, if the email was sent in other encoding, the current code 
discards everything after NUL in that line,
thus silently accept broken commit message.

Attached is the faulty patch in ISO-8859-1, which was used to
demonstrate my words.
The current code will make a commit with only "Áb" in the body,
while the new code rightly claims we have a faulty email.

-- 
Danh

--5mCyUwZo2JvN/JJP
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="faulty.patch"
Content-Transfer-Encoding: quoted-printable

=46rom e27fb59f5a4854efc0badd902673fd636bcab52e Mon Sep 17 00:00:00 2001
=46rom: =3D?ISO-8859-1?q?=3DC4=3D90o=3DC3=3DA0n=3D20Tr=3DE1=3DBA=3DA7n=3D20=
C=3DC3=3DB4ng=3D20Danh?=3D
 <congdanhqx@gmail.com>
Date: Sun, 19 Apr 2020 09:31:22 +0700
Subject: [PATCH] =3D?ISO-8859-1?q?=3DC4=3DCB=3DD1=3DCF=3DD6?=3D
MIME-Version: 1.0
Content-Type: text/plain; charset=3DISO-8859-1
Content-Transfer-Encoding: 8bit

=C1b=00=E7d=E8fg

---
 afile | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 afile

diff --git a/afile b/afile
new file mode 100644
index 0000000000..e69de29bb2
--=20
2.26.1.301.g55bc3eb7cb


--5mCyUwZo2JvN/JJP--
