Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604FFC433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 02:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiCACBk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 21:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiCACBj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 21:01:39 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA35A49C96
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 18:00:59 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id w7so15668006qvr.3
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 18:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xKYvfGIy6YXYLysjkSHRGWB9+AFSzUas1sHFZ5+blxM=;
        b=NI4b6fnVA7omfxEqPhsfLdvO3gl6ZuZ+RRYrc6pvDvhDdM9lVWa4p7CgEvpeqkcKCJ
         zsHsCgxcRqj62zWd+VieX39KzCMf+jsiNj2okLyxP9jo52FjvRjCapBTim6Km8nSG8tw
         9TzDqX2wZMfRVGUixCAEOwWK96tPQTLaWmRfb2lTigb/vHvBnZ0O3qdoji2J0isDMHkc
         hu2U7YjBurOdv342p8RH7k6y2lWLK3R+b63eE197K7LF026NRjgOgJEOg71OqrZT+2oN
         Ev/5niyMpBf+Ql9KSfGmEN3uNMGzuGtjkqpj2M5XxLlgUl2CZWIgkVcR+jVNgPp9pmt5
         736w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xKYvfGIy6YXYLysjkSHRGWB9+AFSzUas1sHFZ5+blxM=;
        b=rWBHz7TKudiRcCYSMPQmJDXeae/bb8wDkgdAGKlGFZeqU+PAnxRbNl52/ManktZhuz
         w85WX4dYIZ5TwV/s2HmEjh3Ug8JOAN7qotnOnviHuVlayeIWo8eWkwVnUf5qXnvD+9aq
         t6MjApIojPxhYzadvs+UqlTW16EEjeYO43R2KhK0O5/uEgKm3bXdtxzf3V7SkplENQNO
         fkwjlyxk/wzDCcSZKhI1NfRMpYblBCRb8LDIbotO6HnEE5A8NWeUfbwW6n+8Dt7UDX5k
         Cjftb14FQg6dRs1C0zVUIG8ZJBVY1v9H0OaQZ8bPsUzARH9OSwkCRBl60F/FBQwSvba+
         EA7A==
X-Gm-Message-State: AOAM532Lge5Rx/S+eBxlILNkEfYljCbSRYcsBdOxtUYSPByLL9nGe0oW
        b1ANTRW8F+yRj/XV/mDqNA5MTN0Hkkbw9wQm
X-Google-Smtp-Source: ABdhPJwKM1HsPfs7uAZNo2JBpQeHDjGg3a5NDLBCEGqrU803KKBovVhGJcTLswk7Kycf0VkYfMos4A==
X-Received: by 2002:a05:6214:16c1:b0:42b:f181:664c with SMTP id d1-20020a05621416c100b0042bf181664cmr16161641qvz.121.1646100058799;
        Mon, 28 Feb 2022 18:00:58 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3-20020ac85703000000b002dcea434fa4sm8162738qtw.18.2022.02.28.18.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 18:00:58 -0800 (PST)
Date:   Mon, 28 Feb 2022 21:00:57 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, larsxschneider@gmail.com, peff@peff.net,
        tytso@mit.edu
Subject: Re: [PATCH 12/17] builtin/repack.c: support generating a cruft pack
Message-ID: <Yh1+WQcs71rQYPEg@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <a05675ab834ac5e8bc3ab72847b0621a563e0e1b.1638224692.git.me@ttaylorr.com>
 <xmqqk0gikcf8.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0gikcf8.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 05, 2021 at 12:46:19PM -0800, Junio C Hamano wrote:
> Various thoughts on just this part, as the hunk got my attention
> while merging with other topics in 'seen'.
>
> > +	if (pack_everything & PACK_CRUFT && delete_redundant) {
> > +		if (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE))
> > +			die(_("--cruft and -A are incompatible"));
> > +		if (keep_unreachable)
> > +			die(_("--cruft and -k are incompatible"));
> > +		if (!(pack_everything & ALL_INTO_ONE))
> > +			die(_("--cruft must be combined with all-into-one"));
> > +	}
>
> The "reuse similar messages for i18n" topic will encourage us to
> turn this part into:
>
> 	if (pack_everything & PACK_CRUFT && delete_redundant) {
> 		if (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE))
> 			die(_("%s and %s are mutually exclusive"),
> 			    "--cruft", "-A");
> 		if (keep_unreachable)
> 			die(_("%s and %s are mutually exclusive"),
> 			    "--cruft", "-k");
> 		if (!(pack_everything & ALL_INTO_ONE))
> 			die(_("--cruft must be combined with all-into-one"));
> 	}

Thanks, done.

> The conditionals are a bit unpleasant to read and maintain, but I
> guess we cannot help it?

I don't know that I find them unpleasant to read, but perhaps they are a
hassle to maintain (as we add new, mutually-exclusive options). But I
can't seem to think of a better alternative...

> Saying ALL_INTO_ONE is a bit unfriendly to the end user, who would
> probably not know that it is the name the code gave to the bit that
> is turned on when given an option externally known under a different
> name (is that "-a"?).
>
> If "--cruft" must be used with "all into one", I wonder if it makes
> sense to make it imply that?  Not in the sense that OPT_BIT()
> initially flips the ALL_INTO_ONE bit on upon seeing "--cruft", but
> after parse_options() returns, we check PACK_CRUFT and if it is on
> turn ALL_INTO_ONE also on (so even if '-a' gains '--all-into-one'
> option, the user won't break us by giving "--no-all-into-one" after
> they gave us "--cruft")?  I didn't think about this part thoroughly
> enough, though.

Yes, `--cruft` must be used with an option that sets ALL_INTO_ONE. Since
we don't have any automatic '--no-' versions of single character
options, I think that this conditional is currently redundant, but I
agree that this code would break if we (a) removed the conditional
you're talking about and (b) allowed passing something like
`--no-all-into-one` which unsets the ALL_INTO_ONE bit.

So setting ALL_INTO_ONE ourselves _after_ option parsing is done makes
sense to me, thanks.

Thanks,
Taylor
