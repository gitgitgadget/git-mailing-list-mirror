Return-Path: <SRS0=ylBF=6D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DABC38A30
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 14:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1CD8214AF
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 14:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvlVWIiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgDSOQm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Apr 2020 10:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgDSOQl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Apr 2020 10:16:41 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E813C061A0C
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 07:16:41 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 7so3683733pjo.0
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 07:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Y1e6tEGmk7aErgk2/jmeWfKYLyjVwrVGikg/8ds6RAM=;
        b=MvlVWIiONgNVaFygM8cMQc5iam2eE2JLK808vQRcktNYx5WHA9+7eiJmThUpJrsH7w
         /U3+C8bq+9+8s2bxwTMdrTHa5a7Ny85Xh1kJp0iRWvZd+Fjrn9//Hafxc7tWn6cxYVNj
         8g9upgp9oyLX/or2A3WHZPzbj8nUy6DAtcmZCatbJBdKToTM+O/g3VoekEXLw042nKwg
         86unidS97RS+WAurOL3Eqa3hTwMg2x55PaK9s3gOCEaOU6J9C2X7TFXYbl4qxrXHA/Ri
         xgAy9t09EYYsufq0VotohqlX53ZqQiKjORFGNI7GrV6W3xhu8NdxJUtN5QEDIo0Zfro4
         +jTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Y1e6tEGmk7aErgk2/jmeWfKYLyjVwrVGikg/8ds6RAM=;
        b=g9tHx6KBF55WlwKmNEG/e0d5T1deX1AjnNGDtzadqzmpcTWOBzLaA1jfzMvtq2kV3k
         xxyestgiaLOy6BCm1VAme8IdHuXa9gVjbsueahown+bbwGB/yGDbDvTu3u3o16NIhfNY
         SGlhKRgogyzu86zdpk96dM12ahSKS1avJHoxzp1QWDy8XcpMr2yJgY7pAtLDYzemGh8z
         tsUa7FohqNsMX80x8uO59IpH+Ese3P1U6syRLJTQ3hyqpOi2Mp9h1XHQ2+sTG7EFxzhW
         Fh4BiEELNnULc15Abu0WHdhUJ3LIj9jks8JLohN4tF2gMukv4LkXFaF0CD+Tos9W3tMD
         IafA==
X-Gm-Message-State: AGi0PuaSR/Z8L4qJ9ulcLZaJcx0nBFwY3RByGG4DXuH7iuEd1IPwlw4M
        WgRB+Zute6+RdNqbLNBlqQc=
X-Google-Smtp-Source: APiQypJOtxpu5EicNVnemD6n6VkdtGdsojWXfIorVfqYXjIwmMKr1UCvQ7GTotvzsTKaT50Sqdx6YA==
X-Received: by 2002:a17:902:b408:: with SMTP id x8mr4580778plr.75.1587305800926;
        Sun, 19 Apr 2020 07:16:40 -0700 (PDT)
Received: from localhost ([2402:800:6374:5380:b9e1:93e1:68db:b9f6])
        by smtp.gmail.com with ESMTPSA id e26sm24573623pfi.84.2020.04.19.07.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 07:16:40 -0700 (PDT)
Date:   Sun, 19 Apr 2020 21:16:37 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] mailinfo.c::convert_to_utf8: reuse strlen info
Message-ID: <20200419141637.GA28207@danh.dev>
References: <20200418035449.9450-1-congdanhqx@gmail.com>
 <cover.1587289680.git.congdanhqx@gmail.com>
 <e3e542d38818b762f8d6d6b50bc42e01b070772b.1587289680.git.congdanhqx@gmail.com>
 <CAN0heSqi8KvbfSD80UA9s_aj9dGYTvbeW4GXVY59014_Sm-HmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSqi8KvbfSD80UA9s_aj9dGYTvbeW4GXVY59014_Sm-HmQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-19 14:29:06+0200, Martin Ågren <martin.agren@gmail.com> wrote:
> I think the subject could be adapted though? Now it's not about "reusing
> info" anymore, it's about using *other*, *better* info. Maybe
> 
>   mailinfo.c: avoid strlen on strings that might contain NUL

