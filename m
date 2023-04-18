Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E96C6FD18
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 19:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjDRTb2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 15:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjDRTb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 15:31:27 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652BD93D9
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 12:31:25 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-54fa9da5e5bso271651627b3.1
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 12:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681846284; x=1684438284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c0hmtHaN/GnpnMf8rYvbwrZ+MftDMnNFGa6F904Xqlo=;
        b=j+SsXjlOFPXixjER0u/B9BcRzkRMk6bym5UX0NB6GXJbY7IhOv/Ty+2wELvjSXntfN
         vvhPINuhqq4ig3VKCEd3FNSErggvCfPSGsAJvfBTDmAvOZrrxAXA2jtqr/rmS3flOjJW
         joFe5jfKnGAbhjzJAyvgfP36v2DYRwSkuFsqmQHK2QsDqgTSh3b+vYzn5K1aaVconk2n
         ItKLxupPTvWXFKAOUZZwMluLCl5hApK2fnviUDBSImWZYfWhkG3nwWk3Ls2FRnfHu24h
         +vnDKucHoQgpFaUPzPxKWymJ9LaAmoQtYf5kzmD8Rhc2lFQ3y31J2/54s9lAbVbf1VT2
         kh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681846284; x=1684438284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0hmtHaN/GnpnMf8rYvbwrZ+MftDMnNFGa6F904Xqlo=;
        b=EpLB5Dw+//xqHlixSOGYDpVpsmo++CfYxTSPpA9q9O9RxAlB8svtovjNCqtcaWHNLc
         6+0ZlE7eS40Zny0++Th8ZGMBCOyQYvzBo3b3QNHrZzWPyKE5UBpMc01HR3iWrF6Ay4NG
         OvmLTKsmk0RYm3k6FkqVvA1TbwgMXK8F2809z9enS496i8kRWDXbkegA1l/7u3awq0Yd
         MBTXDy/whda5o9bH8Ca5Vi8qWt9x0MZnxi+tukuUo3O+hQ8zFNdCBjYE73sWQdYwj3B5
         IEgHVVoKcw0cDdDEzZPMYMyQqf0FsZiFUzX8wKLw+q+AhPfwT9Ygfo8yqX0Q8iJxQCXE
         5zQw==
X-Gm-Message-State: AAQBX9dbz2OkEyBLwY+strDwKAdlrE3/YyK1zB27jWd5h7r56yo5LxuW
        0uU9MMfermtqftZH2fTCMr3d61C2pwXEFIU51YLUxg==
X-Google-Smtp-Source: AKy350bf4ibEseQebz4bI1xbFVRRoGpsXBJ+NDNg5mCxIcewg5oKSfo29VoTd0NzSZs4yafbBkRW6A==
X-Received: by 2002:a0d:d88c:0:b0:544:5b63:b956 with SMTP id a134-20020a0dd88c000000b005445b63b956mr1204578ywe.8.1681846283144;
        Tue, 18 Apr 2023 12:31:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a192-20020a811ac9000000b0054c19f4d6d2sm3999335ywa.29.2023.04.18.12.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:31:22 -0700 (PDT)
Date:   Tue, 18 Apr 2023 15:31:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: tb/ban-strtok
Message-ID: <ZD7wCYDmhiKcfhow@nand.local>
References: <xmqqfs8xfw25.fsf@gitster.g>
 <ZD6vu6H0xzLSF/2w@nand.local>
 <xmqqo7nldt5f.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo7nldt5f.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2023 at 09:58:20AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >>  Mark strtok() and strtok_r() to be banned.
> >>
> >>  source: <cover.1681428696.git.me@ttaylorr.com>
> >
> > This one needs a reroll to remove `strtok_r()` from the proposed banned
> > list, and to support slightly different semantics the new
> > string_list_split_in_place_multi() function. Will send today.
>
> I actually do not think we would seriously miss strtok_r(); as long
> as the rationale for doing so is clearly described, I think we are
> OK.  Just do not sell string-list as if it were the solution to
> everything (which is not---it is a rather poor data structure), but
> compare string_list_split() with strtok_r() and say our application
> hasn't needed the flexibility of the latter.

I agree that we wouldn't miss it at all, since we have no uses of
strtok_r() today.

But let's decide on banning it separately, since the much more
immediate-term issues are the existing uses of strtok() that are in the
tree.

Thanks,
Taylor
