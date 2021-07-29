Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6882DC4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 19:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44C4A60EE2
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 19:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhG2TJ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 15:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbhG2TJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 15:09:57 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A88BC061765
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 12:09:53 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id f13so8146679plj.2
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 12:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=9ushP6xjE/qSP5pBCPRYy9J6pJiozLwIhndLTlWYo2w=;
        b=jfdtJQDx91XBV+wrlvRpyKM3MPD3A+O+apZfNksqh6ctBkekV9LNCOZnz4qoeILfE7
         Jg81E+p48Ojm48igW5g1ZlqGV5lUIWEeMd2Tmo1rSj7pG3bMS7NZ2D4QkKXTmdr7nJj+
         U7YTb/MRQ/r5cIfzxnkgJQsCJrm4GhgXXlQnOvvSMbng6Gzfucx4UYuX0AO79UVu+Aam
         uRHlkNgcaxRjFXjCGhgtb1kMHzYBFZ1/mDB4wOLhJ6H6hB2jpSwdFzofJSL18I9wf4li
         oY+EO/GNGUAz+EGurh5+1kgU+M3w35dcnoOy9zyi04QuExOpUO53nG94VoKxecZ1FbjK
         j/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=9ushP6xjE/qSP5pBCPRYy9J6pJiozLwIhndLTlWYo2w=;
        b=m0tGYI0EENH9Qizi7aN883Yj/42XVObG5V0C/nMddH1a9pMPk5T1j4V0mJfCLVmqSB
         kXFPgtPwdh61PPt84xpFlqLBpgA7Oi1OLZcEJzS9uY/2YQoISAHvI1R1r477GKjxtEfH
         z3aiCpfyXaYkpCA9LX+tcaLa41C8vaprK0EnOV6PtkJGrQ7RNALclkcRknnb29kLnQrR
         zuNzDBtp246KgkMv9VTRAByBl/7kW8AO24jQuDpPXogG9rBHLVh2ydZYQfThYCoOsNhl
         LI6mXF2FuqidA5RGyG+jObEQvdEjN/KXkoBItiwZAa61ui3WfK6ztA6ch6/dmbX0YLsE
         sWQw==
X-Gm-Message-State: AOAM533phd9R1egso0sF50jsQjzRpDHKG/IlihIdSJREio5Ewp8OpKNa
        C3GXSU/g6117VwCDV6tw8ILaEWw+HBZZvw==
X-Google-Smtp-Source: ABdhPJyj7tXgf116c+e9WypLU0zigpiLp9qv1za1pMeToJXCGU7jek/HKa8VN1VhKGn0RVDwvkHv2w==
X-Received: by 2002:a17:90b:1d86:: with SMTP id pf6mr6925724pjb.104.1627585793037;
        Thu, 29 Jul 2021 12:09:53 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:12b4:7532:e087:f8ab])
        by smtp.gmail.com with ESMTPSA id n8sm1809938pfd.100.2021.07.29.12.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 12:09:52 -0700 (PDT)
Date:   Thu, 29 Jul 2021 12:09:45 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>
Subject: Re: [PATCH v6 6/9] ssh signing: add test prereqs
Message-ID: <YQL8+UFtVJPlJroe@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>
References: <pull.1041.v5.git.git.1627391744.gitgitgadget@gmail.com>
 <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
 <18a26ca49e7a9b0046559ac8d5c62c99ea7262ae.1627501009.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18a26ca49e7a9b0046559ac8d5c62c99ea7262ae.1627501009.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.07.28 19:36, Fabian Stelzer via GitGitGadget wrote:
> From: Fabian Stelzer <fs@gigacodes.de>
> 
> generate some ssh keys and a allowedSignersFile for testing
> 
> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
> ---
>  t/lib-gpg.sh | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
> index 9fc5241228e..600c8d1a026 100644
> --- a/t/lib-gpg.sh
> +++ b/t/lib-gpg.sh
> @@ -87,6 +87,35 @@ test_lazy_prereq RFC1991 '
>  	echo | gpg --homedir "${GNUPGHOME}" -b --rfc1991 >/dev/null
>  '
>  
> +test_lazy_prereq GPGSSH '
> +	ssh_version=$(ssh-keygen -Y find-principals -n "git" 2>&1)
> +	test $? != 127 || exit 1
> +	echo $ssh_version | grep -q "find-principals:missing signature file"
> +	test $? = 0 || exit 1;
> +	mkdir -p "${GNUPGHOME}" &&
> +	chmod 0700 "${GNUPGHOME}" &&
> +	ssh-keygen -t ed25519 -N "" -C "git ed25519 key" -f "${GNUPGHOME}/ed25519_ssh_signing_key" >/dev/null &&
> +	echo "\"principal with number 1\" $(cat "${GNUPGHOME}/ed25519_ssh_signing_key.pub")" >> "${GNUPGHOME}/ssh.all_valid.allowedSignersFile" &&
> +	ssh-keygen -t rsa -b 2048 -N "" -C "git rsa2048 key" -f "${GNUPGHOME}/rsa_2048_ssh_signing_key" >/dev/null &&
> +	echo "\"principal with number 2\" $(cat "${GNUPGHOME}/rsa_2048_ssh_signing_key.pub")" >> "${GNUPGHOME}/ssh.all_valid.allowedSignersFile" &&
> +	ssh-keygen -t ed25519 -N "super_secret" -C "git ed25519 encrypted key" -f "${GNUPGHOME}/protected_ssh_signing_key" >/dev/null &&
> +	echo "\"principal with number 3\" $(cat "${GNUPGHOME}/protected_ssh_signing_key.pub")" >> "${GNUPGHOME}/ssh.all_valid.allowedSignersFile" &&
> +	cat "${GNUPGHOME}/ssh.all_valid.allowedSignersFile" &&
> +	ssh-keygen -t ed25519 -N "" -f "${GNUPGHOME}/untrusted_ssh_signing_key" >/dev/null
> +'
> +
> +SIGNING_KEY_PRIMARY="${GNUPGHOME}/ed25519_ssh_signing_key"
> +SIGNING_KEY_SECONDARY="${GNUPGHOME}/rsa_2048_ssh_signing_key"
> +SIGNING_KEY_UNTRUSTED="${GNUPGHOME}/untrusted_ssh_signing_key"
> +SIGNING_KEY_WITH_PASSPHRASE="${GNUPGHOME}/protected_ssh_signing_key"
> +SIGNING_KEY_PASSPHRASE="super_secret"
> +SIGNING_ALLOWED_SIGNERS="${GNUPGHOME}/ssh.all_valid.allowedSignersFile"
> +
> +GOOD_SIGNATURE_TRUSTED='Good "git" signature for'
> +GOOD_SIGNATURE_UNTRUSTED='Good "git" signature with'
> +KEY_NOT_TRUSTED="No principal matched"
> +BAD_SIGNATURE="Signature verification failed"
> +

Is there a reason why we don't use these variables in the script above?

Also, in general I feel that it's better to add tests in the same commit
where new features are added, rather than having standalone test
commits.


>  sanitize_pgp() {
>  	perl -ne '
>  		/^-----END PGP/ and $in_pgp = 0;
> -- 
> gitgitgadget
> 
