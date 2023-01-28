Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F8CC38142
	for <git@archiver.kernel.org>; Sat, 28 Jan 2023 14:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbjA1O2d (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Jan 2023 09:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjA1O2c (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jan 2023 09:28:32 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F7D2D40
        for <git@vger.kernel.org>; Sat, 28 Jan 2023 06:28:29 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h12so7372369wrv.10
        for <git@vger.kernel.org>; Sat, 28 Jan 2023 06:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qT9m8x+5U1cOO8IKd8WdbYIEfrssbJS2MrzwdUI7TFk=;
        b=JJoQd0Ew7J3zlezrpXMTJTHqX1NqhFrFXoug7+ANCKm96JQq2oB2BbKA+URDNZ62lz
         +I2Vq1wtgq7EwxOzYYw4OoMaDMcbVzhC8DoE3bflmbLi78AhfjrWdstZUBbFpXxGPHOr
         sfPIPXgGJ2EmYLtauT6Ygtzmm454X1OINNEmKj4xaqsp8VZa8UmZZY4powlFX1AVyvSB
         5TspFvqr7E+TB33+nxLI3TsULTbpcOSKRMYUYLyrwaLQIaSevbKFV5UM8xVErfegtKxi
         qKqE+GUJMpUSkgxi4AB58qQQl6H3qmk0o3i5bvQSHe52HWbq/JA62cU2Z5yUKtOC3/3i
         /DFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qT9m8x+5U1cOO8IKd8WdbYIEfrssbJS2MrzwdUI7TFk=;
        b=NbsStemMUzM4YBvzBfrDz7lo0cckUtJTkD54hMo+xJOl2/Ckxn+ct+XeFNF02vLqm8
         nJLxxnMKW84J0eit59hVqoWQdn22TCbXu7E6QLUHl3CPbpw+1BkjxghWVVF1mHY8S3lW
         Tq+TS9+mhwO3HnhBqtqASLPgkHNUuerTS91BBDbY57Al9QqZUaWwBMQzni4selWeVCaI
         IZGSaU8rtf62b1Xb5Z1MnuS5O++qWsmQcDP/+oHx+NMg7tlLrI/Ymq3GlSoHkrW5G1vW
         qQ+FqSLXqd19auI2d22zjuSX2Q03usp92KZ0DL0oO+6YuG5FVkHsQJEBS8jFkzKcYS0K
         rW0w==
X-Gm-Message-State: AFqh2kpfMdD4SRV/vYqbyyRNvch6GXtaVnb9sZgH7TAZGQisGqvq8kGg
        ROL5ea+w/ITB2uDMOmcoMTxZokPt8wQ=
X-Google-Smtp-Source: AMrXdXv8ggM5+0HzuLjUMNmTAAO0kNyEKLEj1Jq0C1/ZM/va4Ra9r1Brdxg7Ps9WZh6eF08CQBx4yw==
X-Received: by 2002:adf:a18a:0:b0:2be:691c:a584 with SMTP id u10-20020adfa18a000000b002be691ca584mr25355094wru.49.1674916108067;
        Sat, 28 Jan 2023 06:28:28 -0800 (PST)
Received: from penguin.lxd ([95.146.230.133])
        by smtp.gmail.com with ESMTPSA id u6-20020a5d4346000000b002bc84c55758sm7748323wrr.63.2023.01.28.06.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 06:28:27 -0800 (PST)
From:   M Hickford <mirth.hickford@gmail.com>
To:     gitgitgadget@gmail.com
Cc:     avarab@gmail.com, chooglen@google.com, derrickstolee@github.com,
        git@jeffhostetler.com, git@vger.kernel.org,
        lessleydennington@gmail.com, mirth.hickford@gmail.com,
        mjcheetham@outlook.com, vdye@github.com
Subject: [PATCH v7 00/12] Enhance credential helper protocol to include auth headers
Date:   Sat, 28 Jan 2023 14:28:27 +0000
Message-Id: <20230128142827.17397-1-mirth.hickford@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
References: <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Future work
> ===========
> 
> In the future we can further expand the protocol to allow credential helpers
> decide the best authentication scheme. Today credential helpers are still
> only expected to return a username/password pair to Git, meaning the other
> authentication schemes that may be offered still need challenge responses
> sent via a Basic Authorization header. The changes outlined above still
> permit helpers to select and configure an available authentication mode, but
> require the remote for example to unpack a bearer token from a basic
> challenge.
> 
> More careful consideration is required in the handling of custom
> authentication schemes which may not have a username, or may require
> arbitrary additional request header values be set.
> 
> For example imagine a new "FooBar" authentication scheme that is surfaced in
> the following response:
> 
> HTTP/1.1 401 Unauthorized
> WWW-Authenticate: FooBar realm="login.example", algs="ES256 PS256"
> 
> 
> With support for arbitrary authentication schemes, Git would call credential
> helpers with the following over standard input:
> 
> protocol=https
> host=example.com
> wwwauth[]=FooBar realm="login.example", algs="ES256 PS256", nonce="abc123"
> 
> 
> And then an enlightened credential helper could return over standard output:
> 
> protocol=https
> host=example.com
> authtype=FooBar
> username=bob@id.example.com
> password=<FooBar credential>
> header[]=X-FooBar: 12345
> header[]=X-FooBar-Alt: ABCDEF
> 
> 
> Git would be expected to attach this authorization header to the next
> request:
> 
> GET /info/refs?service=git-upload-pack HTTP/1.1
> Host: git.example
> Git-Protocol: version=2
> Authorization: FooBar <FooBar credential>
> X-FooBar: 12345
> X-FooBar-Alt: ABCDEF

Interesting! Can you tell us more about how you hope to use this at GitHub? Could this be used for OAuth 2.0 Demonstrating Proof-of-Possession at the Application Layer (DPoP)? https://datatracker.ietf.org/doc/html/draft-ietf-oauth-dpop (some of the fields in your example look familiar). 

Challenge responses are typically short lived [1]. What happens if a storage helper is configured before a challenge-response helper? We want to maintain composability of helpers.

[credential]
    helper = storage  # eg. cache or osxkeychain
    helper = challenge-response  # eg. oauth-dpop

Storage may return an expired challenge response stored earlier. This could be avoided by introducing an expiry attribute to the credential protocol. https://lore.kernel.org/git/pull.1443.git.git.1674914650588.gitgitgadget@gmail.com/T/#u

A monolithic helper configured alone doesn't have this problem -- it knows which parts of its output to store or discard.

Declaration of interest: I maintain a credential-generating OAuth helper composable with any storage helper. https://github.com/hickford/git-credential-oauth

[1] https://datatracker.ietf.org/doc/html/draft-ietf-oauth-dpop#section-8
