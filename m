Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE0EC433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 02:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB0BB60F70
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 02:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238907AbhIWCmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 22:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238859AbhIWCmL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 22:42:11 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63466C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 19:40:40 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id a20so5024049ilq.7
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 19:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DpjWsdkCCJKbUBQt7nPKdq4cvyzRDzjDulnSyQzs/Hc=;
        b=ue5oBWCTIur561PUZfBcLUPd67vMKB8hkZTS6Zv2Wk/0O0orsuO9Qc9BcEaQjl3vWF
         SEiutC/qncW3o5J8zoSZ5KAItjksct2bcDBQ+grUpam69LQ0/fY9igHmVN4mx62W0yTH
         Npe/pJKTi0rtDkWAhwMl2L0OTDg3WjKmEytWN7T4HAjnWlwWBb/E77egphGTdUIOgCBz
         sm6nZCPZUkvby5bI2Av5CPn2U9KWPUUo/X71zeAs2fnGXFrojTB8hG6mw2Aua5r+HMvj
         XLlNO3oplrpbjUo6LjcQjIwWb4YvuTzaxMJUBatnLrSpoQfOmf0gTBlDJqcofSRJd2YD
         3klA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DpjWsdkCCJKbUBQt7nPKdq4cvyzRDzjDulnSyQzs/Hc=;
        b=gAxsckEyjan4jCDg1ZdWR4S6KkE89crkAav7BUpA7+sLnn8AAaUqMo3W1/vX3FCCY7
         av7iP2MUJXx+4djTYLDqVlV7Z7jzix9IfOQuOkc3MjfoD4H8uVpD6/FrofW57ExXq/dq
         Z3j9FKFzbu31mHNEYQ21ffCAS9/1G6uSHfo74FkWJuaSTyfnpCwmkL9naZfIMlqUB0vd
         8F0dSJhwBMkksKPbUepCsqFrlU6an9teKP8NoUYmn8jmTYhklFiYHSb4ev1gueeVrQI1
         ZMAp89kg5Qrz6NCjwZNdhR6HP8fCqqY203kwHIsDpWJxEWLO8imQl05tJXuCRQSUWmtD
         jghw==
X-Gm-Message-State: AOAM533ELanZ3DNxQrcFYGE90lZNjZUCSCy69FppL1Ae3FBFjAsQ0/mV
        COYsEnvAJINm3LZ6CxyRZiMLHRGdBFMo/w==
X-Google-Smtp-Source: ABdhPJyuIgAflC45rQqzTsJvRP01bVlx2PHtn8ChHdcLBKZAOtm+LnOQHevGd/3cIJpWTAH9outJhg==
X-Received: by 2002:a05:6e02:13d4:: with SMTP id v20mr1763868ilj.247.1632364837479;
        Wed, 22 Sep 2021 19:40:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f12sm1843496ilu.24.2021.09.22.19.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 19:40:36 -0700 (PDT)
Date:   Wed, 22 Sep 2021 22:40:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     me@ttaylorr.com, git@vger.kernel.org, peff@peff.net,
        gitster@pobox.com, avarab@gmail.com
Subject: Re: [PATCH v2 6/8] builtin/repack.c: support writing a MIDX while
 repacking
Message-ID: <YUvpI3vL8iIidMR+@nand.local>
References: <83dfdb8b125efe970659eeea1e5e88b09546c81e.1631730270.git.me@ttaylorr.com>
 <20210922223936.2606010-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210922223936.2606010-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 03:39:35PM -0700, Jonathan Tan wrote:
> > @@ -683,22 +755,41 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
> >  	}
> >  	/* End of pack replacement. */
> >
> > +	if (delete_redundant && pack_everything & ALL_INTO_ONE) {
> > +		const int hexsz = the_hash_algo->hexsz;
> > +		string_list_sort(&names);
> > +		for_each_string_list_item(item, &existing_packs) {
> > +			char *sha1;
> > +			size_t len = strlen(item->string);
> > +			if (len < hexsz)
> > +				continue;
> > +			sha1 = item->string + len - hexsz;
> > +			item->util = (void*)(intptr_t)!string_list_has_string(&names, sha1);
>
> OK, here is the tricky part. They are marked for deletion here...

Yep, instead of deleting the packs immediately, which would cause an
existing MIDX referencing them to become corrupt, we split that into two
phases: one to figure out which packs need to be deleted (after the new
MIDX), and then another to actually delete those packs.

> > +		}
> > +	}
> > +
> > +	if (write_midx) {
> > +		struct string_list include = STRING_LIST_INIT_NODUP;
> > +		midx_included_packs(&include, &existing_packs,
> > +				    &existing_kept_packs, &names, geometry);
>
> ...the mark for deletion is taken into account during the execution of
> midx_included_packs() (as can be seen by looking at that function)...
>
> > +
> > +		ret = write_midx_included_packs(&include,
> > +						show_progress, write_bitmaps > 0);
> > +
> > +		string_list_clear(&include, 0);
> > +
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> >  	reprepare_packed_git(the_repository);
> >
> >  	if (delete_redundant) {
> >  		int opts = 0;
> > -		if (pack_everything & ALL_INTO_ONE) {
> > -			const int hexsz = the_hash_algo->hexsz;
> > -			string_list_sort(&names);
> > -			for_each_string_list_item(item, &existing_packs) {
> > -				char *sha1;
> > -				size_t len = strlen(item->string);
> > -				if (len < hexsz)
> > -					continue;
> > -				sha1 = item->string + len - hexsz;
> > -				if (!string_list_has_string(&names, sha1))
> > -					remove_redundant_pack(packdir, item->string);
> > -			}
> > +		for_each_string_list_item(item, &existing_packs) {
> > +			if (!item->util)
> > +				continue;
>
> ...and the marks are also used here. I was at first confused about why
> the functionality of midx_included_packs() depended on whether redundant
> packs were marked for deletion - if they are redundant, shouldn't they
> never be taken into account (regardless of whether we actually delete
> them)? But I guess it makes sense as an overall design point that we
> pass all packs that are to remain (so if they will be deleted, exclude
> them, and if they will not be, include them).

Right; midx_included_packs() is used to determine which packs are going
to be written into the new MIDX, and we need to make sure that we
exclude any packs which are about to be deleted.

> I think a comment "mark this pack for deletion" at the point we write
> the mark (so, where the cast to intptr_t is) is worthwhile. Other than
> that, this patch looks good to me.

Sure, that seems like it would be helpful to other readers.

> I (and the others in our review club) only managed to reach this patch.
> I hope to get to the other 2 by the end of the week.

Thanks for reviewing, I look forward to more of your feedback.

Thanks,
Taylor
