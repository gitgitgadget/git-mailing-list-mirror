Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E967FC433DB
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 20:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F1B3224F9
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 20:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbhAYUEw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 15:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731681AbhAYUDw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 15:03:52 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88EFC061573
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 12:03:11 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id l14so4725986qvp.2
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 12:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o7f11APc6KpbBztE6atjuImnYR6y0VTi1DOzxioOaIQ=;
        b=atszEV7UXJR2WF7hL3HPPpRc6eXY9rWB2Bn1smV/ASQivmHIbxiEJ2Y525viQ8CZYt
         QoR1JX+ZDml9oaxxRT7oq08OdB/amLLHuyugY66PBNpBfJKb6aNGoslCSo58BZZ4g7WU
         qNqXtWbJeNrbdG6P6siy7kDYOzFExEQb9r2bjIksPvxY3TufeM8xHcfZ6PQ2JPp+6wWC
         Yue4vhTmU8y5QDFHeumR7SFmbGRqBwFpF8x2jhKcbJxCtYaXSv3wJ/Pyom5gMoI461/A
         zEb9pWWKViK98k6A0syah65AeRvmF8pEMJQqsSvPPlwsZopZqCDXdcLMUIqZho77umyU
         yM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o7f11APc6KpbBztE6atjuImnYR6y0VTi1DOzxioOaIQ=;
        b=lbzBJLV5nWz9MkcWWm198i29ECENkrWghZoemnG+/dVEhkEBwlssEiabWJxEHQBBsq
         ea1aUEdktTVJi9jHEhnee7xJMY/eA0yaV+WhUzkje+ldpHpnA+oqUs9mWQT24T2WlcRs
         YqyiQ5rvpnG1AWSqzGj5ORSkyoxCOP3mtIl7O9juX41sbQFuEYbQ+2M675MstIHfhfpp
         elO/J7r4WavJuc+LB5GBkKN3unet5AqoU5zzSEC3eXoVdVrHJaN+3cs58e6gvR4sup9A
         rikrUigC+b51eDWa5mMN3GWizLpkGb02y9lf2hce0mQx1I10ewDQ43CwS3UkJKLs32BR
         d/aw==
X-Gm-Message-State: AOAM5317OC2rl6HPn4Sz9Sx+9seS+iIdf0T44LaSJvxuIG4ZmF7ubJKY
        QwcuV8drDS1KFg3gOGti8Yr3mQ==
X-Google-Smtp-Source: ABdhPJyrI8tWnzzRd3OtfuzEYZEoRpVAsucnpdQtQdMAfv65alnYud/Vywn7ZLlKhVLiy2nJ1hqDeA==
X-Received: by 2002:a05:6214:a14:: with SMTP id dw20mr2390741qvb.43.1611604990901;
        Mon, 25 Jan 2021 12:03:10 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5e9f:a2e5:e7ac:394d])
        by smtp.gmail.com with ESMTPSA id z26sm12607996qki.40.2021.01.25.12.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 12:03:10 -0800 (PST)
Date:   Mon, 25 Jan 2021 15:03:07 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v2 3/8] builtin/index-pack.c: write reverse indexes
Message-ID: <YA8j+3nq8nI/hcIQ@nand.local>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1610576805.git.me@ttaylorr.com>
 <5b18ada61113faa9dc1de584366cb39b6a449ec6.1610576805.git.me@ttaylorr.com>
 <YAtlZ49mTfTGg11/@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAtlZ49mTfTGg11/@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 22, 2021 at 06:53:11PM -0500, Jeff King wrote:
> On Wed, Jan 13, 2021 at 05:28:15PM -0500, Taylor Blau wrote:
>
> >  OPTIONS
> > @@ -33,7 +34,14 @@ OPTIONS
> >  	file is constructed from the name of packed archive
> >  	file by replacing .pack with .idx (and the program
> >  	fails if the name of packed archive does not end
> > -	with .pack).
> > +	with .pack). Incompatible with `--rev-index`.
>
> I wondered which option was incompatible, but couldn't see from the
> context. It is "index-pack -o", which kind of makes sense. We can derive
> "foo.rev" from "foo.idx", but normally "-o" does not do any deriving.
>
> So I was all set to say "OK, we can live without it", but...
>
> > @@ -1824,7 +1851,16 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
> >  	if (from_stdin && hash_algo)
> >  		die(_("--object-format cannot be used with --stdin"));
> >  	if (!index_name && pack_name)
> > -		index_name = derive_filename(pack_name, "idx", &index_name_buf);
> > +		index_name = derive_filename(pack_name, ".pack", "idx", &index_name_buf);
> > +
> > +	opts.flags &= ~(WRITE_REV | WRITE_REV_VERIFY);
> > +	if (rev_index) {
> > +		opts.flags |= verify ? WRITE_REV_VERIFY : WRITE_REV;
> > +		if (index_name)
> > +			rev_index_name = derive_filename(index_name,
> > +							 ".idx", "rev",
> > +							 &rev_index_name_buf);
> > +	}
>
> ...here we do end up deriving ".rev" from ".idx" anyway. So I guess we
> probably could support "-o".  I also wonder what happens with "git
> index-pack -o foo.idx" when pack.writeReverseIndex is set. It looks like
> it would just work because of this block. But then shouldn't
> "--rev-index" work, too? And indeed, there is a test for that at the end
> of the patch! So is the documentation just wrong?

