Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D7EC433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 01:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D2EF64DFD
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 01:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhA2BWq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 20:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhA2BWh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 20:22:37 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF01C061573
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 17:21:57 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id t63so7392426qkc.1
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 17:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uoqethwe/Z6Pd6RSKFBCu43Dw3EGetwhS1UcIyAhtg0=;
        b=PonndQDu1Ub2sNnaEkMRZ+6OfKfxgt9Qi/ny6/82M9fs17k4CziVXVOzGLsEmtZybu
         /2NDsKhzDTDRn/cIqWgt5/ukRnP7DUn57KpcXzKLJAaPXpkeS5M/4sFAAefXsGxduHtH
         qtVX1R6Paae78H1B8QKEWIhPJ4kQGiHDQVKdOW2FMQ0cQe4Kt4uz5FZD/doeXsmJUG/i
         Ur0akA7ezQzq+WrsOfYI3a+++sQZjgwfWpCh6mDSUCHNgIFuCh/ecfAMVxxwmkkegRnu
         Jg9G5vnvO1TcvvL7zZ0mh7XrkMbjlbusKHXsUZsgCAnqgtETUOxuYkS9JNEBKGhw2AR/
         LcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uoqethwe/Z6Pd6RSKFBCu43Dw3EGetwhS1UcIyAhtg0=;
        b=FiL3QUYuJhPC25eBNq9XyMbU6i5xfQ8dGABAFUktJs1hu4pAQ6uIpCOcKKERT1k/E5
         zOUPt5Oi5TbLmKWZGbE7f5NSNXVLUDKCOGJco6+LzGTsU4xmU6prc7AwYQ9YOAhJq96g
         /ioSaKrrMycddjX+x19LMIpng9WKoenNpIscefopyjz5eBJerISUz5KqYQFulU7+TY6z
         dq2IcsuC2kN8Ehp34MOrnU4i4OYemy4RTHPNIZUCOVk9vAsz8+29khtZjSn4ODTvEJLV
         v5j2P8XoxFV26GriM2uK7ALcYMUWUpktYPGNIfX49eeEsDALVJER0q+/51af+dUQ72kc
         +9+g==
X-Gm-Message-State: AOAM530YNDv7d3IwZs8JYXhSBJqKQwm/EhWa3UlvHK8QbS7hKBsKA0zX
        sLjWhjYBhq7vQ5eJMxVVHVnIjS6ijRpYoA==
X-Google-Smtp-Source: ABdhPJy2p97q4QtMjcherIuqoUwHTT/L64FwvV13Yx90faH0CTrXXQmI017ghmvBnQeS7COLh65KbA==
X-Received: by 2002:a37:458c:: with SMTP id s134mr2312942qka.142.1611883316672;
        Thu, 28 Jan 2021 17:21:56 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5d6b:9c45:5e60:e7b4])
        by smtp.gmail.com with ESMTPSA id b72sm4749679qkc.60.2021.01.28.17.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 17:21:56 -0800 (PST)
Date:   Thu, 28 Jan 2021 20:21:50 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com
Subject: Re: [PATCH v3 07/10] t: prepare for GIT_TEST_WRITE_REV_INDEX
Message-ID: <YBNjLqOe1NtpziV7@nand.local>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1611617819.git.me@ttaylorr.com>
 <7cf16485cccccf365101d30138d9ee8b00d705d0.1611617820.git.me@ttaylorr.com>
 <YBNasXXZc1BEkMxH@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YBNasXXZc1BEkMxH@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 28, 2021 at 07:45:37PM -0500, Jeff King wrote:
> On Mon, Jan 25, 2021 at 06:37:38PM -0500, Taylor Blau wrote:
>
> > diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> > index 297de502a9..2fc3aadbd1 100755
> > --- a/t/t5319-multi-pack-index.sh
> > +++ b/t/t5319-multi-pack-index.sh
> > @@ -710,8 +710,9 @@ test_expect_success 'expire respects .keep files' '
> >  		PACKA=$(ls .git/objects/pack/a-pack*\.pack | sed s/\.pack\$//) &&
> >  		touch $PACKA.keep &&
> >  		git multi-pack-index expire &&
> > -		ls -S .git/objects/pack/a-pack* | grep $PACKA >a-pack-files &&
> > -		test_line_count = 3 a-pack-files &&
> > +		test_path_is_file $PACKA.idx &&
> > +		test_path_is_file $PACKA.keep &&
> > +		test_path_is_file $PACKA.pack &&
>
> I find the post-image here more readable than the original. It probably
> runs faster, too (zero processes instead of three).
>
> > --- a/t/t5325-reverse-index.sh
> > +++ b/t/t5325-reverse-index.sh
> > @@ -3,6 +3,10 @@
> >  test_description='on-disk reverse index'
> >  . ./test-lib.sh
> >
> > +# The below tests want control over the 'pack.writeReverseIndex' setting
> > +# themselves to assert various combinations of it with other options.
> > +sane_unset GIT_TEST_WRITE_REV_INDEX
>
> I think we had a discussion a while ago about sane_unset outside of an
> &&-chain, where it does nothing that regular "unset" would not. But I
> don't know if we reached any kind of conclusion. I actually argued that
> it was fine in:
>
>   https://lore.kernel.org/git/20200630185536.GA1888406@coredump.intra.peff.net/
>
> So I guess I should probably stand by that. ;)

