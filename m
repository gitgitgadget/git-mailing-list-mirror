Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF1CC432C0
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 06:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A232068E
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 06:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="lSX+3/3d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfLCGRs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 01:17:48 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40749 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfLCGRr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 01:17:47 -0500
Received: by mail-pf1-f194.google.com with SMTP id q8so1305871pfh.7
        for <git@vger.kernel.org>; Mon, 02 Dec 2019 22:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=00ol6mlU1a5bAOeec/ypYhNYcbX20n7QBOEnKuZ+ewQ=;
        b=lSX+3/3dQTwZ5IL+iqR+uVHlqDu+h+QA0zn6WF4UOhSp5v64TOu0FNaXkxtTMYUE9p
         OASvH97z525JJ11l7JsXds/PtYet7V7r9JXuGyUBaHPQJZ9xQsq/WZp0UlErduE0+1eG
         sM9eEcUSC/dtVQaAtPQLUk7nwVRe5zIHFkYQcyZtIkx4SdtskHfZsN+gOa+oOb+Y7ByL
         s+14kg1wXTdowmyokJ3uqvluZ8sWl8z1ubPL3/qGS/CB9s32Htq8mWJtwKCNXgzINy8u
         ag70IpfYG3m2L7I0hu0zwF5RSOIcGFAzPWqdKLbvBdNMn24fQcDuWL8spz0zNNgMqcGC
         HWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=00ol6mlU1a5bAOeec/ypYhNYcbX20n7QBOEnKuZ+ewQ=;
        b=JfSFxf1IjiemppMnMF42w4fNTDKRdeH4a4WjSOTR05H5ALGlywRyZr/9h8hhkzMLLk
         3QpHlj8SNfy3aVjMHO1K4rNOicVyHYxsblNnsXJy+4J35tgOld1g0sP1r/5sgulsHqDh
         R1MwR1shKfLyJ9BREFbg+OFwliQLLU6cTTni+U3ZXg0rPI+tAYwLmomx8/rQqST2/WIi
         7Yzi5g+BgXx97kKwt/HxYn3PeL5oaNMZgi158frOWelYnTMtrgjbspCPN1BKw7bBxrJg
         60fjFAgXf+6UU8OuuBM52tn7gnjw8I2O7JxZh5GgqvQuFnMRmUtxUSkFMVWErvGaMlmJ
         hxPw==
X-Gm-Message-State: APjAAAU5F6mylvZOs61amvzO/TE68+/1QuU260wWup5qT77ODFrn5826
        2HPwc6vpeiSiIM6y/GN/nVO9SA==
X-Google-Smtp-Source: APXvYqww1CbxFrHVnPWYXo4YqjFXNta2E82y7+nbDmwZVsZKzVtwdAXITGjNdn044JHUSVEp3U9+1Q==
X-Received: by 2002:a63:c652:: with SMTP id x18mr3654696pgg.211.1575353866920;
        Mon, 02 Dec 2019 22:17:46 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:10fc:56b2:d967:f5c8])
        by smtp.gmail.com with ESMTPSA id o15sm1773597pgf.2.2019.12.02.22.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 22:17:46 -0800 (PST)
Date:   Mon, 2 Dec 2019 22:17:44 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Colin Stolley <cstolley@runbox.com>, git@vger.kernel.org
Subject: Re: [PATCH] packfile.c: speed up loading lots of packfiles.
Message-ID: <20191203061744.GA74594@syl.local>
References: <20191127222453.GA3765@owl.colinstolley.com>
 <20191202174035.GJ23183@szeder.dev>
 <20191202194231.GA10707@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191202194231.GA10707@sigill.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 02, 2019 at 02:42:31PM -0500, Jeff King wrote:
> On Mon, Dec 02, 2019 at 06:40:35PM +0100, SZEDER Gábor wrote:
>
> > > When loading packfiles on start-up, we traverse the internal packfile
> > > list once per file to avoid reloading packfiles that have already
> > > been loaded. This check runs in quadratic time, so for poorly
> > > maintained repos with a large number of packfiles, it can be pretty
> > > slow.
> > >
> > > Add a hashmap containing the packfile names as we load them so that
> > > the average runtime cost of checking for already-loaded packs becomes
> > > constant.
> > [...]
> > This patch break test 'gc --keep-largest-pack' in 't6500-gc.sh' when
> > run with GIT_TEST_MULTI_PACK_INDEX=1, because there is a duplicate
> > entry in '.git/objects/info/packs':
>
> Good catch. The issue is that we only add entries to the hashmap in
> prepare_packed_git(), but they may be added to the pack list by other
> callers of install_packed_git(). It probably makes sense to just push
> the hashmap maintenance down into that function, like below. That
> requires an extra strhash() when inserting a new pack, but I don't think
> that's a big deal.

Ah, great catch, and thanks for pointing it out. We have been running
this patch in production at GitHub for a few weeks now, but didn't
notice this because we never run tests with
'GIT_TEST_MULTI_PACK_INDEX=1' in the environment.

Perhaps in the future that might change, but I think that for now that
can explain why the failure wasn't noticed earlier.

> diff --git a/packfile.c b/packfile.c
> index 253559fa87..f0dc63e92f 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -757,6 +757,9 @@ void install_packed_git(struct repository *r, struct packed_git *pack)
>
>  	pack->next = r->objects->packed_git;
>  	r->objects->packed_git = pack;
> +
> +	hashmap_entry_init(&pack->packmap_ent, strhash(pack->pack_name));
> +	hashmap_add(&r->objects->pack_map, &pack->packmap_ent);
>  }
>
>  void (*report_garbage)(unsigned seen_bits, const char *path);
> @@ -864,11 +867,8 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
>  		/* Don't reopen a pack we already have. */
>  		if (!hashmap_get(&data->r->objects->pack_map, &hent, pack_name)) {
>  			p = add_packed_git(full_name, full_name_len, data->local);
> -			if (p) {
> -				hashmap_entry_init(&p->packmap_ent, hash);
> -				hashmap_add(&data->r->objects->pack_map, &p->packmap_ent);
> +			if (p)
>  				install_packed_git(data->r, p);
> -			}
>  		}
>  		free(pack_name);
>  	}
>
> -Peff
Thanks,
Taylor
