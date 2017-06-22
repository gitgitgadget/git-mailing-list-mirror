Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D93D1FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 18:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752071AbdFVScq (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 14:32:46 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35620 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbdFVScp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 14:32:45 -0400
Received: by mail-pf0-f193.google.com with SMTP id s66so4150558pfs.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 11:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RwyjHzfV9pk2BRVVBBH9e0drDe2TW9sHgjWAG0bMa4U=;
        b=nfqZyS7m9My5fkLqYyGNlIhlBp0WojM/X8KiVmi131RmV4LxXhzHzCDlZ1bfr4h/bp
         S6hoNwsXFIQlLZWLBjD0gNGjqlLajFQDpnp9pXnuNtaNnZoY9S8A4pHuODsFWaDb3zGC
         iBw09XfgJWyNbeYjLTCUfiWxIKV3irat8UkwrDs7SKX56T+D8YXiswDGUYe3rPJnJLq7
         cWGEVQlTTiNdg40ApaXeoyE6J13BYQX+jbb7VVSDLOMMKu58vrP3rEJ0sdUE3CvHlU+p
         UZNcRAo9m1ujOT+sVw9pqQR/rjZOZxL7sj24d+AbA4149GIGbHWCvlhxAGkCO5RuWddM
         J17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RwyjHzfV9pk2BRVVBBH9e0drDe2TW9sHgjWAG0bMa4U=;
        b=eqE1MpTymbacZK3xCMvHyckKxBemxq2ACohKu2MkM3EGfhQzPsbQoyhB9++0EkwSk5
         96g/fQfaWMQGv39F8wOwLMJWnE/Ny3cIY0gjtDDrXNiZedYkPEH88g3PxbyBWj9tMu8E
         bta5QBRUpiSGPHATopr8BMFN6AELWnkZgnlHLzIZuy8oToEmINRZojrMDeZqaDALsNZQ
         70+WqvRev/12QTAsrM7hD6zHrZIej1XAguna8/IW11AXS8LJQ7YEYkrtxtyKwglI6wzr
         3W4z/YdRkDdnq7C4d8KMrFfEWhL5v+453Nkta2mVU2orSvPNMvLzDq03hpFiDfMDtGXS
         aStw==
X-Gm-Message-State: AKS2vOwRUe557DEGiS6Z3Ld09mZnGerBhCYqKF9vwh4ESjiYIUZlp7NQ
        9rzZVDZBRcJ6zg==
X-Received: by 10.101.89.69 with SMTP id g5mr4038897pgu.69.1498156365009;
        Thu, 22 Jun 2017 11:32:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:20f6:6e44:6707:50bd])
        by smtp.gmail.com with ESMTPSA id b82sm5100714pfd.111.2017.06.22.11.32.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 11:32:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kyle Meyer <kyle@kyleam.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>
Subject: Re: Truncating HEAD reflog on branch move
References: <20170621213924.wh43i2h7v2zwihq3@genre.crustytoothpaste.net>
        <xmqqpodxm2t8.fsf@gitster.mtv.corp.google.com>
        <87efud7xjd.fsf@kyleam.com>
        <20170622151603.rrh2j7zsotyt2jxe@sigill.intra.peff.net>
Date:   Thu, 22 Jun 2017 11:32:43 -0700
In-Reply-To: <20170622151603.rrh2j7zsotyt2jxe@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 22 Jun 2017 11:16:03 -0400")
Message-ID: <xmqqziczkh4k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> There's some magic in fake_reflog_parent() when we hit an entry with a
> ...
> This whole fake-parents things does just feel like a gigantic hack,
> though.
> ...
> It seems like we should be able to just walk backwards down the
> reflog list and show the entries. The revision machinery already
> special-cases a bunch of reflog-walk bits; I don't know that adding one
> or two more would be the end of the world.

Unfortunate but I tend to agree that at least such an addition would
make the "gigantic hack" a bit more complete one ;-)

> diff --git a/reflog-walk.c b/reflog-walk.c
> index ed99437ad..b7e489ad3 100644
> --- a/reflog-walk.c
> +++ b/reflog-walk.c
> @@ -259,6 +259,8 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
>  		/* a root commit, but there are still more entries to show */
>  		reflog = &commit_reflog->reflogs->items[commit_reflog->recno];
>  		logobj = parse_object(&reflog->noid);
> +		if (!logobj)
> +			logobj = parse_object(&reflog->ooid);
>  	}
>  
>  	if (!logobj || logobj->type != OBJ_COMMIT) {

We already have a loop to find an entry that is a commit that
discards any non-commit object before the pre-context of this hunk.
This "oops, old side is NULL so let's cover it up by using the new
side" kicks in after that.  I wonder if we can roll that cover-up
logic into the loop, perhaps like

	do {
		reflog = &commit_reflog->...[recno];
		commit_reflog->recno--;
-		logobj = parse_object(&reflog->ooid);
+		logobj = parse_object(is_null_oid(&reflog->ooid) 
+				? &reflog->noid : &reflog->ooid);
-	} while (commit_reflog->recno && (logobj && logobj->type != OBJ_COMMIT));
+	} while (commit_reflog->recno && (!logobj || logobj->type != OBJ_COMMIT));
-
-	if (!logobj && commit_reflog->recno >= 0 && is_null_oid(&reflog->ooid)) {
-		/* a root commit ... */
-		reflog = &commit_reflog->...[recno];
-		logobj = parse_object(&reflog->noid);
-	}

which may deal with your "both old and new sides were  NULL" case
better.


