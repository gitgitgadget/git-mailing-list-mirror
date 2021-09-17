Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C0DC43219
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 04:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F128760F93
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 04:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244606AbhIQEJ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 00:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238324AbhIQEHg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 00:07:36 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C02C0613DE
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 21:06:03 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id d11so4988685ilc.8
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 21:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Rc88FGBQWHay47vfcAqOYLzDFkXhR7OMSXZQiQ4vkLM=;
        b=uEr6sm17QAQKTqCGxtdoytGb8bKIbfHvQ0bC1dFWZVwimHpZSkh1HgGeqjzI7RSfaS
         wbIqNEazoFOEQmfT/zm1kHhNenOg2Yap6b04tNNrwVgcwb6FJUOPuYaq9vRcH+A8WQ1n
         OlK8BHJk5Mfrt69KTED9hQmnULTLQWhW7UKqFsOQVeEaXKqIf9Zzb2GIcfxVlOIE52qc
         MduIlKFT9ohEMQmGs/khxPAWJzgOQW5Ei2GKt8cxkZBt21UdScHHRQRdkeZWsXXOuiLG
         yNdd9UNxwNk7+g1abNyYxUz64VRek+OjOVBZOfQrjjYOYe+rojJ+Z6kKOs6CJEq9nqxk
         h/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Rc88FGBQWHay47vfcAqOYLzDFkXhR7OMSXZQiQ4vkLM=;
        b=ilCrYXi9ENtH/edhsooeSZIGvRIdsozaYOyOY4Ns1JoJLV3GxikZaABK8qzM+isNOW
         bQA1u97T64TaExNc5bapQB8tTCNMaZHC+eUlMPIlRJwa3dQh5NOo2NMpkej4T4qNM4j7
         iMDOPCoqDMZawgM5RojnebBfYfbKQsOW5GHwXzWaU5ZU8n7OsG85pK/Y91fOzkDFkp8g
         m2m3Oz3dW4bw9hC5D1fJS1cEbB3i0QGFCAfo0olBGdKbz/cSXaonjVLngBFfA+0uB1wS
         4NRCcJf4Kto0I53OBkpwrqmAZ0APZ7MG+7E6XCE+JKlWTJvXNMzwnrw19le0QVGxmHhZ
         DZzw==
X-Gm-Message-State: AOAM5333ZTEV6xdKEUAIrC5rGpHHMHGuLeWwTixeII2juXcNZwDcJKXq
        TXy5MgQW5wiXSp89AA6E36vpZg==
X-Google-Smtp-Source: ABdhPJwrWlSrq56QavvGPK7WmyUv9n4Udh/YkiXjKqaR/JRv18Xf2PkuK9OgIKItreH12+RsbHUcvg==
X-Received: by 2002:a92:de0e:: with SMTP id x14mr6513636ilm.259.1631851562985;
        Thu, 16 Sep 2021 21:06:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r16sm2938696ilj.77.2021.09.16.21.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 21:06:02 -0700 (PDT)
Date:   Fri, 17 Sep 2021 00:06:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v6 22/22] fsck: report invalid object type-path
 combinations
Message-ID: <YUQUKvM3yjx9yDQI@nand.local>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
 <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
 <patch-v6-22.22-804673a17b0-20210907T104559Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v6-22.22-804673a17b0-20210907T104559Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 07, 2021 at 12:58:17PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Improve the error that's emitted in cases where we find a loose object
> we parse, but which isn't at the location we expect it to be.
>
> Before this change we'd prefix the error with a not-a-OID derived from
> the path at which the object was found, due to an emergent behavior in
> how we'd end up with an "OID" in these codepaths.
>
> Now we'll instead say what object we hashed, and what path it was
> found at. Before this patch series e.g.:
>
>     $ git hash-object --stdin -w -t blob </dev/null
>     e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
>     $ mv objects/e6/ objects/e7
>
> Would emit ("[...]" used to abbreviate the OIDs):
>
>     git fsck
>     error: hash mismatch for ./objects/e7/9d[...] (expected e79d[...])
>     error: e79d[...]: object corrupt or missing: ./objects/e7/9d[...]
>
> Now we'll instead emit:
>
>     error: e69d[...]: hash-path mismatch, found at: ./objects/e7/9d[...]

Lovely!

> @@ -603,20 +603,25 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
>  	struct strbuf sb = STRBUF_INIT;
>  	unsigned int oi_flags = OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
>  	struct object_info oi;
> +	struct object_id real_oid = *null_oid();
>  	int found = 0;
>  	oi.type_name = &sb;
>  	oi.sizep = &size;
>  	oi.typep = &type;
>
> -	if (read_loose_object(path, oid, &contents, &oi, oi_flags) < 0) {
> +	if (read_loose_object(path, oid, &real_oid, &contents, &oi, oi_flags) < 0) {
>  		found |= ERROR_OBJECT;
> -		error(_("%s: object corrupt or missing: %s"),
> -		      oid_to_hex(oid), path);
> +		if (!oideq(&real_oid, oid))
> +			error(_("%s: hash-path mismatch, found at: %s"),
> +			      oid_to_hex(&real_oid), path);
> +		else
> +			error(_("%s: object corrupt or missing: %s"),
> +			      oid_to_hex(oid), path);

Nice; this is the important part that this patch is changing, and the
logic is very nice. Before it read "anytime read_loose_object fails,
it's an error" to "it's still an error, but we can handle the case where
the real OID and the one we expected were different separately from
generic corruption".

>  	}
>  	if (type < 0) {
>  		found |= ERROR_OBJECT;
>  		error(_("%s: object is of unknown type '%s': %s"),
> -		      oid_to_hex(oid), sb.buf, path);
> +		      oid_to_hex(&real_oid), sb.buf, path);

Could go either way on this hunk, but I think that I err slightly on
your side now that we have access to the "real_oid".

The rest of the code and test changes in this patch look good to me.

Thanks,
Taylor
