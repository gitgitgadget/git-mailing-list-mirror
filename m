Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1496320401
	for <e@80x24.org>; Thu, 15 Jun 2017 17:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751016AbdFORAo (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 13:00:44 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35479 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750803AbdFORAn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 13:00:43 -0400
Received: by mail-pg0-f65.google.com with SMTP id f127so2286401pgc.2
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 10:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0q2GzJ+9Kxzal1Wf7Rj8emTH0bxsxmkJjqAFy5l4n+M=;
        b=XcTc3TkOvdW3umGnFrlg7IkBGmdbpo2jzsIxrEzr7YomW2HwZn33AfLldumwUMAmCY
         sjYYTk6TSlNrmva79vyCh3MvyEzlkn/j6HC4L4Eq2nZYISm8QiojX/NujIIVWJJH1jqA
         4bBpp7wcb7mLi9CsOkYPWWJdXWRjIif6Sb06bFZ5aTZ4TXPtCb9z+9sF31YyMcSA6+eR
         jVI9lxGTVUKnPrtjGO57ee60Ap7Jkg8fyk0hw1+/RbdCJSt/we9c3LnZhLTHUqoj5NX1
         Av1EKPD0DGcg0zuGWBAnDLKkSqOGT2ewzKJBfdXkDMyZAG13ttnFLOWX9s6rsuI9Ib9H
         U41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0q2GzJ+9Kxzal1Wf7Rj8emTH0bxsxmkJjqAFy5l4n+M=;
        b=EYuPrafZKPwuyZIWaP2R+8+2cUa8yaVWwomFWyo6QPesWd5QTSk3OhA9RNRV+9mq43
         5cDTZlSoTt1MCS65Cf07uTOYAyiVW6gQy+Ju7kZSrCSPhCz1leVoqySBgyULrZah1O35
         BrogbDfos4w7/ivH8a3CDFOiRoE9Ap1R1Zly2lqpduDs7g/9SdhDjW3vMrSRVm0afdKy
         9+I6iXBQ9pH5C8VPOdo9fddh7AbQcw2BIow0xg5Ul7o7cF9BrHn/iHCPUQvLgJVz7vN6
         3cgIKlYFfB5H43zEnwXJ4OnHS7bPwyJ1vG+qCqbAz8DrNGhFjKZh+ArF29dmw8sRm6cD
         mrEg==
X-Gm-Message-State: AKS2vOzRCCfD4kx88i6oANp4EhE/vfOKcr2ZPUErH5vpThT1cw8OjCOT
        RoImBac5tkzfn6jAcyY=
X-Received: by 10.98.2.151 with SMTP id 145mr6149293pfc.52.1497546041719;
        Thu, 15 Jun 2017 10:00:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88c8:4433:c52b:12d7])
        by smtp.gmail.com with ESMTPSA id k192sm1138168pgc.31.2017.06.15.10.00.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 10:00:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 2/4] sha1_file: move delta base cache code up
References: <cover.1497387713.git.jonathantanmy@google.com>
        <cover.1497035376.git.jonathantanmy@google.com>
        <cover.1497387713.git.jonathantanmy@google.com>
        <36b7984ee85d22800b974a04952c50eef043fa67.1497387714.git.jonathantanmy@google.com>
Date:   Thu, 15 Jun 2017 10:00:39 -0700
In-Reply-To: <36b7984ee85d22800b974a04952c50eef043fa67.1497387714.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 13 Jun 2017 14:05:58 -0700")
Message-ID: <xmqqbmpp2nk8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> In a subsequent patch, packed_object_info() will be modified to use the
> delta base cache, so move the relevant code to before
> packed_object_info().
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  sha1_file.c | 226 +++++++++++++++++++++++++++++++-----------------------------
>  1 file changed, 116 insertions(+), 110 deletions(-)

Hmph, is this meant to be just moving two whole functions?

> diff --git a/sha1_file.c b/sha1_file.c
> index a52b27541..a158907d1 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2239,116 +2239,6 @@ static enum ...
> ...
> -int packed_object_info(struct packed_git *p, off_t obj_offset,
> -		       struct object_info *oi)
> -{
> -...
> -	if (oi->delta_base_sha1) {
> -		if (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
> -			const unsigned char *base;
> -
> -			base = get_delta_base_sha1(p, &w_curs, curpos,
> -						   type, obj_offset);
> -			if (!base) {
> -				type = OBJ_BAD;
> -				goto out;
> -			}
> -
> -			hashcpy(oi->delta_base_sha1, base);
> -		} else
> -			hashclr(oi->delta_base_sha1);
> -	}
> -
> -out:
> -	unuse_pack(&w_curs);
> -	return type;
> -}
> -...

The above is what was removed, while ...

> @@ -2486,6 +2376,122 @@ static void ...
> ...
> +int packed_object_info(struct packed_git *p, off_t obj_offset,
> +		       struct object_info *oi)
> +{
> +...
> +	if (oi->delta_base_sha1) {
> +		if (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
> +			const unsigned char *base;
> +
> +			base = get_delta_base_sha1(p, &w_curs, curpos,
> +						   type, obj_offset);
> +			if (!base) {
> +				type = OBJ_BAD;
> +				goto out;
> +			}
> +
> +			hashcpy(oi->delta_base_sha1, base);
> +		} else
> +			hashclr(oi->delta_base_sha1);
> +	}
> +
> +	oi->whence = OI_PACKED;
> +	oi->u.packed.offset = obj_offset;
> +	oi->u.packed.pack = p;
> +	oi->u.packed.is_delta = (type == OBJ_REF_DELTA ||
> +				 type == OBJ_OFS_DELTA);
> +
> +out:
> +	unuse_pack(&w_curs);
> +	return type;
> +}

... we somehow gained code to update *oi that used to be (and still
is) done by its sole caller, sha1_object_info_extended().

Perhaps this is a rebase-gotcha?
