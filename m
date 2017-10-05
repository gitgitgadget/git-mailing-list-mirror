Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 338762036B
	for <e@80x24.org>; Thu,  5 Oct 2017 11:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751785AbdJELTQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 07:19:16 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34604 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbdJELTP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 07:19:15 -0400
Received: by mail-pf0-f193.google.com with SMTP id g65so14430709pfe.1
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 04:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ryi7RC1aafNzRjsECaMj9J15SRdd3d7QkijX5sfrzec=;
        b=Cz+aHCv6LwWE3oJ9TyhQ+d/ynvQoLndqMuGzAtw8crJUVCtxrwACKz2r+mFdGCtfcU
         YAH1IzTa3s7Ccce6a9AdqBxtgwGLZd7UjhbNjsmhfasMyVLEndkjFBqWlT2NwiEqPtRx
         xzbXOe58ggDjrXmZJePDjRxtTh2hpnj9MovNJ1Ar04c7Dv3jDV/7STeCjskzEKnr+JhG
         56kngtOOFwPFe7WolBBHJrEMWkB0b80TSoTOr19J6S6fwI7JySsMEII5z/tFxjD9QNgP
         Gwl7jIHf3DAYyCOC752ckbNRrcsBELstHQ9okxLH1HD8/EiyKwRdU50z6glp/7Kfr3Kd
         w9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Ryi7RC1aafNzRjsECaMj9J15SRdd3d7QkijX5sfrzec=;
        b=RSEQ+5Ahg7YDQYwJaqPPPovLqYzWPpy4yJxYhDIxgveeDd1+2xYkEycTWkIfstLwCJ
         nWWiydPJWWuy8bw+s6F9SNRMf600yX3ndlnQueu2FaE4IW8dcFbWybv0e0Cvk+JnS0xT
         7SnWEz/Ak9UCSOECSvumGIdgrKdpmRYWOjh+tWQ0iIxMRbfH4YIAo6xDNI9bl2MxnRxe
         hBwnzvquY7dC1vzZc1VqisnbYNW/ob4JXcM5RVifKOGcnpBY/zHjgv0Z+AXenozMRIDx
         hd74NRKjDRqP86vYDOdRlurz6QGw/o0iRMwZypE2BaQw66jVrDYhIwJNcXPFeQNvoJZ1
         /9pA==
X-Gm-Message-State: AMCzsaWbyZ/f8yRl6aBVSRLKAF0vbFuXklS3Ihs9KA0Q6UsS4zuWAY1E
        GDCNG66NfjtCrj1Be/Iyww0=
X-Google-Smtp-Source: AOwi7QA05UigJy8z8BXdH8RLbl3wzeRP/a07B0mUlNVymz03eSJJlykj5a4D5B1KG/+tozH35cdT1A==
X-Received: by 10.159.254.14 with SMTP id r14mr15656849pls.298.1507202354908;
        Thu, 05 Oct 2017 04:19:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f087:433c:d262:15e2])
        by smtp.gmail.com with ESMTPSA id f10sm28309346pgr.67.2017.10.05.04.19.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 05 Oct 2017 04:19:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, peff@peff.net, t.gummerer@gmail.com,
        jrnieder@gmail.com, Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1 1/2] entry.c: update cache entry only for existing files
References: <20171005104407.65948-1-lars.schneider@autodesk.com>
        <20171005104407.65948-2-lars.schneider@autodesk.com>
Date:   Thu, 05 Oct 2017 20:19:13 +0900
In-Reply-To: <20171005104407.65948-2-lars.schneider@autodesk.com> (lars
        schneider's message of "Thu, 5 Oct 2017 12:44:06 +0200")
Message-ID: <xmqqk2097sge.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

lars.schneider@autodesk.com writes:

> diff --git a/entry.c b/entry.c
> index 1c7e3c11d5..5dab656364 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -304,7 +304,7 @@ static int write_entry(struct cache_entry *ce,
>  					ce->name, new, size, &buf, dco);
>  				if (ret && string_list_has_string(&dco->paths, ce->name)) {
>  					free(new);
> -					goto finish;
> +					goto delayed;
>  				}
>  			} else
>  				ret = convert_to_working_tree(

This is unrelated to the main topic of this patch, but we see this
just before the precontext of this hunk:

			if (dco && dco->state != CE_NO_DELAY) {
				/* Do not send the blob in case of a retry. */
				if (dco->state == CE_RETRY) {
					new = NULL;
					size = 0;
				}
				ret = async_convert_to_working_tree(
					ce->name, new, size, &buf, dco);

Aren't we leaking "new" in that CE_RETRY case?
