Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E56BC43217
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 01:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbiK2BUU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 20:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbiK2BUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 20:20:16 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA2240931
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 17:20:06 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id r18so11561422pgr.12
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 17:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LFY7rQk49TQEwxOJAwR6IRydtpy/Qf3yAWpVBUVQRf8=;
        b=NfXvZRdNTTUanwuftzTJrmIBRJCVbsU7611qH7Mt7QS4eBNmhLdISpekC8hTXs7kdx
         0PQtcby0GLihCWlHi0sYvv2FtYWjTKXsVi37WKq6Qu1PiNX+oGHF4ulDyASoCKbClw2Q
         EWNhRaneJIToEP3p0KejXzY+Rh4kJ0di6xkix1xC1fYGDOoFhiCzp4lXChlwwbEhrtn3
         D5GRQ9L5JUEMLlT4bY4llui6OrZ3pXwp1iWHA2UKhvJhJA9C9nB60yAhTelcCe4FqQ8K
         VTw7P/IeStMFmp3UDhHKdwgzSYS1I6v0F/eV9jx5VljDUEEAn6kjPvYHVkkqB7fD41N8
         Ypew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LFY7rQk49TQEwxOJAwR6IRydtpy/Qf3yAWpVBUVQRf8=;
        b=dTxeTjAV32t8f3DYcg2fmJ/kbpCOx0OlnntyC2k4uyqsViqF5iu7xUcS+gxWfMf4ob
         VoxoeRZm+z0KCw5Xa9DcJ0PB7I3lJ00kc8aCIJEOfdpPMe+NQ3ObsNLZoA77geXY4twk
         vLf0jm1TR7olRIoUkEgcbKe1bIX3wRoEitwEYL3Kr8yyaL2Lc1pkgGfa0Qzqwl/uflqE
         61DbB1ZAcg0O69pwVcrYE2R4XzP1vV4PqiH9oUPbPPx/B20JxrY81lBZUCp/L5dFHhfg
         VMZGmCK6HvctIzs4reZGcvPKgZuMUGrg9rwNZBldyrBzYDp3h1jAagdTBVNG1yOjC9wO
         HMOw==
X-Gm-Message-State: ANoB5pk2WSCWLtXbx05NtkVOYGT4WokU9uFfZVwzXnNSU3e/gRExor7c
        Ib6YzUAOCnLN5T8DLHFtnOk=
X-Google-Smtp-Source: AA0mqf7GaEUUr+Q1eU5Mj1hm0Cr5dBinsC9liByWrqScTDSsm78T7CrSTYuVgQvL7kDAMlZT1Lxd0A==
X-Received: by 2002:a65:53ca:0:b0:476:dd80:fb29 with SMTP id z10-20020a6553ca000000b00476dd80fb29mr49056576pgr.619.1669684806102;
        Mon, 28 Nov 2022 17:20:06 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id e8-20020a170902784800b001896040022asm8464007pln.190.2022.11.28.17.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 17:20:05 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3] am: Allow passing --no-verify flag
References: <20221128174825.1510407-1-thierry.reding@gmail.com>
Date:   Tue, 29 Nov 2022 10:20:05 +0900
In-Reply-To: <20221128174825.1510407-1-thierry.reding@gmail.com> (Thierry
        Reding's message of "Mon, 28 Nov 2022 18:48:25 +0100")
Message-ID: <xmqqv8my4kvu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thierry Reding <thierry.reding@gmail.com> writes:

> +test_expect_success 'am with failing applypatch-msg hook (no verify)' '
> +	rm -fr .git/rebase-apply &&
> +	git reset --hard &&
> +	git checkout first &&
> +	test_hook applypatch-msg <<-\EOF &&
> +	exit 1
> +	EOF
> +	git am --no-verify patch1
> +'
> +
>  test_expect_success 'am with pre-applypatch hook' '
>  	rm -fr .git/rebase-apply &&
>  	git reset --hard &&
> @@ -374,6 +384,16 @@ test_expect_success 'am with failing pre-applypatch hook' '
>  	test_cmp_rev first HEAD
>  '
>  
> +test_expect_success 'am with failing pre-applypatch hook (no verify)' '
> +	rm -fr .git/rebase-apply &&
> +	git reset --hard &&
> +	git checkout first &&
> +	test_hook pre-applypatch <<-\EOF &&
> +	exit 1
> +	EOF
> +	git am --no-verify patch1
> +'
> +
>  test_expect_success 'am with post-applypatch hook' '
>  	rm -fr .git/rebase-apply &&
>  	git reset --hard &&

These two tests will still pass if you change the implementation to
run the hook and simply ignore its exit status, but I recall you
making a good argument against that alternative implementation ,in
comparison to "not running the hook at all".

I think these tests should make sure that the hooks did not even
run.  Perhaps by creating a marker file before running "git am",
adding a "rm" that marker file in the hook, and making sure that
the marker file still exists after "git am" returns, or something
like that.
