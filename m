Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46EA1202AE
	for <e@80x24.org>; Sun,  9 Jul 2017 16:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752268AbdGIQ7h (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 12:59:37 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35297 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752149AbdGIQ7g (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 12:59:36 -0400
Received: by mail-pf0-f195.google.com with SMTP id q85so11382286pfq.2
        for <git@vger.kernel.org>; Sun, 09 Jul 2017 09:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ixG/JsaFcjOdWhC0OZ2i6BtgM2Oh638UPQt+zJu4BzY=;
        b=hF8mB8Mc+j9YjSvrk0+8SGXNgdnJriESJGPBuMusu9rQzjOE7ejxR44px2EGUI9ryy
         23zue9rnhsSTpD8WbKMUwh/9xCneuxBFw0CdCzXG6w62SaZpIGSsEPmvbCGC0/8TYssM
         6zgNXL/ZQiDqAFAI7iiHDi7EZVB2LkvzemmNyzv6WwjAIEtZ5TyCeuCXLsna1MpVyda5
         PqVvaXE4Ql56548BWkdRRh52w38NcpPzK3CJVRM23z/zsumwvsLasAkdBdqOpvamkXjK
         0H3GBczeCA00fZ2AuiTHXDcOCQsCpAogsBVVsV2V++8XLEklo8Z1iZP8olXSypa7YSba
         /dhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ixG/JsaFcjOdWhC0OZ2i6BtgM2Oh638UPQt+zJu4BzY=;
        b=fG0r5VEzYaMy+s03w6NKbBIlb3/ZoA7csY07VVpv4gVjANEy+HDYpyvxrK7/jS0rfn
         FDv9c5Q20S8+nKFlIY5SELZ+9om9hndYmBeUCVBNhHGTDxQtiLzcfLk1z5QDow8PXbNE
         n2U8Toxw9J8TVSJ7QD/yXZDeXYKEj3EdSYjEOlhxl2NFKcEbC0GXwqsYewXVTzR61VSk
         E7Qn1UmeX6GcuWk6r2z35UE6uCNrqUdnaqjy20RCHNrcFlXvJumeyQhVO06eNxZWrbaf
         5Yzrg2Ukk5W6ywx1pVckRCWG1dkCjH4xWpi0UeLb/bEOXLSkKlDlOMTwbu9dX57UKe6B
         HMww==
X-Gm-Message-State: AIVw113ruSDXRe1Viy+WfWazBQ+Yaiky9r2jpLVFs5sdhte0h25RO8oQ
        VOlXF39zb+RzcQ==
X-Received: by 10.84.224.15 with SMTP id r15mr13593863plj.78.1499619575560;
        Sun, 09 Jul 2017 09:59:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:dc1e:60e1:7751:9c92])
        by smtp.gmail.com with ESMTPSA id g73sm18778636pfk.19.2017.07.09.09.59.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 09 Jul 2017 09:59:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Sahil Dua <sahildua2305@gmail.com>, Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 3/7] log: do not free parents when walking reflog
References: <20170707090507.ko2ygry7j4zv7t3s@sigill.intra.peff.net>
        <20170707090734.x2ki7lluawf66g4a@sigill.intra.peff.net>
        <xmqqwp7kb2ap.fsf@gitster.mtv.corp.google.com>
        <20170709101351.qcwgtzly72wwvwmq@sigill.intra.peff.net>
Date:   Sun, 09 Jul 2017 09:59:33 -0700
In-Reply-To: <20170709101351.qcwgtzly72wwvwmq@sigill.intra.peff.net> (Jeff
        King's message of "Sun, 9 Jul 2017 06:13:51 -0400")
Message-ID: <xmqqtw2l8s22.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jul 07, 2017 at 10:10:54AM -0700, Junio C Hamano wrote:
>
>> > diff --git a/builtin/log.c b/builtin/log.c
>> > index 8ca1de9894..9c8bb3b5c3 100644
>> > --- a/builtin/log.c
>> > +++ b/builtin/log.c
>> > @@ -374,9 +374,9 @@ static int cmd_log_walk(struct rev_info *rev)
>> >  		if (!rev->reflog_info) {
>> >  			/* we allow cycles in reflog ancestry */
>> >  			free_commit_buffer(commit);
>> > +			free_commit_list(commit->parents);
>> > +			commit->parents = NULL;
>> 
>> After step 6/7, we no longer "allow cycles in reflog ancestry", as
>> there will be no reflog ancestry to speak of ;-), so it would be
>> nice to remove the comment above in that step.  But alternatively,
>> we can rephrase the comment here, to say something like "the same
>> commit can be shown multiple times while showing entries from the
>> reflog" instead.
>
> I actually think the comment is a bit obtuse in the first place. The
> real issue is that we show commits multiple times. That's caused by
> cycles, yes, but also by us clearing the SEEN flag. ;)
>
> Maybe this on top?

Yup, that is a much better version of what I had in mind that can go
either before this step as a preparatory cleanup, squashed into this
as "while at it", or after the series as a finishing touches.  The
last one will let the codebase lie for a short while, though, so I am
likely to squash it in or wiggle it under.

Thanks.



>
> -- >8 --
> Subject: [PATCH] log: clarify comment about reflog cycles
>
> When we're walking reflogs, we leave the commit buffer and
> parents in place. A comment explains that this is due to
> "cycles". But the interesting thing is the unsaid
> implication: that the cycles (plus our clearing of the SEEN
> flag) will cause us to show commits multiple times. Let's
> spell it out.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/log.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 9c8bb3b5c..630d6cff2 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -372,7 +372,10 @@ static int cmd_log_walk(struct rev_info *rev)
>  			 */
>  			rev->max_count++;
>  		if (!rev->reflog_info) {
> -			/* we allow cycles in reflog ancestry */
> +			/*
> +			 * We may show a given commit multiple times when
> +			 * walking the reflogs.
> +			 */
>  			free_commit_buffer(commit);
>  			free_commit_list(commit->parents);
>  			commit->parents = NULL;
