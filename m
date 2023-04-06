Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E19C77B6C
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 21:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjDFVfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjDFVff (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 17:35:35 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5633A5E3
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 14:35:31 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5491fa028adso267918667b3.10
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 14:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1680816931; x=1683408931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ctQqQol/j/ZiiWxwY6ETWLhaFdQqjcG7I4b/6YGGgc=;
        b=qGLLQnaz0p8X7SqCel6gc17eShAjbFcRQE23Sc3Aaz5Ru7r+zGNm937RFF8EEwHrwC
         3/VHxAkAiHqhmMTunQJWgUYW/hv9sYKls0RfEPCwo6gOQpeLaBCePTUzLyYTMaTVu9bF
         N4/fEVFxh5BxaJbq6fT7gxnCbnUXNA2JxMgfXlp+rd/njeAwkmLSXoK9UymGjyhC7UFA
         I28bjj5sUPwydilMqNO3+qP7PFdvGcdnJo+ThzCmW/iH7qzOhZH++jcM0U0V7c8IcHtP
         X8Uu/oAhVJ1GtETBzesSY9jZbsRZB+GPVtTYWGY5Ida1SI+4dJ44+cH1qjq51cfq1Wl9
         f2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680816931; x=1683408931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ctQqQol/j/ZiiWxwY6ETWLhaFdQqjcG7I4b/6YGGgc=;
        b=vymWfLsvUjNiAZSgx+7PqHQqArN2jvtiarCNlCzw1ZcCyFwGPXVIFL32qvWjsD0KMt
         TrOnKliJXu+XIhU3egtZfJND5pb+ZSMpeEErnTeNO/Q+G3Qq63uR8lE0T/xxZ+SxLSjN
         SOyh9ZscioHkAtFqNJGZcWrk3k1gD1WjXXhPljN7oi9Pk5Yqcdbu7y+iC3SVseqqHYE+
         7cIw7QRnOJdjiIe/MWjWVqPrH9hLEZZNDPYJXPJwmNLhS4wtupqpdGqwZ82asIsUpBQd
         qK9JC/bNhAf4JSFh/iiL1rBJ5F4th1i4bFDUjkm13/O1MnBOrwRfQaAw5qxipaMeFofw
         HSlw==
X-Gm-Message-State: AAQBX9fyhoF/YuEJ4M2l4DRLl66pwkPKeMclABXoIt7u4ZeVROkYDAt3
        UJwV59EwQm6xBsZb/CQ0Uvv2bw==
X-Google-Smtp-Source: AKy350angv4wz6NId5wZObuzQdG0M35tbfLZaxk931wE93bM1UtJ8p+lKeLe9eo3Tuw1Sx/JVkqlSg==
X-Received: by 2002:a0d:dfc5:0:b0:54c:a66:281b with SMTP id i188-20020a0ddfc5000000b0054c0a66281bmr3411834ywe.20.1680816930969;
        Thu, 06 Apr 2023 14:35:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bh30-20020a05690c039e00b0054c0ddb3611sm569335ywb.87.2023.04.06.14.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:35:30 -0700 (PDT)
Date:   Thu, 6 Apr 2023 17:35:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] clone: error specifically with --local and symlinked
 objects
Message-ID: <ZC87IcLcBnxBRCdr@nand.local>
References: <pull.1488.git.git.1680652122547.gitgitgadget@gmail.com>
 <xmqq7curxk22.fsf@gitster.g>
 <kl6ly1n65l7t.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <kl6ly1n65l7t.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 05, 2023 at 09:48:22AM -0700, Glen Choo wrote:
> Since this is an error code path, I think the extra lstat() is probably
> worth it since it lets us be really specific about the error. Maybe:

FWIW, I don't totally think it's necessary for us to report back to the
user that they're trying to clone a repository with `--local` whose
`$GIT_DIR/objects` either is or contains a symbolic link. Especially so
since you're already updating the documentation here.

But I think it's a compelling argument in the name of improving the user
experience, so I think that this is a reasonable direction. And I agree,
that while the extra lstat() is unfortunate, I don't think there is a
convenient way to do it otherwise.

We *could* teach the dir-iterator API to return a specialized error code either
through a pointer, like:

    struct dir_iterator *dir_iterator_begin(const char *path,
                                            unsigned int flags, int *error)

and set error to something like -DIR_ITERATOR_IS_SYMLINK when error is
non-NULL.

Or we could do something like this:

    int dir_iterator_begin(struct dir_iterator **it,
                           const char *path, unsigned int flags)

and have the `dir_iterator_begin()` function return its specialized
error and initialize the dir iterator through a pointer. Between these
two, I prefer the latter, but I think it's up to individual taste.

> 	if (!iter) {
> 		struct stat st;
>
>     if (errno == ENOTDIR && lstat(src->buf, &st) == 0 && S_ISLNK(st.st_mode))

Couple of nit-picks here. Instead of writing "lstat(src->buf, &st ==
0)", we should write "!lstat(src->buf, &st)" to match
Documentation/CodingGuidelines.

But note that that call to lstat() will clobber your errno value, so
you'd want to save it off beforehand. If you end up going this route,
I'd probably do something like:

    if (!iter) {
      int saved_errno = errno;
      if (errno == ENOTDIR) {
        struct stat st;

        if (!lstat(src->buf, &st) && S_ISLNK(st.st_mode))
          die(_("'%s' is a symlink, refusing to clone with `--local`"),
              src->buf);
      }
      errno = saved_errno;

      die_errno(_("failed to start iterator over '%s'"), src->buf);
    }

Thanks,
Taylor
