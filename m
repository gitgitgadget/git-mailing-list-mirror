Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32D9E20958
	for <e@80x24.org>; Thu, 23 Mar 2017 17:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbdCWRpJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 13:45:09 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36403 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751333AbdCWRpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 13:45:09 -0400
Received: by mail-pg0-f46.google.com with SMTP id g2so126600299pge.3
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 10:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6+/Zx2VoPL43hMNCx2Q6y1wvM5zDy9Gt1mF9vT8ZIno=;
        b=lYs2LcEZfNT1qru9Qe4BtrrLfBz2nVCGEPlRKjdTT9LCmPTiN2hs6U1N4cY/kk7iak
         74mkQObE4nZloWILq8CMweeIOkm2UFbNm1E9/GfodxMRmGg1Kr6rnYEgbC4N+Fh+TnBL
         ymUUVsouDoH337uyPO2d7C2X6pxQZh8ONcgwCtNJjSj/skw77JLz2unh6h+5khOfooRB
         +egIrHLz3tXX5Bh1yG+fSH3GO3adQH1l5/Prv2M552MXaVh+pIXEYRyFTFJKhTcYxU4r
         sHgkn/98XMp0eTUby3C09132F950kyB9UxQlMv76FBD6i6zpv9davDrKPQWhIe36CH4I
         4mXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6+/Zx2VoPL43hMNCx2Q6y1wvM5zDy9Gt1mF9vT8ZIno=;
        b=b7f824Bl+L/Zc1aZwwehXj29IA9z/MIGR9iywPJCCUkmurD5imtzWrLPmFI0wzfthC
         Kt8FSAodwr5ugjtbwJv88ls3MQkeCWRbwzYAl19aGUSk5ltAKYjE0+CIwW7PXPrfeUpn
         SLK+skAvfXcfKjuyEHz0QxOsCvisTeolHNbK3gVRr4HGdYw8BW7JQP31v8FtKHN8/+dD
         yY3aKUnJu4/stlXjx1OLO7crZ+TkPy+SFTenM5U/DVq/UWM0N1PWrFevhsbGFGB3Va7Y
         kcsYYElSTKOXuW0wWhLCSQO4LDHb2iNKY9XQ/AyB41VdQvF6VlEPGTURLoehMLvTujEF
         TeeA==
X-Gm-Message-State: AFeK/H3Fj4hRfEG+4SIEKoG/JJXJvZ/KswO0VgrZktA1yVSzth2zZhibsqSuO7xfLnlFcah1e6oru2tUB6EnWJDO
X-Received: by 10.98.69.86 with SMTP id s83mr4503313pfa.232.1490291107636;
 Thu, 23 Mar 2017 10:45:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.161 with HTTP; Thu, 23 Mar 2017 10:45:07 -0700 (PDT)
In-Reply-To: <e987714e-473f-cad1-159b-18459ffeb241@ramsayjones.plus.com>
References: <1490276825-41544-1-git-send-email-git@jeffhostetler.com>
 <1490276825-41544-6-git-send-email-git@jeffhostetler.com> <e987714e-473f-cad1-159b-18459ffeb241@ramsayjones.plus.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 23 Mar 2017 10:45:07 -0700
Message-ID: <CAGZ79kZKri4jsnGCWhpV_WjSef5DxSwMTxYOour9kjzTWOFcxA@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] name-hash: perf improvement for lazy_init_name_hash
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 8:25 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>> +static struct dir_entry *hash_dir_entry_with_parent_and_prefix(
>> +     struct index_state *istate,
>> +     struct dir_entry *parent,
>> +     struct strbuf *prefix)
>> +{
>> +     struct dir_entry *dir;
>> +     unsigned int hash;
>> +     int lock_nr;
>> +
>> +     /*
>> +      * Either we have a parent directory and path with slash(es)
>> +      * or the directory is an immediate child of the root directory.
>> +      */
>> +     assert((parent != NULL) ^ (strchr(prefix->buf, '/') == 0));
>
> sparse complains about 'Using plain integer as a NULL pointer', (the
> return from strchr() is NULL, if '/' is not found) so maybe:
>
> +       assert((parent != NULL) ^ (strchr(prefix->buf, '/') == NULL));
>

Also this seems part of the actual shipped code, not testing code.
In that case we prefer

    if (<condition>)
        die("BUG: <description>");

This is because asserts may be omitted by the compiler,
when compiled with NDEBUG.

However it is preferable to have these error checking code
in the shipped product, as opposed to users running into
that edge case and reporting an error which is totally non-obvious.

Thanks,
Stefan
