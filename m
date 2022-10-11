Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5BEC433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 01:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiJKBZd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 21:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiJKBYt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 21:24:49 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4494820F
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 18:24:35 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id z197so4834743iof.2
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 18:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f2ekx+Jp+wkKKsjBFDl+HxxfGmVAX8Ebs0449hZzyNg=;
        b=Cdj0wFmRk1v4ag/mPA8feFvR3cxEckOI1PoLgRI1XEvi4BPtFYkEk14+4FUVXa1IM4
         3026GWTUYvkduOT5uoAbKNaMKx/sxI+EUpUPvQKkMM6loyjAJLQJHgVCPCEU0nvkF7bY
         RY8Jw1entmWDVpbyK41q0080ukWstQ5Cd8gz00s5CeqZyF0Q032YQ+P8aKQOGeD8ADML
         FqTjwTem2pwybxwsIM4fxsfAUKnJHkT9xUPEBKmYeBMN7AqX0iedck9VAZjabqgxl5c9
         9h+A0UNVXmc5JXhxUqr37xO18fnzYv/+T0NYM8cstSiQE4vJhkq7fWsbILDsEjOh4NMi
         wyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2ekx+Jp+wkKKsjBFDl+HxxfGmVAX8Ebs0449hZzyNg=;
        b=dd40C1EQ97wBlNp0RslZ+/EVn+WoLOasx7r2BKcQ52HCyb15zAJBGhFZL1c8YEl1/c
         i+ty+/tIWs6ARTqEE9wdwYa9hfqXYtlC7Xzku7QsT0++jdPIhwC8yL0wF/1+TElEUSuH
         zuwcl50MnF5IcUDu6fomCQJIwjRuh+DtQEVsub0x/dVSlpMZiGxj9LtoV2DZwTEwed/c
         x+uyrD/8kut5Jf3Mtk3r2k+g/EWOPnQYqSapEyA46XrQhyuZyEIb7quedGI9ODp4d1u4
         zqs0LZVnptsM+tWGo4aMcZ3pxDWuQqhL/TbgOudwLGqAQPwEHziiMPvOvCMmpFjzy0ad
         ZPfw==
X-Gm-Message-State: ACrzQf3JUcn4/tKjWN5yJ7VgJRqRgKacRUwoOZHN7mfdphv2N5ZQ1HAZ
        S8fHUJnbctpz/j8/HGUPcsk8rg==
X-Google-Smtp-Source: AMsMyM6sJ7M0E4aiEJFhTDE663ECLDBo4Y58fND6VV3Fp6m4Sx45hB6saE9MQmDcYojqX5XK6lszPQ==
X-Received: by 2002:a5e:8e0d:0:b0:6bc:5e1e:6987 with SMTP id a13-20020a5e8e0d000000b006bc5e1e6987mr1839918ion.135.1665451474377;
        Mon, 10 Oct 2022 18:24:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v2-20020a02b082000000b0036378e4747esm4493119jah.114.2022.10.10.18.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 18:24:33 -0700 (PDT)
Date:   Mon, 10 Oct 2022 21:24:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        jacob@initialcommit.io, gitster@pobox.com
Subject: Re: [PATCH 4/7] shortlog: support arbitrary commit format `--group`s
Message-ID: <Y0TF0M6UzLS9r6iM@nand.local>
References: <cover.1665448437.git.me@ttaylorr.com>
 <6f38990cc2ea8460ce37437e0770784d9b712dab.1665448437.git.me@ttaylorr.com>
 <Y0TDDvzeCxIMFbG5@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0TDDvzeCxIMFbG5@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 09:12:46PM -0400, Jeff King wrote:
> On Mon, Oct 10, 2022 at 08:34:12PM -0400, Taylor Blau wrote:
>
> > diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
> > index 4982ceee21..ca15643f45 100644
> > --- a/Documentation/git-shortlog.txt
> > +++ b/Documentation/git-shortlog.txt
> > @@ -59,6 +59,8 @@ OPTIONS
> >     example, if your project uses `Reviewed-by` trailers, you might want
> >     to see who has been reviewing with
> >     `git shortlog -ns --group=trailer:reviewed-by`.
> > + - `<format>`, any string accepted by the `--format` option of 'git log'.
> > +   (See the "PRETTY FORMATS" section of linkgit:git-log[1].)
>
> I have a slight preference here to call this:
>
>   --group=format:<format>

That seems very reasonable, thanks!

> > @@ -243,6 +266,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
> >  	if (log->groups & SHORTLOG_GROUP_TRAILER) {
> >  		insert_records_from_trailers(log, &dups, commit, &ctx, oneline_str);
> >  	}
> > +	insert_records_from_format(log, &dups, commit, &ctx, oneline_str);
>
> Hmm. I see why we don't need to guard this with:
>
>   if (log->groups & SHORTLOG_GROUP_FORMAT)
>
> since our helper function is a noop if log->format is empty. But I
> wonder if:
>
>   - it's more clear to match the others (although it looks like they are
>     going away later, so that potentially becomes a non-issue)
>
>   - it's useful to have a conditional that lets us skip any setup work.
>     For trailers, in particular, we call logmsg_reencode(), which is
>     potentially expensive. OTOH, it would be easy for the helper
>     function to just return early when log->format.nr is 0.

In this case, `insert_records_from_format()` is cheap when
log->format.nr is 0. It is limited to setting up a strbuf to
STRBUF_INIT, and then calling strbuf_release() on it before returning.

And, indeed, the remaining conditionals go away by the final patch, so
you may want to decide then if it looks good to you or not.

> > diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
> > index 3095b1b2ff..2417ac8896 100755
> > --- a/t/t4201-shortlog.sh
> > +++ b/t/t4201-shortlog.sh
> > @@ -237,6 +237,15 @@ test_expect_success 'shortlog --group=trailer:signed-off-by' '
> >  	test_cmp expect actual
> >  '
> >
> > +test_expect_success 'shortlog --group=<format>' '
> > +	git shortlog -s --date="format:%Y" --group="%cN (%cd)" HEAD >actual &&
> > +	cat >expect <<-\EOF &&
> > +	     4	C O Mitter (2005)
> > +	     1	Sin Nombre (2005)
> > +	EOF
> > +	test_cmp expect actual
> > +'
>
> Makes sense. Two other tests that might be worth including:
>
>   - "shortlog --group=bogus" generates an error (we might already have
>     such a test; I didn't check)

We didn't have such a test before, so adding one is a good call, thanks!

>   - since the multiple-option behavior is so subtle, maybe show a case
>     where two formats partially overlap. A plausible one is "--group=%aN
>     --group=%cN", but the test setup might need tweaked to cover both.
>     There's an existing "multiple groups" test that might come in handy.

Interesting. I was starting to write that test up, but then realized
that this will be covered by the end of the series, since the
`--group=trailer` machinery is reimplemented in terms of the new format
group.

So if the existing "shortlog can match multiple groups" test keeps
passing, we did our job correctly ;-).

Thanks,
Taylor
