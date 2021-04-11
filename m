Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE34C433ED
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 07:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49DB2611EF
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 07:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbhDKH1M (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 03:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbhDKH1L (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 03:27:11 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B9CC061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 00:26:55 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id e14so15070608ejz.11
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 00:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sIq5bxT3mt3cl5G/RHVOiMA8+VWjcmMI/2VtE+brCO0=;
        b=b27hZ8QS/zQ8gCkgixT3MX/xOKA+tba8wR8if/uWtiyvDXybJsli6sDwVdxH/72Kha
         gOzc8Yz4r+8l7NKn1ckNBAnRaXMyx7qZfcYwCVjSQI3u9xnKkBxbyslOoUcl6FlO4abt
         jz9L2VD7VUymjulqSh/boSOr+Mxh3bLspWXi+9gNj48fVkNOX0nLvvZAVdIbpm3efOIE
         d7AuY/yJYrSidID/5Uohx+2k21jJnOJqCiAoVsTiKaaLbHjNrOh9X8c7wBSZt6rcdRkq
         7yfkm+WBh4RSVr/Cs/f5HzmDeZ1Ia4XPmnb/nbmeoRoJuFpyVNNSqzpnXRHCYOcDDPbc
         pXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sIq5bxT3mt3cl5G/RHVOiMA8+VWjcmMI/2VtE+brCO0=;
        b=bBoTk8O31P86YNMDDXwGTx6Ms2F9CivEtPFCaBKlj9u9XtqzpAANwO4HI0Hecl8eij
         oKIfcUjlUGRr1zIEdiPm0HYK0VfeaaCUoeh84kEbrg7Ha9nh3ty3C6kZefK2HdY7/P6E
         2giGNvF6cQygU+41jRNdEnk8mIf9PI7y3Y8N1SUeMfNsu+AMQOs/H3J4VkfD2BoS+tx8
         Zz/uAoEvLHMY6tkGu2UHx294BIhlTqSxBNCjeVAQGQwpFy0hA20InVGQ4mYHHh1S6at2
         F2fHFRNYG5vtG7cRC1sODSe7B76L3tiMDfCn4vhK/a1X3QaIpMiV5nSTszmYB3s5TK/Y
         JA4g==
X-Gm-Message-State: AOAM532u2Zvdm4YDxRLYF4uu8Qw/hBOjB7JrqooG57HsbHUZzUoRD5PU
        hAvwH/24Aded8RfOIjg2VJc=
X-Google-Smtp-Source: ABdhPJyhseJU5IQ+9mXNQv0GEOwc7GnVZw8X4mb1IRt5FA6NqCcdQn57pIlvRlioCqMSRaDISUBecw==
X-Received: by 2002:a17:906:560c:: with SMTP id f12mr21982896ejq.363.1618126014111;
        Sun, 11 Apr 2021 00:26:54 -0700 (PDT)
Received: from szeder.dev (94-21-23-40.pool.digikabel.hu. [94.21.23.40])
        by smtp.gmail.com with ESMTPSA id y21sm4314791edr.38.2021.04.11.00.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 00:26:53 -0700 (PDT)
Date:   Sun, 11 Apr 2021 09:26:51 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Subject: Re: [PATCH 04/12] bloom: clear each bloom_key after use
Message-ID: <20210411072651.GF2947267@szeder.dev>
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
 <9ae15b94881369fa1cbd09fc2de9cc94c30edb2d.1617994052.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9ae15b94881369fa1cbd09fc2de9cc94c30edb2d.1617994052.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 09, 2021 at 06:47:23PM +0000, Andrzej Hunt via GitGitGadget wrote:
> From: Andrzej Hunt <ajrhunt@google.com>
> 
> fill_bloom_key() allocates memory into bloom_key, we need to clean that
> up once the key is no longer needed.
> 
> This fixes the following leak which was found while running t0002-t0099.
> Although this leak is happening in code being called from a test-helper,
> the same code is also used in various locations around git, and could
> presumably happen during normal usage too.

It does indeed happen: 'git commit-graph write --reachable
--changed-paths' generates Bloom filters for every commit, with each
filter containing all paths modified by its associated commit, so it
leaks a lot of 7 * 4byte hashes.  This patch reduces the memory usage
of that command:

                         Max RSS
                    before      after
  ---------------------------------------------
  android-base     1275028k   1006576k   -21.1%
  chromium         3245144k   3127764k    -3.6%
  cmssw             793996k    699156k   -12.0%
  cpython           371584k    343480k    -7.6%
  elasticsearch     748104k    637936k   -14.7%
  freebsd-src       819020k    741272k    -9.5%
  gcc               867412k    730332k   -15.8%
  gecko-dev        2619112k   2457280k    -6.2%
  git               252684k    216900k   -14.2%
  glibc             239000k    222228k    -7.0%
  go                264132k    251344k    -4.9%
  homebrew-cask     542188k    480588k   -11.4%
  homebrew-core     805332k    715848k   -11.1%
  jdk               417832k    342928k   -17.9%
  libreoff-core    1257296k   1089980k   -13.3%
  linux            2033296k   1759712k   -13.5%
  llvm-project     1067216k    956704k   -10.4%
  mariadb-srv       695172k    559508k   -19.5%
  postgres          340132k    317416k    -6.7%
  rails             325432k    294332k    -9.6%
  rust              655244k    584904k   -10.7%
  tensorflow        507308k    480848k    -5.2%
  webkit           2466812k   2237332k    -9.3%

Just out of curiosity, I disabled the questionable hardcoded 512 paths
limit on the size of modified path Bloom filters, and the memory usage
in the jdk repository sunk by over 55%, from 849520k to 379760k.

Please feel free to include any of the above data points in the commit
message.

> Direct leak of 308 byte(s) in 11 object(s) allocated from:
>     #0 0x49a5e2 in calloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:154:3
>     #1 0x6f4032 in xcalloc wrapper.c:140:8
>     #2 0x4f2905 in fill_bloom_key bloom.c:137:28
>     #3 0x4f34c1 in get_or_compute_bloom_filter bloom.c:284:4
>     #4 0x4cb484 in get_bloom_filter_for_commit t/helper/test-bloom.c:43:11
>     #5 0x4cb072 in cmd__bloom t/helper/test-bloom.c:97:3
>     #6 0x4ca7ef in cmd_main t/helper/test-tool.c:121:11
>     #7 0x4caace in main common-main.c:52:11
>     #8 0x7f798af95349 in __libc_start_main (/lib64/libc.so.6+0x24349)
> 
> SUMMARY: AddressSanitizer: 308 byte(s) leaked in 11 allocation(s).
> 
> Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
> ---
>  bloom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/bloom.c b/bloom.c
> index 52b87474c6eb..5e297038bb1f 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -283,6 +283,7 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
>  			struct bloom_key key;
>  			fill_bloom_key(e->path, strlen(e->path), &key, settings);
>  			add_key_to_filter(&key, filter, settings);
> +			clear_bloom_key(&key);
>  		}
>  
>  	cleanup:
> -- 
> gitgitgadget
> 
