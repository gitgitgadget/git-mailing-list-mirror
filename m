Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C187DC83001
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 23:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8965D2072D
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 23:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNG69W75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgD0XtO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 19:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726244AbgD0XtO (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 19:49:14 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C434BC0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 16:49:12 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d184so9795938pfd.4
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 16:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n+9rjs8wzTG1bDezu/GYhZFuo5wBbJuqsstom/U/x2Q=;
        b=bNG69W75rg5CbHMc2G/49xUenKgbTVp92m5DJIdPX6md0wIqchc8hnW/yY7cbqs7vk
         ckP9XZep8jfJrOy8ox5BvuFc8APLUB+V9tzHIpMucGimgr8CBPtDIq4uoXct66nuB31D
         GfNxi8SJQMoYpGh9IT5y6cKGMJx9fd2JnzqTM4/oQPwKOIPKFPrTl2bcka3el9emLQyF
         zx/WaQZg21qRhYp8ki7hyN4hFzfBJhuPM/HJHAyzEILBOpiun4isyALcDAZYbHJR8688
         PvI0l0Nu2H6ViKF0FdIRELiqAbWC5FyxY0KDpXCzd0P52QDLDKD5uBWSIkAXYGiSbufr
         j0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n+9rjs8wzTG1bDezu/GYhZFuo5wBbJuqsstom/U/x2Q=;
        b=Js8vqwXr+2p3nbJYT2mdnNzKktKP3NXUDAaJ658ZI/fGdpjBrLO3j31iZ3xFuFRTzX
         g6te+eE52QorFaN3Kg/iBUK4AwhPEZZ+vdgX5KVZ6D1UmJvWVq5VEDIcA2yOAaHCiMLm
         +/hOKDodXdoslTF9fdr389wWcODe7eoptn0Urcc9R5iUdDZyZcsAFfMHUT+wf19ke5FJ
         QEtu4j+/r5+dQzhZZskBOd8S2NWmBVtMAVIdHXqTYpxIeNCqEZgisnSnjB4dr745GUwx
         LfGREUndUt6DSld7cRFhIXzsaOWZI7GLyHd38Cps1egnYHoK9DsI/KzftMS4jAKwqb66
         mEOQ==
X-Gm-Message-State: AGi0PubER5zbDYctqNzX+QB8P2+k45Eu6fcAB8hNMG86PkOyxSnlXwLJ
        T86+NFIZX5nAeUzFFkRZzKQ=
X-Google-Smtp-Source: APiQypLwYrWjzpEhawoUmL3NwghMP6R+02nDZlL0vg8oZlhAX0eTiZPzTULkY/Gp9ng/NaDwDpvaIA==
X-Received: by 2002:a63:c34a:: with SMTP id e10mr25524920pgd.132.1588031352030;
        Mon, 27 Apr 2020 16:49:12 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id f76sm13194498pfa.167.2020.04.27.16.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 16:49:11 -0700 (PDT)
Date:   Mon, 27 Apr 2020 16:49:09 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org, dirk@ed4u.de,
        sunshine@sunshineco.com
Subject: Re: [PATCH v3] git-credential-store: skip empty lines and comments
 from store
Message-ID: <20200427234909.GC61348@Carlos-MBP>
References: <20200427084235.60798-1-carenas@gmail.com>
 <20200427125915.88667-1-carenas@gmail.com>
 <xmqqftco94wx.fsf@gitster.c.googlers.com>
 <20200427191858.GB1728884@coredump.intra.peff.net>
 <xmqqv9lk7j7p.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv9lk7j7p.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 01:43:38PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Mon, Apr 27, 2020 at 11:09:34AM -0700, Junio C Hamano wrote:
> >
> >> > modified store files which might have empty lines or even comments
> >> > were reported[1] failing to parse as valid credentials.
> >> 
> >> These files are not supposed to be viewed or edited without the help
> >> of the credential helpers.  Do these blank lines and comments even
> >> survive when a new credential is approved, or do we just overwrite
> >> and lose them?
> >
> > That's a good question. In the older code we do save them, because
> > credential-store passes through lines which don't match the credential
> > we're operating on.
> >
> > But in Carlo's patch, the immediate "continue" means we wouldn't ever
> > call "other_cb", which is what does that pass-through.
> 
> So, does that mean the patch that started this thread will still help
> users who wrote custom comments and blank lines in their credential
> store by letting git-credential-store start up, but leaves a ticking
> bomb for them to lose these precious comments and blanks once they
> add a new site, change password, etc., at which point the user realizes
> that comments and blanks are not supported after all?

yes, and it also helps users that might have added spaces or tabs
around their credentials while editing them to still be able to use those
instead of just failing to match them.

IMHO the only "regression" I was fixing was the fact that the current
code will get to throw a fatal error with an unhelpful message and prevent
access to valid credentials as shown by :

$ /git credential fill
protocol=http
host=example.com

warning: url has no scheme:
fatal: credential url cannot be parsed:
Username for 'http://example.com':

> >> I'd rather not to do either, if we did not have to, but if it were
> >> necessary for us to do something, I am OK to ignore empty lines.
> >> But I'd prefer not to mix the new "# comment" feature in, if we did
> >> not have to.
> >> 
> >> Also, triming the lines that are not empty is unwarranted.  IIUC,
> >> what the "store" action writes encodes whitespaces, so as soon as
> >> you see whitespace on either end, (or anywhere on the line for that
> >> matter), it is a hand-edited cruft in the file.  If you ignore
> >> comments, you probably should ignore those lines, too.
> >
> > Yeah, all of that seems quite sensible.
> 
> I think the first patch we need is a (belated) documentation patch,
> that adds to the existing "STORAGE FORMAT".  We already say "Each
> credential is stored on its own line as a URL", but we do not say
> anything about allowing other cruft in the file.  We probably
> should.  Adding a "comment" feature, if anybody feels like it, is OK
> and we can loosen the paragraph when that happens.
> 
> -- >8 --
> Subject: credential-store: document the file format a bit more
> 
> Reading a malformed credential URL line and silently ignoring it
> does not mean that we promise to torelate and/or keep empty lines
> and "# commented" lines forever.
> 
> Some people seem to take anything that is not explicitly forbidden
> as allowed, but the world does not work that way.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-credential-store.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.txt
> index 693dd9d9d7..76b0798856 100644
> --- a/Documentation/git-credential-store.txt
> +++ b/Documentation/git-credential-store.txt
> @@ -94,6 +94,10 @@ stored on its own line as a URL like:
>  https://user:pass@example.com
>  ------------------------------
>  
> +No other kinds of lines (e.g. empty lines or comment lines) are
> +allowed in the file, even though some may be silently ignored. Do
> +not view or edit the file with editors.

view should be ok; mentioning that any typos or extraneous characters
will compromise the validation of credentials like I mentioned in my
proposed documentation update probably worth doing here instead, too.

Carlo
