Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C7E6201A7
	for <e@80x24.org>; Wed, 17 May 2017 17:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753540AbdEQRTs (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 13:19:48 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33093 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753741AbdEQRSS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 13:18:18 -0400
Received: by mail-pg0-f46.google.com with SMTP id u187so10086613pgb.0
        for <git@vger.kernel.org>; Wed, 17 May 2017 10:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=s36/y9MSKpuzo1xezowXU7R0/KTf6grlDLFv81wBQRA=;
        b=Z1R4GN9m260a4EQIriQNDWxc0W/CHkCo70sn0xdQikgxOX6QhBqZ7jaQwBg3OJFZ44
         GR/hfl0jBTH4ahaGJ71GgBbXSqWIZF0aLDVfjbQpFtTIvn9NV4dcCgqoVSycOT38GSbA
         KfN20kwC7oQVfP3Mm+UIGePevQaWCmDEU0azFlQXaTDNQWSGesmAqCpZ4T+3+TU12kjm
         eDAECq1AbsgOvAwYksR+b+MwJfTKfJF346OnoOpJ3SjyE5rK3FAsShgiLPano0GQjeL/
         S+pFInaiacpL5Jsu9iH9fbIKHzstSMu7QWoP3iL9hvrny7OXhziWkfd8YVD8JxysBQXf
         Vohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=s36/y9MSKpuzo1xezowXU7R0/KTf6grlDLFv81wBQRA=;
        b=tTjUMZAE8xBPNt+sHuKWqDX6jObKceGv1IUyWVkNWTE4UfJLOAI+94zhXyYfyOC5hI
         2qA8VN1RF8JmwscAFgCwbQh339M2hhcp83yYx68SY12z8p/oPx8NNISg3o1QsgDkvNz4
         WJoy8VpEcYVsdoShZil/TOWlsZlL6Ol/3XZO19dnPgyS51x8g96lRykkrplTC+GMZzHs
         A11JwVFDtFdMEmAAU20FtcBzAVOMkbvUqzzpn176h+ZPtKE/M9sKeOjECrtwDBrWHDM3
         Bsd0ZylKuWcnQOZSr5Q/nAJDq7aEoCXKI/23FJ4584rpYhAyFFERCb+/REA4yWzzqWmn
         Nd4w==
X-Gm-Message-State: AODbwcBENhmXQXNSDjV7vDx25H6oWslX4ok1isOv4bqz5AqG+gvRqjo8
        LmtnDiUNCDi58joVkkSiykFf4UkYK+ah
X-Received: by 10.98.104.4 with SMTP id d4mr4802349pfc.94.1495041497527; Wed,
 17 May 2017 10:18:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Wed, 17 May 2017 10:18:17 -0700 (PDT)
In-Reply-To: <20170517131753.rditx62clmkrdmeq@sigill.intra.peff.net>
References: <cover.1495014840.git.mhagger@alum.mit.edu> <dd7637060bac1a27e03563edc82649812dcf897c.1495014840.git.mhagger@alum.mit.edu>
 <20170517131753.rditx62clmkrdmeq@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 17 May 2017 10:18:17 -0700
Message-ID: <CAGZ79kbdQ-MqYKH-L9unqEAPUtgQxNv6ANJERKSEQCADjgmm1w@mail.gmail.com>
Subject: Re: [PATCH 10/23] files_ref_store: put the packed files lock directly
 in this struct
To:     Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 6:17 AM, Jeff King <peff@peff.net> wrote:
> On Wed, May 17, 2017 at 02:05:33PM +0200, Michael Haggerty wrote:
>
>> Instead of using a global `lock_file` instance for the main
>> "packed-refs" file and using a pointer in `files_ref_store` to keep
>> track of whether it is locked, embed the `lock_file` instance directly
>> in the `files_ref_store` struct and use the new
>> `is_lock_file_locked()` function to keep track of whether it is
>> locked. This keeps related data together and makes the main reference
>> store less of a special case.
>
> This made me wonder how we handle the locking for ref_stores besides the
> main one (e.g., for submodules). The lockfile structs have to remain
> valid for the length of the program. Previously those stores could have
> xcalloc()'d a lockfile and just leaked it. Now they'll need to xcalloc()
> and leak their whole structs.

+cc Brandon, who is eager to go down that road.

> I suspect the answer is "we don't ever lock anything except the main ref
> store because that is the only one we write to", so it doesn't matter
> anyway.
>
> -Peff


> @@ -102,7 +98,7 @@ static void clear_packed_ref_cache(struct files_ref_store *refs)
>        if (refs->packed) {
>                struct packed_ref_cache *packed_refs = refs->packed;
>
> -               if (refs->packlock)
> +               if (is_lock_file_locked(&refs->packlock))
>                        die("internal error: packed-ref cache cleared while locked");

I think the error message needs adjustment here as well? Maybe

     die("internal error: packed refs locked in cleanup");

Thanks,
Stefan
