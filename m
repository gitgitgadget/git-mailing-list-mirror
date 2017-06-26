Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6710D207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 19:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751456AbdFZTbZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 15:31:25 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33224 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751813AbdFZTae (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 15:30:34 -0400
Received: by mail-pf0-f193.google.com with SMTP id e199so1474210pfh.0
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 12:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oGmMc8Tu0WN+Bukxu0/P1NzRZxdmosJRFrLEvaIu4Sw=;
        b=jE1TGaAawsGfUD8gDo0rF8LN7JqiruwBe1g8EmVN7tx2orljLjLVUduaDfKb5TvFKi
         fPuz2VGWhC0Li3SOpPe+WCKScWbQiNLL9rHVG91Vd+a0cRlikROo9bO7gm86OXiReL9k
         v9uw55b22aKMnDapi+KWh54vf0WKX8br/2wHnUdhUZE9zWb7uTX+wKVTH6zFJueNizUq
         vjYDc1Sw4m4ootx2/2E/7O8SKoTwc36EOk3scbSjWgbVL44pD1bijDC9ppiRuWuSRwoZ
         6R3DGfyCOdZ7FgfW98qo97U2bgPL2wnVvWWn+seWVJtOlBMPtN6NvJT3akJafHsM6md/
         zdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oGmMc8Tu0WN+Bukxu0/P1NzRZxdmosJRFrLEvaIu4Sw=;
        b=ODVLCUUxlHYsJOJh+qxYBDIA6IZ1ZQCiuHsHBiqTYgz5Gz2kMOJ4I4ArrfNbK9Juhv
         +vJy1NUBvqBZV0qsih2ViWsocb9MutovO8asj6e8LxKjBc7j8l+CElUzuhCvp7qUbSWg
         HCOsYZD739GjKuEQs+0vNN/V1qXhi3V8B/f/HKatpXn4HtFXbuLZ0rVFaSEgib0BGAXp
         01muWFD/sDPw4ERp7SNJLLgijqLuUC5Opznsz4+deVG4apwbAwLvQHnFGBm5JtKNlR2i
         TI6klPTrXXfkL3olLg10dpF1OkOJahwttTdqXDvRstBongeyKwrDbEEtlP/eEseKb7ke
         7Uuw==
X-Gm-Message-State: AKS2vOx7LQza+GUnS1qRQmaAXEDeWjOCg5JKY3OzaxAY8zzQtk9Jo+D/
        bfhCVDXacnrEFQF389o=
X-Received: by 10.101.76.3 with SMTP id u3mr1570186pgq.119.1498505433641;
        Mon, 26 Jun 2017 12:30:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b537:cc1a:8e81:b9ca])
        by smtp.gmail.com with ESMTPSA id l3sm1487610pfk.34.2017.06.26.12.30.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 26 Jun 2017 12:30:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     James Clarke <jrtc27@jrtc27.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pack-bitmap: Don't perform unaligned memory access
References: <20170626151612.64019-1-jrtc27@jrtc27.com>
Date:   Mon, 26 Jun 2017 12:30:32 -0700
In-Reply-To: <20170626151612.64019-1-jrtc27@jrtc27.com> (James Clarke's
        message of "Mon, 26 Jun 2017 16:16:12 +0100")
Message-ID: <xmqqr2y64kdj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

James Clarke <jrtc27@jrtc27.com> writes:

> The preceding bitmap entries have a 1-byte XOR-offset and 1-byte flags,
> so their size is not a multiple of 4. Thus the name-hash cache is only
> guaranteed to be 2-byte aligned and so we must use get_be32 rather than
> indexing the array directly.
>
> Signed-off-by: James Clarke <jrtc27@jrtc27.com>
> ---
>
> This was noticed thanks to the recent tests added to t5310-pack-bitmaps.sh,
> which were crashing with SIGBUS on Debian sparc64. All tests (excluding those
> marked with known breakage) now pass again.

Thanks.

>
>  pack-bitmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index a3ac3dccd..327634cd7 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -627,7 +627,7 @@ static void show_objects_for_type(
>  			sha1 = nth_packed_object_sha1(bitmap_git.pack, entry->nr);
>
>  			if (bitmap_git.hashes)
> -				hash = ntohl(bitmap_git.hashes[entry->nr]);
> +				hash = get_be32(bitmap_git.hashes + entry->nr);
>
>  			show_reach(sha1, object_type, 0, hash, bitmap_git.pack, entry->offset);
>  		}
> --
> 2.13.2
