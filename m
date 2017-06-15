Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66F3020D0C
	for <e@80x24.org>; Thu, 15 Jun 2017 17:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750793AbdFORut (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 13:50:49 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34949 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbdFORus (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 13:50:48 -0400
Received: by mail-pg0-f68.google.com with SMTP id f127so2412614pgc.2
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 10:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5DC0tmo9tZHXu+ihDgk1940TTuhTQT5hDUAioaqRsY4=;
        b=GdYxZWPp21HT5QVToCQJ9wOH20Nl8SvqqDZwUgaEhTK9cU0JNqnL12dj0gcuI0h3zW
         bEJcbrFqWy47l1lvMmwCXXQHkVFvWMOygYLtEI7/PN5/rkCG4dTjnEpWUZ6F8MoEPOSL
         MP/j/3v5e5HyaupVlGmrFyznHUTjM1pAIn53rKh4Zf4vax5ycbJX7Ug7t3UA1EFHNTDd
         ShuTPUURg4e7t6n9+PqlDpr4XzBAXsafHYcUeLk/o7GE2JIa05lx2LtTFxnF//ru3mLB
         7/uA/G8JrrIF9wvfyCDrgsHkdc8GjuZYrCP4EwOcgWevEJENfh20Z6278wZLOETNgi+O
         VNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5DC0tmo9tZHXu+ihDgk1940TTuhTQT5hDUAioaqRsY4=;
        b=asERQgYb6qWlAaU7t/lT85ccvZJR3XCJ3W4VOGlBd5JJ5GDB0YRkOf1LNlGIWt3qev
         s4iBEvHZ2ZgGWoU6UD04TXCDHX8QA1PjZliedgzW+GPh/flDsTeOMCsK8V1tT1A9JfUO
         7MrQHjMWbojVGCFGUP41K+TZ3ExpBnV/HVIVrhiSEnw+igKZfHZ5t1yGwE7Z1/QdbAPc
         JCSVYo0Bw+eDPB0V/uMQ8DuIB2RgMus2Q/iyblc8ohVIspQSOJ2qkkZYSsyyPBXoM4d+
         xOmJOFqYfjOp5nN4fl2NmKWyreiG3CEScWBqJo+EPHYcppyP6kGZ4MOATUAPAFsjBkP+
         D9zg==
X-Gm-Message-State: AKS2vOwnfIs4oD2lqgNiHKG8h2rJkZ6BeLclohr/WxnhLJ1N2KHvJh7o
        wTGcQeE83ch89A==
X-Received: by 10.98.201.25 with SMTP id k25mr6440804pfg.206.1497549047742;
        Thu, 15 Jun 2017 10:50:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88c8:4433:c52b:12d7])
        by smtp.gmail.com with ESMTPSA id e23sm1325098pfh.28.2017.06.15.10.50.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 10:50:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 3/4] sha1_file: consolidate storage-agnostic object fns
References: <cover.1497387713.git.jonathantanmy@google.com>
        <cover.1497035376.git.jonathantanmy@google.com>
        <cover.1497387713.git.jonathantanmy@google.com>
        <33a75a60b1d4298ec0af21c0df19e12bb0e43e2d.1497387714.git.jonathantanmy@google.com>
Date:   Thu, 15 Jun 2017 10:50:46 -0700
In-Reply-To: <33a75a60b1d4298ec0af21c0df19e12bb0e43e2d.1497387714.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 13 Jun 2017 14:05:59 -0700")
Message-ID: <xmqq7f0d2l8p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Looking at the 3 primary functions (sha1_object_info_extended,
> read_object, has_sha1_file_with_flags), they independently implement
> mechanisms such as object replacement, retrying the packed store after
> failing to find the object in the packed store then the loose store, and
> being able to mark a packed object as bad and then retrying the whole
> process. Consolidating these mechanisms would be a great help to
> maintainability.
>
> Therefore, consolidate all 3 functions by extending
> sha1_object_info_extended() to support the functionality needed by all 3
> functions, and then modifying the other 2 to use
> sha1_object_info_extended().

This is a rather "ugly" looking patch ;-) but I followed what
has_sha1_file_with_flags() and read_object() do before and after
this change, and I think this patch is a no-op wrt their behaviour
(which is a good thing).

But I have a very mixed feelings on one aspect of the resulting
sha1_object_info_extended().

>  int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi, unsigned flags)
>  {
> ...
>  	if (!find_pack_entry(real, &e)) {
>  		/* Most likely it's a loose object. */
> -		if (!sha1_loose_object_info(real, oi, flags)) {
> +		if (oi && !sha1_loose_object_info(real, oi, flags)) {
>  			oi->whence = OI_LOOSE;
>  			return 0;
>  		}
> +		if (!oi && has_loose_object(real))
> +			return 0;

This conversion is not incorrect per-se.  

We can see that has_sha1_file_with_flags() after this patch still
calls has_loose_object().  But it bothers me that there is no hint
to future developers to warn that a rewrite of the above like this
is incorrect:

        if (!find_pack_entry(read, &e)) {
                /* Most likely it's a loose object. */
       +        struct object_info dummy_oi;
       +        if (!oi) {
       +                memset(&dummy_oi, 0, sizeof(dummy_oi);
       +                oi = &dummy_oi;
       +        }
       -        if (oi && !sha1_loose_object_info(real, oi, flags)) {
       +        if (!sha1_loose_object_info(real, oi, flags)) {
                        oi->whence = OI_LOOSE;
                        return 0;
                }
       -        if (!oi && has_loose_object(real))
       -                return 0;

It used to be very easy to see that has_sha1_file_with_flags() will
call has_loose_object() when it does not find the object in a pack,
which will result in the loose object file freshened.  In the new
code, it is very subtle to see that---it will happen when the caller
passes oi == NULL, and has_sha1_file_with_flags() is such a caller,
but it is unclear if there are other callers of this "consolidated"
sha1_object_info_extended() that passes oi == NULL, and if they do
also want to freshen the loose object file when they do so.

> @@ -3480,18 +3491,12 @@ int has_sha1_pack(const unsigned char *sha1)
>  
>  int has_sha1_file_with_flags(const unsigned char *sha1, int flags)
>  {
> -	struct pack_entry e;
> +	int f = OBJECT_INFO_SKIP_CACHED |
> +		((flags & HAS_SHA1_QUICK) ? OBJECT_INFO_QUICK : 0);
>  
>  	if (!startup_info->have_repository)
>  		return 0;
> -	if (find_pack_entry(sha1, &e))
> -		return 1;
> -	if (has_loose_object(sha1))
> -		return 1;
> -	if (flags & HAS_SHA1_QUICK)
> -		return 0;
> -	reprepare_packed_git();
> -	return find_pack_entry(sha1, &e);
> +	return !sha1_object_info_extended(sha1, NULL, f);
>  }

I would have preferred to see the new variable not to be called 'f',
as that makes it unclear what it is (is that a callback function
pointer?).  In this case, uyou are forcing the flag bits passed
down, so perhaps you can reuse the same variable?  

If you allocated a separate variable because
has_sha1_file_with_flags() and sha1_object_info_extended() take flag
bits from two separate vocabularies, that is a valid reasoning, but
if that is the case, then I would have named 'f' to reflect that
fact that this is different from parameter 'flag' that is defined in
the has_sha1_file_with_flags() world, but a different thing that is
defined in sha1_object_info_extended() world, e.g. "soie_flag" or
something like that.

Thanks.
