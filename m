Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CF0C43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 02:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242908AbiFNC6O (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 22:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351913AbiFNC51 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 22:57:27 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0823FDB8
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 19:49:31 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id hh4so5237622qtb.10
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 19:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G42E29AzWMBK/XfRYLg6N5nTByVnE6sFrExTHGHwfZ0=;
        b=TvWbDZslwsK7Kib3tu7m8oamLjoqnwKD8xVjXizQGBglbAwZYoDc8CSjA0CHyOQ8G4
         uPDbJ68VNVZUHaC/gVMNr/tPmxc+GUj+vipNnx9CAO2Zweih9SuEtpHTFD6VqdImT+1R
         +EyeUe+0Jv93WRya7tldeCVI3jl1stad9/xCwF+gEDa89oTjuWaNESkcC5Vf7EyjcWdw
         j9rcPAV3phaBUMldP09XPDbSX6N7D9v1ziXNtKSJyPhLe7Gs5D0Am4MrP36ObGF1OCjE
         KSLK0+H4aznmH37TnJ0G75UQ1pYrbm3vCdltEepSyG5DpMgphGZrMZ2aEETpgPdquOor
         +hdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G42E29AzWMBK/XfRYLg6N5nTByVnE6sFrExTHGHwfZ0=;
        b=EppKuPQOv33Vye1uFQ/ZpBRMzy1H6tQxddy3vUX6Vfew0Rwgwqfhdwk7CacKbNh0gb
         sImyO3CoCEPpkSjY3aw71Gxms2DyeLYnQUEIukTwTQ1JiGdZuWrrFfS87cWiy48YoEtp
         pnYJdaaXwzOPxjpla03butAyEEFpEATSwJZ1UDyzREjHnmxKVbKb1HW8GQlof9pchIuq
         Cl6QgPQfX5bU4MBb1DDg75I31UWCGeckJTbaJJBKhxMN1IANEN/lAP5nxUVln42SZC9R
         IT367PUAMhhAFqtQr2/AWQF/KaSTWWP9M+B7C8+Cx9jKlljLJuT5ByeNtnBLSUgsYxk7
         4BKQ==
X-Gm-Message-State: AOAM533yTx+w9+gi2pdjeYcZic7aXg2w/ZTH7rt9fxRISEyVy5nPidb4
        V1/WPH1QyIfHiHEGPuIpVkxRstEaDyOZPIMd
X-Google-Smtp-Source: ABdhPJx7Sh3ad+/zPoGg35WlAvKlRTrYWMJ0EoohAUrHi96x1rbtLfE79rfmQrVSH3Eu1xhUIuQ4VQ==
X-Received: by 2002:ac8:7d16:0:b0:305:1e80:b44d with SMTP id g22-20020ac87d16000000b003051e80b44dmr2492603qtb.231.1655174970659;
        Mon, 13 Jun 2022 19:49:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j14-20020ac806ce000000b003050af740e6sm6281536qth.22.2022.06.13.19.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 19:49:30 -0700 (PDT)
Date:   Mon, 13 Jun 2022 22:49:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] revision: mark blobs needed for resolve-undo as reachable
Message-ID: <Yqf3OT9vSvWETVCJ@nand.local>
References: <xmqqfskdieqz.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfskdieqz.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 09, 2022 at 04:44:20PM -0700, Junio C Hamano wrote:
> The resolve-undo extension was added to the index in cfc5789a
> (resolve-undo: record resolved conflicts in a new index extension
> section, 2009-12-25).  This extension records the blob object names
> and their modes of conflicted paths when the path gets resolved
> (e.g. with "git add"), to allow "undoing" the resolution with
> "checkout -m path".  These blob objects should be guarded from
> garbage-collection while we have the resolve-undo information in the
> index (otherwise unresolve operation may try to use a blob object
> that has already been pruned away).
>
> But the code called from mark_reachable_objects() for the index
> forgets to do so.  Teach add_index_objects_to_pending() helper to
> also add objects referred to by the resolve-undo extension.

Nice find!

> Also make matching changes to "fsck", which has code that is fairly
> similar to the reachability stuff, but have parallel implementations
> for all these stuff, which may (or may not) someday want to be unified.

I wasn't sure what the change in fsck was when skimming the diffstat
before reading your patch message, but makes sense. I'm glad that you
included this, too.

> +static void add_resolve_undo_to_pending(struct index_state *istate, struct rev_info *revs)
> +{
> +	struct string_list_item *item;
> +	struct string_list *resolve_undo = istate->resolve_undo;
> +
> +	if (!resolve_undo)
> +		return;
> +
> +	for_each_string_list_item(item, resolve_undo) {
> +		const char *path = item->string;
> +		struct resolve_undo_info *ru = item->util;
> +		int i;
> +
> +		if (!ru)
> +			continue;
> +		for (i = 0; i < 3; i++) {
> +			struct blob *blob;
> +
> +			if (!ru->mode[i] || !S_ISREG(ru->mode[i]))
> +				continue;
> +
> +			blob = lookup_blob(revs->repo, &ru->oid[i]);
> +			if (!blob) {
> +				warning(_("resolve-undo records `%s` which is missing"),
> +					oid_to_hex(&ru->oid[i]));
> +				continue;
> +			}
> +			add_pending_object_with_path(revs, &blob->object, "",
> +						     ru->mode[i], path);
> +		}
> +	}
> +}

This implementation looks good to my eyes.

> @@ -1718,6 +1752,8 @@ static void do_add_index_objects_to_pending(struct rev_info *revs,
>  		add_cache_tree(istate->cache_tree, revs, &path, flags);
>  		strbuf_release(&path);
>  	}
> +
> +	add_resolve_undo_to_pending(istate, revs);
>  }

Great; this fixes the bug for cruft packs, too, whose reachable pack is
generated with `--indexed-objects`, so the cruft pack will no longer
contain the resolve-undo objects.

> +test_expect_success 'resolve-undo keeps blobs from gc' '

Very thorough. Thanks!

Taylor
