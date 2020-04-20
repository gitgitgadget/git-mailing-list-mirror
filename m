Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538BCC54FCC
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 23:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 278B22064C
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 23:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0uHxBnA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgDTXxG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 19:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725989AbgDTXxF (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 19:53:05 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47FCC061A0E
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 16:53:05 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t40so576424pjb.3
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 16:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SlQd0dzn+F7Yn0+b9t27HmDmSwddXlC6LIz19UJMlqU=;
        b=B0uHxBnAnYMXBTSbhjlBvNpEOi5G4LQAVBsH6jZCRmCZjH3TecV/9++DT8AqvMkVaB
         xdXndZvycl4d9aqEXJBXGvibNEL6O9HHBewdmF4gSHAv9hjnZ5m5GuZak94eR3YvuvZO
         86fb0TD9PUUJp3U9TazCumscLfs53IV9F/ZUg2JFyAVhVp6EdligkHYtUHISFKlZRbr4
         +yPDCIwmXB4lPhAEDvyXV9aqqisNa3d5KA+DGxHsgn9WeHff1z9ZpJzNCqKu6c7gd2cb
         ASzQcEWenAZztDH+2fy8iIGyr2mQhXC20RFS1pHEWBhLNAzpyrqm16cDQM7rHeNwcLFg
         7/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SlQd0dzn+F7Yn0+b9t27HmDmSwddXlC6LIz19UJMlqU=;
        b=TL0iHBZ95T1XhllwzkMFGA29ZdgHtwvW+RNlRtQ0icOQL7unDUazvJ1DcdD9tWPqC/
         yROZzxnvIMdR+SWR8mOEDI73Ob+nKSDBIDXPpg4J2sgern5vBRwqp0+kJE29VgWTbs+O
         GZroIVlcUr86aKvqS37ckhSA+gBtzXyA25gofwXxHFbtQYRC0XSFFFa0k5ijZrA1ZLhr
         CamLuBFlxK7XvmvwB9vR25TQ3cyM2wbY0sChVisW/fWI8T79QbitG0zbxNMuIUn+jBII
         hw40hq8Pj5i0GvpMbUcs3ib0SMRiA385uoGh8X9x+PmUA+f1VyJnVT4IcqsbGwPoXEY0
         WjhA==
X-Gm-Message-State: AGi0PuaB+fqX9H2+Whad4K8J4oWxzege84FdUF5AltZwyURHswm45nft
        jaaCdtQBnXcnwHLz/8aD5YU=
X-Google-Smtp-Source: APiQypLG4yVz3PXozF3GvGWiw8PgWgz167RFYhIEq2iXTiMGPTNow8rUAbiCdKoNtko/fwCefYUH8Q==
X-Received: by 2002:a17:902:8a89:: with SMTP id p9mr18753502plo.286.1587426785329;
        Mon, 20 Apr 2020 16:53:05 -0700 (PDT)
Received: from localhost ([2402:800:6374:f359:effc:5180:3a91:1887])
        by smtp.gmail.com with ESMTPSA id 135sm620605pfu.207.2020.04.20.16.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 16:53:04 -0700 (PDT)
Date:   Tue, 21 Apr 2020 06:53:02 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mailinfo.c::convert_to_utf8: reuse strlen info
Message-ID: <20200420235302.GA2377@danh.dev>
References: <20200418035449.9450-1-congdanhqx@gmail.com>
 <cover.1587289680.git.congdanhqx@gmail.com>
 <e3e542d38818b762f8d6d6b50bc42e01b070772b.1587289680.git.congdanhqx@gmail.com>
 <xmqqv9luq66u.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqv9luq66u.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-20 12:59:37-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:
> 
> > diff --git a/t/t4254-am-corrupt.sh b/t/t4254-am-corrupt.sh
> > index ddd35498db..98cda32d0a 100755
> > --- a/t/t4254-am-corrupt.sh
> > +++ b/t/t4254-am-corrupt.sh
> > @@ -3,6 +3,36 @@
> >  test_description='git am with corrupt input'
> >  . ./test-lib.sh
> >  
> > +write_nul_patch() {
> 
> Style: SP on both sides of (), i.e.
> 
> 	write_nul_patch () {
> 
> But isn't this misnamed?  You are interested in injecting '\0' byte

Originally, this function was written to create a file named
"nul.patch", but it's prohibited in Windows land.

It's still misnamed, though.

> in the e-mail headers and bodies, not necessarily part of the patch,
> but "nul-patch" somehow hints readers that we are writing out a Null
> Patch (something that does not do anything, perhaps?).
> 
> sample_mbox_with_nul is the best alternative I can come up with
> offhand, which is not great either, but at least it does not say
> patch.

I prefer having a verb, but make_sample_mbox_with_nul is too long.
I'll take make_mbox_with_nul. Naming is hard.

> > +	cat <<-\EOF
> > +	---
> > +	diff --git a/afile b/afile
> > +	new file mode 100644
> > +	index 0000000000..e69de29bb2
> > +	--$space
> > +	2.26.1
> > +	EOF
> 
> Doesn't this want to interpolate $space in the output?  I think you
> want to say <<-EOF, without quoting.
> 
>     cd t && sh t4254-am-corrupt.sh -d && cat trash*.t4254-*/body.patch
> 
> tells me that "--$space" is left in the output, not "-- ".

I recalled it now. Originially, I wrote "-- " in that line,
When I try git-am(1) the mail, I saw a warning about trailing space.
I want to get rid of it but forget to change "-\EOF"

Those last 2 lines isn't strictly required, I wanted to mimic a real
patch created by git-format-patch, though.


-- 
Danh