I think I probably took this from the trace2 tests? Not sure. I'm glad
that it's not wrong, strictly speaking.

This is another instance that I'd be happy to send a follow-up patch to
get rid of all of these at once, unless you feel strongly that it should
be changed in this series before applying.

> > --- a/t/t5604-clone-reference.sh
> > +++ b/t/t5604-clone-reference.sh
> > @@ -329,7 +329,7 @@ test_expect_success SYMLINKS 'clone repo with symlinked or unknown files at obje
> >  	for raw in $(ls T*.raw)
> >  	do
> >  		sed -e "s!/../!/Y/!; s![0-9a-f]\{38,\}!Z!" -e "/commit-graph/d" \
> > -		    -e "/multi-pack-index/d" <$raw >$raw.de-sha-1 &&
> > +		    -e "/multi-pack-index/d" -e "/rev/d" <$raw >$raw.de-sha-1 &&
>
> This one is less readable than before. :) I'm not sure how to really
> improve that, though.

Yeah, this follows from a suggestion that Ævar gave in:

  https://lore.kernel.org/git/878s8y5bdn.fsf@evledraar.gmail.com/

FWIW, I found that his suggestion was *clearer* than what was in v2. But
I get that others may feel differently, too.

> > --- a/t/t5702-protocol-v2.sh
> > +++ b/t/t5702-protocol-v2.sh
> > @@ -851,8 +851,10 @@ test_expect_success 'part of packfile response provided as URI' '
> >  	test -f h2found &&
> >
> >  	# Ensure that there are exactly 6 files (3 .pack and 3 .idx).
> > -	ls http_child/.git/objects/pack/* >filelist &&
> > -	test_line_count = 6 filelist
> > +	ls http_child/.git/objects/pack/*.pack >packlist &&
> > +	ls http_child/.git/objects/pack/*.idx >idxlist &&
> > +	test_line_count = 3 idxlist &&
> > +	test_line_count = 3 packlist
> >  '
>
> Hmm. Too bad we can't rely on shell brace expansion, as:
>
>   ls http_child/.git/objects/pack/*.{pack,idx}
>
> would be more readable. You could still do it in a single "ls" by
> writing out both arguments manually, but it's probably not that
> important.

Agreed on all of that.

> This one is making the test a bit looser (it would miss a case where we
> somehow failed to generate the .idx). That seems like an unlikely bug,
> but I wonder if we can keep the original behavior. I guess:
>
>   ls .git/objects/pack/*.pack \
>      .git/objects/pack/*.idx |
>      sort >post_packs
>
> would work?

Sure, I see what you're saying. To be honest, I'm skeptical that we'd
have a bug which failed only this one test, so I'm hesitant to send a
replacement/reroll for this alone.

If you feel strongly, though, I'm happy to change it. (But, I'll err on
the side of leaving it as-is, since you indicated in your response to
v3's cover letter that you'd be OK if I discarded some or all of your
suggestions).

> >  test_expect_success 'gc --no-quiet' '
> > diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> > index 3d17e932a0..8f1caf8025 100755
> > --- a/t/t9300-fast-import.sh
> > +++ b/t/t9300-fast-import.sh
> > @@ -1632,7 +1632,10 @@ test_expect_success 'O: blank lines not necessary after other commands' '
> >  	INPUT_END
> >
> >  	git fast-import <input &&
> > -	test 8 = $(find .git/objects/pack -type f | grep -v multi-pack-index | wc -l) &&
> > +	ls -la .git/objects/pack/pack-*.pack >packlist &&
> > +	ls -la .git/objects/pack/pack-*.pack >idxlist &&
> > +	test_line_count = 4 idxlist &&
> > +	test_line_count = 4 packlist &&
>
> Another case where I don't think we're losing anything (actually, we are
> gaining just slightly; if a bug somehow created 6 packs and 2 idx files,
> we'd now notice!).

Yay!

> -Peff

Thanks,
Taylor
