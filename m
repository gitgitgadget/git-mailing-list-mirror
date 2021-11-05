Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4B7C433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 11:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED2356124F
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 11:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbhKEL2V (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 07:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbhKEL2R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 07:28:17 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7E2C061203
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 04:25:37 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so6221100wme.4
        for <git@vger.kernel.org>; Fri, 05 Nov 2021 04:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1FaoF86L8m9mDixkp/kdClY1QbGRk6zfjoW6gV/pMuw=;
        b=cz4dp4ZLQ+FSwj35H/tSnGdtxx6+YmfDgUIELcarUSlSvuUlW+rSdaXxWPnA1nO9ls
         pZNQtHpJX7sfOI0XDrTQBDU7Ln2KZFVyQoz97ENGuVfQh/ojIdu7kMWY8pcqXKqu7nyb
         zNo5gNWQ3nKpldMOdxIq9jXpiKk0+F3I8V/rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1FaoF86L8m9mDixkp/kdClY1QbGRk6zfjoW6gV/pMuw=;
        b=vwVZoSo45/l+6IsGvfqTreQFzT0TovCxbr2y0d9mbujOXTO7eGULZh0JC4Raz9+zL6
         3byVjXedN3HCBOi87qVq32v+b+jDQb4MjrHZzeJuippc+tKon2GEFlEruObO6C/7uZZu
         QOvzV7f908eHzlXU0/8Rxdoya2IawNlpx/oaz6cKKeT9wO70RxpfQVv3GDM+hsG56ol0
         ODkIzfQbUH4c6qWK0OBTeDSKlrrRQMn5u9sryEOzeK/jB1mCQndS/8JRmUzdoAR1RnB0
         mlYrpaM+6zLaNcMFK2pRJWvoa8jXKbafkbZTtBppmxMB6IyS2DY8N5XIBxr1FY5MCvx+
         ddLA==
X-Gm-Message-State: AOAM532aA8vgynvYrYc3EPIsbffuM4ced9qwPHrwNlpyq68IskAKDfl+
        ndpGKr4B2kxWxoGKYvPX0L0R1w==
X-Google-Smtp-Source: ABdhPJyBIp6utlRsgtLyX8bekeBC1FthNJZxcxqAQXFDM6ccV3ziuQp6Z4ipp1Zzmw5cJj+f9wwShw==
X-Received: by 2002:a1c:f219:: with SMTP id s25mr30295736wmc.31.1636111536495;
        Fri, 05 Nov 2021 04:25:36 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id d16sm3974193wmb.37.2021.11.05.04.25.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Nov 2021 04:25:35 -0700 (PDT)
Date:   Fri, 5 Nov 2021 11:25:25 +0000
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Fabian Stelzer <fs@gigacodes.de>
Subject: Re: [PATCH] t/lib-git.sh: fix ACL-related permissions failure
Message-ID: <20211105112525.GA25887@dinwoodie.org>
References: <20211104192533.2520-1-adam@dinwoodie.org>
 <xmqq7ddn3dlt.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7ddn3dlt.fsf@gitster.g>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday 04 November 2021 at 12:49 pm -0700, Junio C Hamano wrote:
> Adam Dinwoodie <adam@dinwoodie.org> writes:
> 
> > SSH keys are expected to be created with very restrictive permissions,
> > and SSH commands will fail if the permissions are not appropriate.  When
> > creating a directory for SSH keys in test scripts, attempt to clear any
> > ACLs that might otherwise cause the private key to inherit less
> > restrictive permissions than it requires.
> 
> All of the above makes sense as an explanation as to why the
> ssh-keygen command may be unhappy with the $GNUPGHOME directory that
> is prepared here, but ...
> 
> > This change is required in particular to avoid tests relating to SSH
> > signing failing in Cygwin.
> 
> ... I am not quite sure how this explains "tests relating to ssh
> signing failing on Cygwin".  After all, this piece of code is
> lazy_prereq, which means that ssh-keygen in this block that fails
> (due to a less restrictive permissions) would merely mean that tests
> that are protected with GPGSSH prerequisite will be skipped without
> causing test failures.  After all that is the whole point of
> computing prereq on the fly.

The issue is that the prerequisite check isn't _just_ checking a
prerequisite: it's also creating an SSH key that's used without further
modification by the tests.

There are three cases to consider:

- On systems where this prerequisite check fails, a key may or may not
  be created, but the tests that rely on the key won't be run, so it
  doesn't matter either way.

- On (clearly the mainline) systems where this check passes and there
  are no ACL problems, the key that's generated is stored with
  sufficiently restrictive permissions that the tests that rely on the
  key can pass.

- On my system, where ACLs are a problem, the prerequisite check passes,
  and a key is created, but it has permissions that are too permissive.
  As a result, when a test calls OpenSSH to use that key, OpenSSH
  refuses due to the permissions, and the test fails.

> > Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
> > Helped-by: Fabian Stelzer <fs@gigacodes.de>
> 
> Please order these chronologically, i.e. Fabian helped and the patch
> was finished, and finally you sent with your sign off.

Shall do!  I'll resubmit a corrected version as soon as all the other
discussions about this patch seem tidied up.

> > ---
> >  t/lib-gpg.sh | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
> > index f99ef3e859..1d8e5b5b7e 100644
> > --- a/t/lib-gpg.sh
> > +++ b/t/lib-gpg.sh
> > @@ -106,6 +106,7 @@ test_lazy_prereq GPGSSH '
> >  	test $? = 0 || exit 1;
> >  	mkdir -p "${GNUPGHOME}" &&
> >  	chmod 0700 "${GNUPGHOME}" &&
> > +	(setfacl -k "${GNUPGHOME}" 2>/dev/null || true) &&
> >  	ssh-keygen -t ed25519 -N "" -C "git ed25519 key" -f "${GPGSSH_KEY_PRIMARY}" >/dev/null &&
> >  	echo "\"principal with number 1\" $(cat "${GPGSSH_KEY_PRIMARY}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
> >  	ssh-keygen -t rsa -b 2048 -N "" -C "git rsa2048 key" -f "${GPGSSH_KEY_SECONDARY}" >/dev/null &&
> 
> There are other uses of ssh-keygen in the real tests but presumably
> they just use the GNUPGHOME directory prepared with this lazy_prereq
> block, and "setfacl -k" here would have wiped any possible loosening
> of permission, and that is why this is the only place that needs a
> change, right?  That fact might deserve recording in the proposed
> log message.

More than that: the uses of ssh-keygen elsewhere are calling `ssh-keygen
-l`.  That command doesn't generate a key at all, it merely calculates
the fingerprint from the keys that are generated with the ssh-keygen
commands in this prerequisite check.

I think it's unusual that this test_lazy_prereq check isn't just
checking the state of the system but is creating the keys that will be
used in later tests, but I didn't think to document that in my log
because that was clearly a decision that had been made earlier.  But I'm
very happy to make that logic clearer in my commit message!
