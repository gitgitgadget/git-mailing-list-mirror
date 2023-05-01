Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1C5C77B7C
	for <git@archiver.kernel.org>; Mon,  1 May 2023 21:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjEAVwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 17:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjEAVww (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 17:52:52 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D455E1FC1
        for <git@vger.kernel.org>; Mon,  1 May 2023 14:52:49 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b5c4c76aaso2169005b3a.2
        for <git@vger.kernel.org>; Mon, 01 May 2023 14:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682977969; x=1685569969;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKIQtb7Ru9gs2YHU3CpLiFWXvoU+6Og/CiqsXr0aIXo=;
        b=kWJdbSLbtoS/8zQQSEoXt3D2QB/zWMFmUCgtlv1uevWvNS17rqN8JEKUntFcsCyHpq
         23a/3jqSpyE0LyCKUfFmvKs6Dq8Ek5MPOs7lzBOhdB0xuBAknbeDuU1XQyHWAwaUR4J6
         Canlv+DxQZWLZAlspjLdZjer67VEkq3CcFdVwxhVONmRwqYv4As5wRlF7D8BAjvyUBTL
         p4a9TBJ/x48ZZsxvwKn+jfv9x6oAHh9Kcq88JtCxJF4N6LLyhsjadUqWgVWtzD7sIcnp
         iOGGaPOSg62zn+75lhb50gyppo2fknFwSkTOcfuCGdn5KJubcMop4o0FxbETjrWVqu78
         Qm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682977969; x=1685569969;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IKIQtb7Ru9gs2YHU3CpLiFWXvoU+6Og/CiqsXr0aIXo=;
        b=MCwJ8eiqQp+qfP3d551OnBa2xg3QLNFLoVO37YZ+KKmtonY6hu7XlY75zEcBmQA8yz
         n8Gftv20zPIDLsZXn0iBmlc5tzbvda+qLUajpq/BBlajJBpyjQQ0cco0OzAolX5zLdBG
         u6x/02Jh6vNHWlIQ9J31s3Kh9KPSVXfZJK4cH1xMvlSEyqQMwfPN/M4cp+kjZizXrCwp
         41vNYhS4Q4W3Ckuyegq9D5QXn+S4OBbAQiQSKIHVKuFLmfAtIrQOaHOGYCnO3uRneQNh
         +66g/BW9Ah2ITFOOp44LG1Tyu68KDhMugP5OREO2opDs5hagRcJqHjRj9UBFVWSTOuXA
         SvLg==
X-Gm-Message-State: AC+VfDxGQJLwXpYyacUy4/bvsyCf3ZbeLJtDhLPbx91wCf1uJSfah2uM
        8FV3gjemlvtf1t6dUvy2JwQ=
X-Google-Smtp-Source: ACHHUZ7pZub0py4jpOpki5k9aXa4IoDzhGoqXIN7BkSuFLQXm9SwoGo8lgpo2jiE8L6Fe++05htNpA==
X-Received: by 2002:a05:6a20:4286:b0:dd:7661:fb34 with SMTP id o6-20020a056a20428600b000dd7661fb34mr19719914pzj.51.1682977969222;
        Mon, 01 May 2023 14:52:49 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id y62-20020a17090a53c400b0024e14a3dba6sm1211665pjh.10.2023.05.01.14.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 14:52:48 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?=C3=98ystei?= =?utf-8?Q?n?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH v3 0/6] t: fix unused files, part 2
References: <20230403223338.468025-1-rybak.a.v@gmail.com>
        <20230417191044.909094-1-rybak.a.v@gmail.com>
Date:   Mon, 01 May 2023 14:52:48 -0700
In-Reply-To: <20230417191044.909094-1-rybak.a.v@gmail.com> (Andrei Rybak's
        message of "Mon, 17 Apr 2023 21:10:38 +0200")
Message-ID: <xmqq8re74t3j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> Creation of files from redirecting output of Git commands in tests has been
> removed for files which aren't being used for assertions.  CC'ed are authors of
> the affected tests.
>
> v1 cover letter:
>   https://lore.kernel.org/git/20230401212858.266508-1-rybak.a.v@gmail.com/
> v2 cover letter:
>   https://lore.kernel.org/git/20230403223338.468025-1-rybak.a.v@gmail.com/

This round has not seen any further comments; shall we consider it
pretty much done and ready to move to 'next' by now?

Thanks.
