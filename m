Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD14EC7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 21:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjDLVQg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 17:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjDLVQc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 17:16:32 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB3F65B3
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 14:16:32 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b145b3b03so1406980b3a.1
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 14:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681334191; x=1683926191;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHjKolSurEijwmN8GlfyaB2E8TadwRnKaUL7RvMtreQ=;
        b=C3z61AIasb+uZ/kty95Nzkr/pqyCh15rJHkzpQgES0EwScFE/UH59mn0BVVKSEdgAg
         6iO2QYOU2d5ptGd6oxhQApS5wnWzVVPSqiDb3bl5u3arHhk5DnDNV+X+Ig+6jyd0kaHB
         UG4ItLFprQrYRy5bRw0NIAMbMumVS4f2wgA0eF24SHqbwgV9DGoAMi+d0AN4uAkNqRXB
         u5w8bo9K0Y7m5xJtgKjKgKPYgmTOHMBXizBUl1Qn09PBOVj9nkIXtcqLHQ9gjoSYweIT
         Fdj+1jytnN9FQE6niYoF0DmT0/dTsJiX4d3xWqiNl+V8s8RpFWEwdsS3UKcXlZJwAqX3
         TbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681334191; x=1683926191;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHjKolSurEijwmN8GlfyaB2E8TadwRnKaUL7RvMtreQ=;
        b=aZB+0tmGAB0eUZw6rWb87WE12WiLbeKDYiNWLvv+pM/t2AUDpt6IrFf6TAuqWvGVg/
         PgAEPZ6t3RWZKMz2eMjZpnlqhdW/vAgcNmv2/hllupY7xnoPaTsRzcPXs36f80Gymlir
         KZsTAXsQkdiCv/UNoi5Cz6BvJWC3hiQ1l9a76YkvDq6KHS7CbujCCImptDGRAUqraFD8
         ETTPsb6Qhnq+gY6UQf3W42WQzKLOUpez7YCJM82twZcJXeYFTTtfFBvf/woRt8nMyqbA
         dve7n5Xt0waGeNtp4QOWqiXMSQlbux16g0ua2Sqx7TA2uQgodwm/KjTWo7FPIHDZBZm1
         yJ0A==
X-Gm-Message-State: AAQBX9dA4B7n787B5IzfhwMHrxv0Mvdmo4MmaS+i/n7Ym6YlkJZyNK34
        8z+0pUQqPQzlMqJlVhTNzg8=
X-Google-Smtp-Source: AKy350YihVv2Ihf8jUQegio2iLKXU24DMmeHBUOTQAjqPXZT4V0X3bkhuTRSGjUJWT+UjAwh8iM/mg==
X-Received: by 2002:a05:6a00:710:b0:627:e677:bc70 with SMTP id 16-20020a056a00071000b00627e677bc70mr4059730pfl.14.1681334191534;
        Wed, 12 Apr 2023 14:16:31 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id s11-20020a62e70b000000b0063af7d177aesm2516229pfh.195.2023.04.12.14.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 14:16:31 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org, adlternative@gmail.com,
        christian.couder@gmail.com
Subject: Re: [PATCH v3 1/4] doc: interpret-trailers: =?utf-8?Q?don?=
 =?utf-8?Q?=E2=80=99t?= use heredoc in
 examples
References: <cover.1680548208.git.code@khaugsbakk.name>
        <cover.1681326818.git.code@khaugsbakk.name>
        <fd515ad8b4b7c04aea9f332f47a660350d91fd57.1681326818.git.code@khaugsbakk.name>
Date:   Wed, 12 Apr 2023 14:16:31 -0700
Message-ID: <xmqqcz487qds.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

> Let’s get rid of these whitespace errors and also make the examples more
> friendly to cut-and-paste by replacing the heredocs with files which are
> shown with cat(1).
> -$ git interpret-trailers <<EOF
> -> EOF
> +$ git interpret-trailers <empty-msg.txt
>  
>  Signed-off-by: Bob <bob@example.com>

Nobody created empty-msg.txt and readers need to guess that it is a
file with 0-byte contents.  Using "</dev/null" would have avoided
the need for guessing.

But it seems that this goes away at the end of the series, so let's
not worry too much about it ;-)
