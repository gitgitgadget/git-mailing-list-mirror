Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BB0A1FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 16:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078AbcGSQqZ (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 12:46:25 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:37158 "EHLO
	mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916AbcGSQqY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 12:46:24 -0400
Received: by mail-it0-f51.google.com with SMTP id f6so25252044ith.0
        for <git@vger.kernel.org>; Tue, 19 Jul 2016 09:46:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jOpWkmbu4Z2jGCQymyE0crG0HU6I36WD8/zluTykChQ=;
        b=Ij/UlsxdIl/4e2p29UTOR24kYGGtt+KR1RQASVea7PZdsCwwJbr9t0tF7D9cI9LvLB
         Z2CsY7/tzOsXzrLwGc4jzeLs4oBo1FkfPKb5U+IuFZiz956dJjiGO1kTA1cVGVVYD9h+
         C06b+LucNrdXErUmE0VNCBTn+QiYhLuk1Chgawzi+XCJpbn7/7/UR4G1go1O5XNfvmRx
         1X++r+forrJHOw8RNWPb9n0a7pyqG6rLXl+/kg3FP2brc1Lv+LIOuwEWM0bRlWTGpXqF
         7glmFryf22+jgobbrHihNd2y04F9kMgOAKSBXj/vuliffpuVSstq31LnnNjxQIGDu9HJ
         7f1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jOpWkmbu4Z2jGCQymyE0crG0HU6I36WD8/zluTykChQ=;
        b=CMjjXJ2/7nBOQwEuUGXekqv7TdYvAnedhyCwhsJnUEhvwi973AE7tyIRy9NXwSIPKc
         /rjMfc28veIRSHYPKZldR5YZUZa8WNxn6upn/dV4DxEC/bHJ7VySWlHkScM/qs1JCsQ8
         Ge04umsuDqv03sjZwHo3cojv7m6VG7l6ZycFd1zR0BLoWU+HZnw8TGGjVGL7Q6eJaQq1
         QzyrcpAisygSVOqxNs3u3loRy/L1wxpCyavcE7KCnom/7z59edTa1UUL81j9uLedyc7t
         G5iY4A+yykHSvN5eUSok7TEqFAWtP27p7uVZP25/xpV48qInSnG3Py5kzhZGeUnAuwLa
         mCGQ==
X-Gm-Message-State: ALyK8tL4iDJYGYkcER9Esih3J+Ce29E0e1Hl2mhfekMe0JbpkNeg6p8YTYrlEFQwc10n7XbgmmmS7UM4Jmdq7Lsm
X-Received: by 10.36.29.5 with SMTP id 5mr4802406itj.97.1468946770671; Tue, 19
 Jul 2016 09:46:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 19 Jul 2016 09:46:10 -0700 (PDT)
In-Reply-To: <1468880498-30235-1-git-send-email-jonathantanmy@google.com>
References: <xmqq37n6iq7d.fsf@gitster.mtv.corp.google.com> <1468880498-30235-1-git-send-email-jonathantanmy@google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Tue, 19 Jul 2016 09:46:10 -0700
Message-ID: <CAGZ79kY+2PYx9oz9tvi0zG-oE6qS-Za7D3ocY1XtqcSsDchz0Q@mail.gmail.com>
Subject: Re: [PATCH v2] fetch-pack: grow stateless RPC windows exponentially
To:	Jonathan Tan <jonathantanmy@google.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 18, 2016 at 3:21 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> When updating large repositories, the LARGE_FLUSH limit (that is, the
> limit at which the window growth strategy switches from exponential to
> linear) is reached quite quickly. Use a conservative exponential growth
> strategy when that limit is reached instead (and increase LARGE_FLUSH so
> that there is no regression in window size).

Care to elaborate on why you choose 11/10 as growth factor?

(As someone who has a tick in micro optimizing:
9/8 is roughly the same exponent, but the division
by 8 is easier as it is just a shift by 3. Similar 17/16)

I guess one design criterion was 10 being a round number?
Does it make sense to experiment with the factor at all?
Digging into that, LARGE_FLUSH originates from 6afca450c3f,
(2011-03-20, fetch-pack: progressively use larger handshake windows),
and before we only had a linear growth.

So I guess what I do not understand is why we need to slow down the
exponential growth at all?

Thanks,
Stefan



>
> This optimization is only applied during stateless RPCs to avoid the
> issue raised and fixed in commit
> 44d8dc54e73e8010c4bdf57a422fc8d5ce709029.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  fetch-pack.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index b501d5c..85e77af 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -243,16 +243,21 @@ static void insert_one_alternate_ref(const struct ref *ref, void *unused)
>
>  #define INITIAL_FLUSH 16
>  #define PIPESAFE_FLUSH 32
> -#define LARGE_FLUSH 1024
> +#define LARGE_FLUSH 16384
>
>  static int next_flush(struct fetch_pack_args *args, int count)
>  {
> -       int flush_limit = args->stateless_rpc ? LARGE_FLUSH : PIPESAFE_FLUSH;
> -
> -       if (count < flush_limit)
> -               count <<= 1;
> -       else
> -               count += flush_limit;
> +       if (args->stateless_rpc) {
> +               if (count < LARGE_FLUSH)
> +                       count <<= 1;
> +               else
> +                       count = count * 11 / 10;
> +       } else {
> +               if (count < PIPESAFE_FLUSH)
> +                       count <<= 1;
> +               else
> +                       count += PIPESAFE_FLUSH;
> +       }
>         return count;
>  }
>
> --
> 2.8.0.rc3.226.g39d4020
>
