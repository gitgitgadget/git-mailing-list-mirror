Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C118AC433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 08:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbiKHIzU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 03:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiKHIzS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 03:55:18 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F624EE17
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 00:55:17 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id i3so13198583pfc.11
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 00:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TupEruRD4WshdwqT0VUuGBO7JWUZiYIBzNBoaRlR8lA=;
        b=O66MwjL0Vj1MTRw/tS7rwMCl1fz+5Qlpvcnulk6gRna/1g1L8lVPWRmxScFB4yj0WJ
         bJxrr8g5hGa6rij1/3WT1RtHvYSiDHTFKdRKOfc1fh1ez8dcFqD0M8Bav4xXx8x/8DVd
         tYMr2QQl/PtxbNBqSustidZ4UOo7a+r/0Ulcv1DTl/UJR+ZUAykxwRN/vSeVPAtzjC6M
         CvaFa9UvnRgZKZ2ffpQEvUPHkHKQbtAlfCH7kmRNOyjXYGlJ/rZxzpVboqn8LS8iEBD+
         wssW9vCEWYryLSewq7arkO6icw2uildgTcS3s8s9UV+NibBR0eT57z8oKCitzlJJSggk
         RJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TupEruRD4WshdwqT0VUuGBO7JWUZiYIBzNBoaRlR8lA=;
        b=Bfg1B34J27ie1z+kuhGyc8ddH7bmxVZMetu/XYWOAzM3c+vWpvD0EzOeKONJVE0dAU
         EExpqITMbawJ7kJTPS7wNPV7P7CANfIHzezBEP4Se+gjrin8JlFjAQIILQfsAWD0dhLG
         J24b8VjaWETJYsnYY7TRmlj2PJwB825kMixqyu7qo8U1hllJ7IOZap4VYkOGYbz0hxgH
         rRiRbydY/IRU1QWwxn9vw+Fx0YSyw+FghSPhUoBBABZ4t7J2ratgEtNbVh8ysenqfOaI
         h+u6/S+EekFG6BnFx7MfPC5Gw08/y9/e51fqQV8D9YOEXDt85ahQsuIbtK9D4jUC8weZ
         4GBA==
X-Gm-Message-State: ACrzQf1tbNX2//uC41VqG3jy0Y5/6nlqxYC2gQ0CE8X6dMHVG0/ss1wb
        WJl1rfXNCRtI46qgx3Y0JrI=
X-Google-Smtp-Source: AMsMyM53xSCxIJETIJnkZqqnr9coiUdrEhom7Si6/7FRpkCJKey6pQJSKZ9hqIsn/tVR1zV4RrJ0rA==
X-Received: by 2002:a65:6c08:0:b0:448:c216:fe9 with SMTP id y8-20020a656c08000000b00448c2160fe9mr46022672pgu.243.1667897716733;
        Tue, 08 Nov 2022 00:55:16 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.50])
        by smtp.gmail.com with ESMTPSA id pv7-20020a17090b3c8700b00213c7cf21c0sm5633276pjb.5.2022.11.08.00.55.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Nov 2022 00:55:16 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     avarab@gmail.com
Cc:     dyroneteng@gmail.com, git@vger.kernel.org, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2 2/3] notes.c: fixed tip when target and append note are both empty
Date:   Tue,  8 Nov 2022 16:55:10 +0800
Message-Id: <20221108085510.24275-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.1.382.g8ae58934a1d.dirty
In-Reply-To: <221107.86bkpitmw6.gmgdl@evledraar.gmail.com>
References: <221107.86bkpitmw6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ævar Arnfjörð Bjarmason" <avarab@gmail.com> writes:

>  I was still on my initial read-through, and was assuming that it was a
> prep change for the 3/3 adding a new field, before I saw the 3/3...

Yes, you are right, that previous patch add a "copy" of "d", but now it's
unnecessary, so I think make a pre-cleanup commit which includes the "char
*logmsg = NULL" and the "designated init" of "struct note_data d" looks
nice.

Thanks.
