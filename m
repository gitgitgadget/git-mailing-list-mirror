Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5FDC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 21:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0067610C8
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 21:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345646AbhIIVJK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 17:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbhIIVJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 17:09:09 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5202DC061574
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 14:07:59 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id y18so4184860ioc.1
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 14:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=asVc1vQx3/EfQ5Hfu/D6V0OnCUgiqE/Ht/LgC93IBjY=;
        b=TqYlD3G6+7hSoPDrvFVYpv8vqSFUiP2phh9ydnft+u1N2sAyNcf29kasMKCqBf8Sy/
         790czXJKD94mMIyPe1wof2QzAkaALhdcpxpClaWAireYa9zm0dQp1BetwI/zARmhUgJi
         gVfBKI+N6IhFGbo6Ebsqo8K2mS7Jp5gqJmqo4d/Gzlzp+HA6h9R1sT8LpXWl6LNHk+o4
         P80o6UbJGCnmqOCVYC25RPK8nWoDi4IuhSooQi8S5vTODOIdqpZZFKSByTGOB6OE7GE9
         2nhLl9zTH9atSIFITNZgAf5EUHYCe8LAy1owtFAHtmZ1Xjy2mIpKhwdNaT6tWUyvl6JN
         gyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=asVc1vQx3/EfQ5Hfu/D6V0OnCUgiqE/Ht/LgC93IBjY=;
        b=JQuQd4nx+StQhNBMwSUz0bLPXGBBCK72pkoIxZjjTq5y96hZyaA0wMXZlvT3j05W9o
         vmBbgVb0EAjJmhhB92xp8FaQdfCY3sNSX5u1SS0To6HYAEF0C27bH/CkzLxYX+mpnLFQ
         8iQvXI+5B3gc/JlM2kQNomRyZdJDNTLlA+3mnfmrTp77WnJWilzjybQcC4INIvL4aWSo
         8YHAhjAbJI7OnsNvpf1Be2WvUlQ32ndpetIjzjE6FYhwZrPjEFbpQQCUsXclc/FtQQc6
         Xx4GQxGB9OsCJx3vmUV4FLCHZNeLYOAOMN+gFumtxH+Z1/ll1k7R5wCWmWAbnBG7vxW/
         DNBg==
X-Gm-Message-State: AOAM533xUMpMe1MDDSqCAY8g9xnefMp0ryLy1iIX9d6HAntbKvologFz
        EQua3oWXKAVpXNiwCGq+h2cTWQ==
X-Google-Smtp-Source: ABdhPJzDboQj64sZUENunR6MRyJ2hE2fK8kXcHycxOFMfg3S8heyBOAIfYqJJnJ/b52yNmgeBqvFcg==
X-Received: by 2002:a6b:d209:: with SMTP id q9mr4420537iob.206.1631221678626;
        Thu, 09 Sep 2021 14:07:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e13sm1484354iod.36.2021.09.09.14.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 14:07:58 -0700 (PDT)
Date:   Thu, 9 Sep 2021 17:07:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH 3/9] pack-write: refactor renaming in
 finish_tmp_packfile()
Message-ID: <YTp3rYqxLE5/X521@nand.local>
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover.1631157880.git.me@ttaylorr.com>
 <35052ef494dbc55119614f3e22742d8d814b21b1.1631157880.git.me@ttaylorr.com>
 <xmqqk0jpzgxu.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqk0jpzgxu.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 09, 2021 at 12:29:01PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > @@ -1250,8 +1251,9 @@ static void write_pack_file(void)
> >  					    &pack_idx_opts, hash);
> >
> >  			if (write_bitmap_index) {
> > -				strbuf_addf(&tmpname, "%s.bitmap", hash_to_hex(hash));
> > +				size_t tmpname_len = tmpname.len;
> >
> > +				strbuf_addstr(&tmpname, "bitmap");
> >  				stop_progress(&progress_state);
> >
> >  				bitmap_writer_show_progress(progress);
> > @@ -1260,6 +1262,7 @@ static void write_pack_file(void)
> >  				bitmap_writer_finish(written_list, nr_written,
> >  						     tmpname.buf, write_bitmap_options);
> >  				write_bitmap_index = 0;
> > +				strbuf_setlen(&tmpname, tmpname_len);
> >  			}
> >
> >  			strbuf_release(&tmpname);
>
> This runs setlen on tmpname strbuf and immediately releases (the
> close brace before release closes the "if (write_bitmap_index)", not
> any loop.  If we plan to insert more code to use tmpname where the
> blank line we see above is in the future, it may make sense, but
> even in such a case, adding setlen() only when it starts to matter
> may make it easier to follow.
>
> In any case, the above correctly adjusts tmpname to have a <hash>
> plus '.' at the end of tmpname to call finish_tmp_packfile().

Ævar makes a slight mention of this in their commit message:

    This approach of reusing the buffer does make the last user in
    pack-object.c's write_pack_file() slightly awkward, since we
    needlessly do a strbuf_setlen() before calling strbuf_release() for
    consistency. In subsequent changes we'll move that bitmap writing
    code around, so let's not skip the strbuf_setlen() now.

And this is to set us up for the final patch which moves the call to
rename_tmp_packfile_idx(&tmpname, &idx_tmp_name) after the closing brace
in the quoted portion of your message and the strbuf_release(). There,
we'll want the strbuf reset to the appropriate contents and length, and
not released.

But in the meantime it is awkward.

> I do not like '*.%s' here.  Without '*' it is clear enough, and
> because nb->buf has already the same ext information,
>
> [...] But it would be more friendly to those adding more calls to this
> function in the future to document the convention in a comment before
> the function.
>
> Also, the name "nb" would need rethinking.  As far as the callers
> are concerned, that is not a full name, but they are supplying the
> common prefix to the function.  Perhaps "struct strbuf *name_prefix"
> or soemthing might be better?  I dunno.

In each of these three, I wasn't able to decide if you wanted these
addressed in a newer version of this series, or if you were happy enough
with the result to pick it up. I'm happy to send you a new version, but
don't want to clog your inbox if you were already planning on picking
this up.

Thanks,
Taylor
