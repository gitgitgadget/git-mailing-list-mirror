Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68572C6FD1D
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 17:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjDGRxf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 13:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjDGRxd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 13:53:33 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C47BDC2
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 10:53:32 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n14so24696564plc.8
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 10:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680890012; x=1683482012;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=cQSoh/p3zCchGsyCj3KsfvwyRKTnKPgTfqsTjn1GCi4=;
        b=BNjbOecV5q1Gs7Rb60sQZWpWVFhjnRRJqbwgCGJCoCufU0KZ2XPNPWTK1knb4OVmdW
         HXCek3P3veIZpLIrH3SSoXDAt3My4irVhwPv+g+LcUSxv8T89bTzjWuMijRChNTjyJUo
         8FbKl4IQFvvwToQfvMqClnhxOGV/klFeS3HtiCGf9l6n+pVy7JJBJnOkdez1IrmrhdHN
         u/wDrCdY6WlH+x/obPAaw2BCAXLQrABigI54jjIFj73WlE2AdpZUFGmkEuAiFId6EVEv
         5lmZ0+BPhZO882ExngD5nX3mZ7c/JpAFlEXQSJRdqCcf5I1qLl+pCD5CC1S+w/nQuYDc
         N1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680890012; x=1683482012;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQSoh/p3zCchGsyCj3KsfvwyRKTnKPgTfqsTjn1GCi4=;
        b=KjGQ0IPH4PrRLk+gB/fx2Soaq+tRVR3btatnzbO2DB/0VESkhOXXqBA7hTSHMvQTLF
         eCCyEcSU2db8TsePPdUDtjfomUIK5PP8IcCQ5/kac2nVc6AkA1thMOF+zt3gR3hppHWH
         aBiCVEZsR2k0HstVeaULy/+xnAXrgScJGGysG7UQQhbJdJw9RPV/FixJG30pFDVEEf2V
         E3wPY0y4iHpYMkhJfGyz39Bff9KwJHeTz1f/d0sipe73pVRyhbv4Ob2o+SVa0K/9ahXE
         qwO2XiPaqn3mEHUPDL2NuUO4s5wGGIaXt6gK9CqwNi27lfyl7YGQJjD8X0gaetAkFfEv
         UVfA==
X-Gm-Message-State: AAQBX9cY8ONL0pYKxNsPM7e8JGES1KUWcyTpHvPe//EXqBK3xevHK0S0
        7MqwGlFUA15EKfjAwRIPQBvhh8cGd30=
X-Google-Smtp-Source: AKy350ZL9Uw+LB2yDtv5DTg/zccrvEUEZI1/gJFH6N9l9MVexjW3RLlax7BEtY12xkngcvUB5BVgqw==
X-Received: by 2002:a17:902:d709:b0:1a2:74c5:a4ec with SMTP id w9-20020a170902d70900b001a274c5a4ecmr2804403ply.20.1680890011620;
        Fri, 07 Apr 2023 10:53:31 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id je9-20020a170903264900b0019f3e339fb4sm3197442plb.187.2023.04.07.10.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 10:53:31 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/5] rebase: cleanup merge strategy option handling
References: <cover.1678893298.git.phillip.wood@dunelm.org.uk>
        <cover.1680708043.git.phillip.wood@dunelm.org.uk>
        <CABPp-BFMiU8cYzUr1-m6P8w-YAtqPRyMfah8UAqdO_N4cdxUKg@mail.gmail.com>
        <fe8fe698-28a0-3db7-f5b7-57456175fc74@dunelm.org.uk>
Date:   Fri, 07 Apr 2023 10:53:30 -0700
Message-ID: <xmqqmt3jk291.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Thanks for reviewing this series. I've sent v3 with the typo fix and
> your Reviewed-by: trailer.

Thanks, both, for writing, reviewing and polishing.
