Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C936A1F406
	for <e@80x24.org>; Sun, 13 May 2018 23:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751093AbeEMXmn (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 19:42:43 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39927 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbeEMXmm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 19:42:42 -0400
Received: by mail-wm0-f68.google.com with SMTP id f8-v6so11904951wmc.4
        for <git@vger.kernel.org>; Sun, 13 May 2018 16:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=0HMziSLXpMjQZqjmKar8x2TB6wUCWC89BDhRtgEq5sE=;
        b=dL5S8GAvWQYSvCykm1YiQxZaE1/18yev6CgfGFhvKMB1BX6zFvCZpj3tgnmQdeCp6E
         5aE6vIMtksPzWNruPARn7K0MjIrE1w55zeu77YumZ638HXDpO3NtfFi2VE/DXX3wME8x
         Zz6NabDg499SvySO4LDKpw4E8t2jBbuj2rOgSqMVOxNSFHhZL0HClA9stFTKGVGx5uem
         5c4zjZnT9+J/9+fAFZvX6geCDPFehKJgLffnygKTnbhrOMkgHP0xtcgHQq3wRZfFT82+
         1AshxprD6E518Plt6IU6bumG2SXtZB9oUYZyZep+yEJktu14hFXCqUxvbZPmnYoKOK0Y
         c7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=0HMziSLXpMjQZqjmKar8x2TB6wUCWC89BDhRtgEq5sE=;
        b=nch9DuzZLewAmOIs4BHJW20rKW+/rlrUuT1ER/4ewBp1nac5v+gWRhr18Kucwt1MQS
         BLweNytWdiHUhDVouibq3FwztRrySVw9EVmNnmqkVt0LcUsielo4re356Bh1srvL3Wwy
         D3T9oSwqqGP00exBx0k8/vH+s4PU14IpkxwVtXsEzYVIicCpMnAJXR/jP4hRAJKrRNRF
         NT/Fp29t4WUlLibto8LBmeRONBmdEEzIRZQfZuwUhpUyhLl6UNfcOsqNGhjlazJcgeT/
         SQHe+9uDDn9adT7KC0dJ3GiiMOYbFSRNwRW8e3qRRDXEtdEgXgdXlFh1zCyYzogoLUT7
         Y94w==
X-Gm-Message-State: ALKqPwfH3LsYh6pSXer/cloV4fM+UnDkpNvhAJFOCjIDsYZ+d8hH7BQI
        oUTEIlrtxf1czOgPlGJb1D8kjQTO
X-Google-Smtp-Source: AB8JxZqzd3xCTgPtVzzPod6mYX6Q95i2W3TW5dcHkQKHBKgKQiE8RrcUfp5sXLpxwW8eYtFoNV9RoQ==
X-Received: by 2002:a1c:af8a:: with SMTP id y132-v6mr3861617wme.107.1526254960582;
        Sun, 13 May 2018 16:42:40 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r6-v6sm10068996wrg.73.2018.05.13.16.42.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 May 2018 16:42:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 03/14] blame: use commit-slab for blame suspects instead of commit->util
References: <20180512080028.29611-1-pclouds@gmail.com>
        <20180513055208.17952-1-pclouds@gmail.com>
        <20180513055208.17952-4-pclouds@gmail.com>
Date:   Mon, 14 May 2018 08:42:39 +0900
In-Reply-To: <20180513055208.17952-4-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sun, 13 May 2018 07:51:57 +0200")
Message-ID: <xmqq603rdswg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> It's done so that commit->util can be removed. See more explanation in
> the commit that removes commit->util.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  blame.c         | 42 +++++++++++++++++++++++++++++++-----------
>  blame.h         |  2 ++
>  builtin/blame.c |  2 +-
>  3 files changed, 34 insertions(+), 12 deletions(-)
>
> diff --git a/blame.c b/blame.c
> index 78c9808bd1..18e8bd996a 100644
> --- a/blame.c
> +++ b/blame.c
> @@ -6,6 +6,24 @@
>  #include "diffcore.h"
>  #include "tag.h"
>  #include "blame.h"
> +#include "commit-slab.h"
> +
> +define_commit_slab(blame_suspects, struct blame_origin *);
> +static struct blame_suspects blame_suspects;
> +
> +struct blame_origin *get_blame_suspects(struct commit *commit)
> +{
> +	struct blame_origin **result;
> +
> +	result = blame_suspects_peek(&blame_suspects, commit);
> +
> +	return result ? *result : NULL;
> +}
> +
> +static void set_blame_suspects(struct commit *commit, struct blame_origin *origin)
> +{
> +	*blame_suspects_at(&blame_suspects, commit) = origin;
> +}
>  
>  void blame_origin_decref(struct blame_origin *o)
>  {

This makes really a pleasant read.  With these helpers in place, the
remainder of this patch becomes mechanical substitution to call
get_blame_suspects when commit->util appears on the RHS of an
expression and set_blame_suspects when commit->util gets assigned.

> @@ -15,12 +33,12 @@ void blame_origin_decref(struct blame_origin *o)
>  			blame_origin_decref(o->previous);
>  		free(o->file.ptr);
>  		/* Should be present exactly once in commit chain */
> -		for (p = o->commit->util; p; l = p, p = p->next) {
> +		for (p = get_blame_suspects(o->commit); p; l = p, p = p->next) {
>  			if (p == o) {
>  				if (l)
>  					l->next = p->next;
>  				else
> -					o->commit->util = p->next;
> +					set_blame_suspects(o->commit, p->next);
>  				free(o);
>  				return;
>  			}
