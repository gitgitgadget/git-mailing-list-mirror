Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8049E20987
	for <e@80x24.org>; Wed,  5 Oct 2016 18:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbcJESrh (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 14:47:37 -0400
Received: from mout.web.de ([212.227.17.11]:56362 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752537AbcJESrg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 14:47:36 -0400
Received: from [192.168.178.36] ([79.213.121.94]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M7KN0-1awCN02VYk-00x62w; Wed, 05 Oct 2016 20:47:32
 +0200
Subject: Re: [PATCH 07/18] link_alt_odb_entry: handle normalize_path errors
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <20161003203417.izcgwt4yz3yspdnm@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <40d3920f-2267-f76d-a5e0-6868fb9f9be2@web.de>
Date:   Wed, 5 Oct 2016 20:47:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20161003203417.izcgwt4yz3yspdnm@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:y1xh28yv7XJmnzGi/h/K2ilX6vrW3nrkeLPa2iAESZOPqp3lx9a
 SoEPKAuX1o9tGNl+bLLt7qvYAHXYyoUO3uMK3O1XCIh3NVlgGBuamxrdR8g91DPMMApGCVH
 bOJDqjvMSVqStcBFnJK/MDer9df+5USN8qW+O15ks1DqQsbyJZnjwVHeUEt/9RIDg+EG+qs
 r59z8+B16DkfwMtcQ2TOQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9r3gy5OS3Ls=:EZ1JalyBri9n0PzCHEKray
 v4Fn8JSwTRzM1rNtrL6Uhd7inj3cV/jORFNh4S0W244roez6jT0iflmM7FywiNyZ089SdmYjd
 E6jVYN5ppVD8APIZA4zzR9RlKdgoRPnAdO3vqtI9bftaQ9F5pVcQEPITUq7JyqX1qHZFOXXgP
 FnYIUOhdieJI7iXJtJVfIddns/IDtdUAiCI1PaqUsBiaQw4Kii/8mJdG7mAtUSz6/4qBmGJ6k
 fwaJ7buEuce3baJ6+UjW93n00pN8avYY7VwGwDGHLoBBZhPZkJdGGfkb5gDn7y8TxI0Pmtk60
 b12JASJA+DYw7h8lttZocspiXi4LEo/GelZYwCSfPE/EKteqoL7vQQpSbzaVWm3YO30Vdzic9
 eqV5Q6fyqdJV99ZekBiFk6UOpC0MM8wDVDJneEEQHMAree3qZxtop9wAOeDd7L54Gd4WE17L9
 t8bsS9Ai3zZCk0burMaYeBNgTRJ6608ivonjAlIXgbht34iWny2OWwd4oOsNtOe+iHm/GciNP
 hb4cxh3BkRfivWrI8LYbp84H55eFH8bfsmlmWXULRhKQokaRjQYxCRsCjAeR7FslQouJQRXXC
 4V7wZ3paQoDFFpbZhYEY0pX0oILUSADQIZKbe3zq+/ZdWY0eK5gA80Sd+fP5rn1WL81+QKPq+
 CBBIMCRTM8HV2QMfyg2UKWJ2EOuvqBbq0JaviXbJgLN6ZAfmRbd6YLSdilZJ5uB4gCjykuAs1
 momycHGiQzbgqNTd/IMDGSygIzmQ4OW7Xl4meo9IBcpz7NQnHJPGInUMrBmBrXVZjUmBLl8Bv
 sW33shy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.10.2016 um 22:34 schrieb Jeff King:
> When we add a new alternate to the list, we try to normalize
> out any redundant "..", etc. However, we do not look at the
> return value of normalize_path_copy(), and will happily
> continue with a path that could not be normalized. Worse,
> the normalizing process is done in-place, so we are left
> with whatever half-finished working state the normalizing
> function was in.
>
> Fortunately, this cannot cause us to read past the end of
> our buffer, as that working state will always leave the
> NUL from the original path in place. And we do tend to
> notice problems when we check is_directory() on the path.
> But you can see the nonsense that we feed to is_directory
> with an entry like:
>
>   this/../../is/../../way/../../too/../../deep/../../to/../../resolve
>
> in your objects/info/alternates, which yields:
>
>   error: object directory
>   /to/e/deep/too/way//ects/this/../../is/../../way/../../too/../../deep/../../to/../../resolve
>   does not exist; check .git/objects/info/alternates.
>
> We can easily fix this just by checking the return value.
> But that makes it hard to generate a good error message,
> since we're normalizing in-place and our input value has
> been overwritten by cruft.
>
> Instead, let's provide a strbuf helper that does an in-place
> normalize, but restores the original contents on error. This
> uses a second buffer under the hood, which is slightly less
> efficient, but this is not a performance-critical code path.

Hmm, in-place functions are quite rare in the strbuf collection.  It 
looks like a good fit for the two callers and makes sense in general, 
though.
