Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4C6C38A2D
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 22:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJUWMJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 18:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiJUWMH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 18:12:07 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84E92441B8
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 15:12:06 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id e15so3493261iof.2
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 15:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e9+UVn7e49caN96I2kN0XsKbtVOASLah5o34t6kB3YU=;
        b=vsx0qLeSYbcffQZtSzBu368EgxKYPRE7nrWlE2GU27mNkIyvS699E/qIQ61d99S5Lx
         U/ddUuOxgoRoWscZ7zKl8CUpUR6ox4aL1tuYr/RsDTCjKXh5tJNEV2SQGv8y828bI3ql
         YoAUi1pjTI3pM9hEnqkZP9PB46S8h4BHxA4sSg75MkT4j5oW+V87tcxcd5inxkEpewJe
         6KYjjXKqgyj4FZdDWhDwbmAZRQB7CR4YP0XC4hafx579mK79mVW868c5sDVplaF+tu35
         foa1duEbFbbnXjQdjiP2IbIk2MVlL662gGbOmhkw9c9xjNEw2BBfPerZWTbk2INPYTs0
         Hrjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9+UVn7e49caN96I2kN0XsKbtVOASLah5o34t6kB3YU=;
        b=G41tTbBCPyEbzG5d/RpkH+f57f9KnqFVEmtU3/C11tb9mJ9Q2GPSNVWTsBRNYXB2I7
         qj5jSfPCU5fhfeTMlQE1MticjYqZ5B9HDcvT42c9LZaTrsC/AAnTGNm8u+mG2z7ochxC
         wG0JXlVNb54WcuNJhqFOD+LdrZum5rk2W9jcwGxEN/3W7g+FdEDAA1YnilFqTt5H0GJy
         HYYUsIvhhQlGSovqxTHMHGOuwtXDz8+L2a+vCTdR+btWWdDfr5HaACbcRk/OetuHO0/q
         V7tpK63uLpHQCKWmBRBMIcs/v4RPt5r2Ny1CvI8lrqjEPrjux5GWplVYxsIysGnKJv05
         tovw==
X-Gm-Message-State: ACrzQf2BinDDnDBEC4SOIX8wJH1xIP8dkTCmM4z/kifKFmrA+WZknmej
        XgavoTRK51tapjMf7jmOX108CQ==
X-Google-Smtp-Source: AMsMyM4hwNhwdxM/gdZo9CvorJIIubWjWi1HJ30dtLD39k0X+vJ2tMChe3qry5p14T/EeufIs9aB+w==
X-Received: by 2002:a6b:3f04:0:b0:6bc:75c4:586a with SMTP id m4-20020a6b3f04000000b006bc75c4586amr14646577ioa.83.1666390326143;
        Fri, 21 Oct 2022 15:12:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d5-20020a026205000000b0036332a07adcsm4544622jac.173.2022.10.21.15.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 15:12:05 -0700 (PDT)
Date:   Fri, 21 Oct 2022 18:12:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, gitster@pobox.com
Subject: Re: [PATCH 4/7] shortlog: support arbitrary commit format `--group`s
Message-ID: <Y1MZNISVkOFFXX9D@nand.local>
References: <cover.1665448437.git.me@ttaylorr.com>
 <6f38990cc2ea8460ce37437e0770784d9b712dab.1665448437.git.me@ttaylorr.com>
 <Y0TDDvzeCxIMFbG5@coredump.intra.peff.net>
 <Y0TF0M6UzLS9r6iM@nand.local>
 <Y0TOpVF+Y70YJHzx@coredump.intra.peff.net>
 <Y1IGeuudJj18sDPz@nand.local>
 <Y1IsWt0ZrW+0hy1v@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1IsWt0ZrW+0hy1v@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2022 at 01:21:30AM -0400, Jeff King wrote:
> On Thu, Oct 20, 2022 at 10:39:54PM -0400, Taylor Blau wrote:
>
> > --- 8< ---
> > diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
> > index 0abe5354fc..566d581e1b 100755
> > --- a/t/t4201-shortlog.sh
> > +++ b/t/t4201-shortlog.sh
> > @@ -356,6 +356,19 @@ test_expect_success 'shortlog can match multiple groups' '
> >  	test_cmp expect actual
> >  '
> >
> > +test_expect_success 'shortlog can match multiple format groups' '
> > +	cat >expect <<-\EOF &&
> > +	     2	User B <b@example.com>
> > +	     1	A U Thor <author@example.com>
> > +	     1	User A <a@example.com>
> > +	EOF
> > +	git shortlog -ns \
> > +		--group="%(trailers:valueonly,separator=%0x00,key=some-trailer)" \
> > +		--group="%(trailers:valueonly,separator=%0x00,key=another-trailer)" \
> > +		-2 HEAD >actual &&
> > +	test_cmp expect actual
> > +'
> > +
> >  test_expect_success 'set up option selection tests' '
> >  	git commit --allow-empty -F - <<-\EOF
> >  	subject
> > --- >8 ---
> >
> > The gross bit there really is the 'separator=%0x00' thing, since the
> > "trailers" pretty format gives us a NL character already. I suppose that
> > you could do something like this on top instead:
>
> IMHO the new test should avoid using trailers entirely, to avoid the
> notion that they are necessary to create the duplicate situation. In a
> normal repository, the most obvious one is just asking about both
> authors and committers:
>
>   git shortlog --group=format:%cn --group=format:%an

Yeah, that's fair. I was worried enough about whether or not this was
going to cause significant test fallout, but it ended up being extremely
straightforward and simplified the tests nicely. Thanks!

Thanks,
Taylor
