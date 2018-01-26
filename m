Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29DE71F404
	for <e@80x24.org>; Fri, 26 Jan 2018 20:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbeAZUUB (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 15:20:01 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43810 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbeAZUUA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 15:20:00 -0500
Received: by mail-pf0-f193.google.com with SMTP id y26so977389pfi.10
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 12:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HW0mvDFxgVZocvP6eU09mCwgisyfTDRNO1nhQXL11BM=;
        b=VRjoX80O12+RhiM58jm1Rt9MjK6Yps+U1pJzeY4HKQ/thlJZ94aJgvIpd5ctJfaj6h
         ytegixPnP+0lqIzJRST9eOizKZRw5CTBb6SpNE1OoXsRaz+i3FxlYQhH/kCA6O6DNRRw
         bEnP69DU8MmpzmvPxRxZYt8IC5dQW7HXm37Xtbvbqr/4iM1y3A4KPRYseRaAEHuA+ffw
         BedhrBrns3n6fB+ZcsQ44SFXy4YJMHJr7EVZqJigixgE6ryAn1FpK5Q/el4vv+IiI1z3
         N+WsFvgz9ue2nXlYZVYalz8HZ6EUXkoda4vx/rEFU7fVCBCYCiWhM+nADIM9gtfgRv6X
         vqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HW0mvDFxgVZocvP6eU09mCwgisyfTDRNO1nhQXL11BM=;
        b=XRzpQKKAIzZ3EpbCeFISP+2KylNMO2SxnsG1qPPj4KiuGgwq10EpEnb6iqZ1ImSZ8W
         d3eM7tQQF39zn1jSScNYVOqo8CdN0C5q5BZ6upCay7htgnw3i+xvaHjKk8/YPpk4P0mJ
         dvbpvFySJO+vAqF2SHnKhmWXSh/K8zQLmRji/JNURRWU1RlFvIHZ/Z9nXvDI5NBS1mxD
         sY90Y5mdA7PPv32obX7xlgvOIu3lP9ZXepkSUpa+0ImdpsWTmJ4+tF7Uqm7Wb4hv6fUQ
         2HCQi6kzo7Iz2GAo+ljhyuLW3CPd8Npijd8rQpZ4ATHy/3zaPku/27Xl17KsvFHXAthz
         yMdg==
X-Gm-Message-State: AKwxytdVFtJRHRu1V8qF3Sy+iVu+vJaL7mu9xWxd2/fLzKSDOvpc7BSq
        YMe1CCRef0/345HU99IRbEw=
X-Google-Smtp-Source: AH8x2277ozq8cDomWTXVS9PYmFo1q6CBMvP3HrBX23SSkCreC3gyKI0e98W1/gWvejTrciTc7SusrA==
X-Received: by 10.98.89.198 with SMTP id k67mr20182074pfj.110.1516997998978;
        Fri, 26 Jan 2018 12:19:58 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3d49:4bb2:1738:a537])
        by smtp.gmail.com with ESMTPSA id q2sm8364223pgf.10.2018.01.26.12.19.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 12:19:58 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH RFC 01/24] ref-filter: get rid of goto
References: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
Date:   Fri, 26 Jan 2018 12:19:56 -0800
In-Reply-To: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
        (Olga Telezhnaya's message of "Fri, 26 Jan 2018 19:43:40 +0000")
Message-ID: <xmqqfu6s74pf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:

> Get rid of goto command in ref-filter for better readability.
>
> Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored by: Jeff King <peff@peff.net>
> ---

How was this patch "mentored by" these two folks?  Have they already
reviewed and gave you OK, or are you asking them to also help reviewing
with this message?  Mostly just being curious.

It is not convincning that this splitting the last part of a single
function into a separate helper function that is called from only
one place improves readability.  If better readability is the
purpose, I would even say

         for (i = 0; i < used_atom_cnt; i++) {
		if (...)
-			goto need_obj;
+			break;
	}
-	return;
+	if (used_atom_cnt <= i)
		return;

-need_obj:

would make the result easier to follow with a much less impact.

If we later in the series will use this new helper function from
other places, it certainly makes sense to create a new helper like
this patch does, but then "get rid of goto for readability" is not
the justification for such a change.

>  ref-filter.c | 103 ++++++++++++++++++++++++++++++-----------------------------
>  1 file changed, 53 insertions(+), 50 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index f9e25aea7a97e..37337b57aacf4 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1354,16 +1354,60 @@ static const char *get_refname(struct used_atom *atom, struct ref_array_item *re
>  	return show_ref(&atom->u.refname, ref->refname);
>  }
>  
> +static void need_object(struct ref_array_item *ref) {

Style.  The opening brace at the beginning of the function sits on
its own line alone.
