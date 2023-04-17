Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6BDC77B72
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 22:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjDQWB1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 18:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjDQWB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 18:01:26 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF13640FA
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 15:01:24 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1a3df25d44eso30227665ad.2
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 15:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681768884; x=1684360884;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NxSMRGmqWxVvOQL6SLUqQ9tRx4rv8vwXS3rXk3VoiAk=;
        b=K/B6k1lwhMfauTi7SmUzBMcqYE4HxWmyxeTcQ2QNbBlyoDs+o6kQvOAnMWFWXUoLZu
         MaU2uMq85VY+73ewrMOW64w8ERIs3TTafh3aom/7BCKU3DhJ/kXMwKy/kSzJlv2yav2w
         j/Lx7lK+MtuBJHWTP3Jdq7Zww15Ukvin61c1jbroDhIGxaZfztxJmOKMXOZoUxYDv7Sb
         XrXfVR3oRI9jZYBN+9M7F9nKnRj0/XgX9RcLava0RrZZYsEaTBoNHTmdbJqU1oFXtllr
         0y1CW6GSwulNudJRvHvxCVu8c4akdY6uhla0U+Nr7nLa2AIzPqswpC6hMhDFkvF/4g5T
         OWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681768884; x=1684360884;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NxSMRGmqWxVvOQL6SLUqQ9tRx4rv8vwXS3rXk3VoiAk=;
        b=ZKw+Fs9kSEmnK4cFyTf7pe42Y3DBQaRgmD9Aqcolp4aBAGpcWNC/2N71CSgKAllbdZ
         WIfH78QIHBTH9a2V1g5uwi4POMry2g/v2Ct2eVBLhzXNcKzHpJmO6IhcRAlpY/AJ1O2J
         qZrmfr1x7QlKIbXH9Ckv5Vd/yB+GuuykvGQGPwn24iODa6NZhzogKRWpxAxLp4q/dFgv
         YOSn7Uetl1detVsV3d8BnPb9SH/UAnorIGXEcfsU/JeF3GHxByzVnV3sDspJcTdoj1+O
         13pGh6MS85vIJdmh5dQTQmVto1zixRiMbpbyK3cPRga2/kJNB4/+z6uUvt4EY+z1SP8X
         GneA==
X-Gm-Message-State: AAQBX9f0W6GhOq7GDnmzAw36gj0q3uGiP3jeogNZFlCUanulHqibC5Eo
        TqXbhPnN8vApTaSAu9e9XzQ=
X-Google-Smtp-Source: AKy350a5Axhxu1myGNH6yO5wwSFQdhzo+rj+iQjla+ytseEu87e9WXYA4UXz6bEClw6HSdMoObNYkA==
X-Received: by 2002:a17:903:410c:b0:1a6:7f14:707e with SMTP id r12-20020a170903410c00b001a67f14707emr34410pld.9.1681768884069;
        Mon, 17 Apr 2023 15:01:24 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id ja13-20020a170902efcd00b0019682e27995sm2477341plb.223.2023.04.17.15.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 15:01:23 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 3/4] fsck: check rev-index position values
References: <pull.1512.git.1681748502.gitgitgadget@gmail.com>
        <adbe9c8ee90e087e864bd9e0c67338974b5dbc8d.1681748502.git.gitgitgadget@gmail.com>
Date:   Mon, 17 Apr 2023 15:01:23 -0700
In-Reply-To: <adbe9c8ee90e087e864bd9e0c67338974b5dbc8d.1681748502.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 17 Apr 2023
        16:21:40 +0000")
Message-ID: <xmqq1qkijhho.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  	if (!hashfile_checksum_valid((const unsigned char *)p->revindex_map, p->revindex_size)) {
>  		error(_("invalid checksum"));
> -		return -1;
> +		res = -1;
>  	}
>  
> -	return 0;
> +	/* This may fail due to a broken .idx. */
> +	if (create_pack_revindex_in_memory(p))
> +		return res;

Here, if the revindex file itself is self consistent, res would
still be 0, so we will end up silently returning.  Is the idea that
while whatever causes in-memory revindex fail to be computed is a
concern from the point of view of the repository's health, it would
be caught elsewhere as a problem for the <pack,idx> pair we are
seeing here?

> +	for (size_t i = 0; i < p->num_objects; i++) {
> +		uint32_t nr = p->revindex[i].nr;
> +		uint32_t rev_val = get_be32(p->revindex_data + i);
> +
> +		if (nr != rev_val) {
> +			error(_("invalid rev-index position at %"PRIu64": %"PRIu32" != %"PRIu32""),
> +			      (uint64_t)i, nr, rev_val);
> +			res = -1;
> +		}
> +	}
> +
> +	return res;
>  }
>  
>  int load_midx_revindex(struct multi_pack_index *m)
> diff --git a/t/t5325-reverse-index.sh b/t/t5325-reverse-index.sh
> index 6b7c709a1f6..5c3c80f88f0 100755
> --- a/t/t5325-reverse-index.sh
> +++ b/t/t5325-reverse-index.sh
> @@ -185,4 +185,9 @@ test_expect_success 'fsck catches invalid checksum' '
>  		"invalid checksum"
>  '
>  
> +test_expect_success 'fsck catches invalid row position' '
> +	corrupt_rev_and_verify 14 "\07" \

;-)

I wondered how the patch made this "\07" portably available; it is
fed as the format string to printf in the helper, which is clever
but obviously correct way to do this.  Nice.

> +		"invalid rev-index position"
> +'
> +
>  test_done
