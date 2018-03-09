Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA2221F404
	for <e@80x24.org>; Fri,  9 Mar 2018 19:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932247AbeCITyZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 14:54:25 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40506 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932084AbeCITyY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 14:54:24 -0500
Received: by mail-wm0-f66.google.com with SMTP id t6so5882553wmt.5
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 11:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=H38qDNAAuKzqBmXd8UmArtDu7FNuRCOEi3tBhyvhdeY=;
        b=DcZqVqK/hqu+6yM+q53t1ZPgGvYzvt/Y0mLp/abFQ8+vyGz6fsOlZURQ68GwdQ6OH9
         reqITTawgIEQf0/uOP6DaH8bNaHfAfqix6K9ld68C5bn20ki9g59QlZp2jmfEGOOnpcm
         RrCAZiP+PxQx9MeI1ZMZoUmftGdwAQasE5s1U7z57CYlsbju9HaiIjlnnULgKMW5mlhP
         iyKFnkZLxMKA0r22cflUzrTe4lol3qpkRR/oHe+hQR1vfzCaaTo1M6Rf/FuhlVZoRXjH
         0mSavwIxR7nYO2nejhzHN/1KaOclvXpuF5vqKc/gDPodtSCHe0nCFx+e32IJ2loZm8nm
         rIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=H38qDNAAuKzqBmXd8UmArtDu7FNuRCOEi3tBhyvhdeY=;
        b=aR+im2e9R7PdfS2wv0hl1Ek69i6jMUh8Cb9bOCyHa4gAJyvlPqAyeTHbmrRpOvECVw
         I9AkXswDH7ha2OrKmQTu+9J0o1yR1fbEPKiP8BVD7HhOdZ3Pu+FomjX5QtlBI2tc8j4M
         ZFQUZMoVWNTtmY4Kku2cBjCa53MR+mb0K8QhQOIyA9PXanBoCMzpfKtNc1vDg+gjy1bS
         a6lORYHQx0EcqjF8Ndsl4x1XXxGV3g4b1cyyE91jrS1Ak7/zc93mQ5xaPVqFmP1lQvmn
         GRDkzA6VvY8gys+OnroEnIb+1HFuvucyvNYvQiGIVyxEc0+JUfNbrIEc49sCOg3ncQw/
         3YoA==
X-Gm-Message-State: AElRT7GguX7fcQD4fEsQMhjzk+XNHhRIZOlUqLcQ1SagUW+r5KUPOskj
        NfS6lmNgEsy3hcICeQ2ZDJ4=
X-Google-Smtp-Source: AG47ELuljOGCreGUlmOKnhdC8C7hdNrb8xP5Omxsk4aqQTAjSYjS7s2c5OK6Buvf2NbYws89AFd/pA==
X-Received: by 10.28.62.211 with SMTP id l202mr32474wma.1.1520625263413;
        Fri, 09 Mar 2018 11:54:23 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j126sm2031097wmb.33.2018.03.09.11.54.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Mar 2018 11:54:22 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Takuto Ikuta <tikuta@chromium.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] fetch-pack.c: use oidset to check existence of loose object
References: <20180309131136.219303-2-tikuta@chromium.org>
        <20180309132655.224308-1-tikuta@chromium.org>
Date:   Fri, 09 Mar 2018 11:54:21 -0800
In-Reply-To: <20180309132655.224308-1-tikuta@chromium.org> (Takuto Ikuta's
        message of "Fri, 9 Mar 2018 22:26:55 +0900")
Message-ID: <xmqq606558k2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Takuto Ikuta <tikuta@chromium.org> writes:

> In repository having large number of remote refs, because to check

Isn't this "When fetching from a repository with large number of
refs,"?  The number of refs (whether it is local or remote-tracking)
the local side has has nothing to do with the issue you are
addressing, no?

> existence of each refs in local repository, 'git fetch' ends up doing a
> lot of lstat(2) calls to see if it exists in loose form, which makes it
> slow.

Other than that, the above description reads much better and makes
the result easier to understand.

> This patch enumerates loose objects in hashmap beforehand and uses it to
> check existence instead of using lstat(2) to improve performance of
> fetch-pack for repositories having large number of remote refs compared
> to the number of loose objects.

We'd rather write this paragraph as if giving an order to the
codebase "to be like so", e.g.

	Instead of making as many lstat(2) calls as the refs the
	remote side advertised to see if these objects exist in the
	loose form, first enumerate all the existing loose objects
	in hashmap beforehand and use it to check existence of
	them...

> I took time stat of `git fetch` disabling quickfetch, so that fetch-pack

I still do not know if a benchmark with quickfetch disabled gives
relevant numbers, for reasons I gave earlier.  The relative numbers
between Linux and MacBook look quite convincing, as they illustrate
differences of lstat(2) performance on these platforms.

>  	for (ref = *refs; ref; ref = ref->next) {
>  		struct object *o;
> +		unsigned int flags = OBJECT_INFO_QUICK;
>  
> -		if (!has_object_file_with_flags(&ref->old_oid,
> -						OBJECT_INFO_QUICK))
> -			continue;
> +		if (!oidset_contains(&loose_oid_set, &ref->old_oid)) {
> +			/* I know this does not exist in the loose form,
> +			 * so check if it exists in a non-loose form.
> +			 */

	/*
	 * Our multi-line comment looks like this,
	 * with opening slash-asterisk and closing
	 * asterisk-slash on their own lines.
	 */

Thanks.
