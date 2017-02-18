Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DCD3201A9
	for <e@80x24.org>; Sat, 18 Feb 2017 05:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750836AbdBRFyN (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 00:54:13 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34163 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbdBRFyN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 00:54:13 -0500
Received: by mail-pf0-f193.google.com with SMTP id o64so5535189pfb.1
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 21:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lxbDKLchH54mbQ7fAhPGC2bSnNG6GVPgeUxzlkmYX1g=;
        b=l9eMKOMc4+4wlz7UOqFl+CFDn+iJCf8Adrib7hFQ4GwlD4E3z2gcoE40p/o4LnsKwu
         /TVIC1qrfDvp2W+uM1GrkVaKyEEsCG0H4bA2rJol5m4rUn5G16/1ioF5GfJtzR7/709X
         oIlSd7ZfOK1BUZ+qvujDuPKGhVdiCT816VBsxB6ClT7Iy7TQdH2J6jmUeCFs7oexReWM
         hS2Rte5KCnaM2UUUatIGIB15KA3OigNNbyAO44AGXy2NMMSyeHQyY4lT19sIZabFo5AM
         Nec6Fp65XxHaGeCZqArSFwJbApbwQhiGy9jpi14vkMY9taQ+9xhdFJLghQdziFlCikjd
         HXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lxbDKLchH54mbQ7fAhPGC2bSnNG6GVPgeUxzlkmYX1g=;
        b=Bpit3XWPbnIwV/d9UNGqRXYQKNzTjFuigJdfABK50WMtCqqXfLVNFrxgaTfU/nKJsU
         kXYruyVQMTjkj4aD7//Nxq5ebkK1aboyw20wDwpfCQepV6JZmUw4FNgddhgapD5yEXKi
         sH8HiLoDtO4fBkNT9bwWQCVEsriu5pkBpshNMUXFlqUgnISXEYvCLPJn4MtNVsQPx0j8
         dezJlstcLba3OWDgorxS9JGLdb5DSXQBrNrb9g6+mcU9KA0l4hYPGa9hvYyLmqkwko70
         70RUdeB3mKW1VSK8N90NdLGIBTxA11smGAi7eKexLKrtwzSMbWapR4ZSVGaEwiZErtmN
         QG2w==
X-Gm-Message-State: AMke39mrPVMYfXp7oUSCv3D1AFyE2wSvArGpW1zYXQL/cC/atH7GOYKIWCcsI6nG8AwQtw==
X-Received: by 10.84.129.2 with SMTP id 2mr16354485plb.108.1487396854319;
        Fri, 17 Feb 2017 21:47:34 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id r78sm22587671pfl.63.2017.02.17.21.47.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 21:47:33 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <jeffhost@microsoft.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/5] name-hash: precompute hash values during preload-index
References: <cover.1487071883.git.johannes.schindelin@gmx.de>
        <8621305c69898e012720d4fe66d42b096f053073.1487071883.git.johannes.schindelin@gmx.de>
Date:   Fri, 17 Feb 2017 21:47:32 -0800
In-Reply-To: <8621305c69898e012720d4fe66d42b096f053073.1487071883.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 14 Feb 2017 12:32:18 +0100
        (CET)")
Message-ID: <xmqq37fcnj7v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +void precompute_istate_hashes(struct cache_entry *ce)
> +{
> +	int namelen = ce_namelen(ce);
> +
> +	while (namelen > 0 && !is_dir_sep(ce->name[namelen - 1]))
> +		namelen--;
> +
> +	if (namelen <= 0) {
> +		ce->precomputed_hash.name = memihash(ce->name, ce_namelen(ce));
> +		ce->precomputed_hash.root_entry = 1;
> +	} else {
> +		namelen--;
> +		ce->precomputed_hash.dir = memihash(ce->name, namelen);
> +		ce->precomputed_hash.name = memihash_continue(
> +			ce->precomputed_hash.dir, ce->name + namelen,
> +			ce_namelen(ce) - namelen);
> +		ce->precomputed_hash.root_entry = 0;
> +	}
> +	ce->precomputed_hash.initialized = 1;
> +}
> diff --git a/preload-index.c b/preload-index.c
> index c1fe3a3ef9c..602737f9d0f 100644
> --- a/preload-index.c
> +++ b/preload-index.c
> @@ -47,6 +47,8 @@ static void *preload_thread(void *_data)
>  		struct cache_entry *ce = *cep++;
>  		struct stat st;
>  
> +		precompute_istate_hashes(ce);
> +

The fact that each preload_thread() still walks the index in-order
makes me wonder if it may allow us to further optimize the "dir"
part of the hash by passing the previous ce for which we already
precomputed hash values.  While the loop is iterating over the paths
in the same directory, .dir component from the previous ce can be
reused and .name component can "continue", no?

It's possible that you already tried such an optimization and
rejected it after finding that the cost of comparison of pathnames
to tell if ce and previous ce are still in the same directory is
more than unconditionally memihash() the directory part, and I am in
no way saying that I found a missed optimization opportunity you
must pursue.  I am just being curious.

