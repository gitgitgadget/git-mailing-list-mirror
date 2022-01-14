Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95009C433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 03:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239056AbiANDwW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 22:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbiANDwV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 22:52:21 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F11C061574
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 19:52:21 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id c6so3756810plh.6
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 19:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bbH9CmGSOYexzYM2P3nMYBpYR16xq9CnqgPwtJXtX0c=;
        b=BcqdPebo2pSrsUFouybFYy/i+qa1B6km3gOM6Nn7XZNGbe64Dza5ZlwlQOof7CWFir
         Q+KRGtMGG/0aZAE7Xh3O7+mCc5cNXSrAR+q8A3cT9SkGbVKpMOhsWyVieT4mCzXOidls
         x+MAHKk9WmfS2nuExmkORjTmiqz80uIeZrdyrlNXQmeebdP4L72i4t5XRFarZ2xt6Oor
         i8Xu0M7ppYJ+CG4B5bdSbyPri2B6GJgKjWRPhbuLtem0gkhqKziExeAW/WrGjzrcCYDk
         559vKuWADY3fD4zG0zCPe7QddIcwaLNnx+0jdENMF+/MBnr4lFOD8+Wbh4bCFkxcFXZt
         szGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=bbH9CmGSOYexzYM2P3nMYBpYR16xq9CnqgPwtJXtX0c=;
        b=yp4jzeOqZAi0emS5qAQAKCk91a0V1IawJMC39451TCNAe6+8OrtRk0UXEdohjfbO2P
         YRLoCZqNa+I7ZveDpBc7fM2wVZfuEIldonCpysOm2cWER6Y9e4aEZ2oIf7Fljvkc2KEk
         Q5m6b37/zofiHkLN/tll94UvnhDbfp5LZQLSJZkWfGcox+GTK1PeywbXP21SPEK7vAah
         Fr4gAdWYkncsIP4Jeyu7HYuUw81Lj/nzE3Aw0Eb1wppcIvQKaufLKwcNbMsWK/Qwp4p9
         03UX0SZAxUj71BPe0D6Dnfcngw9YAoRFUwGkp9WpMU144UauR96NTIu6of4+8KGjNZ8v
         n7CA==
X-Gm-Message-State: AOAM531U9X3fOrm+fFsIazCLuh6jlh0byM4Ld/mldGCN/tnFhhbwy3Bk
        rsEJGJtMC9gIEU3aLT6Ty1x0EA==
X-Google-Smtp-Source: ABdhPJwo7e7ZD9qAT0/flOuyLEArkhqrW9PaBg0GXr2HU3GQQCUR2kIYDyxeGIE1IleByr12LTacKw==
X-Received: by 2002:a17:90b:17c4:: with SMTP id me4mr8580321pjb.15.1642132340486;
        Thu, 13 Jan 2022 19:52:20 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:d145:5bc6:f3c2:cb74])
        by smtp.gmail.com with ESMTPSA id m10sm3551133pgu.70.2022.01.13.19.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 19:52:19 -0800 (PST)
Date:   Thu, 13 Jan 2022 19:52:07 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] t/gpg: simplify test for unknown key
Message-ID: <YeDzZ1utGGc2ifrC@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Fabian Stelzer <fs@gigacodes.de>, git@vger.kernel.org,
        Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
References: <20220107091432.581225-1-fs@gigacodes.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220107091432.581225-1-fs@gigacodes.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.01.07 10:14, Fabian Stelzer wrote:
> To test for a key that is completely unknown to the keyring we need one
> to sign the commit with. This was done by generating a new key and not
> add it into the keyring. To avoid the key generation overhead and
> problems where GPG did hang in CI during it, switch GNUPGHOME to an
> empty directory instead, therefore making all used keys unknown for this
> single `verify-commit` call.
> 
> Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
> ---
> This was reported by Ævar in <211222.86ilvhpbl0.gmgdl@evledraar.gmail.com>.
> Just using an empty keyring / gpg homedir should achieve the same effect and 
> keeps the stress of generating a gpg key out of the CI.

Looks good to me.

Reviewed-by: Josh Steadmon <steadmon@google.com>
