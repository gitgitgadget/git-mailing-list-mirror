Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAB0C54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 22:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76EE8206D5
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 22:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Mebna4I6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgDUWVc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 18:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgDUWVc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 18:21:32 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054F7C0610D5
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 15:21:32 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w3so81607plz.5
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 15:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fELLA2E0opKAucgeEKrKdCx44ZX1sfbDFRXGSL/ENkk=;
        b=Mebna4I6ohcI8Gnf8JX7lyQVBWtqLjr2BwDUVUp1baR5RGCAjzsRFFIUzd6xM5ciIs
         Rr9gXFxPWyB8cfzuN0XQ+N6N9NLvEiRtWOQ/glMWwB20uyz3dbu5kjdQSV4jEU2bN1s5
         IGqE00Lg6jjt0wpY9OYiJUNG4nRYj//t8qUJKh3AsYbSUNCE7BiXjSVoHxwuj8LvUuFd
         H5chmtCUwUH8Y2aeaMdYRSH4rPCwXcVsj2NKzpPZCQQ7le4QfRpL33v4bpB0h1SOhqkt
         nY5gewasqe8xv0QB/GOPHXPayPP/gvEJrdhJbU5EDvA/UsboEhJKKkGYXkgYsaZVnqti
         j9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fELLA2E0opKAucgeEKrKdCx44ZX1sfbDFRXGSL/ENkk=;
        b=qQIsjl8Vp8r2cS7KjJ8k9K4sIdJPBg+sRa6Hfqr/QDWVYnP4BUcTNSXAWkUt7y7Onw
         viJXjNVfqVZxQKhwbeJJbTqxQB+CJLdroYcQ4+TcE5+EcBIE8DJ2I9ejkLEvvZIPRukv
         ahlZsw6PG6eIC/XZNU/5ZJ1x4JOiN3hJtaKqFKD3UU0YInq2EoRCNdwDM7WJ8fWEKjXZ
         7QxRx7CBxlEqRQ5NKEO5PDGNbktE8ShL5RsomJ+9MrfWkmMZxbWOyv4djPFgpwIO0N+5
         Xp+8M347iz346OiHEB/OMHR8/l1yNz01ZKpgWHDAA8Pm26U7s4GAU9ipWH+fO59eZwYF
         DnYg==
X-Gm-Message-State: AGi0PuZxfJ7S8e2Tdf2xyaS9LZxUG74+n/qbdTMcVw+btjLa0E2rhBr/
        4neO6G2sItvYa9CPLJ8m6nC3Lg==
X-Google-Smtp-Source: APiQypKuXyqHE+d0zZG0qLwmxMC9mc7YRCER3BynvdW3vLrFqQlit96jkdkREQtY2IWX233EjzeqoQ==
X-Received: by 2002:a17:902:8a85:: with SMTP id p5mr23665392plo.305.1587507691386;
        Tue, 21 Apr 2020 15:21:31 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id w66sm3408303pfw.50.2020.04.21.15.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 15:21:30 -0700 (PDT)
Date:   Tue, 21 Apr 2020 16:21:28 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] shallow.c: use 'reset_repository_shallow' when
 appropriate
Message-ID: <20200421222128.GA74697@syl.local>
References: <8d295389ea43c6b7e008514067b7af6eacba64a5.1587492422.git.me@ttaylorr.com>
 <xmqqeesgmuzv.fsf@gitster.c.googlers.com>
 <20200421204516.GA69777@syl.local>
 <xmqq5zdsmuht.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5zdsmuht.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 21, 2020 at 01:52:46PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >> > @@ -414,6 +414,7 @@ void prune_shallow(unsigned options)
> >> >  	} else {
> >> >  		unlink(git_path_shallow(the_repository));
> >> >  		rollback_lock_file(&shallow_lock);
> >> > +		reset_repository_shallow(the_repository);
> >> >  	}
> >>
> >> Here, we reset only after we realize we cannot write the updated
> >> shallow file.  Intended?
> >
> > Yes, see this earlier discussion I had about it with Jonathan:
> > https://lore.kernel.org/git/20200416020509.225014-1-jonathantanmy@google.com/.
>
> I did, and then I asked the question, because I couldn't quite get
> if JTan was asking a question similar to the one he asked earlier in
> the message ("do you need a reset in the "else" branch as well?"),
> or if he was saying what he sees there, "the opposite case", was
> good.

Sorry, I think that the linked message is confusing (at least, it
confused me the second time I read it because I wasn't sure which part
of the mail Jonathan was asking about: my patch, or his response to my
patch).

I think that he was referring to how I had it in the original patch I
sent in that thread, which was wrong. Based on my understanding of his
message, his recommendations match what I have in _this_ patch.

> Also, I was sort-of reacting to """In any case, I think the commit
> message should discuss why reset_repository_shallow() is added only
> on the unlink+rollback side in one "if" statement, but only on the
> opposite "commit" side in another "if" statement.""" in that
> message.

Is the description that I attached in the earlier patch sufficient? I
could certainly add more detail if it's not.

In either case, I'm sitting on another patch locally to improve the
style of the surrounding tests, which is done as a preparatory step
before this patch. I'll re-send after hearing back from you.

> Thanks.

Thanks,
Taylor
