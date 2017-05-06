Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D2B6207F8
	for <e@80x24.org>; Sat,  6 May 2017 17:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbdEFROa (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 13:14:30 -0400
Received: from mout.web.de ([212.227.15.4]:57969 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751593AbdEFRO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2017 13:14:28 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M3k9J-1dyKaY27qT-00rE0U; Sat, 06
 May 2017 19:14:03 +0200
Subject: Re: [PATCH v4 11/25] checkout: fix memory leak
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
References: <cover.1493740497.git.johannes.schindelin@gmx.de>
 <cover.1493906084.git.johannes.schindelin@gmx.de>
 <2704e145927c851c4163a68cfdfd5ada48fff21d.1493906085.git.johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <36a581f6-077e-ca89-49d0-ad487ff222a3@web.de>
Date:   Sat, 6 May 2017 19:14:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <2704e145927c851c4163a68cfdfd5ada48fff21d.1493906085.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:mlk7QJ4Vrdj0+n/Bx2tevR9bp1GbfMJeCDRy2bONUIbC1NCezmE
 zpqCKevRgG/ANhTIchcE6DVe7177FN9VODENhll/re4qSekv50jNfeYWjRJhXBDsJDOYrub
 8kt4a0xSpnoxc14Ou6PT1oig8/0if1aYdzfpu8H5i+ZpCqy71Rr2UpghJ/9l8MpNy0aZZNr
 UCGuhozGIalp+iWjVEzKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KZMa7DX/TiE=:/uNaKz6fhAlwt3Fixq+s4S
 uJNtD9GIvAtlVuT4/Bi8j5uYOOU8Mj5J6XBb7pxl7FtV95n7WcEbtl+slt9OkSiRU+LQFlwfM
 8dlBjziHLwrQ6CEeOn+xdPlZ0DIXT/hImxMNwv1wR+4baYg8nyK/QHLTk0koidpdr9Le8WB4I
 KYw6s0GRmO4nvm14KUG1PbspGUAF22cA8O3fyDlCE08nHnT5+0Q7D4zr2W9l3xSSCpGD1rEuW
 KNB3AJc1SthgF04zNf6boty9RoO/mvOxau9gEM6BJq9+SJ0L+j6oRxfA4qSmkKYiAhyQEr0Zd
 hcLvRsxygPiF7feS5vxsAYcAe0POGvtiV8rDvLNfBZdUYvDU6cWFcAbZ80sZwBM8K1esW/DNi
 6G27gG4lQp3fK0xXNh8mmTAutX752p5+JAxeU9Yssjkyi5pq23j0P0EWdenPTm2mY7oY8bmiu
 XLJM5zRbN8YPUjKn2DWQKcU0RaZ90+eupAhK5Y7AH2RnVHZ6AsrlEIpTLukfr2LxPoitzjAP8
 5c87aNmMIWw6zmswjlJ3aAVtfhgJfyKf+ys6YnNk5FcZtk0kvE71OvST60w+KZbov2+Hyhgxx
 0azSwtAyVz2+JxEzZqTyFDFfRSNYF1jy6+cEQcvMTTIfIWUdaym238mx/CaLuhBSjnnQ++5/j
 aDN3ofOKYOAdxoFadxtp2TvfYKi9tVDVGFDFmRt5hWj3qeWLxXUHfptwUflSLsAQZelqgoVDp
 b51sKEsCXu4L13K/E+Zoo39YyW6rgFtQPkrrdbv1O1cKvQEHErtMzP5Q9AkSdA1ZwdrH57VFw
 5wNoJQZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.05.2017 um 15:56 schrieb Johannes Schindelin:
> This change addresses part of the NEEDSWORK comment above the code,
> therefore the comment needs to be adjusted, too.
> 
> Discovered via Coverity.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   builtin/checkout.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index bfa5419f335..5faea3a05fa 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -235,14 +235,14 @@ static int checkout_merged(int pos, const struct checkout *state)
>   	/*
>   	 * NEEDSWORK:
>   	 * There is absolutely no reason to write this as a blob object
> -	 * and create a phony cache entry just to leak.  This hack is
> -	 * primarily to get to the write_entry() machinery that massages
> -	 * the contents to work-tree format and writes out which only
> -	 * allows it for a cache entry.  The code in write_entry() needs
> -	 * to be refactored to allow us to feed a <buffer, size, mode>
> -	 * instead of a cache entry.  Such a refactoring would help
> -	 * merge_recursive as well (it also writes the merge result to the
> -	 * object database even when it may contain conflicts).
> +	 * and create a phony cache entry.  This hack is primarily to get
> +	 * to the write_entry() machinery that massages the contents to
> +	 * work-tree format and writes out which only allows it for a
> +	 * cache entry.  The code in write_entry() needs to be refactored
> +	 * to allow us to feed a <buffer, size, mode> instead of a cache
> +	 * entry.  Such a refactoring would help merge_recursive as well
> +	 * (it also writes the merge result to the object database even
> +	 * when it may contain conflicts).
>   	 */
>   	if (write_sha1_file(result_buf.ptr, result_buf.size,
>   			    blob_type, oid.hash))

Random observation: Using pretend_sha1_file here would at least avoid
writing the blob.

> @@ -251,6 +251,7 @@ static int checkout_merged(int pos, const struct checkout *state)
>   	if (!ce)
>   		die(_("make_cache_entry failed for path '%s'"), path);
>   	status = checkout_entry(ce, state, NULL);
> +	free(ce);
>   	return status;
>   }

I wonder if that's safe.  Why document a leak when it could have been
plugged this easily instead?  A leak is better than a use after free, so
let's be extra careful here.  Would it leave the index inconsistent?  Or
perhaps freeing it has become safe in the meantime?

@Junio: Do you remember the reason for the leaks in 0cf8581e330
(checkout -m: recreate merge when checking out of unmerged index).

And result_buf is still leaked here, right?

FWIW, after fixing a different issue (patch just sent separately)
t*checkout*.sh complete successfully for me with --valgrind, with and
without freeing both ce and result_buf.ptr.  So it *seems* safe..

René