Hah! The documentation is just plain wrong. It's been a while, but I
have a vague recollection of writing this documentation before changing
the implementation of index-pack to allow this. Clearly, I forgot to go
back to update the broken documentation.

Hilariously, there is even a test in t5325 that demonstrates this
working! 'git index-pack --rev-index -o other.idx' writes both
'other.idx' and 'other.rev'. That was easy :-).

> I admit to finding the use of opts.flags versus the rev_index option a
> bit confusing. It seems like they are doing roughly the same thing, but
> influenced by different sources. It seems like we should be able to have
> a single local variable (then that goes on to set opts.flags for any
> sub-functions we call). Or maybe two, if we need to distinguish config
> versus command-line, but then they should have clear names
> (rev_index_config and rev_index_cmdline or something).

Yeah, I know. It's because we already pass a pointer to a struct
pack_idx_option to git_index_pack_config(), so in effect the 'flags' on
that struct *is* rev_index_config.

It's a little ugly, I agree, but I'm skeptical that the effort to clean
it up is worth it, mostly because the pack_idx_option struct probably
shouldn't be part of the index-pack builtin in the first place.

> As an aside, looking at derive_filename(), it seems a bit weird that one
> argument has a dot in the suffix and the other does not. I guess you are
> following the convention from write_special_file(), which omits it in
> the newly-added suffix. But it is slightly awkward to omit it for the
> old suffix in derive_filename(), because we want to strip_suffix() it
> all at once.

> Probably not that big a deal, but if anybody feels strongly, then
> derive_filename() could do:
>
>   if (!strip_suffix(pack_name, strip, &len) ||
>       !len || pack_name[len] != '.')
> 	die("does not end in .%s", strip);

That does make the callers look nicer, but it needs an extra two things:

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index ef2874a8e6..c758f3b8e9 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1441,11 +1441,10 @@ static const char *derive_filename(const char *pack_name, const char *strip,
 {
        size_t len;
        if (!strip_suffix(pack_name, strip, &len) || !len ||
-           pack_name[len] != '.')
+           pack_name[len - 1] != '.')
                die(_("packfile name '%s' does not end with '.%s'"),
                    pack_name, strip);
        strbuf_add(buf, pack_name, len);
-       strbuf_addch(buf, '.');
        strbuf_addstr(buf, suffix);
        return buf->buf;
 }

And then it does what you are looking for. I'll pull that change out
with your Suggested-by as a preparatory commit right before this one.

> > @@ -1578,6 +1591,12 @@ static int git_index_pack_config(const char *k, const char *v, void *cb)
> >  		}
> >  		return 0;
> >  	}
> > +	if (!strcmp(k, "pack.writereverseindex")) {
> > +		if (git_config_bool(k, v))
> > +			opts->flags |= WRITE_REV;
> > +		else
> > +			opts->flags &= ~WRITE_REV;
> > +	}
> >  	return git_default_config(k, v, cb);
> >  }
>
> IMHO we'll eventually want to turn this feature on by default. In which
> case we'll have to update every caller which is checking the config
> manually. Should we hide this in a function that looks up the config,
> and sets the default? Or alternatively, I guess, they could all use some
> shared initializer for "flags".

Note that there are only two such callers, so I'm not sure the effort to
extract this would be worth it.

> > +	# Intentionally corrupt the reverse index.
> > +	chmod u+w $rev &&
> > +	printf "xxxx" | dd of=$rev bs=1 count=4 conv=notrunc &&
> > +
> > +	test_must_fail git index-pack --rev-index --verify \
> > +		$packdir/pack-$pack.pack 2>err &&
> > +	grep "validation error" err
> > +'
>
> This isn't that subtle of a corruption, because we are corrupting the
> first 4 bytes, which is the magic signature. Maybe something further in
> the actual data would be interesting instead of or in addition?
>
> I dunno. There are a lot of edge cases around corruption (likewise, we
> might care how the normal reading code-path perceives a signature
> corruption like this). I'm not sure it's all that interesting to test
> all of them.

Agreed, I think what is here (even though it's not a severe corruption)
would be sufficient to make me feel good about our error handling in
general.

Thanks,
Taylor
