Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD78C433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 02:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiJRCnZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 22:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiJRCnX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 22:43:23 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E51396228
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 19:43:20 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id i9so6825440ilv.9
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 19:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o3fYRdrXRsBd3aHqBH0EMevvQrLtp23k1Kr8CcaNH5A=;
        b=o8QsK6iq04dqT+upb5C9Il2wdDzZiSm62uEcLXpS4o04+EBNv+wKrgXl+OWDx6y6Pa
         fWB0LbDWePLMEkEQ2xqpz3bbLEFXeyunBe4663kCgzXcVD7P6m1qss2wjhqajAXul+02
         n6B1M6kiDYTVTC2yd7u2gKHJsOIla7PjrojAgXsk7ZNRsGMhZRz2y2B1ZSmqPjZ5WUYE
         6jqazgWNe+FGLUzUcOlcq5GvJxZBIkIUZ050nvm/NPIR5vMRpt5p54dXglos4GcvMKzK
         HG3JPhD5u1wMfAuAvCCKbfIj9lFynLhEhgdH8QEftTZFqjhaza5hq+h5RkJ4m7Hb30A9
         pyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3fYRdrXRsBd3aHqBH0EMevvQrLtp23k1Kr8CcaNH5A=;
        b=rqGKw263vyCHk20fOUktKNUk098RePWiQwGgOexBURL4ndEmpuP8YRCnUyCvSy1Gl0
         LOPCkCSE/uzJ5jwpwQHi0u9FrdNtuBNdF3uQvsD/fgsck9BVt8VhkMWTnV2yhifjmneE
         urz9z9BynyfWeX2g5RNJtpF9CXnagAwNNp3ZoXibNOWQkHV8JaVNywgklUJfKoobGWmN
         ct+wIzTH5DameAqbrl7VFOuKJlgw2+9fhLUccnbUyvwemq+RxKFhBc4uhIp8tfweI2Rz
         TVj+5tvb70yijFOy7/GhzjmwKOzLqdL7g4ZNZqCgADDfC4WVqTUOkncf3zeUCj0ye/rR
         YQLA==
X-Gm-Message-State: ACrzQf2E5MXZatLI8rW4ZZDq+UZ88VBGZAYYHsCNXH4Dtrlh+JPDwB/x
        rtQ0M2v7MDWD3pGQZTbix1V00Z7PXypkY0P+
X-Google-Smtp-Source: AMsMyM7A7LtAsaGdlH40Rca9IW7nsN76BNfknWwjGECY17oe58vrp3E3UsEA09mEtzkgDRur9zIEjw==
X-Received: by 2002:a05:6e02:184c:b0:2fc:4f65:9dee with SMTP id b12-20020a056e02184c00b002fc4f659deemr731984ilv.154.1666060998647;
        Mon, 17 Oct 2022 19:43:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z1-20020a056602204100b0068869b84b02sm568371iod.21.2022.10.17.19.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:43:18 -0700 (PDT)
Date:   Mon, 17 Oct 2022 22:43:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, derrickstolee@github.com, vdye@github.com,
        gitster@pobox.com
Subject: Re: [PATCH] builtin/repack.c: remove redundant pack-based bitmaps
Message-ID: <Y04Sxb/ysk5tgyvZ@nand.local>
References: <393fd4c6db78cd694e6d4dfcf24f17e2850ccd99.1665601403.git.me@ttaylorr.com>
 <Y02YzYS172skpbAb@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y02YzYS172skpbAb@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 17, 2022 at 02:02:53PM -0400, Jeff King wrote:
> > +		if (unlink(path.buf) && errno != ENOENT)
> > +			die_errno(_("could not remove stale bitmap: %s"),
> > +				  path.buf);
>
> We could downgrade this to a warning, since there is no downside to
> retaining those files (aside from wasted space). In
> remove_redundant_pack(), we call into unlink_pack_path(), which just
> ignores unlink errors (though arguably it should at least warn).

I think that downgrading this to `warning_errno()` is appropriate. I'll
make that change locally and send a new version.

I think a good separate topic is teaching `remove_redundant_pack()` to
emit warnings for non-ENOENT errors, too. But I'll leave that for
another day :-).

> > @@ -1059,10 +1088,15 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
> >  						refs_snapshot ? get_tempfile_path(refs_snapshot) : NULL,
> >  						show_progress, write_bitmaps > 0);
> >
> > +		if (ret) {
> > +			string_list_clear(&include, 0);
> > +			return ret;
> > +		}
> > +
> > +		if (write_bitmaps)
> > +			remove_redundant_bitmaps(&include, packdir);
> > +
> >  		string_list_clear(&include, 0);
> > -
> > -		if (ret)
> > -			return ret;
> >  	}
>
> You could avoid having to repeat the string-list cleanup here by
> structuring it like:
>
>   if (!ret && write_bitmaps)
> 	remove_redundant_bitmaps(&include, packdir);
>
>   /* as before, clear string list and possibly return ret */
>
> Since it's only one line, it's not that big a deal, but it simplifies
> the flow.
>
> It's correct either way, of course. One thing I did have to do while
> reviewing this was look at this hunk in place. The context omits that
> this is in the "if (write_midx)" conditional, which is of course very
> important. ;)

Great suggestion, thanks. I'll apply it locally and send a reroll now.

Thanks,
Taylor