This is better than mine.
I couldn't think about any other alternative.

> 
> > --- a/mailinfo.c
> > +++ b/mailinfo.c
> > @@ -447,19 +447,21 @@ static int convert_to_utf8(struct mailinfo *mi,
> >                            struct strbuf *line, const char *charset)
> >  {
> >         char *out;
> > +       size_t out_len;
> >
> >         if (!mi->metainfo_charset || !charset || !*charset)
> >                 return 0;
> >
> >         if (same_encoding(mi->metainfo_charset, charset))
> >                 return 0;
> > -       out = reencode_string(line->buf, mi->metainfo_charset, charset);
> > +       out = reencode_string_len(line->buf, line->len,
> > +                                 mi->metainfo_charset, charset, &out_len);
> >         if (!out) {
> >                 mi->input_error = -1;
> >                 return error("cannot convert from %s to %s",
> >                              charset, mi->metainfo_charset);
> >         }
> > -       strbuf_attach(line, out, strlen(out), strlen(out));
> > +       strbuf_attach(line, out, out_len, out_len);
> >         return 0;
> >  }
> 
> Same diff as before, ok.
> 
> > +write_nul_patch() {
> > +       space=' '
> > +       qNUL=
> > +       case "$1" in
> > +               subject) qNUL='=00' ;;
> > +       esac
> 
> Here it's case/esac...
> 
> > +       cat <<-EOF
> > +       From ec7364544f690c560304f5a5de9428ea3b978b26 Mon Sep 17 00:00:00 2001
> > +       From: A U Thor <author@example.com>
> > +       Date: Sun, 19 Apr 2020 13:42:07 +0700
> > +       Subject: [PATCH] =?ISO-8859-1?q?=C4=CB${qNUL}=D1=CF=D6?=
> > +       MIME-Version: 1.0
> > +       Content-Type: text/plain; charset=ISO-8859-1
> > +       Content-Transfer-Encoding: 8bit
> > +
> > +       EOF
> > +       if test "$1" = body
> > +       then
> > +               printf "%s\0%s\n" abc def
> > +       fi
> 
> Here it's if/fi. Looks a bit inconsistent.
> 
> I suppose you tried to have a case for "body" above but couldn't get it
> to work? Somehow, it would seem more consistent to have a qSubject and
> qBody and handle them the same way, but maybe that's not possible?
> Maybe using q_to_nul to create qBody containing a NUL?

Those patch was written in different time, with different thought in
mind.

I need to send a re-roll to update the subject and moving oneline in
test code to later patch.

I'll update this hunk with that re-roll.
Your new series _won't_ be affected, though.

> > +       cat <<-\EOF
> > +       ---
> > +       diff --git a/afile b/afile
> > +       new file mode 100644
> > +       index 0000000000..e69de29bb2
> > +       --$space
> > +       2.26.1
> > +       EOF
> > +}
> 
> I think this helper function should use &&-chaining.

Correct.

> > +
> >  test_expect_success setup '
> >         # Note the missing "+++" line:
> >         cat >bad-patch.diff <<-\EOF &&
> > @@ -32,4 +62,18 @@ test_expect_success 'try to apply corrupted patch' '
> >         test_i18ncmp expected actual
> >  '
> >
> > +test_expect_success "NUL in commit message's body" '
> > +       test_when_finished "git am --abort" &&
> > +       write_nul_patch body >body.patch &&
> > +       test_must_fail git am body.patch 2>err &&
> > +       grep "a NUL byte in commit log message not allowed" err
> > +'
> 
> Makes sense.
> 
> > +
> > +test_expect_failure "NUL in commit message's header" '
> > +       test_when_finished "git am --abort" &&
> > +       write_nul_patch subject >subject.patch &&
> > +       test_must_fail git am subject.patch 2>err &&
> > +       grep "a NUL byte in Subject is not allowed" err
> > +'
> 
> Interesting. :-)

Going through the mail now make me think about moving the last grep to
next patch in order to clearly indicate that we expect "git-am" is
failling but it's passed instead.

And that message isn't introduced until the very next change.

-- 
Danh
