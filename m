Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A417C83000
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 00:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40CB320787
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 00:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pomNA2cH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgD3ABk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 20:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgD3ABk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 20:01:40 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE88C03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 17:01:40 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f15so1536975plr.3
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 17:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ntz9MkTBUWx8zTUTeWRkeTcnxXtc8IA1GBDYyTHyBdg=;
        b=pomNA2cHRj6+vlsch29rGQg5GMaqgOjZ7MapxIjzA1I8v2WkQia6RhlXS2K7r2OqDA
         Mii/BIS8Qx91vY/NydfVPtxuly58yLDaMM4b69sPCUw+JtRyJBAblmRAumcEUL62SbIt
         ot6PsMkB8daFBIUYtfqOeQCihVj5MAUx9A10XzvRcgcjTqM+HPjBxIvhWHTtE1pq3fl4
         44Yq82AVbZJk38GsBG+PmEn7lcVFlXZLPlYT8+ZcTCf1EpIOBOl7FySKwM9D/vD2RzMt
         WhNd1RlKtjI0mF2KiN9OJw6rSqgGpIO5QbeGxv6G2pFu78aXPslTbdzzngvboAUo3frK
         /+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ntz9MkTBUWx8zTUTeWRkeTcnxXtc8IA1GBDYyTHyBdg=;
        b=TqEHmhs6Mn/0cdhOMq/6DjxEqyx+5m7LeofMtKOlsaQiffl4LyPuB5vfJouc6VtiDL
         hG6HmHfhk918AOP4BpULsCFUW5bUrLLghJFth9PwDiPkVGfCp7yLM+D0TzC/9vZMIo9R
         hjf74+AlOwpLcOvicH1G4Klk8ecjyfXzz9PRyj8W1OYp9dN49MYiCT5/RVqmi9eOqI1q
         JYyCPFfVnNHmW3lup8goyz0/dcqioqMRDQ2wSKlSEoAdhoSqEqyL5dR5SvARCPQyZY78
         qMC7XfGaPe8i4se7WiLZDLa0QICxVnHiU9GExz8bAWRZjnTKoSy8HWeXYJEMwaYfvf2x
         FvgA==
X-Gm-Message-State: AGi0PuZfqXBjU4mIGSH3wRkMirfMis9K4QQRxIma8MWLXWCJNWxGUM+K
        bpWpc6gWTrF+2Ia1Dgmpc8jXFwNdao0=
X-Google-Smtp-Source: APiQypLpwbLD9avnHKkWgmpNrCMPtLzC88no/yeY097Tdm9ViAvAtCGiXvS/DVJwEHECcAkwcjFqng==
X-Received: by 2002:a17:902:a5c2:: with SMTP id t2mr938764plq.151.1588204899206;
        Wed, 29 Apr 2020 17:01:39 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id i185sm1905852pfg.14.2020.04.29.17.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 17:01:38 -0700 (PDT)
Date:   Wed, 29 Apr 2020 17:01:33 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] bugreport: collect list of populated hooks
Message-ID: <20200430000133.GD77802@google.com>
References: <20200424233800.200439-1-emilyshaffer@google.com>
 <20200427233820.179891-1-emilyshaffer@google.com>
 <20200427234510.GC36078@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427234510.GC36078@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 04:45:10PM -0700, Jonathan Nieder wrote:
> 
> Emily Shaffer wrote:
> 
> > --- a/t/t0091-bugreport.sh
> > +++ b/t/t0091-bugreport.sh
> > @@ -57,5 +57,15 @@ test_expect_success 'can create leading directories outside of a git dir' '
> >  	nongit git bugreport -o foo/bar/baz
> >  '
> >  
> > +test_expect_success 'indicates populated hooks' '
> > +	test_when_finished rm git-bugreport-hooks.txt &&
> > +	test_when_finished rm -fr .git/hooks &&
> > +	mkdir .git/hooks &&
> > +	touch .git/hooks/applypatch-msg &&
> > +	chmod +x .git/hooks/applypatch-msg &&
> 
> optional: could use write_script for this

ACK, especially given Junio's comment in reply here.

> 
> > +	git bugreport -s hooks &&
> > +	test_i18ngrep applypatch-msg git-bugreport-hooks.txt
> 
> This should work even when translated, so it can use "grep" instead of
> test_i18ngrep.
> 
> A few more things to test:
> - that it doesn't include hooks we *haven't* installed. :)
> - that it isn't confused by the default *.sample hooks

I'll lump these together by adding a .sample hook and ensuring that hook
was excluded.

> - what happens when outside a git repository?

The earlier test to make sure it doesn't crash seems satisfactory to me
- is there some other behavior you'd like to ensure? I'm not keen to
check the lines below the header are empty, since the spacing there
could change and break an unrelated test.

Reroll coming today. These changes are straightforward and passing for
me locally.

 - Emily
